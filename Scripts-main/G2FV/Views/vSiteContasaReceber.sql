CREATE view [dbo].[v_SiteContasaReceber] as
	Select (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2, --PK
			A.Entidadeid_loja,  A.Tituloid, A.Entidadeid_cliente, A.juros, A.tipo,
			A.numdocumento, A.descricao, A.ordem, A.nossonumero, A.valor, A.datavencimento,
			A.datapagamento, A.status, A.desconto, A.outros, A.percjuros, A.percdesconto,
			A.dataemissao, A.faturaid, A.conta, A.contaid, A.obs, A.multa, A.formapagid,
			A.protestado, A.localid, A.entidadeid_func, A.pre_tituloid, A.cobranca1,
			A.cobranca2, A.cobranca3, A.data_previsao, A.data_envio, A.enviado_cartorio,
			A.chequeid, A.renegociacaoid, A.contratoid, A.entidadeid_loja_refererencia,
			MD.CONDICAOID,
			MD.TABPRECOID,
			TP.DESCRICAO tabPrecoDescricao,
			CP.Descricao condicaoPagDescricao,
			isnull((Select Sum(Valor) from ReceberItens
					Where tituloid = a.tituloid
					and entidadeid_loja = a.entidadeid_loja
					and STATUS = '2'),0) as ValorPago
	From REGISTROS_SINCRONIZAR b INNER JOIN Contas_a_Receber a ON (
			a.DATAEMISSAO >= (SELECT DATEADD(MONTH,-6, GETDATE())) -- Apenas dos ultimos 6 meses
			and a.TITULOID = b.TITULOID
			and a.ENTIDADEID_LOJA = b.ENTIDADEID_LOJA
			and A.STATUS = '1'
			AND A.CONTA IS NOT NULL)
		LEFT JOIN MOVIMENTO_DIA MD ON (MD.conta = A.CONTA and MD.entidadeid_loja = A.ENTIDADEID_LOJA)
		LEFT JOIN TABPRECO TP ON (TP.TABPRECOID = MD.TABPRECOID)
		LEFT JOIN CondicaoPagamento CP ON (CP.CONDICAOID = MD.CONDICAOID)