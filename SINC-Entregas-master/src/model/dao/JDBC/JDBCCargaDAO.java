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
import model.dao.interfaces.CargaDAO;
import model.pojo.Carga;
import persistence.ConnectionFactory;
import requests.MakeRequests;
import util.Log;

public class JDBCCargaDAO implements CargaDAO {

    private Log lgErro;
    private Connection con;

    public JDBCCargaDAO() {
    }

    @Override
    public List<Carga> consultaCargasLocal(Log log) throws IOException{
        con = ConnectionFactory.getConnection();

        final String sql = "SELECT *"+
                           " FROM v_Site_Cargas";
        
        List<Carga> cargaList = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cargaList = new ArrayList<>();
                do {
                    Carga carga = new Carga();

                    carga.setIdg2(rs.getInt("idg2"));
                    carga.setCargaId(rs.getInt("cargaid"));
                    carga.setData(rs.getTimestamp("data"));
                    carga.setStatus(rs.getString("status"));
                    carga.setEntidadeIdMotorista(rs.getInt("entidadeid_motorista"));
                    carga.setKmInicial(rs.getString("km_inicial"));
                    carga.setKmFinal(rs.getString("km_final"));
                    carga.setVeiculoId(rs.getInt("veiculoid"));
                    carga.setEntidadeIdLoja(rs.getInt("entidadeid_loja"));
                    carga.setObs(rs.getString("obs"));
                    carga.setEntregue(rs.getString("entregue"));
                    carga.setDataSaida(rs.getDate("data_saida"));
                    carga.setDataRetorno(rs.getTimestamp("data_retorno"));
                    carga.setNomeMotorista(rs.getString("nome_motorista"));
                    carga.setPlaca(rs.getString("placa"));
                    carga.setDescricao(rs.getString("descricao"));
                    carga.setStatusSincronizacao(1);
                    //carga.setDataEnvio(carga.getDataEnvio());

                    cargaList.add(carga);
                } while (rs.next());
            } else {
                System.out.println("consultaCargasLocal - Nenhum registro encontrado");
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("consultaCargasLocal", e, log, lgErro);
        } finally {
            ConnectionFactory.closeConnection(con);
        }
        return cargaList;
    }
    
    @Override
    public boolean updateRegistroLocal(Carga carga, Log log) throws IOException{
        con = ConnectionFactory.getConnection();
        try {
            con.setAutoCommit(false);

            final String sql = "UPDATE REGISTROS_SINCRONIZAR" +
                           " SET DATASINCRONIZACAO = GETDATE()" +
                           " WHERE cargaid = ?";
        
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, carga.getCargaId());

            ps.addBatch();
            ps.executeBatch();
            con.commit();
            ps.close();
        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("updateRegistroLocal", e, log, lgErro);
        } finally {
            ConnectionFactory.closeConnection(con);
        }
        return true;
    }
    
    @Override
    public boolean updateStatusCargaLocal(List<Carga> cargaList, Log log) throws IOException{
        con = ConnectionFactory.getConnection();
        final int batchSize = 1000;
        int count = 0;
        try {
            if (!cargaList.isEmpty()) {
                con.setAutoCommit(false);

            final String sql = "UPDATE CARGA" +
                           " SET STATUS = ?" +
                           " WHERE cargaid = ?";
            
                PreparedStatement ps = con.prepareStatement(sql);
                
                for (Carga carga : cargaList) {
                    ps.setString(1, carga.getStatus());
                    ps.setInt(2, carga.getCargaId());
                    ps.addBatch();
                    if (++count % batchSize == 0) {
                        ps.executeBatch();
                        con.commit();
                    }
                }
                ps.executeBatch();
                con.commit();
                ps.close();
            }
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("updateStatusCargaLocal", e, log, lgErro);
            if (con != null) ConnectionFactory.roolbackConnection(con);
        } finally {
            ConnectionFactory.closeConnection(con);
        }
        return true;
    }
    
    
    @Override
    public boolean insereCargasWS(String cargaPostURL, String cargasJsonArgs, Log log) throws IOException{     
        String respostaStatusInsercao = MakeRequests.makePostRequest(cargaPostURL, cargasJsonArgs);
        if (!respostaStatusInsercao.isEmpty() && respostaStatusInsercao.contains("erro"))
            util.Log.ocorreuUmErroLog("insereCargasWS", respostaStatusInsercao, log, lgErro);
        return !respostaStatusInsercao.contains("erro");
    }
    
    @Override
    public boolean updateStatusSincronizacaoCargaWS(String cargaPostURL, String cargaJsonArgs, Log log) throws IOException{     
        String respostaStatusUpdate = MakeRequests.makePostRequest(cargaPostURL, cargaJsonArgs);
        if (!respostaStatusUpdate.isEmpty() && !respostaStatusUpdate.contains("Atualização concluida")) 
            util.Log.ocorreuUmErroLog("updateStatusSincronizacaoCargaWS", respostaStatusUpdate, log, lgErro);
        return respostaStatusUpdate.contains("Atualização concluida");
    }
    
    @Override
    public List<Carga> consultaCargasEmAbertoWS(String URL) throws IOException, InterruptedException{
        List<Carga> cargaListRetornoGet;
        Gson gson =  new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        
        //dataDownloaded são os pedidos que foram baixados de acordo com as cargas passadas
        String dataDownloaded = MakeRequests.makeGetRequest(URL);
        
        if (!dataDownloaded.isEmpty()) cargaListRetornoGet = gson.fromJson(dataDownloaded, new TypeToken<List<Carga>>(){}.getType());
        else cargaListRetornoGet = new ArrayList();
        return cargaListRetornoGet;
    }
}



