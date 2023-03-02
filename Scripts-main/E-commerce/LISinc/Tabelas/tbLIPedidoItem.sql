CREATE TABLE [dbo].[LI_PEDIDO_ITEM](
	[id_pedido_item] [varchar](20) NOT NULL,
	[altura] [varchar](20) NULL,
	[disponibilidade] [varchar](20) NULL,
	[largura] [varchar](20) NULL,
	[linha] [varchar](20) NULL,
	[ncm] [varchar](20) NULL,
	[nome] [varchar](100) NULL,
	[id_pedido] [varchar](20) NULL,
	[peso] [float] NULL,
	[preco_cheio] [float] NULL,
	[preco_custo] [float] NULL,
	[preco_promocional] [float] NULL,
	[preco_subtotal] [float] NULL,
	[preco_venda] [float] NULL,
	[produto] [varchar](40) NULL,
	[produto_pai] [varchar](20) NULL,
	[profundidade] [varchar](20) NULL,
	[quantidade] [float] NULL,
	[sku] [varchar](20) NULL,
	[tipo] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LI_PEDIDO_ITEM]  WITH CHECK ADD FOREIGN KEY([id_pedido])
REFERENCES [dbo].[LI_PEDIDO] ([id_pedido])
GO

