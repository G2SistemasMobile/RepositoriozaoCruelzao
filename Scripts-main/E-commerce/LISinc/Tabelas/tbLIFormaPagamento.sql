CREATE TABLE [dbo].[LI_FORMA_PAGAMENTO](
	[codigo] [varchar](30) NULL,
	[configuracao_ativo] [bit] NOT NULL,
	[configuracao_disponivel] [bit] NOT NULL,
	[id_forma_pagamento] [varchar](20) NOT NULL,
	[imagem] [varchar](200) NULL,
	[nome] [varchar](40) NULL,
	[resource_uri] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_forma_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

