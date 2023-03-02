package model.pojo;


public class Cliente {

    protected int clienteId;
    protected int idg2;
    protected String descricao;
    protected String descricao2;
    protected String endereco;
    protected String numero;
    protected String complemento;
    protected String bairro;
    protected int cidadeId;
    protected int ufId;
    protected String cep;
    protected String cnpjCpf;
    protected String inscricao;
    protected String uf;
    protected String fone;
    protected String cidade;
    protected int cadastradoTablet;
    protected int idGpVendas; //entidadeid_vendedor
    protected String tipoCliente;

    public Cliente() {
    }

    public int getClienteId() {
        return clienteId;
    }

    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao2() {
        return descricao2;
    }

    public void setDescricao2(String descricao2) {
        this.descricao2 = descricao2;
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

    public int getCidadeId() {
        return cidadeId;
    }

    public void setCidadeId(int cidadeId) {
        this.cidadeId = cidadeId;
    }

    public int getUfId() {
        return ufId;
    }

    public void setUfId(int ufId) {
        this.ufId = ufId;
    }
    
    public void setTipoCliente(String tipoCliente){
        this.tipoCliente = tipoCliente;
    }
    
    public String getTipoCliente(){
        return tipoCliente;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getCnpjCpf() {
        return cnpjCpf;
    }

    public void setCnpjCpf(String cnpjCpf) {
        this.cnpjCpf = cnpjCpf;
    }

    public String getInscricao() {
        return inscricao;
    }

    public void setInscricao(String inscricao) {
        this.inscricao = inscricao;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public String getFone() {
        return fone;
    }

    public void setFone(String fone) {
        this.fone = fone;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public int getIdg2() {
        return idg2;
    }

    public void setIdg2(int idg2) {
        this.idg2 = idg2;
    }

    public int getCadastradoTablet() {
        return cadastradoTablet;
    }

    public void setCadastradoTablet(int cadastradoTablet) {
        this.cadastradoTablet = cadastradoTablet;
    }

    public int getIdGpVendas() {
        return idGpVendas;
    }

    public void setIdGpVendas(int idGpVendas) {
        this.idGpVendas = idGpVendas;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + this.clienteId;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Cliente other = (Cliente) obj;
        if (this.clienteId != other.clienteId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        //Descomentar se necessitar adicionar o tipo ao banco de dados
        //return "Cliente{" + "clienteId=" + clienteId + ", idg2=" + idg2 + ", descricao=" + descricao + ", descricao2=" + descricao2 + ", endereco=" + endereco + ", numero=" + numero + ", complemento=" + complemento + ", bairro=" + bairro + ", cidadeId=" + cidadeId + ", ufId=" + ufId + ", cep=" + cep + ", cnpjCpf=" + cnpjCpf + ", inscricao=" + inscricao + ", uf=" + uf + ", fone=" + fone + ", cidade=" + cidade + ", cadastradoTablet=" + cadastradoTablet + ", idGpVendas=" + idGpVendas +  ", tipoCliente=" + tipoCliente +'}';
        return "Cliente{" + "clienteId=" + clienteId + ", idg2=" + idg2 + ", descricao=" + descricao + ", descricao2=" + descricao2 + ", endereco=" + endereco + ", numero=" + numero + ", complemento=" + complemento + ", bairro=" + bairro + ", cidadeId=" + cidadeId + ", ufId=" + ufId + ", cep=" + cep + ", cnpjCpf=" + cnpjCpf + ", inscricao=" + inscricao + ", uf=" + uf + ", fone=" + fone + ", cidade=" + cidade + ", cadastradoTablet=" + cadastradoTablet + ", idGpVendas=" + idGpVendas +  ", tipoCliente=" + tipoCliente +'}';
   
    }

}
