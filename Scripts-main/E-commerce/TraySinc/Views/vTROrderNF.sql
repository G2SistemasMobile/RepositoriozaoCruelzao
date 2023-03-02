CREATE view [dbo].[V_TR_ORDER_NF] as
	SELECT A.Conta as ContaPedido, 
		 A.Entidadeid_Loja as LojaPedido,  
		 Nfe.Conta as ContaNFE, 
		 Nfe.Entidadeid_loja as LojaNFE,
		 b.CODIGO_PEDIDO as OrderID, 
		 cast(nfe.dataemissao as DATE) as issueDate,  
		 Nfe.NumDocumento as number,  
		 nfe2.serie_nfe as Serie, 
		 nfe.valortotalnota as Value, 
		 nfe2.Numdocumento_nfe as Nfekey, 
		 '' as link, X.procnfe as xmlDanfe 
	FROM movimento_dia a join PREVENDA_PEDIDO_TR B on (a.conta = b.conta and a.entidadeid_loja = b.ENTIDADEID_LOJA)
		 join movimento_dia Nfe on ( a.conta = nfe.contaorigem)
		 join movimento_dia_nfe Nfe2 on (nfe.conta = nfe2.conta and nfe.entidadeid_loja = nfe2.entidadeid_loja)
		 join nfe_xml X on (nfe.conta = x.conta and nfe.entidadeid_loja = x.entidadeid_loja)
	WHERE A.tipo = '1'
		AND a.status = '2'
		AND Nfe.Tipo = '8'
		AND Nfe.status = '3'
		AND datediff(DAY, cast(nfe.dataemissao as DATE), getdate() ) <= 7
