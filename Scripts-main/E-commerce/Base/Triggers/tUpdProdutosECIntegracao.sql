CREATE trigger [dbo].[tUpdIntegracaoProdutos] on [dbo].[INTEGRACAO_ECOMMERCE_PRODUTOS] for Insert, update as
	insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
		select PRODUTOID, GETDATE()
		from inserted