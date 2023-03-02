CREATE VIEW V_VTEX_FILTRO_GRUPOS_ESPECIFICACOES AS
-- Não é possível editar um grupo, apenas cadastrar novos
-- Editar a descrição de um grupo fará com que ele seja criado, o mesmo não será editado/deletado.
SELECT 1 filtroGrupoId, 1 position, 'Glúten' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_COLECOES UNION   -- PRODUTOS_COLECOES
SELECT 2 filtroGrupoId, 2 position, 'Adoçantes, Açúcares e Conservantes' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_CATEGORIA UNION -- PRODUTOS_CATEGORIA
SELECT 3 filtroGrupoId, 3 position, 'Tipo de Proteína' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTO_STATUS UNION    -- PRODUTO_STATUS
SELECT 4 filtroGrupoId, 4 position, 'Tipo de Produção' filtroGrupoDescricao, DESCRICAO descricaoEspecificacao FROM PRODUTOS_GRUPOS           -- PRODUTOS_GRUPOS