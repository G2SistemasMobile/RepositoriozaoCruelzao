package main;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.dao.interfaces.CargaDAO;
import model.dao.interfaces.ClienteDAO;
import model.dao.interfaces.PedidoDAO;
import model.dao.interfaces.PedidoOcorrenciaDAO;
import model.pojo.Carga;
import model.pojo.Pedido;
import model.pojo.PedidoOcorrencia;
import persistence.DAOFactory;
import util.Log;

public class SincEntregas {
    public static final String MAIN_URL = "http://cloud47.p80.com.br:8080/WSEntregas/webresources/";
    public static String GET_CARGAS_URL = "carga/consultaCargas/";
    public static String POST_INSERT_CARGAS_URL = "carga/insereCargasBatch/";
    public static String POST_INSERT_PEDIDOS_URL = "pedido/inserePedidosBatch/";
    public static String GET_PEDIDOS_ALTERADOS_URL = "pedido/consultaPedidosAlterados/"; //A CONSULTA DE PEDIDOS É FEITA POR UM POST
    public static String POST_UPDATE_PEDIDOS_URL = "pedido/updatePedidoStatusSinc/";
    public static String GET_CARGAS_EM_ABERTO_URL = "carga/consultaCargasPorIdg2/";
    public static String POST_CARGAS_UPDATE_URL = "carga/updateStatusSincronizacaoCarga/";
    public static String POST_PEDIDO_OCORRENCIA_URL = "pedidoOcorrencia/inserePedidoOcorrenciaBatch/";
    public static String GET_PEDIDO_OCORRENCIA_URL = "pedidoOcorrencia/consultaPedidosOcorrencias/";
    
    private static Log lg, lgErro;
    public static void main(String[] args) {
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd KK:mm:ss").create();
        ClienteDAO clienteDAO = DAOFactory.createClienteDAO();
        CargaDAO cargaDAO = DAOFactory.createCargaDAO();
        PedidoDAO pedidoDAO = DAOFactory.createPedidoDAO();
        PedidoOcorrenciaDAO pedidoOcorrenciaDAO = DAOFactory.createPedidoOcorrenciaDAO();
        List<Carga> cargaListLocal, cargasNaoSincronizadasWS;
        List<Pedido> pedidoListLocal, pedidosAlteradosWSList;
        List<PedidoOcorrencia> pedidoOcorrenciaList;
        String jsonArgCargas, jsonArgPedidos, jsonPedidoOcorrenciaList;
        
        try{
            lg = new Log(false);
            int idg2 = clienteDAO.consultaCodigoCliente(lg).getIdg2();
            cargaListLocal = cargaDAO.consultaCargasLocal(lg);
            pedidoListLocal = new ArrayList<>();
            jsonArgCargas = "";
            jsonArgPedidos = "";
            
            if(!cargaListLocal.isEmpty()){
                pedidoListLocal = pedidoDAO.consultaPedidosLocal(cargaListLocal, lg);

                jsonArgCargas = gson.toJson(cargaListLocal);
                jsonArgPedidos = gson.toJson(pedidoListLocal);
            }
            
            pedidoOcorrenciaList = pedidoOcorrenciaDAO.consultaPedidoOcorrenciaLocal(lg);
            if(!pedidoOcorrenciaList.isEmpty()){
                jsonPedidoOcorrenciaList = gson.toJson(pedidoOcorrenciaList);
                boolean statusInsercaoPedidoOcorrenciaList = pedidoOcorrenciaDAO.inserePedidoOcorrenciaWS(MAIN_URL+POST_PEDIDO_OCORRENCIA_URL, jsonPedidoOcorrenciaList, lg);
                if(statusInsercaoPedidoOcorrenciaList) lg.escreveLog(PedidoOcorrencia.CLASSE_DESCRICAO_LOCAL);
            }
            
            cargasNaoSincronizadasWS = cargaDAO.consultaCargasEmAbertoWS(MAIN_URL+GET_CARGAS_EM_ABERTO_URL+idg2);
            if(cargasNaoSincronizadasWS != null && !cargasNaoSincronizadasWS.isEmpty()){
                boolean wasSuccessful = cargaDAO.updateStatusCargaLocal(cargasNaoSincronizadasWS, lg);
                if(wasSuccessful){
                    for(Carga carga : cargasNaoSincronizadasWS){
                        cargaDAO.updateStatusSincronizacaoCargaWS(MAIN_URL+POST_CARGAS_UPDATE_URL+idg2+"/"+carga.getCargaId(), gson.toJson(carga), lg);
                    }
                    lg.escreveLog(Carga.CLASSE_DESCRICAO_LOCAL);
                }
            }
            
            pedidosAlteradosWSList = pedidoDAO.consultaPedidosAlteradosWS(MAIN_URL+GET_PEDIDOS_ALTERADOS_URL+idg2);
                        lg.escreveLog(Pedido.CLASSE_DESCRICAO_LOCAL);

            if(!pedidosAlteradosWSList.isEmpty()){
                List<Pedido> pedidosParaMudarStatusWS = new ArrayList();
                for(Pedido pedido : pedidosAlteradosWSList){
                    boolean wasSuccessful = pedidoDAO.updatePedidoUnicoLocal(pedido, lg);
                    if (wasSuccessful) pedidosParaMudarStatusWS.add(pedido);
                
                    if(!pedidosParaMudarStatusWS.isEmpty()){
                        //Dá um update da nuvem com todos os pedidos que foram atualizados na base local;
                        //Esse método altera DataUpdateLocal = data e hora atual
                        //StatusSincronizacao = 2 (significa que ele foi atualizado na base do cliente)
                        //Alterado = 0, significa que esse pedido tá igual em ambas as bases (nuvem e cliente) e não
                        //sofreu alterações

                        String jsonArgPedidoAtualizar = gson.toJson(pedidosParaMudarStatusWS);
                        pedidoDAO.updatePedidoAlteradoWS(MAIN_URL+POST_UPDATE_PEDIDOS_URL, jsonArgPedidoAtualizar);
                    }
                }
            }
            if(!cargaListLocal.isEmpty()){
                boolean retornoInserirCarga, retornoInserirPed = false;
                retornoInserirCarga = cargaDAO.insereCargasWS(MAIN_URL+POST_INSERT_CARGAS_URL, jsonArgCargas, lg);
                if(!pedidoListLocal.isEmpty()){
                    retornoInserirPed = DAOFactory.createPedidoDAO().inserePedidosWS(MAIN_URL+POST_INSERT_PEDIDOS_URL, jsonArgPedidos, lg);
                    lg.escreveLog(Pedido.CLASSE_DESCRICAO_NUVEM);
                }
                if(retornoInserirCarga && retornoInserirPed){
                    for(Carga carga: cargaListLocal){
                        cargaDAO.updateRegistroLocal(carga, lg);
                    }
                }
            }
        } catch (Exception e) {
            try {
                util.Log.ocorreuUmErroLog("SincEntregas/Main", e, lg, lgErro);
            } catch (IOException ex) {
                System.exit(0);
            }
        } finally{
            try {
                lg.fechaLog();
            } catch (IOException e) {
                try {
                    util.Log.ocorreuUmErroLog("SincEntregas/Main/fechaLog", e, lg, lgErro);
                } catch (IOException ex) {
                    System.exit(0);
                }
            }
        }
    }
}