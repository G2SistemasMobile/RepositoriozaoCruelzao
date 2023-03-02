Create TRIGGER TInsUpdCarga on Carga for Insert, Update as
	insert into REGISTROS_SINCRONIZAR(cargaid, DATAENTRADA)
	select cargaid, getdate()
	from inserted