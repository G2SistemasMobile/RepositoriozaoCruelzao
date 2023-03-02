-- Verificação do ID (deve retornar apenas um valor, e deve ser o mesmo do CRM)
(SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601)
----------------------------------------------------------------------------------------------------------------------
/* spProcessaPedido:
		Escolher APENAS UMA para aplicar: 
 													[1]: spProcessaPedido - Orçamento (Pedidos irão cair no Orçamento)
													[2]: spProcessaPedido - PreVenda  (Pedidos irão cair na Pré-venda)
*/
----------------------------------------------------------------------------------------------------------------------
-- Inicialização de Entidades
insert into REGISTROS_SINCRONIZAR(entidadeid, DATAENTRADA)
	select entidadeid, GETDATE()
	from entidades
	where tipo in (?)
----------------------------------------------------------------------------------------------------------------------
-- Inicialização de Produtos
insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
	select produtoid, GETDATE()
	from produtos
	where TIPOPROD in (?)
----------------------------------------------------------------------------------------------------------------------
-- Inicialização do tipoEntidade 'Distribuição', para vendedores que irão utilizar Consignação
INSERT INTO TIPOENTIDADE(descricao, tipo, tipoentidadeid)
values('DISTRIBUICAO', '3', 123)
----------------------------------------------------------------------------------------------------------------------