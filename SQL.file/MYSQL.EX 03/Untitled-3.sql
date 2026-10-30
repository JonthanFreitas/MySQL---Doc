-- ============================================================
-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL
-- Curso: Análise e Desenvolvimento de Sistemas (ADS)
-- Assunto: UPDATE e DELETE sem proteção e com proteção (safe update mode)
-- ============================================================
-- Criando um Banco de dados

create database aula;

-- Seleciona o banco de dados aula
use aula;

-- Apaga a tabela cidade para recomeçar o exercício
drop table cidade;

-- Cria a tabela cidade
create table cidade (
    id int, -- Identificador da cidade
    nome varchar(100), -- Nome da cidade
    uf char(02), -- Sigla do estado, com 2 caracteres
    constraint pkCidade primary key (id)
    -- Define o id como chave primária (não repete e não fica vazio)
);
-- Inserir os registros na tabela cidade
insert into cidade values (1, 'Curitiba', 'PR');
insert into cidade values (2, 'Bagé', 'RS');
insert into cidade values (3, 'Parnaíba', 'PI');
insert into cidade values (4, 'Videira', 'SC');
insert into cidade values (5, 'Imperatriz' , 'MA');
insert into cidade values (6, 'Belo Horizonte', 'MG');
insert into cidade values (7, 'São Paulo', 'SP');

-- Mostra todos os registros da tabela cidade
select * from cidade;

-- ============================================================
-- PARTE 1: UPDATE E DELETE SEM PROTEÇÃO (modo seguro desligado)
-- ============================================================
-- Desliga o modo seguro (safe update mode) nesta conexão
set SQL_SAFE_UPDATES = 0;

-- Altera o nome de TODAS as cidades para Teste
-- Sem o WHERE, o update atinge todas as linhas
-- Com a proteção desligada, o MySQL deixa passar
update cidade 
set nome = 'Teste';

-- Mostra todos os registros da tabela cidade
-- Todas as cidades ficaram com o nome Teste (os nomes originais foram perdidos)
select * from cidade;

-- Apaga TODAS as cidades da tabela
-- Sem o WHERE, o delete atinge todas as linhas
-- Com a proteção desligada, o MySQL deixa passar
delete from cidade;

-- Mostra todos os registros da tabela cidade
-- A tabela continua existindo, mas voltou vazia (todos os dados foram perdidos)
select * from cidade;

-- ============================================================
-- PARTE 2: UPDATE E DELETE COM PROTEÇÃO (modo seguro ligado)
-- ============================================================
-- Insere de novo os mesmos registros na tabela cidade
insert into cidade values (1, 'Curitiba', 'PR');
insert into cidade values (2, 'Bagé', 'RS');
insert into cidade values (3, 'Parnaíba', 'PI');
insert into cidade values (4, 'Videira', 'SC');
insert into cidade values (5, 'Imperatriz' , 'MA');
insert into cidade values (6, 'Belo Horizonte', 'MG');
insert into cidade values (7, 'São Paulo', 'SP');

-- Liga o modo seguro (safe update mode) nesta conexão
set SQL_SAFE_UPDATES = 1;

-- Tenta alterar o nome de TODAS as cidades para Teste
-- Sem o WHERE, o MySQL bloqueia o comando (erro 1175)
-- Nenhuma linha é alterada
update cidade 
set nome = 'Teste';

-- Altera o nome da cidade de id 2 (Bagé) para Gramado
-- O WHERE usa o id (coluna chave), então o MySQL permite mesmo com a proteção ligada
-- Só a cidade de id 2 é alterada
update cidade 
set nome = 'Gramado'
where id = 2;

-- Mostra todos os registros da tabela cidade
select * from cidade;

-- Altera o nome e a uf da cidade de id 5 (Imperatriz)
-- Para alterar mais de uma coluna, separa com vírgula
-- Só a cidade de id 5 é alterada
update cidade 
set nome = 'Londrina',
uf = 'PR'
where id = 5;

-- Mostra todos os registros da tabela cidade
select * from cidade;

-- Tenta apagar TODAS as cidades da tabela
-- Sem o WHERE, o MySQL bloqueia o comando (erro 1175)
-- Nenhuma linha é apagada
delete from cidade;

-- Apaga a cidade de id 7 (São Paulo)
-- O WHERE usa o id (coluna chave), então o MySQL permite mesmo com a proteção ligada
-- Só a linha que atende ao WHERE é apagada
delete from cidade where id = 7;

-- Mostra todos os registros da tabela cidade
-- Sobram 6 cidades (Gramado e Londrina alteradas, e São Paulo apagada)
select * from cidade;