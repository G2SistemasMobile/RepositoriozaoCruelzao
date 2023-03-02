CREATE VIEW v_SitePedidosFaturadosItens AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		   A.CONTA,
		   A.ENTIDADEID_LOJA,
		   B.ITEM,
		   B.PRODUTOID, 
		   B.QUANTIDADE,
		   B.PRECO,
		   B.DESCONTO,
		   B.DATA
	FROM v_SitePedidosFaturados A JOIN ITENS_DIA B
	ON (A.CONTA = B.CONTA
	AND A.ENTIDADEID_LOJA = B.ENTIDADEID_LOJA)