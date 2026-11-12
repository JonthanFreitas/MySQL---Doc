-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: LENGTH, UPPER, LOWER, LTRIM, RTRIM, TRIM, SUBSTRING, REPLACE e CAST

-- ============================================================



-- ============================================================

-- LENGTH

-- ============================================================


-- Consulta o nome e a quantidade de caracteres do nome e do telefone

-- LENGTH conta o tamanho do texto
-- Os espaços também são contados

-- Se o valor for NULL, o resultado também será NULL

select nome, length(nome), length(telefone) from pessoa;

-- No MySQL, LENGTH conta bytes
-- Para contar letras de nomes com acento, use CHAR_LENGTH



-- ============================================================

-- UPPER E LOWER

-- ============================================================


-- Consulta o nome em letras maiúsculas e em letras minúsculas

-- UPPER transforma o texto em MAIÚSCULAS
-- LOWER transforma o texto em minúsculas

select upper(nome), lower(nome) from pessoa;

-- Altera somente o resultado da consulta
-- O dado gravado na tabela continua igual



-- ============================================================

-- LTRIM E RTRIM

-- ============================================================


-- Consulta o nome removendo os espaços de um dos lados

-- LTRIM remove os espaços da esquerda (início do texto)
-- RTRIM remove os espaços da direita (fim do texto)

select ltrim(nome), rtrim(nome) from pessoa;

-- Os espaços do meio do texto não são removidos



-- ============================================================

-- TRIM

-- ============================================================


-- Consulta o nome removendo os espaços dos dois lados

-- TRIM remove os espaços do início e do fim do texto

-- BOTH indica que a limpeza é feita dos dois lados (é o padrão)
-- Também existem LEADING (só o início) e TRAILING (só o fim)

select trim(both from nome), nome from pessoa;

-- A coluna nome ao lado mostra o texto original para comparação



-- ============================================================

-- SUBSTRING

-- ============================================================


-- Consulta o nome a partir da posição 5 até o final

-- SUBSTRING extrai um pedaço do texto
-- A contagem das posições começa em 1

-- Com um argumento, retorna do início informado até o final

select substring(nome, 5), nome from pessoa;

-- Se o nome tiver menos de 5 caracteres, o resultado é vazio


-- Consulta as três primeiras letras do nome

-- Com dois argumentos, informa a posição inicial (1)
-- e a quantidade de caracteres a retornar (3)

select substring(nome, 1, 3), nome from pessoa;



-- ============================================================

-- REPLACE

-- ============================================================


-- Consulta o e-mail e o e-mail corrigido, trocando # por @

-- REPLACE troca todas as ocorrências de um trecho por outro

-- Primeiro argumento: a coluna que será analisada
-- Segundo argumento: o trecho que será procurado
-- Terceiro argumento: o trecho que entra no lugar

select email, replace(email, '#', '@') from pessoa;

-- Altera somente o resultado da consulta
-- Para corrigir os dados na tabela seria necessário um UPDATE



-- ============================================================

-- CAST

-- ============================================================


-- Converte valores de texto para outros tipos de dados

-- CAST converte um valor de um tipo para outro

-- AS DATE converte o texto para uma data
-- AS FLOAT converte o texto para um número decimal

select cast('2029-12-31' as date), cast('1000.99' as float);

-- Esta consulta não usa tabela, por isso não possui FROM