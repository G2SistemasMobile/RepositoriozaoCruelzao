CREATE VIEW [dbo].[v_siteprodutos_grupos] AS
	Select (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
			grupoid,
			descricao
	From produtos_grupos