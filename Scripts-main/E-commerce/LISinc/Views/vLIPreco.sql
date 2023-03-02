/*									Duas opções de view disponíveis:	
									[1]: Preço por AlmoxLojaItens
									[2]: Preço por TABPRECOITEM

									[ATENÇÃO]: Verificar se o cliente já possui uma dessas views aplicadas; Se houver, prestar atenção em qual regra o cliente utiliza
													para que não haja sobrescrita com uma view diferente. É necessário se atentar também aos campos marcados com "?",
													pois ele difere para cada cliente e regra. Então, se o cliente já tiver uma delas aplicada, olhar a regra antes
													de atualizar.
*/


-- [1]: Preço por AlmoxLojaItens
CREATE VIEW [dbo].[V_LI_PRECO] AS
	SELECT	A.PRODUTOID, C.PRODUTOID_API, B.ENTIDADEID_LOJA, B.ALMOXID,
			A.PRECOVENDA AS CHEIO,
			A.PRECOCOMPRA AS CUSTO,
			case 
			  when GETDATE() between c.promocao_inicio and c.promocao_fim then c.PRECO_PROMOCAO
			  else a.PRECOVENDA 
			  end as PROMOCIONAL
	FROM	PRODUTOS A JOIN ALMOXLOJAITENS B ON (A.PRODUTOID = B.PRODUTOID)
			JOIN INTEGRACAO_ECOMMERCE_PRODUTOS C ON 		
			(B.ENTIDADEID_LOJA = C.ENTIDADEID_LOJA AND 
			B.ALMOXID = C.ALMOXID AND
			B.PRODUTOID = C.PRODUTOID)
			JOIN REGISTROS_SINCRONIZAR R ON (A.PRODUTOID = R.PRODUTOID)
	WHERE	B.ENTIDADEID_LOJA = ?
			AND B.ALMOXID = ?
			AND C.PRODUTOID_API IS NOT NULL
			AND R.DATAENTRADA >= (SELECT DATA_ULTIMA_SINCRONIZACAO FROM INTEGRACAO_ECOMMERCE WHERE INTEGRACAOID = 1)
	GROUP BY A.PRODUTOID, C.PRODUTOID_API, B.ENTIDADEID_LOJA, B.ALMOXID,
			A.PRECOVENDA, A.PRECOCOMPRA, c.PRECO_PROMOCAO, a.PRECOVENDA, c.promocao_inicio, c.promocao_fim


-- [2]: Preço por TABPRECOITEM
CREATE VIEW [dbo].[V_LI_PRECO] AS
	SELECT	A.PRODUTOID, C.PRODUTOID_API, C.ENTIDADEID_LOJA, C.ALMOXID,
			A.PRECOVENDA AS CHEIO,
			A.PRECOCOMPRA AS CUSTO,
			case 
			  when GETDATE() between c.promocao_inicio and c.promocao_fim then c.PRECO_PROMOCAO
			  else a.PRECOVENDA 
			  end as PROMOCIONAL
	FROM PRODUTOS A JOIN TABPRECOITEM B ON (A.PRODUTOID = B.PRODUTOID)
		 JOIN INTEGRACAO_ECOMMERCE_PRODUTOS C ON (B.PRODUTOID = C.PRODUTOID)
		 JOIN REGISTROS_SINCRONIZAR R ON (A.PRODUTOID = R.PRODUTOID)
	WHERE  C.ENTIDADEID_LOJA = ?
		AND C.ALMOXID = ?
		AND B.TABPRECOID = ?
		AND C.PRODUTOID_API IS NOT NULL
		AND R.DATAENTRADA >= (SELECT DATA_ULTIMA_SINCRONIZACAO FROM INTEGRACAO_ECOMMERCE WHERE INTEGRACAOID = 1)
	GROUP BY A.PRODUTOID, C.PRODUTOID_API, C.ENTIDADEID_LOJA, C.ALMOXID,
	  		 A.PRECOVENDA, A.PRECOCOMPRA, c.PRECO_PROMOCAO, a.PRECOVENDA, c.promocao_inicio, c.promocao_fim

