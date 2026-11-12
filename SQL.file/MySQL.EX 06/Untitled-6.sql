-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: UPDATE, DELETE, TRUNCATE, IS NULL, LIKE, IN, BETWEEN,
-- ORDER BY, UNION, UNION ALL e DISTINCT

-- ============================================================


-- Seleciona o banco de dados aula para utilizar

use aula;



-- ============================================================

-- CONSULTAS INICIAIS

-- ============================================================


-- Mostra todos os registros e todas as colunas
-- das tabelas pessoa, cidade e departamento

select * from pessoa;
select * from cidade;
select * from departamento;



-- ============================================================

-- INNER JOIN (PESSOA E CIDADE)

-- ============================================================


-- Consulta o ID e o nome da pessoa junto com o nome da cidade onde ela mora

-- INNER JOIN retorna somente os registros que possuem
-- correspondência entre as duas tabelas

-- ON relaciona pessoa.cidadeId com cidade.id

select pessoa.id, pessoa.nome, cidade.nome
from pessoa
inner join cidade
on  pessoa.cidadeId = cidade.id;

-- As duas colunas se chamam nome no resultado
-- Use AS para dar um apelido a cada uma e diferenciar



-- ============================================================

-- UPDATE COM SUBCONSULTA

-- ============================================================


-- Atualiza a cidade da pessoa de ID 1 para São Paulo

-- UPDATE altera registros que já existem na tabela

-- SET define o novo valor da coluna

-- A subconsulta busca o ID da cidade de São Paulo

-- WHERE limita a alteração à pessoa de ID 1

update pessoa
set cidadeId = (select id from cidade where nome = 'São Paulo')
where id = 1;

-- Sem o WHERE, o UPDATE alteraria TODAS as linhas da tabela



-- ============================================================

-- INNER JOIN (PESSOA E DEPARTAMENTO)

-- ============================================================


-- Consulta o funcionário e o departamento onde ele trabalha

-- AS define um apelido para as colunas no resultado

-- ON relaciona pessoa.departamentoId com departamento.id

select pessoa.id, pessoa.nome as func , departamento.nome as departamento, departamento.id as depID
from pessoa
inner join departamento
on pessoa.departamentoId = departamento.id;



-- ============================================================

-- UPDATE COM MAIS DE UMA COLUNA

-- ============================================================


-- Atualiza o nome e o departamento da pessoa de ID 2

-- No SET, as colunas são separadas por vírgula

update pessoa
set nome = 'Joao da silva',
departamento = 2
where id = 2;

-- Os dois valores são alterados ao mesmo tempo, somente no ID 2



-- ============================================================

-- DELETE

-- ============================================================


-- Exclui as pessoas do departamento 1 que são do sexo masculino

-- DELETE remove registros da tabela

-- WHERE filtra quais registros serão excluídos

-- AND exige que as duas condições sejam verdadeiras

delete from pessoa
where departamento = 1
and genero = 'M';

-- Sem o WHERE, o DELETE exclui TODOS os registros da tabela
-- Teste sempre com um SELECT antes de excluir



-- ============================================================

-- DELETE COM SUBCONSULTA

-- ============================================================


-- Exclui as pessoas que moram em Curitiba

-- IN compara a coluna com a lista de IDs retornada pela subconsulta

delete from pessoa where cidadeId in
(select id from cidade where nome = 'Curitiba');

-- Se a pessoa excluída for gerente de outra,
-- ocorre o erro 1451 (chave estrangeira)
-- Primeiro é preciso alterar ou excluir quem depende dela

-- Se nenhuma pessoa morar em Curitiba, nenhum registro é excluído



-- ============================================================

-- TRUNCATE

-- ============================================================


-- Apaga todos os registros da tabela pessoa

-- TRUNCATE esvazia a tabela de uma só vez
-- A estrutura da tabela continua existindo

-- Não aceita WHERE

