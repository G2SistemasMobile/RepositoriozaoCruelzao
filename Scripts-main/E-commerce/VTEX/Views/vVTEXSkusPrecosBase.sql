CREATE VIEW V_VTEX_SKUS_PRECOS_BASE AS
	SELECT DISTINCT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		P.PRODUTOID SKU_ID,
		P.PRODUTOID,
		descricao NOME,
		P.PRECOCOMPRA PRECOCOMPRA_BASE,
		P.PRECOVENDA PRECOVENDA_BASE
	FROM PRODUTOS P JOIN INTEGRACAO_ECOMMERCE_PRODUTOS IEP ON (P.PRODUTOID = IEP.PRODUTOID)
	WHERE P.PRECOCOMPRA > 0 AND P.PRECOVENDA > 0