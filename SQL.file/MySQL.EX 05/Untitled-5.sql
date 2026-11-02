
-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: INNER JOIN, LEFT JOIN, RIGHT JOIN, CROSS JOIN, SELF JOIN, LIMIT e CASE

-- ============================================================

-- Cria o banco de dados aula

create database aula;


-- Seleciona o banco de dados aula para utilizar

use aula;

-- ============================================================

-- CRIAÇÃO DAS TABELAS

-- ============================================================


-- Cria a tabela estado

create table estado (

    id int not null primary key auto_increment,

    -- ID do estado, chave primária e gerado automaticamente


    nome varchar(100) not null,

    -- Nome do estado, obrigatório


    uf char(02) not null

    -- Sigla do estado com dois caracteres

);


-- Cria a tabela cidade

create table cidade (

    id int not null primary key auto_increment,

    -- ID da cidade, chave primária e gerado automaticamente


    nome varchar(100) not null,

    -- Nome da cidade, obrigatório


    estadoId int not null,

    -- Armazena o ID do estado ao qual a cidade pertence


    constraint fkCidadeEstado
    foreign key (estadoId)
    references estado(id)

    -- Cria uma chave estrangeira
    -- Relaciona cidade.estadoId com estado.id

);


-- Cria a tabela departamento

create table departamento (

    id int not null primary key auto_increment,

    -- ID do departamento, chave primária e gerado automaticamente


    nome varchar(100) not null

    -- Nome do departamento, obrigatório

);


-- Cria a tabela pessoa

create table pessoa (

    id int not null primary key auto_increment,

    -- ID da pessoa, chave primária e gerado automaticamente


    nome varchar(100) not null,

    -- Nome da pessoa, obrigatório


    sexo char(01) not null check (sexo in ('M', 'F')),

    -- Armazena um caractere para o sexo
    -- CHECK permite apenas os valores M ou F
    -- NOT NULL não permite valores nulos


    telefone varchar(15),

    -- Armazena o telefone com DDD


    email varchar(120) unique,

    -- E-mail com até 120 caracteres
    -- UNIQUE não permite valores duplicados


    salario decimal(10,2) default 0 check (salario >= 0),

    -- Salário com até 10 dígitos e 2 casas decimais
    -- DEFAULT 0 = se não informar, o salário será 0
    -- CHECK impede valores negativos


    cidadeId int not null,

    -- Armazena o ID da cidade onde a pessoa mora


    departamentoId int not null,

    -- Armazena o ID do departamento onde a pessoa trabalha


    gerenteId int,

    -- Armazena o ID do gerente da pessoa
    -- NULL significa que não possui gerente cadastrado


    constraint fkPessoaCidade
    foreign key (cidadeId)
    references cidade(id),

    -- Cria uma chave estrangeira
    -- Relaciona pessoa.cidadeId com cidade.id


    constraint fkPessoaDepartamento
    foreign key (departamentoId)
    references departamento(id),

    -- Cria uma chave estrangeira
    -- Relaciona pessoa.departamentoId com departamento.id


    constraint fkPessoaGerente
    foreign key (gerenteId)
    references pessoa(id)

    -- Cria uma chave estrangeira na própria tabela
    -- Relaciona pessoa.gerenteId com pessoa.id
    -- Esse relacionamento é chamado de autorrelacionamento

);



-- ============================================================

-- INSERÇÃO DOS REGISTROS

-- ============================================================


-- Insere os estados na tabela estado

-- Os estados são cadastrados primeiro, pois as cidades dependem deles

insert into estado (id, nome, uf) values

(1, 'Paraná', 'PR'),
(2, 'Rio Grande do Sul', 'RS'),
(3, 'Piauí', 'PI'),
(4, 'Maranhão', 'MA'),
(5, 'Santa Catarina', 'SC'),
(6, 'Minas Gerais', 'MG'),
(7, 'São Paulo', 'SP'),
(8, 'Rio de Janeiro', 'RJ'),
(9, 'Distrito Federal', 'DF'),
(10, 'Bahia', 'BA');


-- Insere as cidades na tabela cidade

-- O estadoId identifica o estado ao qual cada cidade pertence

insert into cidade (id, nome, estadoId) values

(1, 'Curitiba', 1),
(2, 'Bagé', 2),
(3, 'Parnaíba', 3),
(4, 'Imperatriz', 4),
(5, 'Videira', 5),
(6, 'Belo Horizonte', 6),
(7, 'São Paulo', 7),
(8, 'Rio de Janeiro', 8),
(9, 'Brasília', 9),
(10, 'Salvador', 10);


-- Insere os departamentos na tabela departamento

-- Cada departamento possui um ID e um nome

insert into departamento (id, nome) values

(1, 'TI'),
(2, 'Vendas'),
(3, 'RH'),
(4, 'Financeiro');


-- Insere as pessoas na tabela pessoa

-- cidadeId identifica a cidade onde a pessoa mora
-- departamentoId identifica o departamento onde a pessoa trabalha
-- gerenteId identifica o gerente responsável pela pessoa

-- Os gerentes são cadastrados antes dos funcionários
-- que possuem relacionamento com eles

-- NULL no gerenteId significa que a pessoa não possui gerente

