CREATE VIEW [dbo].[v_sitetabprecoitem] AS
	Select (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2, --PK
			tabprecoid, --PK
			produtoid, --PK
			precovenda,
			precopromocao,
			precopromocao_de,
			precopromocao_ate,
			desconto,
			0 as quantidade
	From tabprecoitem 
	where TABPRECOID is null
	UNION
	SELECT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) AS IDG2, --PK
			1 as tabprecoid, --PK
			a.produtoid, --PK
			a.precovenda, 
			a.preco_promocao AS precopromocao,
			a.preco_promocao_de AS precopromocao_de,
			a.preco_promocao_ate AS precopromocao_ate,
			desconto AS desconto,
			0 as quantidade
	From ALMOXLOJAITENS a, REGISTROS_SINCRONIZAR B
	WHERE a.ENTIDADEID_LOJA = ?
	AND a.ALMOXID = ?
	AND A.PRODUTOID = B.PRODUTOID
	and datediff(day, b.DATAENTRADA, getdate() ) < 10
