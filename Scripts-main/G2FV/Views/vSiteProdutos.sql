******************************************************************** ATENÇÃO  ********************************************************************************************************
* [1]: Antes de aplicar esta view, pegar a view antiga e MANTER os seguintes campos iguais aos da view antiga
* Campos: descricao, produto_busca, produto_ordenacao e descricao_simples
* 	Os campos devem ser iguais aos da view antiga pois isso é da lógica do cliente. Por exemplo, há clientes que preferem visualização do produto no APP
* 	como PRODUTOID + DESCRICAO, já outros preferem CODCLI + DESCRICAO, e isso se aplica aos outros campos já mencionados antes. Por isso é importante manter
*	iguao ao da view antiga.
* [2]: É necessário MANTER o mesmo WHERE da view antiga e colocá-lo na view nova (CASO NÃO ESTEJA). Isso acontece pois há clientes que só querem um determinado tipo
*      de produto no APP

CREATE VIEW [dbo].[v_SiteProdutos] AS
	SELECT DISTINCT (SELECT VALOR FROM CONFIGURACAO WHERE PARAMETRO = 31601) as IDG2, --PK
			a.PRODUTOID, codigocliente,
			:RTRIM(LTRIM((CAST(A.PRODUTOID AS VARCHAR(100)) + ' - ' + A.DESCRICAO))) as descricao,
			:RTRIM(LTRIM((A.CODIGOCLIENTE + ' - ' + A.DESCRICAO + ' - ' + CAST(A.PRODUTOID AS VARCHAR(100))))) as produto_busca, -- concatenação para customização de busca
			:RTRIM(LTRIM(A.DESCRICAO)) as produto_ordenacao, -- campo de ordenacao de produto
			:RTRIM(LTRIM(A.DESCRICAO)) as descricao_simples, -- campo de descrição simples de produto
			unidade, precovenda, precocompra, ultimopreco, precomedio, menorpreco, tipoprod, datacadastro,
			entidadeid_fornecedor, peso, codforn, clafiscal, sittributariaid, impostoid_piscofins, marcaid,
			safraid, origemid, grupoid, tipoprodid_filho, genid, tipoprod_neto, tipoitemid, especieid, tipoveiculoid,
			grupoid2, dispid_fornecedor, statusid, categoriaid, colecaoid, referenciaid, ativo, COMISSAO, ISNULL(PIMG.PATH, '') url_img
	From REGISTROS_SINCRONIZAR B INNER JOIN produtos A ON (a.PRODUTOID = b.produtoid AND B.DATASINCRONIZACAO IS NULL)
		 LEFT JOIN PRODUTOS_IMAGENS PIMG ON (PIMG.PRODUTOID = A.PRODUTOID)
