CREATE view [dbo].[V_LI_Cliente] as
	Select EMAIL as email,
			a.descricao as nome,
			'' as Sexo,
			'' as aceita_newsletter,
			fone1 as telefone_principal,
			fone3 as telefone_comercial,
			fone2 as telefone_celular,
			a.tipoentidadeid as grupo_id,
			--b.descricao as tipo,
			case
			 when a.TIPO_JF = 'J' then 'PJ'
			 else 'PF' end as tipo,
			case
			 when a.TIPO_JF = 'F' then cnpj_cpf 
			 else '' end as cpf,	 
			case
			 when a.TIPO_JF = 'F' then inscricao_id 
			 else '' end as rg,
			case
			 when a.TIPO_JF = 'J' then a.descricao
			 else '' end as razao_social,
			case
			 when a.TIPO_JF = 'J' then cnpj_cpf 
			 else '' end as cnpj,
			case
			 when a.TIPO_JF = 'J' then inscricao_id 
			 else '' end as ie,
			endereco as endereco,
			numero as numero,
			complemento as complemento,
			bairro as bairro,
			cidade as cidade,
			uf as estado,
			cep as CEP,
			'BRASIL' as Pais,
			datanas as data_nascimento
	from entidades a join tipoentidade b on (a.tipoentidadeid = b.tipoentidadeid)
	where a.tipo = ? -- varchar
	and cep <> '.-'
	and EMAIL <> ''

