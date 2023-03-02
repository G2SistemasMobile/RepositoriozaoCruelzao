/*									Duas opções de view disponíveis:	
									[1]: Quantidade por AlmoxLojaItens
									[2]: Quantidade por V_PRODESTOQUE_CONSULTA

									[ATENÇÃO]: Verificar se o cliente já possui uma dessas views aplicadas; Se houver, prestar atenção em qual regra o cliente utiliza
													para que não haja sobrescrita com uma view diferente. É necessário se atentar também aos campos marcados com "?",
													pois ele difere para cada cliente e regra. Então, se o cliente já tiver uma delas aplicada, olhar a regra antes
													de atualizar.
*/


-- [1]: Quantidade por AlmoxLojaItens
CREATE VIEW [dbo].[V_LI_ESTOQUE] AS
	SELECT A.ENTIDADEID_LOJA, 1 as ALMOXID, 
			A.PRODUTOID,
			B.PRODUTOID_API,
			's' as Gerenciado,
			sum(A.Quantidade) as Quantidade,
			0.0 as Quant_Reservada,
			0.0 as Quant_Disponivel,
			'' as resource_uri,
			0 as situacao_em_estoque, 
			-1 as situacao_sem_estoque 
	FROM ALMOXLOJAITENS A JOIN INTEGRACAO_ECOMMERCE_PRODUTOS B ON 
		 (A.ENTIDADEID_LOJA = B.ENTIDADEID_LOJA AND
		 A.PRODUTOID = B.PRODUTOID)
		 JOIN REGISTROS_SINCRONIZAR C ON (A.PRODUTOID = C.PRODUTOID)
	WHERE A.entidadeid_loja = ?
		  AND A.almoxid = ?
		  AND B.PRODUTOID_API IS NOT NULL
		  AND C.DATAENTRADA >= (SELECT DATA_ULTIMA_SINCRONIZACAO FROM INTEGRACAO_ECOMMERCE WHERE INTEGRACAOID = 1)
	group by A.ENTIDADEID_LOJA, A.PRODUTOID, B.PRODUTOID_API


-- [2]: Quantidade por V_PRODESTOQUE_CONSULTA
CREATE VIEW [dbo].[V_LI_ESTOQUE] AS
	SELECT A.ENTIDADEID_LOJA, A.ALMOXID, 
			A.PRODUTOID,
			B.PRODUTOID_API,
			's' as Gerenciado,
			c.qtestoque as Quantidade,
			0.0 as Quant_Reservada,
			0.0 as Quant_Disponivel,
			'' as resource_uri,
			0 as situacao_em_estoque, 
			-1 as situacao_sem_estoque 
	FROM ALMOXLOJAITENS A JOIN INTEGRACAO_ECOMMERCE_PRODUTOS B ON 
		 (A.ENTIDADEID_LOJA = B.ENTIDADEID_LOJA AND 
		  A.ALMOXID = B.ALMOXID AND
		  A.PRODUTOID = B.PRODUTOID) 
 		 join V_PRODESTOQUE_CONSULTA C on (a.entidadeid_loja =c.entidadeid_loja and a.almoxid = c.almoxid and a.produtoid = c.produtoid)
		 JOIN REGISTROS_SINCRONIZAR R ON (A.PRODUTOID = R.PRODUTOID)
	WHERE A.entidadeid_loja = ?
		  and A.almoxid = ?
		  AND b.PRODUTOID_API IS NOT NULL
		  AND R.DATAENTRADA >= (SELECT DATA_ULTIMA_SINCRONIZACAO FROM INTEGRACAO_ECOMMERCE WHERE INTEGRACAOID = 1)
	GROUP BY A.ENTIDADEID_LOJA, A.ALMOXID, A.PRODUTOID, B.PRODUTOID_API, C.qtestoque

		

/*
gerenciado: Define se o estoque será gerenciado pela Loja Integrada, 
caso não seja gerenciado o estoque sempre será definido pelo campo 
situacao_em_estoque e o campo quantidade será ignorado.
quantidade: Define a quantidade de produto que está atualmente em estoque.
situacao_em_estoque: Define o prazo para envio do produto. 
Use 0 (zero) para imediato e 1 (ou qualquer o outro inteiro positivo) para prazo de envio em x dias.
situacao_sem_estoque: Só é usado quando o campo gerenciado estiver definido como true. 
Define o prazo de envio do produto assim que o estoque chegar a zero. 
Use -1 para deixar o tornar o produto indisponível, 0 (zero)
 para deixar o prazo de envio como imediato e 1 (ou qualquer o outro inteiro positivo) 
 para deixar o prazo de envio para x dias
 */