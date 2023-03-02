create procedure [dbo].[spEntregaItemSaidaDesfazer]  @EntregaID int, @loja int, @Item int as
	declare @NEntregas int

	Delete from ENTREGA_ITEM_SAIDA
	where ENTREGAID = @entregaid
	and ENTIDADEID_LOJA = @loja
	and item = @item

	update ENTREGA_ITEM set status = '1'
	where ENTREGAID = @entregaid
	and ENTIDADEID_LOJA = @loja
	and item = @item

	Select @NEntregas = Count(*)
	from ENTREGA_ITEM_SAIDA
	where ENTREGAID = @entregaid
	and ENTIDADEID_LOJA = @loja

	if isnull(@NEntregas,0) = 0 
	 begin
			update ENTREGA set status = '1'
			where ENTREGAID = @entregaid
			and ENTIDADEID_LOJA = @loja
	 end 
	else if isnull(@NEntregas,0) > 0 
	 begin
			update ENTREGA set status = '2'
			where ENTREGAID = @entregaid
			and ENTIDADEID_LOJA = @loja
	 end 
