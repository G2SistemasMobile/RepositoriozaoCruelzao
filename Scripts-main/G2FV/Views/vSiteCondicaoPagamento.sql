CREATE VIEW [dbo].[v_siteCondicaoPagamento] as
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		CondicaoID,
		Descricao,
		prazo
	FROM CondicaoPagamento