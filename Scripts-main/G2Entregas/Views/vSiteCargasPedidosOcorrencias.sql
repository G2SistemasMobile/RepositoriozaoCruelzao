CREATE VIEW v_Site_CargasPedidosOcorrencias AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		OCORRENCIAID,
		DESCRICAO,
		ATIVO
	FROM OCORRENCIAS_ENTREGA