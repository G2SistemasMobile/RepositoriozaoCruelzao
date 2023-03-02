CREATE trigger [dbo].[tInsIntegracaoECInsVtexRelProdutos] on [dbo].[INTEGRACAO_ECOMMERCE_PRODUTOS] for Insert as
	insert into VTEX_RELACAO_PRODUTOS_SKUS(PRODUTOID, SKUID_VTEX)
		select PRODUTOID, NULL
		from inserted