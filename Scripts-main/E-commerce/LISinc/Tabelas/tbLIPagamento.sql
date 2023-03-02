CREATE TABLE [dbo].[LI_PAGAMENTO](
	[authorization_code] [varchar](100) NULL,
	[banco] [varchar](100) NULL,
	[bandeira] [varchar](100) NULL,
	[codigo_retorno_gateway] [varchar](100) NULL,
	[id_pagamento] [varchar](20) NOT NULL,
	[identificador_id] [varchar](100) NULL,
	[mensagem_gateway] [varchar](100) NULL,
	[pagamento_tipo] [varchar](100) NULL,
	[transacao_id] [varchar](100) NULL,
	[valor] [float] NULL,
	[valor_pago] [float] NULL,
	[id_forma_pagamento] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LI_PAGAMENTO]  WITH CHECK ADD FOREIGN KEY([id_forma_pagamento])
REFERENCES [dbo].[LI_FORMA_PAGAMENTO] ([id_forma_pagamento])
GO

