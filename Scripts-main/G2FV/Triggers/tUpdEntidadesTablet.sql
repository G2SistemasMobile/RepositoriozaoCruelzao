CREATE trigger [dbo].[tUpdEntidades_TABLET] on [dbo].[entidades] for Insert, update as
	insert into REGISTROS_SINCRONIZAR(entidadeid, DATAENTRADA)
		select entidadeid, GETDATE()
		from inserted