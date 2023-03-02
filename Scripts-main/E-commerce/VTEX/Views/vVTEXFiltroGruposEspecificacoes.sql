CREATE VIEW V_VTEX_FILTRO_GRUPOS_ESPECIFICACOES AS
-- N�o � poss�vel editar um grupo, apenas cadastrar novos
-- Editar a descri��o de um grupo far� com que ele seja criado, o mesmo n�o ser� editado/deletado.
SELECT 1 filtroGrupoId, 1 position, 'Gl�ten' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_COLECOES UNION   -- PRODUTOS_COLECOES
SELECT 2 filtroGrupoId, 2 position, 'Ado�antes, A��cares e Conservantes' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_CATEGORIA UNION -- PRODUTOS_CATEGORIA
SELECT 3 filtroGrupoId, 3 position, 'Tipo de Prote�na' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTO_STATUS UNION    -- PRODUTO_STATUS
SELECT 4 filtroGrupoId, 4 position, 'Tipo de Produ��o' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_GRUPOS           -- PRODUTOS_GRUPOS