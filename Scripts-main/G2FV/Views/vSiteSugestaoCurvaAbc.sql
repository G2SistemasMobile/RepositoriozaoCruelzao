CREATE VIEW [dbo].[V_SITE_SUGESTAO_CURVAABC] AS
	SELECT DISTINCT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2,
				 A.ENTIDADEID_CLIENTE,
				 E.ENTIDADEID_VENDEDOR,
				 A.PRODUTOID,
				 A.QTD_ANUAL,
				 A.PRIMEIRA_COMPRA,
				 A.MEDIA_POR_PEDIDO,
				 MAIOR_PEDIDO,
				 A.MENOR_COMPRA,
				 CASE
						WHEN   DATEDIFF(month,a.PRIMEIRA_COMPRA,   A.DATA_ULTIMA_COMPRA) = '0' THEN '0'
						WHEN   a.qtd_anual = '0' THEN '0'
						ELSE  ( a.qtd_anual/( DATEDIFF(month,a.PRIMEIRA_COMPRA,   a.DATA_ULTIMA_COMPRA)))
				 END AS MEDIA_MENSAL_ANUAL, --'Méd Per'
				 CASE
						WHEN   DATEDIFF(month,a.PRIMEIRA_COMPRA,   A.DATA_ULTIMA_COMPRA) = '0' THEN '0'
						WHEN   a.qtd_anual = '0' THEN '0'
						ELSE  ( a.qtd_anual/( DATEDIFF(month,a.PRIMEIRA_COMPRA,   a.DATA_ULTIMA_COMPRA)))
				 END AS MEDIA_MENSAL_ANUAL_MES_COM_VENDA, --'Méd Per'
			   CASE
						WHEN   A.QTD_ANUAL = '0' THEN '0'
						WHEN   A.MEDIA_MENSAL_ANUAL_MES_COM_VENDA = '0' THEN '0'
						ELSE  A.QTD_ANUAL/A.MEDIA_MENSAL_ANUAL_MES_COM_VENDA
				 END AS Frequencia,
			   CASE
						WHEN (DATEDIFF(month,A.PRIMEIRA_COMPRA,   A.DATA_ULTIMA_COMPRA) = 0 AND (A.QTD_ANUAL>0)) THEN 1
						ELSE  DATEDIFF(month,A.PRIMEIRA_COMPRA,   A.DATA_ULTIMA_COMPRA)
				 END AS Periodo,
				 A.DEVOLUCOES,
				 A.DATA_ULTIMA_COMPRA,
				 A.QTD_ULTIMA_COMPRA,
				 A.VALOR_ULTIMA_COMPRA,
				 A.GARANTIA,
				 A.DESCONTO,
				 A.NOME_PRODUTO AS PRODUTO_DESCRICAO,
				 a.DATA_ULTIMA_DEVOLUCAO,
				 PI.precovenda as PrecoMax,
				 case
			   when getdate() between PI.precopromocao_de and PI.precopromocao_ate then round(PI.precovenda - (PI.precovenda*PI.desconto/100),2)
					else precovenda
				  end as PrecoMin,	0.00 as Contagem, 0.00 as Sugestao, 0.00 as QtdeSol, 0.00 as TotalSol
	from analise_polibras as A, ENTIDADES as E, v_sitetabprecoitem as PI
	WHERE E.CODCLI = A.ENTIDADEID_CLIENTE
	and ENTIDADEID_VENDEDOR IS NOT NULL
	and A.PRODUTOID = PI.PRODUTOID
	and e.ativo = 'S'