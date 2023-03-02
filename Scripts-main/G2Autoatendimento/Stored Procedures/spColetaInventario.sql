CREATE Procedure [dbo].[spColetaInventario]
     @Loja int,
     @AlmoxID int,
     @Usuario varchar(20),
     @Inventario int,
     @CodBarras varchar(20),
     @Qtd int,
     @Endereco varchar(20) as

Declare @PosQtd int, @RuaID int, @PredioID int, @AndarID int, @AptoID int,
     @prod int, @Und varchar(10), @Peso float, @Altura Float, @Comprimento float,
     @Largura float, @FatorConv float, @Item int, @CodBarraTrat varchar(20),
     @Qtd2 varchar(20), @Almox int

Select @Almox = Almoxid from Inventario
Where Inventarioid = @Inventario
and ENTIDADEID_LOJA = @Loja

Select @CodBarraTrat = @CodBarras

/*
Select @RuaID = SubString(@Endereco, 3,2)
Select @PredioID = SubString(@Endereco, 5,2)
Select @AndarID = SubString(@Endereco, 7,2)
Select @AptoID = SubString(@Endereco, 9,2)
*/

Select @Prod = ProdutoID, @Und = unidade, @Peso = ISNULL(Peso, 0),
       @Altura = ISNULL(Altura, 0), @Comprimento = ISNULL(Comprimento, 0),
       @Largura = ISNULL(Largura, 0), @FatorConv = 1
  From produtos
Where CODIGOCLIENTE = @CodBarraTrat

if @Prod is null
begin
	Select @Prod = ProdutoID, @Und = unidade, @Peso = ISNULL(Peso, 0),
       @Altura = ISNULL(Altura, 0), @Comprimento = ISNULL(Comprimento, 0),
       @Largura = ISNULL(Largura, 0), @FatorConv = 1
	From produtos
	Where PRODUTOID = @CodBarraTrat
end

if @Prod is null
begin 
     insert into CodNaoEncontrado(CodBarras, Usuario, Data)
     Values(@CodBarraTrat, @Usuario, getdate() )

     RaisError('CODIGO NAO ENCONTRADO!', 16, -1)
end
else if exists(select ITEM from inventarioitens where produtoid = @Prod
                  and ENTIDADEID_LOJA = @Loja and inventarioid = @Inventario
				  and QUANTIDADE > 0)
begin
	RaisError('PRODUTO JÁ INVENTARIADO!', 16, -1)
end
/*
else if not exists(select ProdutoId from v_PRODUTO_PICK 
                    where ProdutoId = @Prod and RuaId = @RuaID and PredioId = @PredioID 
							                and AndarId = @AndarID and AptoId = @AptoID)
begin
	RaisError 60123 'PRODUTO NÃO PERTENCE AO ENDEREÇADO!'
end */
else 
 begin 


          Select @Item = Max(Item) 
          from InventarioItens
          Where inventarioid = @Inventario

          if @item is null
            Select @Item = 1
          else Select @Item = @Item + 1 


          Insert into Inventarioitens(entidadeid_loja, inventarioid, item, quantidade, valor,
                     produtoid, usuario, local)
          Values(@Loja, @Inventario, @Item, @Qtd, 0.0,
                -- @Prod, @usuario, SubString(@Endereco, 3, 8))
				@Prod, @usuario, @Endereco)


/*
	 UPDATE INVENTARIOITENS SET
              QUANTIDADE = @QTD
        WHERE PRODUTOID = @PROD
          AND INVENTARIOID = @INVENTARIO  
          and ENTIDADEID_LOJA = @Loja 
*/	 
	 /*if exists(select ITEM from inventarioitens
                where produtoid = @Prod
                  and ENTIDADEID_LOJA = @Loja
                  and inventarioid = @Inventario)
     begin
	   UPDATE INVENTARIOITENS SET
              QUANTIDADE = @QTD
        WHERE PRODUTOID = @PROD
          AND INVENTARIOID = @INVENTARIO  
          and ENTIDADEID_LOJA = @Loja
     end        
     else
     begin    
          Select @Item = Max(Item) 
          from InventarioItens
          Where inventarioid = @Inventario

          if @item is null
            Select @Item = 1
          else Select @Item = @Item + 1 


          Insert into Inventarioitens(entidadeid_loja, inventarioid, item, quantidade, valor,
                     produtoid, usuario, local)
          Values(@Loja, @Inventario, @Item, @Qtd, 0.0,
                @Prod, @usuario, SubString(@Endereco, 3, 8))

          update produto_local set
            ruaid = @ruaid,
            predioid = @predioid,
            andarid = @Andarid,
            aptoid = @Aptoid
          where produtoid = @Prod
          and entidadeid_loja = @loja
          and almoxid = @almox  

     end*/
end
