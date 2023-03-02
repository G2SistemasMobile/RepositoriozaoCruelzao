package model.dao.JDBC;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import requests.MakeRequests;
import model.dao.interfaces.PedidoDAO;
import model.pojo.Carga;
import model.pojo.Pedido;
import persistence.ConnectionFactory;
import util.Log;
import util.Tools;

public class JDBCPedidoDAO implements PedidoDAO {

    private Log lgErro;
    private Connection con;
    private final Gson gson;  
    public JDBCPedidoDAO() {
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd KK:mm:ss").create();
    }

    @Override
    //Consulta os pedidos das cargas passadas como parâmetro
    //REALIZA UM POST no Postgre pra conseguir os pedidos
    public List<Pedido> consultaPedidosWS(String pedidoURL, String cargasJsonArgs) throws IOException{
        List<Pedido> pedidoListRetornoGet;
        
        //dataDownloaded são os pedidos que foram baixados de acordo com as cargas passadas
        String dataDownloaded = MakeRequests.makePostRequest(pedidoURL, cargasJsonArgs);
        
        if (!dataDownloaded.isEmpty()) pedidoListRetornoGet = gson.fromJson(dataDownloaded, new TypeToken<List<Pedido>>(){}.getType());
        else pedidoListRetornoGet = new ArrayList();
        return pedidoListRetornoGet;
    }
    
    @Override
    public List<Pedido> consultaPedidosAlteradosWS(String URL) throws IOException, InterruptedException{
        List<Pedido> pedidoListRetornoGet;
        //dataDownloaded são os pedidos que foram baixados de acordo com as cargas passadas
        String dataDownloaded = MakeRequests.makeGetRequest(URL);
        
        if (!dataDownloaded.isEmpty()) pedidoListRetornoGet = gson.fromJson(dataDownloaded, new TypeToken<List<Pedido>>(){}.getType());
        else pedidoListRetornoGet = new ArrayList();
        return pedidoListRetornoGet;
    }
    
    @Override
    public String updatePedidoAlteradoWS(String pedidoURL, String pedidosJsonArgs) throws IOException{
        //dataDownloaded são os pedidos que foram baixados de acordo com as cargas passadas
        String dataDownloaded = MakeRequests.makePostRequest(pedidoURL, pedidosJsonArgs);
        
        if (!dataDownloaded.isEmpty()) return dataDownloaded;
        else return "";
    }
    
    @Override
    public boolean updatePedidoUnicoLocal(Pedido pedido, Log log) throws IOException{
        con = ConnectionFactory.getConnection();

        final String sql;
        try {
            con.setAutoCommit(false);
            sql = "UPDATE Carga_Romaneio_Ped"
                + " SET ENTREGUE = ?,"
                    + " MOTIVONAOENTREGUE = ?,"
                    + " OCORRENCIAID = ?, LATITUDE = ?, LONGITUDE = ?, CIDADE = ?, ESTADO = ?,"
                    + " CEP = ?, RUA = ?, DATA_CHECKIN = ?, DATA_ENTREGA = ?, DATA_NAO_ENTREGUE = ?,"
                    + " DATA_CHECKIN_UPD = ?, DATA_ENTREGA_UPD = ?, DATA_NAO_ENTREGUE_UPD = ?, imagem_recibo = ?, justificativaAtraso = ?"
                + " WHERE"
                    + " CONTA = ?"
                    + " AND CARGAID = ?"
                    + " AND ROMANEIOID = ?"
                    + " AND ENTIDADEID_LOJA = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, pedido.getEntregue());
            ps.setString(2, pedido.getMotivoNaoEntregue());

            ps.setInt(3, pedido.getOcorrenciaid());
            ps.setString(4, pedido.getLatitudeCheckin());
            ps.setString(5, pedido.getLongitudeCheckin());
            ps.setString(6, pedido.getCidadeCheckin());
            ps.setString(7, pedido.getEstadoCheckin());
            ps.setString(8, pedido.getCepCheckin());
            ps.setString(9, pedido.getRuaCheckin());
            ps.setTimestamp(10, pedido.getDataCheckin());
            ps.setTimestamp(11, pedido.getDataEntrega());
            ps.setTimestamp(12, pedido.getDataNaoEntregue());
            
            //Verifica se a data é null, se não for, pega a data atual e registra no BD
            //Isso faz com que quando a data for preenchida (e o pedido att aq), registre a hora desse update local
            //getDataCheckinUpd
            if(pedido.getDataCheckin() == null) ps.setTimestamp(13, null);
            else ps.setTimestamp(13, Tools.getTodayTimestamp());
            //getDataEntregaUpd
            if(pedido.getDataEntrega() == null) ps.setTimestamp(14, null);
            else ps.setTimestamp(14, Tools.getTodayTimestamp());
            //getDataNaoEntregueUpd
            if(pedido.getDataNaoEntregue() == null) ps.setTimestamp(15, null);
            else ps.setTimestamp(15, Tools.getTodayTimestamp());
           
            ps.setBytes(16, pedido.getCanhoto());
            ps.setString(17, pedido.getJustificativaAtraso());
            ps.setInt(18, pedido.getConta());
            ps.setInt(19, pedido.getCargaId());
            ps.setInt(20, pedido.getRomaneioId());
            ps.setInt(21, pedido.getEntidadeIdLoja());

            ps.addBatch();
            ps.executeBatch();
            con.commit();
            ps.close();
        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("updatePedidoUnicoLocal", e, log, lgErro);
        } finally {
           ConnectionFactory.closeConnection(con);
        }  
        return true;
    }
    