-- Os valores de sexo são exemplos para o exercício

insert into pessoa
(nome, sexo, telefone, email, salario, cidadeId, departamentoId, gerenteId)
values

('Helena Magalhães', 'F', '(41) 99812-3456', 'helena.magalhaes@email.com', 12500.99, 1, 1, null),

('Nicolas Oliveira', 'M', '(53) 98745-1209', 'nicolas.oliveira@email.com', 8500, 2, 2, null),

('Ana Rosa Silva', 'F', '(86) 99633-7781', 'ana.rosa@email.com', 8500, 3, 3, null),

('Tales Heitor Souza', 'M', '(99) 98124-5530', 'tales.heitor@email.com', 7689, 4, 1, 1),

('Bia Meireles', 'F', '(49) 99701-8842', 'bia.meireles@email.com', 9450, 5, 2, 2),

('Pedro Filho', 'M', '(31) 98877-0613', 'pedro.filho@email.com', 6800, 6, 4, null),

('Helena Soares', 'F', '(11) 99450-2297', 'helena.soares@email.com', 8600, 7, 3, 3),

('Carlos Eduardo Lima', 'M', '(21) 98312-6748', 'carlos.lima@email.com', 5200, 8, 1, 1),

('Mariana Costa', 'F', '(61) 99265-4015', 'mariana.costa@email.com', 10300.50, 9, 4, 6),

('Rafael Andrade', 'M', '(71) 98590-3326', 'rafael.andrade@email.com', 7150.75, 10, 2, 2);



-- ============================================================

-- CONSULTAS SQL

-- ============================================================


-- Mostra todos os registros e todas as colunas da tabela pessoa

select * from pessoa;



-- ============================================================

-- INNER JOIN

-- ============================================================


-- Consulta o nome das cidades e seus respectivos estados

-- INNER JOIN retorna somente os registros que possuem
-- correspondência entre as duas tabelas

-- AS define um apelido para as colunas no resultado

select cidade.nome as nomeCidade,
       estado.nome as nomeEstado

from cidade

inner join estado

on cidade.estadoId = estado.id;

-- ON relaciona cidade.estadoId com estado.id



-- ============================================================

-- LEFT JOIN

-- ============================================================


-- Consulta todas as cidades e seus respectivos estados

-- LEFT JOIN retorna todos os registros da tabela da esquerda

-- Quando não existe correspondência na tabela estado,
-- o nome do estado aparece como NULL

select cidade.nome as nomeCidade,
       estado.nome as nomeEstado

from cidade

left join estado

on cidade.estadoId = estado.id;



-- ============================================================

-- RIGHT JOIN

-- ============================================================


-- Consulta todos os estados e suas respectivas cidades

-- RIGHT JOIN retorna todos os registros da tabela da direita

-- Quando não existe cidade correspondente,
-- o nome da cidade aparece como NULL

select cidade.nome as nomeCidade,
       estado.nome as nomeEstado

from cidade

right join estado

on cidade.estadoId = estado.id;



-- ============================================================

-- CROSS JOIN

-- ============================================================


-- Realiza todas as combinações possíveis entre cidades e estados

-- CROSS JOIN não utiliza uma condição ON

-- Como existem 10 cidades e 10 estados,
-- o resultado possui 100 combinações

select cidade.nome as nomeCidade,
       estado.nome as nomeEstado

from cidade

cross join estado

order by nomeCidade;

-- ORDER BY organiza os registros pelo nome da cidade



-- ============================================================

-- SELF JOIN COM INNER JOIN

-- ============================================================


-- Consulta os funcionários e seus respectivos gerentes

-- SELF JOIN relaciona uma tabela com ela mesma

-- AS gerente cria um apelido para a tabela pessoa

-- INNER JOIN retorna somente as pessoas que possuem gerente

select pessoa.nome as funcionario,
       gerente.nome as gerente

from pessoa

inner join pessoa as gerente

on pessoa.gerenteId = gerente.id;

-- Relaciona o gerenteId do funcionário com o ID do gerente



-- ============================================================

-- SELF JOIN COM LEFT JOIN

-- ============================================================


-- Consulta todas as pessoas e seus respectivos gerentes

-- LEFT JOIN permite mostrar também as pessoas sem gerente

-- Quando a pessoa não possui gerente,
-- a coluna gerente apresenta NULL

select pessoa.nome as funcionario,
       gerente.nome as gerente

from pessoa

left join pessoa as gerente

on pessoa.gerenteId = gerente.id;



-- ============================================================

-- LIMIT

-- ============================================================


-- Consulta apenas três registros da tabela pessoa

-- ORDER BY organiza os registros pelo ID

-- LIMIT determina a quantidade máxima de registros retornados

select *

from pessoa

order by id

limit 3;

-- ============================================================

-- CASE

-- ============================================================


-- Consulta o nome dos funcionários e apresenta o sexo por extenso

-- CASE permite realizar verificações condicionais

select nome as 'Nome do funcionario',

case

    when sexo = 'F' then 'Feminino'

    -- Se o sexo for F, retorna Feminino


    when sexo = 'M' then 'Masculino'

    -- Se o sexo for M, retorna Masculino

end as 'Genero'

-- Finaliza o CASE e define o apelido da coluna
