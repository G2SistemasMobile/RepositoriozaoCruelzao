CREATE VIEW [dbo].[v_siteMovimento_Dia] AS
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2, --PK
			A.conta, --PK
			A.entidadeid_loja, --PK
			A.almoxid,
			A.numdocumento,
			status,
			tipo,
			dataemissao,
			entidadeid_cliente,
			entidadeid_func,
			desconto,
			valortotalprod,
			valortotalnota,
			valdesconto,
			tiposervid,
			pedcliente,
			condicaoid,
			formapagid,
			datafechamento,
			status_conf,
			entidadeid_parceiro,
			entidadeid_func2
	From movimento_dia A, REGISTROS_SINCRONIZAR B
	Where Status = '2'
	and tipo = '1'
	AND A.CONTA = B.CONTA
	AND A.ENTIDADEID_LOJA = B.ENTIDADEID_LOJA
	AND B.DATASINCRONIZACAO IS NULL
	and Dataemissao >= '05/01/2017'