-- Verifica��o do ID (deve retornar apenas um valor, e deve ser o mesmo do CRM)
(SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601)
----------------------------------------------------------------------------------------------------------------------
-- Inicializa��o de Cargas
INSERT INTO REGISTROS_SINCRONIZAR(entidadeid, DATAENTRADA)
	SELECT CARGAID, GETDATE()
	FROM CARGA
	WHERE STATUS = 4 --> Status em Rota
----------------------------------------------------------------------------------------------------------------------
-- Adi��o do campo justificativaAtraso para receber justificativas de atraso na entrega
ALTER TABLE CARGA_ROMANEIO_PED
	ADD justificativaAtraso VARCHAR(300)
----------------------------------------------------------------------------------------------------------------------