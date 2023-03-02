CREATE VIEW [dbo].[v_sitetipoentidade] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			tipoentidadeid,
			descricao,
			tipo
	FROM tipoentidade