CREATE VIEW [dbo].[v_sitetipoproduto_neto] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			tipoprod,
			tipoprod_filho,
			tipoprod_neto,
			descricao,
			margem,
			comissao
	FROM tipoproduto_neto