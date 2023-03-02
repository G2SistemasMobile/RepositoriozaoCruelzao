-- [1]
--		SEMPRE VERIFICAR SE 'CODIGO_PEDIDO' É INT, SE FOR, APLICAR O SCRIPT ABAIXO
alter table MOVIMENTO_DIA_PEDPALM alter column CODIGO_PEDIDO varchar(30)
-----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[spProcessapedido] 
					@Loja int,
					@Usuario varchar(20) as

Declare @Pedpalm varchar(30), @Data datetime, @DescontoItem float,
			@Vendedor int, @Cliente int, @FormapagID int,
			@CondicaoPag int, @CodTabela int, @VendedorPedido int, 
			@Tipovenda int, @Situacao varchar(1), 
			@Obs varchar(400), @ValDesconto float, 
			@Conta int, @Numdocumento Int,
			@Prazo varchar(72), @Almox int, @Item int, @Produto int , @Comissao float,
			@PVenda float, @PTabela float, @PCompra float, @Qtd float,
			@TotalNota float, @TotalDesconto float, @Desconto float,
			@profid int, @PrevendaID int, @PrecoTabelaPadrao float,
			@idpREVENDA BIGINT	
Exec spProcessaClientes @Loja, @Usuario
Declare pPedido cursor for
select PedidoID, DataEmissao, Formapagid, condicaoid, OBS, 
			entidadeid_cliente, 
			isnull(entidadeid_func,0), tabprecoid, REPLACE(prazo,'/','')
from tablet_pedidos
Where Status_Recepcao = '1'
order by dataemissao

open pPedido
fetch next from pPedido into @Pedpalm, @Data, @FormapagID, @CondicaoPag, @Obs, @Cliente,
		@Vendedor, @CodTabela, @prazo

While (@@FETCH_STATUS = 0)
begin

 	-- Se sempre for cair na mesma loja/almox, utilizar como constantes:
	Select @Almox = ?
	Select @Loja = ?

	/* Se houver uma diferenciação de loja/almox, utilizar a checagem:	
			if @Loja = X?
				select @Almox = ?
			else if @Loja = Y?
				select @Almox = ?
 */

   	Select @Conta = MAX(PREVENDAID) 
	from PREVENDA
	Where ENTIDADEID_LOJA = @Loja
	
	if @Conta is null
		Select @Conta = 1
	else Select @Conta = @Conta + 1

	if Len(@prazo) <= 2
    begin
			Select @Prazo = prazo
			from CondicaoPagamento
			where CondicaoID = @CondicaoPag
    end
	
	SELECT @Numdocumento = @Conta

	INSERT INTO MOVIMENTO_DIA_PEDPALM(CONTA, ENTIDADEID_LOJA, NUMDOCUMENTO, TIPO, 
			CODIGO_PEDIDO, DATAPROC)
	VALUES(@Conta, @Loja, @Numdocumento, '1',
			@Pedpalm, GETDATE() )
					
	if @Vendedor = 0
	 begin
			Select @VendedorPedido = Entidadeid_Vendedor From ENTIDADES
			Where ENTIDADEID = @Cliente
			
			if @VendedorPedido is null
			 Select @VendedorPedido = 0
	 end
	else Select @VendedorPedido = @Vendedor 
	
	INSERT INTO PREVENDA(ALMOXID, ENTIDADEID_LOJA, PREVENDAID, DATA, 
		ENTIDADEID_FUNC, ENTIDADEID_CLIENTE, STATUS,
		PRAZO, FORMAPAGID, CONDICAOID,
		DESCONTO, TIPOSERVID, FRETE, OBS, PEDCLIENTE)
	VALUES(@Almox, @Loja, @Conta, Convert(varchar(12), GETDATE(), 1),
		ISNULL(@VendedorPedido, @Vendedor), @Cliente, '1',
		@Prazo, @FormapagID, @CondicaoPag,
		0, null, '9', @Obs, @Pedpalm)	
	
	
	SELECT @idpREVENDA = ID	
	FROM PREVENDA
	WHERE PREVENDAID = @Conta
	AND ENTIDADEID_LOJA = @Loja	
		 	
	Select @Item = 1
	Declare pProd Cursor for
	Select produtoid, Quantidade, (preco - (preco*desconto/100)), 
	preco_tabela, 0
	From tablet_pedidos_itens 
	Where PedidoID = @PedPalm
	Order By produtoid
	
	open pprod
	fetch next from pProd into @Produto, @Qtd, @PVenda, @PTabela, @DescontoItem
	While (@@FETCH_STATUS = 0)
	begin
		Select @PCompra = PrecoCompra, @PTabela = precovenda
		From ALMOXLOJAITENS
		Where ENTIDADEID_LOJA = @Loja
		And ALMOXID = @Almox
		And PRODUTOID = @Produto
		
		Insert into PREVENDAITEM(PREVENDAID, ALMOXID, ENTIDADEID_LOJA,
			ITEM, PRECOUNIT, PRODUTOID, ICMS, DESCONTO1, QUANTIDADE,
			PRECO_TABELA, PRECOCOMPRA, USUARIO, ENTIDADEID_FUNC,
			ID_Prevenda)
		VALUES(@Conta, @Almox, @Loja,
			@Item, @PVenda, @Produto, 0, @DescontoItem, @Qtd,
			@PTabela, @PCompra, @Usuario, ISNULL(@VendedorPedido, @Vendedor),
			@idpREVENDA)
		
		Select @Item = @item + 1		
			
		fetch next from pProd into @Produto, @Qtd, @PVenda, @PTabela, @DescontoItem	
	end
	deallocate pProd 

	update tablet_pedidos set
			Status_Recepcao = '3',
			numpedidoempresa = @NumDocumento
	where PedidoID = @PedPalm	

	fetch next from pPedido into @Pedpalm, @Data, @FormapagID, @CondicaoPag, @Obs, @Cliente,
		@Vendedor, @CodTabela, @prazo
 end
deallocate pPedido 
GO

