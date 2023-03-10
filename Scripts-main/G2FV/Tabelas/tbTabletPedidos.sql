CREATE TABLE [dbo].[tablet_pedidos](
	[pedidoid] [varchar](30) NULL,
	[lojaid] [int] NOT NULL,
	[idg2] [int] NOT NULL,
	[dataemissao] [datetime] NULL,
	[formapagid] [int] NULL,
	[condicaoid] [int] NULL,
	[status] [varchar](1) NULL,
	[obs] [text] NULL,
	[entidadeid_cliente] [int] NULL,
	[entidadeid_func] [int] NULL,
	[tabprecoid] [int] NULL,
	[datagravacao] [datetime] NULL,
	[status_tablet] [varchar](1) NULL,
	[status_site] [varchar](1) NULL,
	[numpedidoempresa] [int] NULL,
	[numnota] [int] NULL,
	[datafaturamento] [datetime] NULL,
	[datarecepcao] [datetime] NULL,
	[status_recepcao] [varchar](1) NULL,
	[PRAZO] [varchar](80) NULL,
	[latitude] [varchar](40) NULL,
	[longitude] [varchar](40) NULL,
	[cidade] [varchar](40) NULL,
	[estado] [varchar](40) NULL,
	[cep] [varchar](40) NULL,
	[condicaoPagPrazo] [varchar](40) NULL,
	[status2] [text] NULL,
	[pedidoEmpresa] [int] NULL,
	[entidadeIdFuncionario] [int] NULL,
	[entidadeIdCliente] [int] NULL,
	[tipoped] [int] NULL,
	[data_instalacao] [datetime] NULL,
	[data_garantia] [datetime] NULL,
	[data_compra] [datetime] NULL,
	[num_nota_compra] [varchar](100) NULL,
	[equipamento_os] [varchar](200) NULL,
	[descricao_defeito] [varchar](300) NULL,
	[cor] [varchar](50) NULL,
	[combustivel] [varchar](50) NULL,
	[ano_modelo] [varchar](10) NULL,
	[km] [int] NULL,
	[frota] [varchar](50) NULL,
	[tem_garantia] [varchar](1) NULL,
	[motorista] [varchar](300) NULL,
	[renavam] [varchar](50) NULL,
	[chassi] [varchar](50) NULL,
	[descricao_servico] [varchar](400) NULL,
	[serie_placa] [varchar](200) NULL,
	[marca_modelo] [varchar](100) NULL,
	[tipo_os] [int] NULL,
	[tipo_os_descricao] [varchar](100) NULL,
	[data_abertura] [datetime] NULL,
	[status_os] [varchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]