CREATE trigger [dbo].[tUpdProdutos_Tablet] on [dbo].[produtos] for Insert, update as
	insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
		select PRODUTOID, GETDATE()
		from inserted