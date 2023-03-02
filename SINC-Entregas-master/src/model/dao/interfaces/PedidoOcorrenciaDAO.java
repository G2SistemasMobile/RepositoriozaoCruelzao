/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao.interfaces;

import java.io.IOException;
import java.util.List;
import model.pojo.PedidoOcorrencia;
import util.Log;

/**
 *
 * @author Júnior Mourão
 */
public interface PedidoOcorrenciaDAO {
    public List<PedidoOcorrencia> consultaPedidoOcorrenciaLocal(Log log) throws IOException;
    public boolean inserePedidoOcorrenciaWS(String pedidoOcorrenciaPostURL, String pedidoOcorrenciaJsonArgs, Log log) throws IOException;
}
