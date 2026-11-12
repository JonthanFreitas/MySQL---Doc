-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: SUBCONSULTAS, IN, EXISTS, NOT EXISTS, ANY e INTERSECT

-- ============================================================


-- Seleciona o banco de dados aula para utilizar

use aula;



-- ============================================================

-- SUBCONSULTA COM =

-- ============================================================


-- Consulta as pessoas que moram na cidade de São Paulo

-- A subconsulta (entre parênteses) é executada primeiro
-- e retorna o ID da cidade de São Paulo

-- A consulta de fora usa esse ID para filtrar a tabela pessoa

select * from pessoa
where cidadeId = (select id from cidade where nome = 'São Paulo');

-- O sinal de = só funciona quando a subconsulta retorna UM valor
-- Se retornasse mais de uma linha, daria o erro 1242
-- (Subquery returns more than 1 row)



-- ============================================================

-- SUBCONSULTA COM IN

-- ============================================================


-- Consulta as pessoas que moram em São Paulo ou em Bagé

-- IN compara a coluna com uma lista de valores
-- Retorna o registro se o valor estiver em qualquer item da lista

-- A subconsulta retorna os IDs das duas cidades

select * from pessoa
where cidadeId in (select id from cidade where nome = 'São Paulo' or nome = 'Bagé');

-- Use IN no lugar de = quando a subconsulta puder retornar várias linhas



-- ============================================================

-- EXISTS

-- ============================================================


-- Consulta o nome e o salário de quem ganha menos de 7000
-- somente se existir alguém que ganhe mais de 11000

-- EXISTS verifica se a subconsulta retornou pelo menos uma linha
-- Se retornou, o resultado é verdadeiro

-- Esta subconsulta não depende da linha da consulta de fora,
-- por isso o resultado de EXISTS vale para todas as linhas
-- Ou todas passam pelo filtro, ou nenhuma passa

select nome, salario
	from pessoa
    where salario < 7000
and exists (select * from pessoa where salario > 11000);

-- Como existe alguém com salário maior que 11000,
-- o EXISTS é verdadeiro e o filtro salario < 7000 decide o resultado



-- ============================================================

-- NOT EXISTS

-- ============================================================


-- Consulta o nome e o salário de quem ganha menos de 7000
-- somente se NÃO existir ninguém que ganhe mais de 11000

-- NOT EXISTS é o contrário do EXISTS
-- É verdadeiro quando a subconsulta não retorna nenhuma linha

select nome, salario
	from pessoa
    where salario < 7000
and not exists (select * from pessoa where salario > 11000);

-- Como existe alguém com salário maior que 11000,
-- o NOT EXISTS é falso e a consulta não retorna nenhum registro



-- ============================================================

-- ANY

-- ============================================================


-- Consulta as pessoas cujo ID é maior que o ID de algum cliente
-- que já fez uma venda

-- ANY compara o valor com cada item da lista retornada pela subconsulta
-- O resultado é verdadeiro se a comparação for verdadeira
-- para pelo menos um item

-- DISTINCT elimina os IDs repetidos de clienteid na tabela vendas

-- Esta consulta precisa da tabela vendas, que deve existir no banco

select * from pessoa
where id > any (select distinct clienteid from vendas);

-- id > ANY equivale a comparar com o MENOR clienteid da lista
-- Ou seja, retorna as pessoas com ID maior que o menor clienteid



-- ============================================================

-- INTERSECT

-- ============================================================


-- Consulta os IDs de cidade que aparecem nas duas tabelas

-- INTERSECT retorna somente os valores que existem
-- nos resultados das duas consultas

-- A primeira consulta retorna as cidades onde há pessoas morando
-- A segunda consulta retorna os IDs de todas as cidades cadastradas

select cidadeId from pessoa
intersect
select id from cidade;

-- As duas consultas precisam ter o mesmo número de colunas
-- INTERSECT elimina os valores repetidos do resultado

-- Disponível a partir do MySQL 8.0.31
-- Em versões mais antigas, ocorre erro de sintaxe