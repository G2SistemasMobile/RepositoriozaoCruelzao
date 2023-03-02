CREATE VIEW [dbo].[V_TR_CATEGORIAS_NETO] AS
	SELECT distinct (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2, TPN.TIPOPROD, TPN.TIPOPROD_FILHO, TPN.TIPOPROD_NETO, TPN.DESCRICAO, 
		('3' + CAST((SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS VARCHAR(5)) 
		+ CAST(TPN.TIPOPROD_NETO AS VARCHAR(5))) AS TIPOPROD_TRAY,
		LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( REPLACE(RTRIM(LTRIM(TPN.DESCRICAO)), '&', '-'), ' ', '-'), '/', '-'), '---', '--'), '--', '-'), '(', ''), ')', ''), '.', ''), ',', '')) collate SQL_Latin1_General_Cp1251_CS_AS as slug
	FROM TIPOPRODUTO_NETO TPN, V_TR_CATEGORIAS_FILHO TPF
	WHERE TPN.tipoprod_filho = TPF.tipoprod_filho
		AND TPN.TIPOPROD = TPF.tipoprod
		AND TPN.DESCRICAO IS NOT NULL 
		AND TPN.DESCRICAO NOT LIKE ''