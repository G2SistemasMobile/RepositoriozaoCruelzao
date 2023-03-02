package model.pojo;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author Junior Mourão
 */

public class Carga {
    public static final String CLASSE_DESCRICAO = "Cargas";
    public static final String CLASSE_DESCRICAO_NUVEM = "Cargas -> Nuvem";
    public static final String CLASSE_DESCRICAO_LOCAL = "Cargas <- Nuvem";
    
        private int idg2;
        private int cargaId; //entregaId
        private Timestamp data;
        private String status;
        private int entidadeIdMotorista;
        private String kmInicial;
        private String kmFinal;
        private int veiculoId;
        private int entidadeIdLoja;
        private String obs;
        private String entregue;
        private Date dataSaida;
        private Timestamp dataRetorno;
        private String nomeMotorista;
        private String placa;
        private String descricao;
        private int statusSincronizacao; //1 - RECEBIDO PELO BD LOCAL (INSERT NO POSTGRES)
                                     //2 - ENVIADO DO WS PARA O BD LOCAL (UPDATE NO SQLSERVER)
   
    public Carga(){}

    public int getCargaId() {
        return cargaId;
    }

    public void setCargaId(int cargaId) {
        this.cargaId = cargaId;
    }

    public Timestamp getData() {
        return data;
    }

    public void setData(Timestamp data) {
        this.data = data;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStatusSincronizacao() {
        return statusSincronizacao;
    }

    public void setStatusSincronizacao(int statusSincronizacao) {
        this.statusSincronizacao = statusSincronizacao;
    }

    /*
    public String getDataEnvio() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");  
        java.util.Date date;
        date = new java.util.Date();  
        dataEnvio = formatter.format(date);

        return dataEnvio;
    }

    public void setDataEnvio(String dataEnvio) {
        this.dataEnvio = dataEnvio;
    }
*/
    public int getIdg2() {
        return idg2;
    }

    public void setIdg2(int idg2) {
        this.idg2 = idg2;
    }

    public int getEntidadeIdMotorista() {
        return entidadeIdMotorista;
    }

    public void setEntidadeIdMotorista(int entidadeIdMotorista) {
        this.entidadeIdMotorista = entidadeIdMotorista;
    }

    public String getKmInicial() {
        return kmInicial;
    }

    public void setKmInicial(String kmInicial) {
        this.kmInicial = kmInicial;
    }

    public String getKmFinal() {
        return kmFinal;
    }

    public void setKmFinal(String kmFinal) {
        this.kmFinal = kmFinal;
    }

    public int getVeiculoId() {
        return veiculoId;
    }

    public void setVeiculoId(int veiculoId) {
        this.veiculoId = veiculoId;
    }

    public int getEntidadeIdLoja() {
        return entidadeIdLoja;
    }

    public void setEntidadeIdLoja(int entidadeIdLoja) {
        this.entidadeIdLoja = entidadeIdLoja;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }

    public String getEntregue() {
        return entregue;
    }

    public void setEntregue(String entregue) {
        this.entregue = entregue;
    }

    public Date getDataSaida() {
        return dataSaida;
    }

    public void setDataSaida(Date dataSaida) {
        this.dataSaida = dataSaida;
    }

    public Timestamp getDataRetorno() {
        return dataRetorno;
    }

    public void setDataRetorno(Timestamp dataRetorno) {
        this.dataRetorno = dataRetorno;
    }

    public String getNomeMotorista() {
        return nomeMotorista;
    }

    public void setNomeMotorista(String nomeMotorista) {
        this.nomeMotorista = nomeMotorista;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    @Override
    public String toString() {
        return "Carga{" + "idg2=" + idg2 + ", cargaId=" + cargaId + ", data=" + data + ", status=" + status + ", entidadeIdMotorista=" + entidadeIdMotorista + ", kmInicial=" + kmInicial + ", kmFinal=" + kmFinal + ", veiculoId=" + veiculoId + ", entidadeIdLoja=" + entidadeIdLoja + ", obs=" + obs + ", entregue=" + entregue + ", dataSaida=" + dataSaida + ", dataRetorno=" + dataRetorno + ", nomeMotorista=" + nomeMotorista + ", placa=" + placa + ", descricao=" + descricao + ", statusSincronizacao=" + statusSincronizacao + '}';
    }
    
}
