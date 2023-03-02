package persistence;

import model.dao.JDBC.JDBCCargaDAO;
import model.dao.JDBC.JDBCClienteDAO;
import model.dao.JDBC.JDBCPedidoDAO;
import model.dao.JDBC.JDBCPedidoOcorrenciaDAO;
import model.dao.interfaces.CargaDAO;
import model.dao.interfaces.ClienteDAO;
import model.dao.interfaces.PedidoDAO;
import model.dao.interfaces.PedidoOcorrenciaDAO;
public class DAOFactory {
   

    
    public static PedidoDAO createPedidoDAO() {
        return new JDBCPedidoDAO();
    }
    
    public static ClienteDAO createClienteDAO() {
        return new JDBCClienteDAO();
    }
    
    public static CargaDAO createCargaDAO() {
        return new JDBCCargaDAO();
    }
    
    public static PedidoOcorrenciaDAO createPedidoOcorrenciaDAO(){
        return new JDBCPedidoOcorrenciaDAO();
    }

}
