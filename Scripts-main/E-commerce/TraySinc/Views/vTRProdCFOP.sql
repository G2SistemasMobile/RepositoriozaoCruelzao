CREATE VIEW [dbo].[V_TR_PROD_CFOP] AS 
	SELECT A.OrderID, B.PRODUTOID AS PRODUCTid, B.CFOP, '' as variationId
	FROM V_TR_ORDER_NF A JOIN ITENS_DIA B ON ( A.ContaNFE = B.CONTA AND A.LojaNFE = B.ENTIDADEID_LOJA)

