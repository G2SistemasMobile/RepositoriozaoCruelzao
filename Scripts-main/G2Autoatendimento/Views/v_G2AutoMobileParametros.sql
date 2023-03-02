CREATE VIEW v_G2AutoMobileParametros AS
	SELECT parametro, valor, descricao
	FROM tbG2AutoMobileParametros

/* Parâmetros disponíveis:
	SELECT 1, '1', 'Utiliza Formas de Pagamento e Desconto na tela de Pagamento', 'A utilização padrão da tela de pagamento é por pagamento a vista/a prazo. Sendo assim, ao setar esse parâmetro como verdadeiro, a tela de pagamento carregará formas de pagamento e desconto.', ''
*/
