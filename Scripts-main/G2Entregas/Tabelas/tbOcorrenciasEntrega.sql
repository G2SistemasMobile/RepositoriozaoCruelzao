create table OCORRENCIAS_ENTREGA(
       OCORRENCIAID INT NOT NULL PRIMARY KEY,
       DESCRICAO VARCHAR(50) NOT NULL,
       ATIVO VARCHAR(1) NOT NULL)

insert into OCORRENCIAS_ENTREGA(ocorrenciaid, descricao, ativo)
values(1, 'ENDERECO ERRADO', 'S')
insert into OCORRENCIAS_ENTREGA(ocorrenciaid, descricao, ativo)
values(2, 'PEDIDO RECUSADO', 'S')
insert into OCORRENCIAS_ENTREGA(ocorrenciaid, descricao, ativo)
values(3, 'PEDIDO COM DIVERGENCIA', 'S')
insert into OCORRENCIAS_ENTREGA(ocorrenciaid, descricao, ativo)
values(4, 'VOLTAR OUTRO DIA', 'S')