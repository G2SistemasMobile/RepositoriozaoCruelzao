CREATE TABLE [dbo].[LI_SITUACAO_PEDIDO](
	[aprovado] [bit] NOT NULL,
	[cancelado] [bit] NOT NULL,
	[codigo] [varchar](40) NULL,
	[final] [bit] NOT NULL,
	[id_situacao_pedido] [varchar](20) NOT NULL,
	[nome] [varchar](50) NULL,
	[notificar_comprador] [bit] NOT NULL,
	[padrao] [bit] NOT NULL,
	[resource_uri] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_situacao_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

