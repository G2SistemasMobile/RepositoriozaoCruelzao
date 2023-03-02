package model.pojo;

import com.google.gson.Gson;
import java.sql.Date;
import java.sql.Timestamp;
import util.Tools;

/**
 *
 * @author Junior Mourão
 */
public class Pedido {
    public static final String CLASSE_DESCRICAO = "Pedidos";
    public static final String CLASSE_DESCRICAO_NUVEM = "Pedidos -> Nuvem";
    public static final String CLASSE_DESCRICAO_LOCAL = "Pedidos <- Nuvem";
    
    private int idg2;
    private int cargaId;
    private int entidadeIdLoja;
    private int entidadeIdCliente;
    private String clienteRazaoSocial;
    private String volumes;
    private String entregue;
    private int conta;
    private String ordem;
    private int numDocumento;
    private String motivoNaoEntregue;
    private String cep;
    private String endereco;
    private String numero;
    private String complemento;
    private String bairro;
    private String cidade;
    private String uf;
    private Timestamp dataEmissao;
    
    private String latitudeCheckin;
    private String longitudeCheckin;
    private String cidadeCheckin;
    private String estadoCheckin;
    private String cepCheckin;
    private String ruaCheckin;
    private Timestamp dataCheckin;
    private Timestamp dataEntrega;
    private Timestamp dataNaoEntregue;
    private int ocorrenciaid;
    
    private Timestamp dataCheckinUpd;
    private Timestamp dataEntregaUpd;
    private Timestamp dataNaoEntregueUpd;
    private byte [] canhoto;
    private int romaneioId;
    private String justificativaAtraso;
    
    
    public Pedido(){}

    public String getJustificativaAtraso() {
        return justificativaAtraso;
    }

    public void setJustificativaAtraso(String justificativaAtraso) {
        this.justificativaAtraso = justificativaAtraso;
    }

    public int getRomaneioId() {
        return romaneioId;
    }

    public void setRomaneioId(int romaneioId) {
        this.romaneioId = romaneioId;
    }
    
    public void setCanhoto(byte[] canhoto) {
        this.canhoto = canhoto;
    }
    public byte[] getCanhoto() {
        return canhoto;
    }
    
    public int getCargaId() {
        return cargaId;
    }

    public void setCargaId(int cargaId) {
        this.cargaId = cargaId;
    }

    public String getClienteRazaoSocial() {
        return clienteRazaoSocial;
    }

    public void setClienteRazaoSocial(String clienteRazaoSocial) {
        this.clienteRazaoSocial = clienteRazaoSocial;
    }

    public String getVolumes() {
        return volumes;
    }

    public void setVolumes(String volumes) {
        this.volumes = volumes;
    }

    public String getEntregue() {
        if(entregue == null) entregue = "N";
        return entregue;
    }

    public void setEntregue(String entregue) {
        if(entregue == null) this.entregue = "N";
        else this.entregue = entregue;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public int getEntidadeIdLoja() {
        return entidadeIdLoja;
    }

    public void setEntidadeIdLoja(int entidadeIdLoja) {
        this.entidadeIdLoja = entidadeIdLoja;
    }

    public int getEntidadeIdCliente() {
        return entidadeIdCliente;
    }

    public void setEntidadeIdCliente(int entidadeIdCliente) {
        this.entidadeIdCliente = entidadeIdCliente;
    }

    public int getIdg2() {
        return idg2;
    }

    public void setIdg2(int idg2) {
        this.idg2 = idg2;
    }

    public int getConta() {
        return conta;
    }

    public void setConta(int conta) {
        this.conta = conta;
    }

    public String getOrdem() {
        return ordem;
    }

    public void setOrdem(String ordem) {
        this.ordem = ordem;
    }

    public int getNumDocumento() {
        return numDocumento;
    }

    public void setNumDocumento(int numDocumento) {
        this.numDocumento = numDocumento;
    }

    public String getMotivoNaoEntregue() {
        if(motivoNaoEntregue == null) return "";
        else return motivoNaoEntregue;
    }

    public void setMotivoNaoEntregue(String motivoNaoEntregue) {
        this.motivoNaoEntregue = motivoNaoEntregue;
    }

    public Timestamp getDataEmissao() {
        return dataEmissao;
    }

    public void setDataEmissao(Timestamp dataEmissao) {
        this.dataEmissao = dataEmissao;
    }

    public String getLatitudeCheckin() {
        return latitudeCheckin;
    }

    public void setLatitudeCheckin(String latitudeCheckin) {
        this.latitudeCheckin = latitudeCheckin;
    }

    public String getLongitudeCheckin() {
        return longitudeCheckin;
    }

    public void setLongitudeCheckin(String longitudeCheckin) {
        this.longitudeCheckin = longitudeCheckin;
    }

    public String getCidadeCheckin() {
        return cidadeCheckin;
    }

    public void setCidadeCheckin(String cidadeCheckin) {
        this.cidadeCheckin = cidadeCheckin;
    }

    public String getEstadoCheckin() {
        return estadoCheckin;
    }

    public void setEstadoCheckin(String estadoCheckin) {
        this.estadoCheckin = estadoCheckin;
    }

    public String getCepCheckin() {
        return cepCheckin;
    }

    public void setCepCheckin(String cepCheckin) {
        this.cepCheckin = cepCheckin;
    }

    public String getRuaCheckin() {
        return ruaCheckin;
    }

    public void setRuaCheckin(String ruaCheckin) {
        this.ruaCheckin = ruaCheckin;
    }

    public Timestamp getDataCheckin() {
        return dataCheckin;
    }

    public void setDataCheckin(Timestamp dataCheckin) {
        this.dataCheckin = dataCheckin;
    }

    public int getOcorrenciaid() {
        return ocorrenciaid;
    }

    public void setOcorrenciaid(int ocorrenciaid) {
        this.ocorrenciaid = ocorrenciaid;
    }

    public Timestamp getDataEntregaUpd() {
        return dataEntregaUpd;
    }

    public void setDataEntregaUpd(Timestamp dataEntregaUpd) {
        this.dataEntregaUpd = dataEntregaUpd;
    }

    public Timestamp getDataEntrega() {
        return dataEntrega;
    }

    public void setDataEntrega(Timestamp dataEntrega) {
        this.dataEntrega = dataEntrega;
    }

    public Timestamp getDataNaoEntregue() {
        return dataNaoEntregue;
    }

    public void setDataNaoEntregue(Timestamp dataNaoEntregue) {
        this.dataNaoEntregue = dataNaoEntregue;
    }

    public Timestamp getDataCheckinUpd() {
        return dataCheckinUpd;
    }
    
    public Timestamp verificaData(Timestamp data) {
        if(data != null) return Tools.getTodayTimestamp();
        else return null;
    }

    public void setDataCheckinUpd(Timestamp dataCheckinUpd) {
        this.dataCheckinUpd = dataCheckinUpd;
    }

    public Timestamp getDataNaoEntregueUpd() {
        return dataNaoEntregueUpd;
    }

    public void setDataNaoEntregueUpd(Timestamp dataNaoEntregueUpd) {
        this.dataNaoEntregueUpd = dataNaoEntregueUpd;
    }

    @Override
    public String toString() {
        return new Gson().toJson(this, Pedido.class);
    }
    
}