-- Reinicia o AUTO_INCREMENT, e o próximo ID volta a ser 1
-- (o DELETE não faz isso, o próximo ID continua de onde parou)

-- Não pode ser desfeito
-- Depois dele, as consultas seguintes na tabela pessoa retornam vazio

truncate table pessoa;



-- ============================================================

-- IS NULL E IS NOT NULL

-- ============================================================


-- Consulta as cidades que não possuem nome

-- IS NULL verifica se o valor é nulo (vazio, não informado)

-- Não se usa = NULL, pois NULL não é igualado com o sinal de =

select * from cidade
where nome is null;


-- Consulta as cidades que possuem nome

-- IS NOT NULL retorna os registros em que o valor foi informado

SELECT *
FROM cidade
where nome is not null;



-- ============================================================

-- LIKE

-- ============================================================


-- Consulta os nomes que possuem o texto Silva

-- LIKE procura um padrão dentro do texto

-- O símbolo % representa qualquer quantidade de caracteres

-- %Silva% = contém Silva em qualquer posição
-- %Silva = termina com Silva
-- Silva% = começa com Silva

select nome from pessoa where nome like '%Silva%';
select nome from pessoa where nome like '%Silva';
select nome from pessoa where nome like 'Silva%';

-- Por padrão, o LIKE não diferencia maiúsculas de minúsculas
-- Silva e silva retornam o mesmo resultado



-- ============================================================

-- IN

-- ============================================================


-- Consulta o nome e a cidade das pessoas que moram nas cidades 1, 2 ou 3

-- IN compara a coluna com uma lista de valores
-- Equivale a usar OR entre cada um dos valores

select nome, cidadeId from pessoa where cidadeId in (1, 2, 3);



-- ============================================================

-- BETWEEN E NOT BETWEEN

-- ============================================================


-- Consulta as pessoas cujo cidadeId está entre 1 e 4

-- BETWEEN retorna os valores dentro de um intervalo
-- Os valores inicial e final também entram no resultado

select * from pessoa where cidadeId between 1 and 4;


-- Consulta as pessoas cujo cidadeId está fora do intervalo de 1 a 4

-- NOT BETWEEN retorna os valores fora do intervalo

select * from pessoa where cidadeId not between 1 and 4;



-- ============================================================

-- ORDER BY

-- ============================================================


-- Consulta as pessoas ordenadas por nome e por salário

-- ORDER BY organiza os registros do resultado

-- DESC ordena do maior para o menor (de Z para A)
-- ASC ordena do menor para o maior (é o padrão)

-- O segundo critério (salario) só é usado
-- quando o primeiro (nome) tem valores repetidos

select * from pessoa order by nome desc, salario asc;



-- ============================================================

-- UNION

-- ============================================================


-- Consulta o nome e o nascimento de pessoas e de gerentes juntos

-- UNION junta o resultado de duas consultas em uma só

-- Elimina as linhas repetidas

-- As consultas precisam ter o mesmo número de colunas
-- e os tipos de dados precisam ser compatíveis

-- Os nomes das colunas vêm da primeira consulta

select nome, nascimento from pessoa
union
select nome, nascimento from gerente;



-- ============================================================

-- UNION ALL

-- ============================================================


-- Consulta o nome e o nascimento de pessoas e de gerentes juntos,
-- mantendo as linhas repetidas

-- UNION ALL junta o resultado de duas consultas
-- sem eliminar as linhas repetidas

-- É mais rápido que o UNION, pois não precisa procurar repetidos

select nome, nascimento from pessoa
union all
select nome, nascimento from gerente;



-- ============================================================

-- DISTINCT

-- ============================================================


-- Consulta os nomes sem repetição

-- DISTINCT elimina as linhas repetidas do resultado

select distinct nome from pessoa order by nome;


-- Consulta as combinações diferentes de nome e sexo

-- Com mais de uma coluna, o DISTINCT considera a combinação das colunas
-- Só elimina as linhas em que todas as colunas são iguais

select distinct nome, sexo from pessoa order by nome;