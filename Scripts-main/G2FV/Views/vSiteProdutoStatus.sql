CREATE VIEW [dbo].[v_siteproduto_status] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			statusid,
			descricao
	FROM Produto_Status