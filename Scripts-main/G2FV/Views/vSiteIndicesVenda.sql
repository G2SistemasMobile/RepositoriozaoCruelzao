CREATE VIEW v_SiteIndicesVenda as
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) as IDG2,
	entidadeid_func, mes, ano, descricao_mes, vendasTransmitida, vendaFaturada,
	devolucao, vendaNaoFaturada, clientesPositivados, qtd_Vendas, margemContribuicao,
	markup, descontoGeral, 0.0 vendaLiquida, 0 vendasCanceladas 
	FROM Vendedor_Indicador