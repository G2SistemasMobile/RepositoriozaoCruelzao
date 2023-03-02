CREATE VIEW V_VTEX_SKUS AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		P.PRODUTOID SKU_ID,
		P.PRODUTOID,
		DESCRICAO_ECOMMERCE NOME,
		CARACTERISTICA2 DESCRICAO_PEQUENA,
		CODIGOCLIENTE REFID,
		CASE WHEN (P.PESO IS NULL OR P.PESO = 0) THEN 100
			ELSE CEILING(P.PESO * 1000)
		END AS PESO_KG,
		CASE WHEN (P.COMPRIMENTO IS NULL OR P.COMPRIMENTO = 0) THEN 10
			ELSE CEILING(P.COMPRIMENTO * 100)
		END AS COMPRIMENTO,
		CASE WHEN (P.LARGURA IS NULL OR P.LARGURA = 0) THEN 10
			ELSE CEILING(P.LARGURA * 100)
		END AS LARGURA,
		CASE WHEN (P.ALTURA IS NULL OR P.ALTURA = 0) THEN 10
			ELSE CEILING(P.ALTURA * 100)
		END AS ALTURA,
		unidade UNIDADE_MEDIDA,
		'0' ISACTIVE, -- Deve ser zero, documentacao: https://developers.vtex.com/vtex-rest-api/reference/catalog-api-post-sku
		'1' ISKIT
	FROM PRODUTOS P JOIN INTEGRACAO_ECOMMERCE_PRODUTOS IEP ON(P.PRODUTOID = IEP.PRODUTOID)
	JOIN PRODUTOS_IMAGENS PIMG ON (P.PRODUTOID = PIMG.PRODUTOID)
	WHERE DESCRICAO_ECOMMERCE IS NOT NULL
	AND DESCRICAO_ECOMMERCE <> ''