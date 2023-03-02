package model.dao.interfaces;

import java.io.IOException;
import java.util.List;
import model.pojo.Carga;
import model.pojo.Pedido;
import util.Log;

/**
 *
 * @author USUARIO
 */
public interface PedidoDAO {
    public List<Pedido> consultaPedidosLocal(List<Carga> listCarga7DiasLocal, Log log) throws IOException;
    public boolean inserePedidosWS(String pedidoPostURL, String pedidosJsonArgs, Log log) throws IOException;
    public List<Pedido> consultaPedidosWS(String pedidoURL, String cargasJsonArgs) throws IOException;
    public boolean updatePedidoUnicoLocal(Pedido pedido, Log log) throws IOException;
    public List<Pedido> consultaPedidosAlteradosWS(String URL)  throws IOException, InterruptedException;
    public String updatePedidoAlteradoWS(String pedidoURL, String pedidosJsonArgs) throws IOException;
    
    
}
