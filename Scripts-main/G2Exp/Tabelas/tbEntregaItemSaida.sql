CREATE TABLE [dbo].[ENTREGA_ITEM_SAIDA](
	[ENTREGAID] [int] NOT NULL,
	[ENTIDADEID_LOJA] [int] NOT NULL,
	[ITEM] [int] NOT NULL,
	[ITEM_SAIDA] [int] NOT NULL,
	[ROMANEIO] [int] NOT NULL,
	[DATA] [datetime] NOT NULL,
	[USUARIO] [varchar](20) NOT NULL,
	[QUANTIDADE] [float] NOT NULL,
	[CONTA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ENTREGAID] ASC,
	[ENTIDADEID_LOJA] ASC,
	[ITEM] ASC,
	[ITEM_SAIDA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ENTREGA_ITEM_SAIDA]  WITH CHECK ADD FOREIGN KEY([ENTREGAID], [ENTIDADEID_LOJA], [ITEM])
REFERENCES [dbo].[ENTREGA_ITEM] ([ENTREGAID], [ENTIDADEID_LOJA], [ITEM])
GO

