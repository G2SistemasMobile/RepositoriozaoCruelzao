CREATE VIEW [dbo].[v_sitetipoproduto] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			tipoprod,
			descricao
	FROM  tipoproduto