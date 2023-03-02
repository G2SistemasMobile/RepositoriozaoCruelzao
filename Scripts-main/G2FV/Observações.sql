-- Verifica��o do ID (deve retornar apenas um valor, e deve ser o mesmo do CRM)
(SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601)
----------------------------------------------------------------------------------------------------------------------
/* spProcessaPedido:
		Escolher APENAS UMA para aplicar: 
 													[1]: spProcessaPedido - Or�amento (Pedidos ir�o cair no Or�amento)
													[2]: spProcessaPedido - PreVenda  (Pedidos ir�o cair na Pr�-venda)
*/
----------------------------------------------------------------------------------------------------------------------
-- Inicializa��o de Entidades
insert into REGISTROS_SINCRONIZAR(entidadeid, DATAENTRADA)
	select entidadeid, GETDATE()
	from entidades
	where tipo in (?)
----------------------------------------------------------------------------------------------------------------------
-- Inicializa��o de Produtos
insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
	select produtoid, GETDATE()
	from produtos
	where TIPOPROD in (?)
----------------------------------------------------------------------------------------------------------------------
-- Inicializa��o do tipoEntidade 'Distribui��o', para vendedores que ir�o utilizar Consigna��o
INSERT INTO TIPOENTIDADE(descricao, tipo, tipoentidadeid)
values('DISTRIBUICAO', '3', 123)
----------------------------------------------------------------------------------------------------------------------