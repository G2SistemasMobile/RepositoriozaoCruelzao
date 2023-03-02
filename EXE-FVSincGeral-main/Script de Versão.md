# Histórico de Scripts - Atualização do FVSincGeral
Este histórico foi criado para auxiliar na atualização do FVSincGeral.

## Como Utilizar?
Suponha que a versão do FVSincGeral na máquina cliente é a v1.45 e a versão mais atual seja a v1.63**\
Logo, é necessário, aplicar os scripts presentes na v1.46 até chegar na v1.63 **(A ordem importa)**\
Ou seja, será aplicado os scripts da v1.46, v1.47, v1.48.... v1.61, v1.62 e v1.63

## v1.72 [Versão Atual]
- Nenhum escript a ser aplicado p/ esta versão
- Correção do método registraVersaoAtual na class JDBCSincronizadorVersaoDAO
- Ajuste do método upsertEntidadeCadastradaAPP, incluido a chamado ao método updateStatusEntidadeCadastradoAPP na class JDBCEntidadeDAO 

## v1.70 - 71 
- Nenhum escript a ser aplicado p/ esta versão

## v1.69
**Reaplicar:**
- [vSitePedidosFaturados](https://github.com/G2SistemasMob/Scripts/blob/8841a8a356b13b91047776352f1b03e5114600f8/G2FV/Views/vSitePedidosFaturados.sql)
- [vSitePedidosFaturadosItens](https://github.com/G2SistemasMob/Scripts/blob/8841a8a356b13b91047776352f1b03e5114600f8/G2FV/Views/vSitePedidosFaturadosItens.sql)

## v1.68
- Nenhum escript a ser aplicado p/ esta versão

## v1.67
**Reaplicar:**
- [vSiteCondicaoPagamento](https://github.com/G2SistemasMob/Scripts/blob/38e167ee24f6b9612de6428e80493cf009492c93/G2FV/Views/vSiteCondicaoPagamento.sql)

## v1.62 - v1.66
- Nenhum escript a ser aplicado p/ esta versão

## v1.61
**Aplicar:**
- [tbTabletEntidadesImagens](https://github.com/G2SistemasMob/Scripts/blob/bb0718bf907bf8fb582d272703cd32eac814e547/G2FV/Tabelas/tbTabletEntidadesImagens.sql)

**Reaplicar:**
- [vSiteEntidades](https://github.com/G2SistemasMob/Scripts/blob/90947ac33539b303b9feb7a56afc9b93f585082c/G2FV/Views/vSiteEntidades.sql)
		   
## v1.60
**Reaplicar:**
- [vSiteContasaReceber](https://github.com/G2SistemasMob/Scripts/blob/bb0718bf907bf8fb582d272703cd32eac814e547/G2FV/Views/vSiteContasaReceber.sql)
- [vSiteProdutos](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteProdutos.sql)

## v1.58 - v1.59
- Nenhum escript a ser aplicado p/ esta versão

## v1.57
- Nenhum escript a ser aplicado p/ esta versão

## v1.56
**Aplicar:**
- [tbVendedorIndicador](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Tabelas/tbVendedorIndicador.sql)
- [vSiteIndicesVenda](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteIndicesVenda.sql)

**Reaplicar:**
- [vSiteVendedores](https://github.com/G2SistemasMob/Scripts/blob/bb0718bf907bf8fb582d272703cd32eac814e547/G2FV/Views/vSiteVendedores.sql)

**Adicionar:**
- 'condicaoId' na view **[vSiteTabPreco]**

## v1.55
**Aplicar:**
- [vSiteMovDiaCheckList](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteMovDiaCheckList.sql)
- [tbTabletMovimentoDiaCheckList](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Tabelas/tbTabletMovimentoDiaCheckList.sql)
- [tbMovimentoDiaCheckList](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Tabelas/tbMovimentoDiaCheckList.sql)
- [vSiteCheckListOS](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteCheckListOS.sql)

## v1.54
**Aplicar:**
- [vSiteMovDiaOrdensServico](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteMovDiaOrdensServico.sql)
- [vSiteItensDiaOrdensServico](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteItensDiaOrdensServico.sql)

## v1.53
**Reaplicar:**
- [vSiteConsignacaoRotaVendedor](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteConsignacaoRotaVendedor.sql)
- [vSiteMovDiaConsignacoes](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteMovDiaConsignacoes.sql)
- [vSiteItensDiaConsignacoes](https://github.com/G2SistemasMob/Scripts/blob/b0bfa900243d37dc30309763f9f21b4c3474e92f/G2FV/Views/vSiteItensDiaConsignacoes.sql)
			
## v1.47 - V1.52
- Nenhum escript a ser aplicado p/ esta versão

## v1.46
~~~~sql
ALTER TABLE TABLET_ENTIDADES
ADD OBS VARCHAR(400),
	REFERENCIA_COMPLEMENTO VARCHAR(400),
	RESPONSAVEL_CONTATO VARCHAR(400),
	EMAIL VARCHAR(100)
~~~~
## v1.45
~~~~sql
CREATE TABLE TABLET_CONSIGNACAO_FATURAS(
	[FATURAID] [int] NOT NULL,
	[VALOR] [float] NOT NULL,
	[FORMAPAGID] [int] NULL,
	[RECEBIMENTO_ID] [int] NOT NULL,
	[CONSIGNACAO_ID] [varchar](30) NOT NULL,
	[DATA_PAGAMENTO] [datetime] NULL,
	[ENTIDADEID_VENDEDOR] [int] NULL,
	[ENTIDADEID_LOJA] [int] NULL,
	PRIMARY KEY (FATURAID, RECEBIMENTO_ID, CONSIGNACAO_ID))
~~~~

## v1.44
~~~~sql
CREATE TABLE TABLET_CONSIGNACAO_RECEBIMENTO(
	RECEBIMENTO_ID INTEGER,
	CONSIGNACAO_ID VARCHAR(20),
	PRODUTO_ID INTEGER,
	DATA_RECEBIMENTO DATETIME,
	DEVOLUCOES INTEGER,
	COMPRAS INTEGER,
	DOCUMENTO VARCHAR(20),
	ENTIDADEID_VENDEDOR INTEGER,
	PRIMARY KEY (RECEBIMENTO_ID, CONSIGNACAO_ID, PRODUTO_ID))

ALTER TABLE TABLET_PEDIDOS ALTER COLUMN STATUS VARCHAR(10);
ALTER TABLE TABLET_PEDIDOS ALTER COLUMN STATUS_TABLET VARCHAR(10);
ALTER TABLE TABLET_PEDIDOS ALTER COLUMN STATUS_SITE VARCHAR(10);
ALTER TABLE TABLET_PEDIDOS ALTER COLUMN STATUS_RECEPCAO VARCHAR(10);
~~~~
## v1.43 -
**Aplicar:** 
- [vSiteTipoVisitaSemPedido](https://github.com/G2SistemasMob/Scripts/blob/bb0718bf907bf8fb582d272703cd32eac814e547/G2FV/Views/vSiteTipoVisitaSemPedido.sql)
