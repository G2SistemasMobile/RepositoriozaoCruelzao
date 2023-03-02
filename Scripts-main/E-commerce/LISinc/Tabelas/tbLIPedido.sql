CREATE TABLE [dbo].[LI_PEDIDO](
	[data_criacao] [datetime] NULL,
	[data_expiracao] [datetime] NULL,
	[data_modificacao] [datetime] NULL,
	[numero] [varchar](10) NULL,
	[peso_real] [float] NULL,
	[valor_desconto] [float] NULL,
	[valor_envio] [float] NULL,
	[valor_subtotal] [float] NULL,
	[valor_total] [float] NULL,
	[id_pedido] [varchar](20) NOT NULL,
	[id_entidade] [varchar](20) NULL,
	[id_endereco_entrega_pedido] [varchar](20) NULL,
	[id_envio_pedido] [varchar](20) NULL,
	[id_pagamento] [varchar](20) NULL,
	[id_situacao_pedido] [varchar](20) NULL,
	[DATAGRAVACAO_G2] [datetime] NULL,
	[DATAPROCESSAMENTO_G2] [datetime] NULL,
	[STATUS_G2] [varchar](1) NULL,
	[cupom_desconto_aplicar_no_total] [bit] NULL,
	[cupom_desconto_ativo] [bit] NULL,
	[cupom_desconto_codigo] [varchar](40) NULL,
	[cupom_desconto_cumulativo] [bit] NULL,
	[cupom_desconto_data_criacao] [datetime] NULL,
	[cupom_desconto_data_modificacao] [datetime] NULL,
	[cupom_desconto_descricao] [varchar](80) NULL,
	[cupom_desconto_id] [varchar](40) NULL,
	[cupom_desconto_quantidade] [int] NULL,
	[cupom_desconto_quantidade_por_cliente] [int] NULL,
	[cupom_desconto_quantidade_usada] [int] NULL,
	[cupom_desconto_tipo] [varchar](40) NULL,
	[cupom_desconto_validade] [datetime] NULL,
	[cupom_desconto_valor] [float] NULL,
	[cupom_desconto_valor_minimo] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LI_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_entidade])
REFERENCES [dbo].[LI_ENTIDADE] ([id_entidade])
GO

ALTER TABLE [dbo].[LI_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_endereco_entrega_pedido])
REFERENCES [dbo].[LI_ENDERECO_ENTREGA_PEDIDO] ([id_endereco_entrega_pedido])
GO

ALTER TABLE [dbo].[LI_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_envio_pedido])
REFERENCES [dbo].[LI_ENVIO_PEDIDO] ([id_envio_pedido])
GO

ALTER TABLE [dbo].[LI_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_pagamento])
REFERENCES [dbo].[LI_PAGAMENTO] ([id_pagamento])
GO

ALTER TABLE [dbo].[LI_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_situacao_pedido])
REFERENCES [dbo].[LI_SITUACAO_PEDIDO] ([id_situacao_pedido])
GO

