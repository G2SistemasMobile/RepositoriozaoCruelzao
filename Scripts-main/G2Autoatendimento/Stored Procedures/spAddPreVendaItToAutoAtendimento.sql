CREATE procedure [dbo].[sp_AddPreVendaIt_To_AutoAtendimento] @LojaId int, @PreVendaId int, @ITEM int, @PRECOUNIT float, @QUANTIDADE float, @PRODUTOID int
as
	declare @ALMOXID int;
	declare @VendedorId int;

select @ALMOXID = ALMOXID, @VendedorId = ENTIDADEID_FUNC from PreVenda
where ENTIDADEID_LOJA = @LojaId
and PREVENDAID = @PreVendaId;

insert into PREVENDAITEM (PREVENDAID, ALMOXID, ENTIDADEID_LOJA, ITEM, PRECOUNIT, QUANTIDADE, PRODUTOID, TIPOSEPARACAO, ENTIDADEID_LOJA_ORIGEM, ENTIDADEID_FUNC)
values (@PreVendaId, @ALMOXID, @LojaId, @ITEM, @PRECOUNIT, @QUANTIDADE, @PRODUTOID, '3', @LojaId, @VendedorId); 
