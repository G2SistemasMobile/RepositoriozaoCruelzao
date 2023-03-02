CREATE view [dbo].[V_LI_CATEGORIA] AS
	select A.tipoprod as id, 
		   A.descricao as descricao 
	from tipoproduto A JOIN PRODUTOS B ON (A.TIPOPROD = B.TIPOPROD)
		  JOIN INTEGRACAO_ECOMMERCE_PRODUTOS C ON (C.PRODUTOID = B.PRODUTOID)
	GROUP BY A.tipoprod, A.descricao 