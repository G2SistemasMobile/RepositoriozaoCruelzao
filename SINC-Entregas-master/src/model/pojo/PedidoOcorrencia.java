/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.pojo;

/**
 *
 * @author JUNIOR
 */
public class PedidoOcorrencia {
    public static final String CLASSE_DESCRICAO_LOCAL = "PedidoOcorrencia -> Nuvem";
    
    private int idg2;
    private int ocorrenciaId;
    private String descricao;
    private String ativo;
    
    public PedidoOcorrencia(){}
    
    public int getIdg2(){
        return idg2;
    }
    
    public void setIdg2(int idg2){
        this.idg2 = idg2;
    }

    public int getOcorrenciaId() {
        return ocorrenciaId;
    }

    public void setOcorrenciaId(int ocorrenciaId) {
        this.ocorrenciaId = ocorrenciaId;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getAtivo() {
        return ativo;
    }

    public void setAtivo(String ativo) {
        this.ativo = ativo;
    }

    @Override
    public String toString() {
        return "PedidoOcorrencia{" + "idg2=" + idg2 + ", ocorrenciaId=" + ocorrenciaId + ", descricao=" + descricao + ", ativo=" + ativo + '}';
    }
}
