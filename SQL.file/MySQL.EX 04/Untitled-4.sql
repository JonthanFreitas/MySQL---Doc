-- ============================================================
-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL
-- Curso: Análise e Desenvolvimento de Sistemas (ADS)
-- Assunto: SELECT com WHERE, AND, OR, IN, BETWEEN e ORDER BY
-- ============================================================

-- Cria o banco de dados aula
create database aula;

-- Seleciona o banco de dados aula
use aula;

-- Cria a tabela estado
create table estado (
    id int not null primary key auto_increment, -- ID do estado, gerado automaticamente
    nome varchar(100) not null, -- Nome do estado, obrigatório
    uf char(02) not null -- Sigla do estado
);

-- Mostra todos os registros da tabela estado (ainda vazia)
select * from estado;

-- Cria a tabela cidade
create table cidade (
    id int not null primary key auto_increment, -- ID da cidade, gerado automaticamente
    nome varchar(100) not null, -- Nome da cidade, obrigatório
    estadoId int not null, -- Estado ao qual a cidade pertence
    -- Chave estrangeira: relaciona cidade.estadoId com estado.id
    constraint fkCidadeEstado foreign key (estadoId) references estado(id)
);

-- Mostra todos os registros da tabela cidade (ainda vazia)
select * from cidade;

-- Cria a tabela pessoa
create table pessoa (
    id int not null primary key auto_increment, -- ID preenchido automaticamente
    nome varchar(100) not null, -- Nome da pessoa, obrigatório
    telefone varchar(15), -- Telefone com DDD
    email varchar(120) unique, -- Email, não permite valores duplicados
    salario decimal(10,2) unsigned default 0, -- Salário, não permite valores negativos
    cidadeId int not null, -- Cidade onde a pessoa mora
    -- Chave estrangeira: relaciona pessoa.cidadeId com cidade.id
    constraint fkPessoaCidade foreign key (cidadeId) references cidade(id)
);

-- Insere os estados (primeiro, pois a cidade depende deles)
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

-- Insere as cidades (o estadoId é o id do estado na tabela estado)
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

-- Insere as pessoas (o cidadeId é o id da cidade na tabela cidade)
insert into pessoa (nome, telefone, email, salario, cidadeId) values
('Helena Magalhães', '(41) 99812-3456', 'helena.magalhaes@email.com', 12500.99, 1),
('Nicolas Oliveira', '(53) 98745-1209', 'nicolas.oliveira@email.com', 8500, 2),
('Ana Rosa Silva', '(86) 99633-7781', 'ana.rosa@email.com', 8500, 3),
('Tales Heitor Souza', '(99) 98124-5530', 'tales.heitor@email.com', 7689, 4),
('Bia Meireles', '(49) 99701-8842', 'bia.meireles@email.com', 9450, 5),
('Pedro Filho', '(31) 98877-0613', 'pedro.filho@email.com', 6800, 6),
('Helena Soares', '(11) 99450-2297', 'helena.soares@email.com', 8600, 7),
('Carlos Eduardo Lima', '(21) 98312-6748', 'carlos.lima@email.com', 5200, 8),
('Mariana Costa', '(61) 99265-4015', 'mariana.costa@email.com', 10300.50, 9),
('Rafael Andrade', '(71) 98590-3326', 'rafael.andrade@email.com', 7150.75, 10);

-- ============================================================
-- CONSULTAS COM WHERE, AND, OR, IN, BETWEEN E ORDER BY
-- ============================================================

-- AND: as duas condições precisam ser verdadeiras ao mesmo tempo
-- Mostra nome e salário das pessoas da cidade de id 1 (Curitiba) com salário maior ou igual a 8000
-- Resultado: só a Helena Magalhães (12500.99)
select nome, salario from pessoa
where cidadeid = 1
and salario >= 8000;

-- OR: basta uma das condições ser verdadeira
-- Mostra nome e salário das pessoas das cidades de id 1, 3 ou 5 (Curitiba, Parnaíba ou Videira)
-- Resultado: Helena Magalhães, Ana Rosa Silva e Bia Meireles
select nome, salario from pessoa
where cidadeid = 1
or cidadeid = 3 
or cidadeid = 5;

-- IN: faz o mesmo que os três OR acima, de forma mais curta
-- Mostra nome e salário das pessoas das cidades de id 1, 3 ou 5
-- ATENÇÃO: falta o ponto e vírgula no final (o próximo select é lido junto e dá erro de sintaxe)
select nome, salario from pessoa
where cidadeid in (1, 3, 5)

-- Faixa de valores com AND: salário de 5000 (incluso) até menos de 10000 (não incluso)
-- Mostra nome e salário das pessoas dessa faixa
select nome, salario 
from pessoa
where salario >= 5000
and salario < 10000;

-- BETWEEN: salário de 5000 até 10000, com os dois valores incluídos
-- Faz o mesmo que o >= e <= juntos (aqui o resultado é igual ao anterior, pois ninguém ganha exatamente 10000)
select nome, salario 
from pessoa
where salario between 5000 and 10000;

-- ORDER BY: ordena o resultado
-- Mostra nome e salário de todas as pessoas em ordem alfabética do nome (ASC = crescente, A até Z)
select nome, salario
from pessoa
order by nome asc;

-- Mostra nome e salário de todas as pessoas em ordem alfabética inversa (DESC = decrescente, Z até A)
select nome, salario
from pessoa
order by nome desc;

-- Combina WHERE com ORDER BY: primeiro filtra o salário entre 5000 e 10000, depois ordena pelo salário
-- Sem ASC ou DESC, a ordem padrão é crescente (menor salário primeiro)
select nome, salario 
from pessoa
where salario between 5000 and 10000
order by salario;