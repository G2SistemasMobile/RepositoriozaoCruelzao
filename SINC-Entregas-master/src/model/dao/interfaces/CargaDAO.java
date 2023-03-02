package model.dao.interfaces;

import java.io.IOException;
import java.util.List;
import model.pojo.Carga;
import util.Log;

/**
 *
 * @author Junior Mourão
 */
public interface CargaDAO {
    public List<Carga> consultaCargasLocal(Log log) throws IOException;
    public boolean insereCargasWS(String cargaPostURL, String cargasJsonArgs, Log log) throws IOException;
    public boolean updateRegistroLocal(Carga carga, Log log) throws IOException;
    public List<Carga> consultaCargasEmAbertoWS(String URL) throws IOException, InterruptedException;
    public boolean updateStatusCargaLocal(List<Carga> cargaList, Log log) throws IOException;
    public boolean updateStatusSincronizacaoCargaWS(String cargaPostURL, String cargaJsonArgs, Log log) throws IOException;
    
}
