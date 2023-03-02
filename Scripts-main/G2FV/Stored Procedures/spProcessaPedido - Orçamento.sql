-- [1]
--		SEMPRE VERIFICAR SE 'CODIGO_PEDIDO' É INT, SE FOR, APLICAR O SCRIPT ABAIXO
alter table MOVIMENTO_DIA_PEDPALM alter column CODIGO_PEDIDO varchar(30)
-----------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[spProcessapedido]
                    @Loja int,
                    @Usuario varchar(20) as

Declare @Pedpalm varchar(30), @Data datetime,
            @Vendedor int, @Cliente int, @FormapagID int,
            @CondicaoPag int, @CodTabela int, @func int,
            @Tipovenda int, @Situacao varchar(1),
            @Obs varchar(400), @ValDesconto float,
            @Conta int, @Numdocumento Int,
			@Prazo varchar(72), @Almox int, @Item int, @Produto int , @Comissao float,
            @PVenda float, @PTabela float, @PCompra float, @Qtd float,
            @TotalNota float, @TotalDesconto float, @Desconto float,
            @profid int, @PrevendaID int, @PrecoTabelaPadrao float     
Exec spProcessaClientes @Loja, @Usuario
Declare pPedidoPalm cursor for
select PedidoID, lojaid, DataEmissao, Formapagid, condicaoid, OBS, entidadeid_cliente,
            entidadeid_func, tabprecoid
from tablet_pedidos
Where Status_Recepcao = '1'

open pPedidoPalm
 
