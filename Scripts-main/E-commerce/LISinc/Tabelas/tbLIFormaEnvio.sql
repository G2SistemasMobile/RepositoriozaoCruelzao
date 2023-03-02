CREATE TABLE [dbo].[LI_FORMA_ENVIO](
	[code] [varchar](200) NULL,
	[id_forma_envio] [varchar](20) NOT NULL,
	[nome] [varchar](200) NULL,
	[tipo] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_forma_envio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

