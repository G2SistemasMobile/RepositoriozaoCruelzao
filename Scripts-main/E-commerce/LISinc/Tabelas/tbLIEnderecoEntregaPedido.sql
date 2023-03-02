CREATE TABLE [dbo].[LI_ENDERECO_ENTREGA_PEDIDO](
	[bairro] [varchar](100) NULL,
	[cep] [varchar](100) NULL,
	[cidade] [varchar](100) NULL,
	[cnpj] [varchar](100) NULL,
	[complemento] [varchar](200) NULL,
	[cpf] [varchar](200) NULL,
	[endereco] [varchar](200) NULL,
	[estado] [varchar](100) NULL,
	[id_endereco_entrega_pedido] [varchar](20) NOT NULL,
	[ie] [varchar](100) NULL,
	[nome] [varchar](200) NULL,
	[numero] [varchar](100) NULL,
	[pais] [varchar](100) NULL,
	[razao_social] [varchar](100) NULL,
	[referencia] [varchar](100) NULL,
	[rg] [varchar](100) NULL,
	[tipo] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_endereco_entrega_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

