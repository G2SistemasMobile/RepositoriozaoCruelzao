~ -- [1] SEMPRE VERIFICAR SE 'CODIGO_PEDIDO' É INT, SE FOR, APLICAR O SCRIPT ABAIXO
 alter table MOVIMENTO_DIA_PEDPALM alter column CODIGO_PEDIDO varchar(30);
 
~ -- [2] APLICAR OS SCRIPTS ABAIXO PARA PREVENIR ESTOUROS DE VARCHAR DE OS
 ALTER TABLE MOVIMENTO_DIA ALTER COLUMN USUARIO VARCHAR(300);
 ALTER TABLE MOVIMENTO_DIA ALTER COLUMN PEDCLIENTE VARCHAR(300);
 ALTER TABLE MOVIMENTO_DIA ALTER COLUMN EQPO VARCHAR(300);
 ALTER TABLE MOVIMENTO_DIA ALTER COLUMN NUMSERIE_EQPO VARCHAR(300);
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
            @profid int, @PrevendaID int, @PrecoTabelaPadrao float ,
			@ObsDefeito varchar(500), @ObsRealizado varchar (500) , 
			@equipamento varchar(100) , @serie varchar (100),
			@checkid int, @descrica_check varchar(500), @resposta varchar(1), @obs_checklist varchar(500)
Exec spProcessaClientes @Loja, @Usuario
Declare pPedidoPalm cursor for
select PedidoID, lojaid, DataEmissao, Formapagid, condicaoid, OBS, entidadeid_cliente,
            entidadeid_func, tabprecoid, descricao_defeito, os_acao, equipamento_os, serie_placa
from tablet_pedidos 
Where Status_Recepcao = '1'

open pPedidoPalm
 
fetch next from pPedidoPalm into @Pedpalm, @loja, @Data, @FormapagID, @CondicaoPag, @Obs, @Cliente,
            @Vendedor, @CodTabela, @ObsDefeito, @ObsRealizado, @equipamento, @serie

While (@@FETCH_STATUS = 0)
begin
      if @Cliente < 0 SELECT @Cliente = ENT.ENTIDADEID
		 FROM ENTIDADES ENT, tablet_entidades TENT
		 WHERE (replace(replace(replace(ENT.CNPJ_CPF, '.',''), '-',''), '/','') = replace(replace(replace(TENT.CNPJ_CPF, '.',''), '-',''), '/',''))
		 and TENT.entidadeid = @Cliente
	if @Cliente is null select @Cliente = ENTIDADEID_CLIENTE FROM tablet_pedidos WHERE pedidoid = @Pedpalm
		
      
	-- Se sempre for cair na mesma loja/almox, utilizar como constantes:
	Select @Almox = 0
	Select @Loja = 0
      Select @Conta = MAX(CONTA)
      from MOVIMENTO_DIA
      Where ENTIDADEID_LOJA = @Loja  

      if @Conta is null
        Select @Conta = 1
      else Select @Conta = @Conta + 1  

      Select @NumDOcumento = MAX(NUMDOCUMENTO)
      from Movimento_dia
      Where ENTIDADEID_LOJA = @Loja
      And TIPO = '4'        

      if @NumDocumento is null
        Select @NumDocumento = 1
      else Select @NumDocumento = @NumDocumento + 1  
	  
	  Select @Item = 1    
	  
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
            VALORTOTALNOTA, ACESSORIOS, USUARIO, PRAZO, VALDESCONTO,
            PEDCLIENTE, CONDICAOID, ACRESCIMOFINANCEIRO, FORMAPAGID, TABPRECOID, DEFEITOS, SERVICOEXECUTADO,
			EQPO, NUMSERIE_EQPO, ENTIDADEID_TECNICO)
      values(@Loja, @Conta,
            @Almox, '5403', @NumDocumento, '1', '4', Convert(varchar(12), GETDATE(), 1), Convert(varchar(12), GETDATE(), 1),
            @Comissao, @Cliente, @Vendedor, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, @Obs, @usuario, @prazo, @Valdesconto,
            @Pedpalm, @CondicaoPag, 0, @FormaPagID, null, @ObsDefeito, @ObsRealizado,
			@equipamento, @serie, @Vendedor)
			
	  Select @Item = 1  

      Declare pProd Cursor for

		  Select produtoid, Quantidade, preco, desconto
		  From tablet_pedidos_itens
		  Where PedidoID = @PedPalm
		  Order By produtoid

      open pProd
  
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

	  --inserindo checklist


	  
		insert into MOVIMENTO_DIA_CHECKLIST (entidadeid_loja, conta, checkid, descricao, resposta, obs)
		select @Loja, @conta, checkId, descricao, resposta, obs
		from TABLET_MOVIMENTO_DIA_CHECKLIST
		where conta = @Pedpalm
		and entidadeid_loja = @Loja

	  /*

	  Declare pCheck Cursor for

		  Select A.checkid, A.descricao, A.resposta, A.obs
		  From TABLET_MOVIMENTO_DIA_CHECKLIST A, tablet_pedidos B
		  Where A.CONTA = B.pedidoid
		  AND A.ENTIDADEID_LOJA = B.LOJAID
		  AND B.CONTA = @Pedpalm
		  and ENTIDADEID_LOJA = @Loja
		  
      open pCheck
  
      fetch next from pCheck into @checkid , @descrica_check , @resposta , @obs_checklist
      While (@@FETCH_STATUS = 0)

      begin

		insert into MOVIMENTO_DIA_CHECKLIST (entidadeid_loja, conta, checkid, descricao, resposta, obs)
			 values (@loja, @conta , @checkid, @descrica_check, @resposta, @obs_checklist)

	  end

      deallocate pCheck

	  */


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
            @Vendedor, @CodTabela, @ObsDefeito, @ObsRealizado, @equipamento, @serie

end

deallocate pPedidoPalm
