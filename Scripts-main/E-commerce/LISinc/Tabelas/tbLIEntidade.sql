CREATE TABLE [dbo].[LI_ENTIDADE](
	[id_entidade] [varchar](20) NOT NULL,
	[email] [varchar](60) NULL,
	[nome] [nvarchar](400) NULL,
	[sexo] [varchar](60) NULL,
	[aceita_newsletter] [bit] NOT NULL,
	[telefone_principal] [varchar](60) NULL,
	[telefone_comercial] [varchar](20) NULL,
	[telefone_celular] [varchar](60) NULL,
	[grupo_id] [varchar](60) NULL,
	[tipo] [varchar](60) NULL,
	[cpf] [varchar](60) NULL,
	[rg] [varchar](60) NULL,
	[razao_social] [nvarchar](400) NULL,
	[cnpj] [varchar](60) NULL,
	[ie] [varchar](60) NULL,
	[data_nascimento] [datetime] NULL,
	[id_endereco] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_entidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LI_ENTIDADE]  WITH CHECK ADD FOREIGN KEY([id_endereco])
REFERENCES [dbo].[LI_ENTIDADE_ENDERECO] ([id_endereco])
GO

