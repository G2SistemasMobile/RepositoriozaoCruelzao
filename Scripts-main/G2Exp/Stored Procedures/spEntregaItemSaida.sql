CREATE procedure [dbo].[spEntregaItemSaida] 
					@Entregaid int,
					@loja int,
					@item int,
					@conta int,
					@data datetime,
					@usuario varchar(20),
					@Qtd float as

	declare @ItemSaida int, @Romaneio int

	Select @ItemSaida = Max(item_saida)
	from Entrega_Item_Saida
	where entregaid = @entregaid
	and entidadeid_loja = @loja
	and item = @item 

	if @ItemSaida is null
	 Select @ItemSaida  = 1
	else Select @ItemSaida = @ItemSaida + 1


	Select @Romaneio = Max(Romaneio)
	From Entrega_Item_Saida 
	Where Entregaid = @Entregaid
	And Entidadeid_Loja = @Loja

	if @Romaneio is null
	  select @romaneio = 1

	Insert Into Entrega_Item_Saida(Entregaid, Entidadeid_Loja, Item, CONTA, Item_Saida, Romaneio, Data, Usuario, Quantidade) 
	values(@Entregaid, @loja, @item, @conta, @ItemSaida, @Romaneio, @Data, @usuario, @Qtd)