    @Override
    public List<Pedido> consultaPedidosLocal(List<Carga> listCargaLocal, Log log) throws IOException{
        con = ConnectionFactory.getConnection();
        final String sql = "SELECT * FROM v_Site_CargasPedidos";
        List<Pedido> pedidoList = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                do {
                    Pedido pedido = new Pedido();

                    pedido.setIdg2(rs.getInt("idg2"));
                    pedido.setCargaId(rs.getInt("cargaid"));
                    pedido.setNumDocumento(rs.getInt("numdocumento"));
                    pedido.setEntidadeIdLoja(rs.getInt("entidadeid_loja"));
                    pedido.setEntidadeIdCliente(rs.getInt("entidadeid_cliente"));
                    pedido.setClienteRazaoSocial(rs.getString("cli_razaosocial"));
                    pedido.setVolumes(rs.getString("volumes"));
                    pedido.setEntregue(rs.getString("entregue"));
                    pedido.setConta(rs.getInt("conta"));
                    pedido.setOrdem(rs.getString("ordem"));
                    pedido.setMotivoNaoEntregue(rs.getString("motivonaoentregue"));
                    pedido.setCep(rs.getString("cep"));
                    pedido.setEndereco(rs.getString("endereco"));
                    pedido.setNumero(rs.getString("numero"));
                    pedido.setComplemento(rs.getString("complemento"));
                    pedido.setBairro(rs.getString("bairro"));
                    pedido.setCidade(rs.getString("cidade"));
                    pedido.setUf(rs.getString("uf"));
                    pedido.setDataEmissao(rs.getTimestamp("dt_emissao"));
                    
                    pedido.setLatitudeCheckin(rs.getString("latitude_checkin"));
                    pedido.setLongitudeCheckin(rs.getString("longitude_checkin"));
                    pedido.setCidadeCheckin(rs.getString("cidade_checkin"));
                    pedido.setEstadoCheckin(rs.getString("estado_checkin"));
                    pedido.setCepCheckin(rs.getString("cep_checkin"));
                    pedido.setRuaCheckin(rs.getString("rua_checkin"));
                    pedido.setOcorrenciaid(rs.getInt("ocorrenciaid"));
                    pedido.setDataCheckin(rs.getTimestamp("data_checkin"));
                    pedido.setDataEntrega(rs.getTimestamp("data_entrega"));
                    pedido.setDataNaoEntregue(rs.getTimestamp("data_nao_entregue"));
                    pedido.setDataCheckinUpd(rs.getTimestamp("data_checkin_upd"));
                    pedido.setDataEntregaUpd(rs.getTimestamp("data_entrega_upd"));
                    pedido.setDataNaoEntregueUpd(rs.getTimestamp("data_nao_entregue_upd"));
                    pedido.setRomaneioId(rs.getInt("romaneioid"));
                    pedido.setJustificativaAtraso(rs.getString("justificativaAtraso"));

                    pedidoList.add(pedido);
                } while (rs.next());

                System.out.println("consultaPedidosLocal - " + pedidoList.size() + " registros encontrados");
            } else {
                System.out.println("consultaPedidosLocal - Nenhum registro encontrado");
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("consultaPedidosLocal", e, log, lgErro);
        }
        return pedidoList;
    }
   
    @Override
    public boolean inserePedidosWS(String pedidoPostURL, String pedidosJsonArgs, Log log) throws IOException{
        String respostaStatusInsercao = MakeRequests.makePostRequest(pedidoPostURL, pedidosJsonArgs);
        if (!respostaStatusInsercao.isEmpty() && respostaStatusInsercao.contains("erro"))
            util.Log.ocorreuUmErroLog("inserePedidosWS", respostaStatusInsercao, log, lgErro);
        return !respostaStatusInsercao.contains("erro");
    }
}