fetch next from pPedidoPalm into @Pedpalm, @loja, @Data, @FormapagID, @CondicaoPag, @Obs, @Cliente,
            @Vendedor, @CodTabela

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
      Select @Conta = MAX(CONTA)
      from MOVIMENTO_DIA
      Where ENTIDADEID_LOJA = @Loja  

      if @Conta is null
        Select @Conta = 1
      else Select @Conta = @Conta + 1  

      Select @NumDOcumento = MAX(NUMDOCUMENTO)
      from Movimento_dia
      Where ENTIDADEID_LOJA = @Loja
      And TIPO = '1'        

      if @NumDocumento is null
        Select @NumDocumento = 1
      else Select @NumDocumento = @NumDocumento + 1          

      INSERT INTO MOVIMENTO_DIA_PEDPALM(CONTA, ENTIDADEID_LOJA, NUMDOCUMENTO, TIPO,
                  CODIGO_PEDIDO, DATAPROC)
      VALUES(@Conta, @Loja, @Numdocumento, '1',
                  @Pedpalm, GETDATE() )
             
      Select @Prazo = Prazo
      From CondicaoPagamento
      where condicaoid = @CondicaoPag         

       Select @Func = entidadeid_Vendedor
       from ENTIDADES
       where entidadeid = @Cliente          

      insert into MOVIMENTO_DIA(ENTIDADEID_LOJA, CONTA,
            ALMOXID, CFOP, NUMDOCUMENTO, STATUS, TIPO, DATAEMISSAO, DATASAIDA,
            COMISSAO, ENTIDADEID_CLIENTE, ENTIDADEID_FUNC, DESCONTO,
            BASECALCICMS, VALORICMS, BASECALCICMSSUB, VALORICMSSUB,
            VALORTOTALPROD, VALORFRETE, VALORSEGURO, OUTRASDESPESAS,
            VALORTOTALNOTA, Obs, USUARIO, PRAZO, VALDESCONTO,
            PEDCLIENTE, CONDICAOID, ACRESCIMOFINANCEIRO, FORMAPAGID, TIPOSERVID, TABPRECOID)
      values(@Loja, @Conta,
            @Almox, '5403', @NumDocumento, '1', '1', Convert(varchar(12), GETDATE(), 1), Convert(varchar(12), GETDATE(), 1),
            @Comissao, @Cliente, @Func, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, @Obs, @usuario, @prazo, @Valdesconto,
			--Descomentar a linha que for utilizar
			-- Se não utilizar tabela de preço
            -- @Pedpalm, @CondicaoPag, 0, @FormaPagID, @Tipovenda, null)

			-- Se utilizar tabela de preço
            -- @Pedpalm, @CondicaoPag, 0, @FormaPagID, @Tipovenda, @CodTabela)

                
      Select @Item = 1
      Declare pProd Cursor for
      Select produtoid, Quantidade, preco, desconto
      From tablet_pedidos_itens
      Where PedidoID = @PedPalm
      Order By produtoid

      open pprod
  
      fetch next from pProd into @Produto, @Qtd, @PVenda,  @Desconto
      While (@@FETCH_STATUS = 0)
      begin
          /* SE UTILIZAR TABELA DE PRECO

            Select @PCompra = PrecoCompra
            From ALMOXLOJAITENS
            Where ENTIDADEID_LOJA = @Loja
            And ALMOXID = @Almox
            And PRODUTOID = @Produto

			select @PTabela = PrecoVenda
			from TABPRECOITEM
			where PRODUTOID = @Produto
			and TABPRECOID = @CodTabela

            print '@loja, @almox, @prod'
            print @Loja
            print @Almox
            print @Produto

           */

		 /* SE NAO UTILIZAR TABELA DE PRECO

            Select @PCompra = PrecoCompra, @PTabela = PrecoVenda
            From ALMOXLOJAITENS
            Where ENTIDADEID_LOJA = @Loja
            And ALMOXID = @Almox
            And PRODUTOID = @Produto

            print '@loja, @almox, @prod'
            print @Loja
            print @Almox
            print @Produto

           */
            Insert into Itens_dia(entidadeid_loja, almoxid, conta, item, operador,
                  data, preco, quantidade, produtoid, desconto, icms, ipi, comissao,
                  precocompra, preco_tabela, adicional_sub, cfop)
            values(@Loja, @Almox, @Conta, @item, @Usuario,
                  @Data, @PVenda, @Qtd, @Produto, @Desconto, 0, 0, 0,
                  @PCompra, @PTabela, 0, '5403')
            Select @Item = @item + 1        
            fetch next from pProd into @Produto, @Qtd, @PVenda, @Desconto
      end
      deallocate pProd


      --//Totalizar Pedido
      SELECT @TotalNota = SUM( (ISNULL(QUANTIDADE,0) * ISNULL(PRECO,0))),
	               @TotalDesconto = Round(IsNull((Select sum(IsNull(A.Quantidade,0) * IsNull(A.Preco,0) * IsNull(A.Desconto/100,0))
		                                            From Itens_dia A
													Where A.Entidadeid_Loja = B.Entidadeid_loja
													And A.Conta = B.Conta),0),2)
	  FROM ITENS_DIA B
      Where EntidadeID_Loja = @Loja
      And Conta = @CONTA
	  GROUP BY B.ENTIDADEID_LOJA, B.CONTA

		if Round(Isnull(@TotalNota,0),2) = 0
		 begin
				update Movimento_Dia Set
                        ValorTotalProd = Round(@TotalNota,2) - Isnull(@ValDesconto,0),
                        ValorTotalNota = Round(@TotalNota,2) - Isnull(@TotalDesconto,0),
                        STATUS = '3'
				Where EntidadeID_Loja = @Loja
				And Conta = @Conta

		 end
		else
		 begin 
				update Movimento_Dia Set
                        ValorTotalProd = Round(@TotalNota,2) - Isnull(@ValDesconto,0),
                        ValorTotalNota = Round(@TotalNota,2) - Isnull(@TotalDesconto,0)                               
				Where EntidadeID_Loja = @Loja
				And Conta = @Conta
		 end		
 
      update tablet_pedidos set
            Status_Recepcao = '3',
            numpedidoempresa = @NumDocumento
      where PedidoID = @PedPalm    
 
	select @TotalNota = 0
	
      fetch next from pPedidoPalm into @Pedpalm, @loja, @Data, @FormapagID, @CondicaoPag, @Obs, @Cliente,
            @Vendedor, @CodTabela

end

deallocate pPedidoPalm