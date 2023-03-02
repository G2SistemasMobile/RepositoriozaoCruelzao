CREATE VIEW [dbo].[V_SH_PRODUTO_ATUALIZAR] AS
	SELECT P.descricao AS name, P.descricao AS description, P.ATIVO as status, 
		P.ALTURA AS height, P.LARGURA AS width, P.PESO AS weight, P.COMPRIMENTO AS length, 
		P.PRODUTOID as SKU, A.QUANTIDADE AS qty, '' as brand, P.CODIGOCLIENTE as ean, 
		P.CODIGOCLIENTE as nbm, A.PRECOVENDA AS price, A.PRECOCOMPRA AS cost, A.PRECO_PROMOCAO AS promotional_price,
		PP.PRODUTOID_PRINCIPAL, PG.PRODUTOID, PG.GRADEID AS TAMANHO, C.DESCRICAO_CATEGORIA, SC.DESCRICAO_SUBCATEGORIA,
		P.GRUPOID2 AS CATEGORIAID, P.CATEGORIAID AS SUBCATEGORIAID
	FROM PRODUTOS AS P, 
		--INTEGRACAO_ECOMMERCE_PRODUTOS AS I,
		ALMOXLOJAITENS AS A,
		V_SH_PRODUTOS_PRINCIPAL PP,
		V_SH_PRODUTO_GRADE PG,
		V_SH_CATEGORIA AS C,
		V_SH_SUB_CATEGORIA AS SC
	WHERE A.ALMOXID = ?
		AND A.ENTIDADEID_LOJA = ?
		AND P.PRODUTOID = A.PRODUTOID
		AND P.PRODUTOID = PG.PRODUTOID	
		AND P.CODFORN = PP.CODFORN
		AND PP.CODFORN = PG.CODFORN
		AND P.GRUPOID2= C.CATID
		AND P.CATEGORIAID = SC.SUBCATID
		AND P.GRUPOID2 = SC.CATID
		AND C.CATID = SC.CATID
		--AND SH_DATA_INSERCAO IS NOT NULL
GO

