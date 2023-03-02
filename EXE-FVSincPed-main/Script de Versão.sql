-- [ATUAL] 
-- FVSincPed: Versão v1.22
-- Nenhum escript a ser aplicado p/ esta versão


-- Versão v1.20 - v1.21
-- Nenhum escript a ser aplicado p/ esta versão

-- Versão v1.19
ALTER TABLE TABLET_PEDIDOS 
	ADD OS_ACAO VARCHAR(400),
	CONTA VARCHAR(300)

ALTER TABLE TABLET_PEDIDOS_ITENS
	ADD CONTA VARCHAR(300)

/* NOTA: Se o FVSincPed do servidor estiver apenas uma versÃ£o anterior a  atual, aplicar apenas o script acima.
		 Caso contrário, aplicar os scripts retroativamente.
		 Ex: Se a versão do servidor for: v1.13 e a mais atual for v1.16:
			   aplicar os scripts v1.13, depois v1.14, v1.15 e em seguida v1.16.
*/


-- Versão v1.17 - v1.18
-- Nenhum escript a ser aplicado p/ esta versÃ£o

-- Versão v1.16
ALTER TABLE TABLET_PEDIDOS
	ADD TIPOSERVID INTEGER

-- Versão v1.15 (OU ABAIXO)
ALTER TABLE TABLET_PEDIDOS
	ADD 
		data_instalacao datetime NULL, 
		data_garantia datetime NULL,
		data_compra [datetime] NULL, 
		num_nota_compra [varchar](100) NULL, 
		equipamento_os [varchar](200) NULL,
		descricao_defeito [varchar](300) NULL, 
		cor [varchar](50) NULL, 
		combustivel [varchar](50) NULL, 
		ano_modelo [varchar](10) NULL, 
		km [int] NULL, 
		frota [varchar](50) NULL,
		tem_garantia [varchar](1) NULL,
		motorista [varchar](300) NULL,
		renavam [varchar](50) NULL,
		chassi [varchar](50) NULL, 
		descricao_servico [varchar](400) NULL,
		serie_placa [varchar](200) NULL,
		marca_modelo [varchar](100) NULL, 
		tipo_os [int] NULL,
		tipo_os_descricao [varchar](100) NULL,
		data_abertura [datetime] NULL, 
		[tipoped] [int] NULL,
		status_os [varchar](10) NULL
