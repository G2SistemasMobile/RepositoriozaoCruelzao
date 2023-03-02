CREATE trigger [dbo].[tUpdAlmoxLojaItens_TABLET] on [dbo].[ALMOXLOJAITENS] for update as
	insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
		select produtoid, GETDATE()
		from inserted