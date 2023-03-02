/*									Duas op��es de view dispon�veis:	
									[1]: Utilizando AlmoxLojaItens
									[2]: Utilizando a TabPreco
									
									
									[ATEN��O]: Verificar se o cliente j� possui uma dessas views aplicadas; Se houver, prestar aten��o em qual regra o cliente utiliza
													para que n�o haja sobrescrita com uma view diferente. � necess�rio se atentar tamb�m aos campos marcados com "?",
													pois ele difere para cada cliente e regra. Ent�o, se o cliente j� tiver uma delas aplicada, olhar a regra antes
													de atualizar.
*/

-- [1]: Utilizando AlmoxLojaItens
CREATE VIEW [dbo].[V_LI_PRODUTO_INSERIR] AS
	SELECT P.DESCRICAO, P.ATIVO, P.ALTURA, P.LARGURA, P.PESO, P.COMPRIMENTO, P.PRODUTOID, P.CLAFISCAL as NCM, P.CODIGOCLIENTE AS GTIN, P.TIPOPROD AS CATEGORIA,
		   I.PRODUTOID_API, 
		   SUM(A.QUANTIDADE) AS QUANTIDADE
	FROM PRODUTOS AS P, 
		REGISTROS_SINCRONIZAR R,
		INTEGRACAO_ECOMMERCE_PRODUTOS AS I,
		ALMOXLOJAITENS AS A 
    WHERE I.PRODUTOID = P.PRODUTOID
		AND I.PRODUTOID = R.PRODUTOID
		AND I.PRODUTOID = A.PRODUTOID
		AND A.ALMOXID in (?)
		AND A.ENTIDADEID_LOJA = ?
		AND PRODUTOID_API IS NULL
    GROUP BY P.DESCRICAO, P.ATIVO, P.ALTURA, P.LARGURA, 
		P.PESO, P.COMPRIMENTO, P.PRODUTOID, P.CLAFISCAL, 
		P.CODIGOCLIENTE, P.TIPOPROD, I.PRODUTOID_API
		 
-- [2]: Utilizando a TabPreco
CREATE VIEW [dbo].[V_LI_PRODUTO_INSERIR] AS
	SELECT TPI.TABPRECOID, P.DESCRICAO, P.ATIVO, P.ALTURA, P.LARGURA, P.PESO, P.COMPRIMENTO, P.PRODUTOID, P.CLAFISCAL as NCM, P.CODIGOCLIENTE AS GTIN, P.TIPOPROD AS CATEGORIA,
		I.PRODUTOID_API, 
		A.QUANTIDADE
	FROM PRODUTOS AS P, 
		INTEGRACAO_ECOMMERCE_PRODUTOS AS I,
		ALMOXLOJAITENS AS A,
		REGISTROS_SINCRONIZAR R,
		TABPRECOITEM AS TPI
    WHERE I.PRODUTOID = P.PRODUTOID
		AND I.PRODUTOID = A.PRODUTOID
		AND I.PRODUTOID = R.PRODUTOID
		AND TPI.PRODUTOID = I.PRODUTOID
		AND TPI.TABPRECOID = ?
		AND A.ALMOXID = ?
		AND A.ENTIDADEID_LOJA = ?
		AND PRODUTOID_API IS NULL
	GROUP BY TPI.TABPRECOID, P.DESCRICAO, P.ATIVO, P.ALTURA, P.LARGURA, P.PESO, P.COMPRIMENTO, P.PRODUTOID, P.CLAFISCAL, P.CODIGOCLIENTE, P.TIPOPROD,
		I.PRODUTOID_API, A.QUANTIDADE