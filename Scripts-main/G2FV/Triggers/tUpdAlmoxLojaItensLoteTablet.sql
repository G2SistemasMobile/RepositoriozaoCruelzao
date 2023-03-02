CREATE trigger [dbo].[tUpdAlmoxLojaItensLote_Tablet] on [dbo].almox_lote for update as
	insert into REGISTROS_SINCRONIZAR(PRODUTOID, DATAENTRADA)
		select produtoid, GETDATE()
		from inserted