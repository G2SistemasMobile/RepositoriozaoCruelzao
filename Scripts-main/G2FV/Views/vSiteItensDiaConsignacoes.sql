CREATE VIEW [dbo].[v_SiteItensDiaConsignacoes] AS
select (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) as idg2, * from itens_dia
where conta in (SELECT CONTA FROM v_SiteMovDiaConsignacoes)