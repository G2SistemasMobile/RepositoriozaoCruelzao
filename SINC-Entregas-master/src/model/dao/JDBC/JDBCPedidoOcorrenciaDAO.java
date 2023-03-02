package model.dao.JDBC;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.dao.interfaces.PedidoOcorrenciaDAO;
import model.pojo.PedidoOcorrencia;
import persistence.ConnectionFactory;
import requests.MakeRequests;
import util.Log;

/**
 *
 * @author Júnior Mourão
 */
public class JDBCPedidoOcorrenciaDAO implements PedidoOcorrenciaDAO{
    private Log lgErro;
    private Connection con;

    public JDBCPedidoOcorrenciaDAO() {
    }

    @Override
    public List<PedidoOcorrencia> consultaPedidoOcorrenciaLocal(Log log) throws IOException{
        con = ConnectionFactory.getConnection();

        final String sql = "SELECT *"+
                           " FROM v_Site_CargasPedidosOcorrencias";
        
        List<PedidoOcorrencia> pedidoOcorrenciaList = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                do {
                    PedidoOcorrencia pedidoOcorrencia = new PedidoOcorrencia();
                    pedidoOcorrencia.setIdg2(rs.getInt("idg2"));
                    pedidoOcorrencia.setOcorrenciaId(rs.getInt("ocorrenciaid"));
                    pedidoOcorrencia.setDescricao(rs.getString("descricao"));
                    pedidoOcorrencia.setAtivo(rs.getString("ativo"));

                    pedidoOcorrenciaList.add(pedidoOcorrencia);
                } while (rs.next());

                System.out.println("consultaPedidoOcorrenciaLocal - " + pedidoOcorrenciaList.size() + " registros encontrados");
            } else {
                System.out.println("consultaPedidoOcorrenciaLocal - Nenhum registro encontrado");
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("consultaPedidoOcorrenciaLocal", e, log, lgErro);
        } finally {
            ConnectionFactory.closeConnection(con);
        }
        return pedidoOcorrenciaList;
    }
    
    @Override
    public boolean inserePedidoOcorrenciaWS(String pedidoOcorrenciaPostURL, String pedidoOcorrenciaJsonArgs, Log log) throws IOException{     
        String respostaStatusInsercao = MakeRequests.makePostRequest(pedidoOcorrenciaPostURL, pedidoOcorrenciaJsonArgs);
        if (!respostaStatusInsercao.isEmpty() && respostaStatusInsercao.contains("erro"))
            util.Log.ocorreuUmErroLog("inserePedidoOcorrenciaWS", respostaStatusInsercao, log, lgErro);            
        return !respostaStatusInsercao.contains("erro");
    }
}
