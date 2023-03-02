CREATE TABLE [dbo].[tbG2AutoMobileParametros](
	[parametro] [int] NOT NULL,
	[valor] [varchar](10) NULL,
	[descricao] [varchar](300) NULL,
	[detalhes] [varchar](300) NULL,
	[variavel_parametro] [varchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[parametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]