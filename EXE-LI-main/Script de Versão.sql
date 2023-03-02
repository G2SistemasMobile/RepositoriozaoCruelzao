-- [ATUAL] LISinc: Versão v1.33
CREATE TABLE INTEGRACAO_LOG(
	INTEGRACAOID INT NOT NULL,
	ENTIDADEID_LOJA INT NOT NULL,
	TIPO VARCHAR(1) NOT NULL, --1 - INICIO DO PROCESSO, 2 - DADO, 3 - FINALIZACAO INTEGRACAO
	DESCRICAO VARCHAR(400),
	DATAINTEGRACAO DATETIME)

ALTER TABLE integracao_ecommerce
	ADD DATA_ULTIMA_SINCRONIZACAO DATETIME

/*
[ATENÇÃO]: 

As views V_LI_PRECO, V_LI_ESTOQUE, V_LI_PRODUTO_ATUALIZAR e V_LI_PRODUTO_INSERIR já estão aplicadas no cliente, mas necessitam ser atualizadas.
Algumas dessas views possuem duas implementações diferentes dentro do mesmo arquivo (no GitHub), pois a regra de negócio pode variar para cada cliente.
Ex: Há clientes que utilizam AlmoxLojaItens e outros que utilizam TabPrecoItem.
Sendo assim, antes de atualizar, verificar (na view que já esta no cliente) qual regra é utilizada e quais os valores utilizados nos campos marcados com "?" (normalmente utilizado pra almox, loja ou tabpreco)
Esses cuidados fazem-se necessários para evitar sobrescrita das views já aplicadas com regras de negócios diferentes do cliente
*/

--	-> Reaplicar [V_LI_PRECO];								Disponível em: Scripts/LISinc/Views/ (GitHub) 
--	-> Reaplicar [V_LI_ESTOQUE];								Disponível em: Scripts/LISinc/Views/ (GitHub)
--	-> Reaplicar [V_LI_PRODUTO_ATUALIZAR];							Disponível em: Scripts/LISinc/Views/ (GitHub)
--	-> Reaplicar [V_LI_PRODUTO_INSERIR];							Disponível em: Scripts/LISinc/Views/ (GitHub)
--  -> Aplicar tUpdProdutosTablet, tUpdAlmoxLojaItensTablet e tUpdEntidadesTablet;		Disponível em: Scripts/LISinc/Triggers/ (GitHub)
--		Obs: As triggers acima podem já estar aplicadas, mas de toda forma, 
--			 faz-se necessário verificar se as três estão presentes;






--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTA: Se o LISinc do servidor estiver apenas uma versão anterior à atual, aplicar apenas o script acima.
			Caso contrário, aplicar os scripts retroativamente.
			Ex: Se a versão do servidor for: v1.13 e a mais atual for v1.16:
			aplicar os scripts v1.13, depois v1.14, v1.15 e em seguida v1.16.
*/
