CREATE VIEW [dbo].[v_SiteAlmoxLojaItens] as
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
		a.Entidadeid_loja,
		a.ALMOXID,
		a.produtoid,
		isnull(CASE -- verificação de lote (caso possua, pega a quantidade de lá)
			         WHEN isnull(C.LOTE, 'N') = 'S' THEN isnull((SELECT SUM(QTD_INICIAL - isnull(QTD_USADA,0))
							                        FROM ALMOX_LOTE
						                            WHERE ENTIDADEID_LOJA = A.ENTIDADEID_LOJA
						                            AND ALMOXID = A.ALMOXID
						                            AND PRODUTOID = A.PRODUTOID), 0)
			             ELSE A.QUANTIDADE
		    END, 0) as quantidade
	FROM ALMOXLOJAITENS a, REGISTROS_SINCRONIZAR b, PRODUTOS C
	WHERE a.ENTIDADEID_LOJA = ?
		AND A.PRODUTOID = C.PRODUTOID
		and a.ALMOXID IN (SELECT DISTINCT ENTIDADEID_EQUIPE FROM v_SiteEquipesVendaConsignacao UNION SELECT ? AS ENTIDADEID_EQUIPE) -- O ULTIMO UNION OBRIGATORIAMENTE DEVE SER O ALMOX PADRÃO
		and a.PRODUTOID = b.PRODUTOID
		and datediff(day, b.DATAENTRADA, getdate() ) < 7