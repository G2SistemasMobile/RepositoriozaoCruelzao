CREATE trigger [dbo].[tUpdCargas_TABLET] on [dbo].[CARGA] for Insert, update as
	insert into REGISTROS_SINCRONIZAR(CARGAID, DATAENTRADA)
		select CARGAID, GETDATE()
		from inserted