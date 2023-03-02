CREATE Procedure [dbo].[spProcessaClientes] @loja int, @Usuario varchar(20) as

declare @CodCli int, @cnpj  varchar(20), @descricao varchar(120), @Entidadeid int,
		@Bairro varchar(20), @Cidade Varchar(20), @Uf Varchar(2), @Pais Varchar(6),
		@Fone Varchar(40), @Endereco Varchar(40), @InscricaoIE Varchar(20), @Cep Varchar(20), 
		@Complemento Varchar(80), @Numero Varchar(20), @Ponto_Referencia Varchar(300), 
		@Responsavel Varchar(30), @Email Varchar(100)

Declare pCliente cursor for
select CodCli, Descricao, cnpj_cpf, bairro, cidade, uf, pais, fone, endereco, inscricao, 
		cep, complemento, numero, REFERENCIA_COMPLEMENTO, RESPONSAVEL_CONTATO, EMAIL
from tablet_entidades 
Where Dataleitura is null

open pCliente
fetch next from pCliente into @CodCli, @Descricao, @Cnpj, @Bairro , @Cidade, @Uf, @Pais, @Fone, @Endereco, @InscricaoIE, 
							  @Cep, @Complemento, @Numero, @Ponto_Referencia, @Responsavel, @Email
While (@@FETCH_STATUS = 0)
 begin
		Select @Entidadeid = Entidadeid 
		from Entidades
		where replace(replace(replace(CNPJ_CPF, '.',''), '-',''), '/','') = replace(replace(replace(@CNPJ, '.',''), '-',''), '/','')

		if @Entidadeid is not null
		 begin
			UPDATE ENTIDADES SET	
				   BAIRRO = ISNULL(@Bairro, BAIRRO),
				   CIDADE = ISNULL(@Cidade, CIDADE),
				   UF = ISNULL(@Uf, UF),
				   FONE1 = ISNULL(@Fone, FONE1),
				   ENDERECO = ISNULL(@Endereco, ENDERECO),
				   INSCRICAO_ID = ISNULL(@InscricaoIE, INSCRICAO_ID),
				   CEP = ISNULL(@Cep, CEP),
				   COMPLEMENTO = ISNULL(@Complemento, COMPLEMENTO),
				   NUMERO = ISNULL(@Numero, NUMERO),
				   PONTOREFERENCIA = ISNULL(@Ponto_Referencia, PONTOREFERENCIA),
				   RESPONSAVEL = ISNULL(@Responsavel, RESPONSAVEL),
				   EMAIL = ISNULL(@Email, EMAIL)
			 WHERE ENTIDADEID = @Entidadeid
			   --AND CNPJ_CPF = replace(replace(replace(@CNPJ, '.',''), '-',''), '/','') 

			PRINT 'ATUALIZOU O CADASTRO'
		 end		
		
		if @Entidadeid is null
		 begin
			Select @Entidadeid = max(entidadeid) from entidades

			select @Entidadeid = Isnull(@Entidadeid, 1) + 1
		
			insert into entidades(tipo, entidadeid, codcli, descricao, descricao2, CNPJ_CPF, INSCRICAO_ID, 
				endereco, bairro, cep, cidade, uf, obs, fone1, fone2, fone3, contato, email,
				site, ativo, credito, DESCONTO, TIPO_JF, DATACADASTRO, TIPOENTIDADEID, ENTIDADEID_VENDEDOR,
				LIMITECREDITO, REGTRIBUTARIAID, CIDADE_ID, UF_ID, REGTRIBID_PIS_COFINS, paisid, 
				numero, complemento, isento_cgf, LIMITECREDITO_MES)
			select '1', @Entidadeid, @Entidadeid, descricao, descricao2, cnpj_cpf, inscricao,
				endereco, bairro, cep, cidade, uf, obs, fone, '', '', RESPONSAVEL_CONTATO, EMAIL,
				'', 'S', 'S', 0, 'J', getdate(), tipoentidadeid, entidadeid_vendedor,
				0, case
				     when UF = 'CE' then '1'
					 when UF = 'PB' then '8'
					 else '3' end, cidade_id, uf_id, '1', paisid,
				numero, complemento, 'N', 0
			--select *
			from tablet_entidades 
			where codcli = @CodCli
			and cnpj_cpf = @Cnpj
			and descricao = @Descricao

			print 'cadastrado: @descricao / @entidadeid'
			print  @descricao
			print @entidadeid

		 end

		update tablet_entidades set Dataleitura = getdate()
		Where Dataleitura is null
		and codcli = @CodCli
		and cnpj_cpf = @Cnpj
		and descricao = @Descricao
		
		select @Entidadeid = null

		fetch next from pCliente into @CodCli, @Descricao, @Cnpj, @Bairro , @Cidade, @Uf, @Pais, @Fone, @Endereco, @InscricaoIE, 
									  @Cep, @Complemento, @Numero, @Ponto_Referencia, @Responsavel, @Email
 end
 deallocate pCliente
GO
