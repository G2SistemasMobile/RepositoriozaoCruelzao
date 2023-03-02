package model.dao.interfaces;

import java.io.IOException;
import model.pojo.Cliente;
import util.Log;

public interface ClienteDAO {

    public Cliente consultaCodigoCliente(Log log) throws IOException;
}
