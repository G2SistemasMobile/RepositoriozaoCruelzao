CREATE TABLE [dbo].[LI_ENTIDADE_ENDERECO](
	[bairro] [varchar](100) NULL,
	[cep] [varchar](100) NULL,
	[cidade] [varchar](100) NULL,
	[cliente] [varchar](200) NULL,
	[complemento] [varchar](100) NULL,
	[endereco] [varchar](200) NULL,
	[estado] [varchar](100) NULL,
	[id_endereco] [varchar](20) NOT NULL,
	[nome] [varchar](200) NULL,
	[numero] [varchar](100) NULL,
	[pais] [varchar](100) NULL,
	[principal] [varchar](100) NULL,
	[referencia] [varchar](100) NULL,
	[resource_uri] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_endereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

