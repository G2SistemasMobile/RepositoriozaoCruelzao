CREATE VIEW [dbo].[v_SiteItensDiaOrdensServico] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) as idg2, * from itens_dia
		WHERE conta in (SELECT CONTA FROM v_SiteMovDiaOrdensServico)