CREATE TABLE [dbo].[LI_ENVIO_PEDIDO](
	[data_criacao] [datetime] NULL,
	[data_modificacao] [datetime] NULL,
	[id_envio_pedido] [varchar](20) NOT NULL,
	[objeto] [varchar](20) NULL,
	[prazo] [varchar](20) NULL,
	[valor] [float] NULL,
	[id_forma_envio] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_envio_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LI_ENVIO_PEDIDO]  WITH CHECK ADD FOREIGN KEY([id_forma_envio])
REFERENCES [dbo].[LI_FORMA_ENVIO] ([id_forma_envio])
GO

