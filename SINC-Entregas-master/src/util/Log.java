package util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.joda.time.Seconds;
import org.joda.time.format.DateTimeFormat;

public class Log {
    private static final String VERSAO_ATUAL = "v.1.8";
    private static File arq;
    private static String logId;
    private static String tempoInicio;
    private static String tempoFim;
    public Log(boolean isErro) throws IOException {
        if(isErro == false){
            logId = geraLogid();
            IniciaLog();
        } else if(isErro == true){
            logId = geraLogid();
            iniciaLogErro();
        }
    }
    
    private static void IniciaLog() throws IOException {
        String path = new File(".").getCanonicalPath();
        File dir = new File(path+"\\logs\\");
        dir.mkdirs();
        arq = new File(dir, "LogEntregas."+logId+".txt");
        if(arq.exists()){
        } else{
                arq.createNewFile();
        }
        FileWriter fileW = new FileWriter(arq);
        BufferedWriter buffW = new BufferedWriter(fileW);
        tempoInicio = getHora();
        buffW.write("INICIANDO SINCRONIZAÇÃO - "+getDataHora());
        buffW.write("\r\nVersão do Sincronizador: ("+VERSAO_ATUAL+")");
        buffW.write("\r\n");
        buffW.flush();
        buffW.close();
    }
    
    public static void ocorreuUmErroLog(String nomeMetodoErro, String erro, Log logPadrao, Log logErro) throws IOException{
        System.err.println("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+erro);
        
        logPadrao.escreveStringLog("\n");
        logPadrao.escreveStringLog("[ATENÇÃO]: OCORREU UM ERRO EM: "+nomeMetodoErro+"\n"
        + "Abra o log de erro para mais detalhes.\n");
        logErro = new Log(true);
        logErro.escreveStringLog("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+erro);
        logErro.fechaLogErro();  
    }
    
    public static void ocorreuUmErroLog(String nomeMetodoErro, String erro, Log logErro) throws IOException{
        System.err.println("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+erro);
        
        logErro = new Log(true);
        logErro.escreveStringLog("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+erro);
        logErro.fechaLogErro();  
    }

    public static void ocorreuUmErroLog(String nomeMetodoErro, Exception e, Log logPadrao, Log logErro) throws IOException{
        System.err.println("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+util.Tools.getExceptionStackTrace(e));
        
        logPadrao.escreveStringLog("\n");
        logPadrao.escreveStringLog("[ATENÇÃO]: OCORREU UM ERRO EM: "+nomeMetodoErro+"\n"
            + "Abra o log de erro para mais detalhes.\n");
//        logPadrao.fechaLog();
        logErro = new Log(true);
        logErro.escreveStringLog("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+util.Tools.getExceptionStackTrace(e));
        logErro.fechaLogErro();  
    }
    
    public static void ocorreuUmErroLog(String nomeMetodoErro, Exception e, Log logErro) throws IOException{
        System.err.println("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+util.Tools.getExceptionStackTrace(e));
        
        logErro = new Log(true);
        logErro.escreveStringLog("[RAIZ DO ERRO]: ("+nomeMetodoErro+")\n"
            + "[DETALHES]: "+util.Tools.getExceptionStackTrace(e));
        logErro.fechaLogErro();  
    }
    
    private static void iniciaLogErro() throws IOException {
        String path = new File(".").getCanonicalPath();
        File dir = new File(path+"\\logsErro\\");
        dir.mkdirs();
        arq = new File(dir, "LogEntregasERRO."+logId+".txt");

        if(arq.exists()){
        } else{
            arq.createNewFile();
        }
        FileWriter fileW = new FileWriter(arq);
        BufferedWriter buffW = new BufferedWriter(fileW);
        tempoInicio = getHora();
        buffW.write("LOG DE ERRO - " + getDataHora());
        buffW.write("\r\nVersão do Sincronizador: (" + VERSAO_ATUAL + ")");
        buffW.write("\r\n");
            buffW.write("\r\n");
            buffW.flush();
            buffW.close();
    }
    
    private static String geraLogid(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");  
        LocalDateTime now = LocalDateTime.now();  
        return dtf.format(now);
    }
    
    private static String getDataHora(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        return dtf.format(now);
    }
    
    private static String getHora(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        return dtf.format(now);
    }
    
    public void escreveLog(String classeAtualizada) throws IOException{
        FileWriter fileW = new FileWriter(arq, true);
        if(classeAtualizada.equals("CarteiraCliente") || classeAtualizada.equals("CondicaoPagamento") || 
                classeAtualizada.equals("TipoProdutoFilho") || classeAtualizada.equals("TipoProdutoNeto")){
            try (BufferedWriter buffW = new BufferedWriter(fileW)) {
                buffW.write("\r\n"+getDataHora()+" \t    "+classeAtualizada);
                buffW.flush();
                buffW.close();
            }
        }else{
            try (BufferedWriter buffW = new BufferedWriter(fileW)) {
                buffW.write("\r\n"+getDataHora()+" \t    "+classeAtualizada);
                buffW.flush();
                buffW.close();
            }
        }
    }
    
    public void escreveStringLog(String valor) throws IOException{
        FileWriter fileW = new FileWriter(arq, true);
        try (BufferedWriter buffW = new BufferedWriter(fileW)) {
            buffW.write("\r\n"+valor);
            buffW.flush();
            buffW.close();
        }
    }
    
    public void fechaLog() throws IOException{
        FileWriter fileW = new FileWriter(arq, true);
        try (BufferedWriter buffW = new BufferedWriter(fileW)) {
            buffW.write("\r\n");
            buffW.write("\r\n");
            buffW.write("\r\n");
            tempoFim = getHora();
            buffW.write("SINCRONIZAÇÃO TERMINADA - "+getDataHora());
            buffW.write("\r\n");
            buffW.write(getTempoSincronizacaoTotal(tempoInicio, tempoFim));
            buffW.flush();
            buffW.close();
            System.exit(0);
        }
    }
    
    public void fechaLogErro() throws IOException{
        FileWriter fileW = new FileWriter(arq, true);
        try (BufferedWriter buffW = new BufferedWriter(fileW)) {
            buffW.write("\r\n");
            buffW.write("\r\n");
            buffW.write("\r\n");
            tempoFim = getHora();
            buffW.write("SINCRONIZAÇÃO FINALIZADA - "+getDataHora());
            buffW.flush();
            buffW.close();
            System.exit(0);
    }
}
    
    private String getTempoSincronizacaoTotal(String tInicial, String tFinal){
        int duracaoMinutos, duracaoSegundos;
        DateTime dinicio = DateTime.parse(tInicial, 
        DateTimeFormat.forPattern("HH:mm:ss"));
        DateTime dfinal = DateTime.parse(tFinal, 
        DateTimeFormat.forPattern("HH:mm:ss"));
        duracaoMinutos = Minutes.minutesBetween(dinicio, dfinal).getMinutes() % 60;
        duracaoSegundos =  Seconds.secondsBetween(dinicio, dfinal).getSeconds() % 60;
        return "ESTA SINCRONIZAÇÃO LEVOU: "+duracaoMinutos+" minutos e "+duracaoSegundos+" segundos";
    }
}

