package persistence;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import util.Log;

public class ConnectionFactory {
    private static Log lgErro;
    private static String SERVIDOR = "";
    private static String BANCODADOS = "";
    private static String url_conexao = "";  
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static String login, senha;
    private static Connection con = null;

    //Atributos para realizar conexão no Postgre
    private static final String DRIVERPOSTGRE = "org.postgresql.Driver";
//    private static final String BANCOPOSTGRE = "jdbc:postgresql://pgsql2.porta80.com.br:5432/gpinformatica2";
    private static final String BANCOPOSTGRE = "jdbc:postgresql://CLOUD64.P80.COM.BR:5432/gpinformatica2";

    private static final String USUARIOPOSTGRE = "gprod";
    private static final String SENHAPOSTGRE = "g2@9876@g2";
    
    public static Connection getConnection() throws IOException {
        try {
            if(con == null || con.isClosed()){
                try {
                    pegaConfIniciaVariaveis();
                    Class.forName(DRIVER);
                    con = DriverManager.getConnection(url_conexao, login, senha);
                } catch (Exception e) {
                    util.Log.ocorreuUmErroLog("getConnection", e, lgErro);
                }
            }
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("getConnection", e, lgErro);
        }
        return con;
    }
    
    public static Connection getConnectionPostgre() throws IOException {
        try {
            if(con == null || con.isClosed()){
                try {
                    Class.forName(DRIVERPOSTGRE);
                    con = DriverManager.getConnection(BANCOPOSTGRE, USUARIOPOSTGRE, SENHAPOSTGRE);
                } catch (Exception e) {
                    util.Log.ocorreuUmErroLog("getConnection", e, lgErro);
                }
            }
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("getConnection", e, lgErro);
        }
        return con;
    }
    
    private static void pegaConfIniciaVariaveis() throws IOException, FileNotFoundException{
        Properties conf = new Properties();
        conf.load(new FileInputStream("gpvendas.conf"));
        
        login = "gpvendas";
        senha = "gpinfo";
        SERVIDOR = conf.getProperty("SERVIDOR");
        BANCODADOS = conf.getProperty("BANCODADOS");
        String tlogin = conf.getProperty("TLOGIN");
        String tsenha = conf.getProperty("TSENHA");
                        
        if(tlogin == null) tlogin = "";
        if(tsenha == null) tsenha = "";

        login = login+tlogin;
        senha = senha+tsenha;

        url_conexao = "jdbc:sqlserver://" + SERVIDOR+ "\\sqlserver:1433;databaseName=" + BANCODADOS;
    }

    public PreparedStatement getPreparedStatement(String sql) throws IOException {
        if (con == null) {
            con = getConnection();
        }
        try {
            return con.prepareStatement(sql);
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("getPreparedStatement", e, lgErro);
        }
        return null;
    }

    public void closePreparedStatement(PreparedStatement ps) throws IOException {
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                util.Log.ocorreuUmErroLog("closePreparedStatement", e, lgErro);
            }
        }
    }

    public static void closeConnection(Connection c) throws IOException {
        try {
            c.close();
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("closeConnection", e, lgErro);
        }
    }
    
    public static void roolbackConnection(Connection c) throws IOException {
        try {
            System.err.println("Rollback efetuado na transação.\n");
            c.rollback();
        } catch (Exception e) {
            util.Log.ocorreuUmErroLog("closeConnection", e, lgErro);
        }
    }
}