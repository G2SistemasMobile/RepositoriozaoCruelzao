package model.dao.JDBC;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.dao.interfaces.ClienteDAO;
import model.pojo.Cliente;
import persistence.ConnectionFactory;
import util.Log;


public class JDBCClienteDAO implements ClienteDAO {

    private Connection con;
    private static Log lgErro;

    public JDBCClienteDAO() {
    }

    @Override
    public Cliente consultaCodigoCliente(Log log) throws IOException{
        this.con = ConnectionFactory.getConnection();

        Cliente cliente = null;
        final String sql = "SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs;
            rs = ps.executeQuery();
            if (rs.next()) {
                cliente = new Cliente();
                if(!rs.getString("VALOR").equals("")) cliente.setIdg2(Integer.parseInt(rs.getString("VALOR")));
                else util.Log.ocorreuUmErroLog("consultaCodigoCliente", "O Código do cliente é vazio ou inválido.\nCódigo: "+(rs.getString("VALOR")), log, lgErro);
            } else util.Log.ocorreuUmErroLog("consultaCodigoCliente", "Nenhum registro encontrado", log, lgErro);
            rs.close();
        } catch (SQLException e) {
            util.Log.ocorreuUmErroLog("consultaCodigoCliente", e, log, lgErro);
        } finally {
            ConnectionFactory.closeConnection(con);
        }
        if(cliente == null) cliente = new Cliente();
        return cliente;
    }
}
