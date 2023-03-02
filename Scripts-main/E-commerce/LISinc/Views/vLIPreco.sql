/*									Duas op��es de view dispon�veis:	
									[1]: Pre�o por AlmoxLojaItens
									[2]: Pre�o por TABPRECOITEM

									[ATEN��O]: Verificar se o cliente j� possui uma dessas views aplicadas; Se houver, prestar aten��o em qual regra o cliente utiliza
													para que n�o haja sobrescrita com uma view diferente. � necess�rio se atentar tamb�m aos campos marcados com "?",
													pois ele difere para cada cliente e regra. Ent�o, se o cliente j� tiver uma delas aplicada, olhar a regra antes
													de atualizar.
*/


-- [1]: Pre�o por AlmoxLojaItens
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


-- [2]: Pre�o por TABPRECOITEM
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

