Create TRIGGER TInsUpdCargaRomaneioPed on Carga_Romaneio_Ped for Insert, Update as
	insert into REGISTROS_SINCRONIZAR(cargaid, DATAENTRADA)
	select cargaid, getdate()
	from inserted