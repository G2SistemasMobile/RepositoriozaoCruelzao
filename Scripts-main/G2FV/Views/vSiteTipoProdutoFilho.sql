USE [GPVENDAS_CMOTOS]
GO
CREATE VIEW [dbo].[v_sitetipoproduto_filho] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			tipoprod,
			tipoprod_filho,
			descricao
	FROM tipoproduto_filho