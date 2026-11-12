-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: COUNT, SUM, MIN, MAX, AVG, GROUP BY e HAVING

-- ============================================================


-- Seleciona o banco de dados aula para utilizar

use aula;



-- ============================================================

-- COUNT

-- ============================================================


-- Consulta a quantidade de registros da tabela
-- e a quantidade de valores preenchidos na coluna sexo

-- COUNT(*) conta todas as linhas da tabela

-- COUNT(coluna) conta somente as linhas em que a coluna não é NULL

select count(*), count(sexo) from pessoa;

-- Aqui os dois resultados são iguais, pois a coluna sexo é NOT NULL
-- Em colunas que aceitam NULL, como gerenteId, o COUNT(coluna)
-- retorna um valor menor que o COUNT(*)

-- COUNT(DISTINCT coluna) conta sem considerar os valores repetidos



-- ============================================================

-- SUM

-- ============================================================


-- Consulta a soma dos salários do departamento 1

-- SUM soma os valores de uma coluna

-- WHERE filtra os registros ANTES de somar
-- Somente as pessoas do departamento 1 entram na soma

select sum(salario) from pessoa
where departamentoId = 1;

-- Valores NULL são ignorados na soma
-- Se nenhum registro for encontrado, o resultado é NULL



-- ============================================================

-- MIN E MAX

-- ============================================================


-- Consulta o menor e o maior salário

-- MIN retorna o menor valor da coluna
-- MAX retorna o maior valor da coluna

select min(salario), max(salario) from pessoa;

-- Também funcionam com texto (ordem alfabética) e com datas



-- ============================================================

-- AVG

-- ============================================================


-- Consulta a média dos salários

-- AVG calcula a média dos valores de uma coluna
-- Fórmula: soma dos valores dividida pela quantidade de valores

select avg(salario) from pessoa;

-- Valores NULL são ignorados e não contam como zero
-- Use ROUND para limitar as casas decimais
-- Exemplo: ROUND(AVG(salario), 2)

-- ============================================================

-- GROUP BY

-- ============================================================


-- Consulta a soma dos salários por departamento e cargo

-- GROUP BY agrupa os registros que têm o mesmo valor na coluna
-- A função de agregação (SUM) é calculada para cada grupo

-- Com mais de uma coluna, cada combinação diferente forma um grupo

select departamentoId, sum(salario) from pessoa
group by departamento, cargo;

-- As colunas do SELECT que não estão dentro de uma função de agregação
-- devem aparecer no GROUP BY



-- ============================================================

-- GROUP BY COM HAVING E ORDER BY

-- ============================================================


-- Consulta os departamentos cuja soma de salários passa de 20000

-- HAVING filtra os grupos DEPOIS do agrupamento
-- WHERE filtra os registros ANTES do agrupamento

-- HAVING permite usar função de agregação, como SUM
-- O WHERE não permite

-- ORDER BY 2 ordena pela segunda coluna do SELECT (a soma)

-- DESC ordena do maior para o menor

select departamentoId, sum(salario) from pessoa
group by departamento
having sum(salario) > 20000
order by 2 desc;

-- Os departamentos com soma de 20000 ou menos não aparecem no resultado



-- ============================================================

-- SUBCONSULTA COM MIN

-- ============================================================


-- Consulta o nome e o salário da pessoa com o menor salário

-- A subconsulta (entre parênteses) é executada primeiro
-- e retorna o menor salário da tabela

-- A consulta de fora busca quem possui esse salário

select nome, salario from pessoa
where salario = (select min(salario) from pessoa);

-- Não é possível usar MIN direto no WHERE
-- Exemplo: where salario = min(salario) causa o erro 1111
-- (Invalid use of group function)

-- Se mais de uma pessoa tiver o menor salário, todas aparecem no resultado



-- ============================================================

-- MIN COM DATA

-- ============================================================


-- Consulta a data de nascimento mais antiga da tabela

-- MIN em uma data retorna a data mais antiga
-- Ou seja, a data de nascimento da pessoa mais velha

-- MAX retornaria a data mais recente (a pessoa mais nova)

select min(dataNacimento) from pessoa;

-- Valores NULL são ignorados