CREATE VIEW v_G2AutoMobileParametros AS
	SELECT parametro, valor, descricao
	FROM tbG2AutoMobileParametros

/* Par�metros dispon�veis:
	SELECT 1, '1', 'Utiliza Formas de Pagamento e Desconto na tela de Pagamento', 'A utiliza��o padr�o da tela de pagamento � por pagamento a vista/a prazo. Sendo assim, ao setar esse par�metro como verdadeiro, a tela de pagamento carregar� formas de pagamento e desconto.', ''
*/
