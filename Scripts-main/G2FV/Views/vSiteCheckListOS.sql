CREATE VIEW v_siteCheckListOS as
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) idg2, * FROM CHECKLIST_OS