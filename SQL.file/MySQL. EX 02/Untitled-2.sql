-- ============================================================
-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL
-- Inclusão de Registro (DML)
-- ============================================================

-- Seleciona o banco de dados aula
use aula;

-- Cria a tabela cidade
create table cidade (
	id int, -- Identificador da cidade
    nome varchar(100) not null, -- Nome da cidade, obrigatório
    uf char(02), -- Sigla do estado, pode ficar vazia
    constraint pkCidade primary key (id)
);

-- Cria a tabela cliente
create table cliente (
	id int auto_increment, -- ID preenchido automaticamente
    nome varchar(100),
    cidadeId int not null, -- Cidade do cliente, obrigatória
    constraint pkCliente primary key (id),
    -- Chave estrangeira: relaciona cliente.cidadeId com cidade.id
    constraint fkClienteCidade foreign key (cidadeId) references cidade(id)
);

-- insert sintax completa
-- Informa as colunas e os valores
insert into cidade (id, nome, uf) values (1, 'Bagé', 'RS');

-- reduzido
-- Sem informar as colunas, precisa passar todos os valores
insert into cidade values (2, 'Parnaiba', 'PI');

-- insert de algumas colunas
-- A uf não foi informada, então fica NULL
insert into cidade (id, nome) values (3,'Imperatriz');

-- Mostra todos os registros da tabela cidade
select * from cidade;

-- Insere um cliente
-- ATENÇÃO: a tabela tem 3 colunas e foram passados só 2 valores (dá erro)
insert into cliente values ('Pedro', 1);

-- erro de chave estrangeira
-- A cidade 10 não existe na tabela cidade
insert into cliente values ('Maria', 10);

-- insert de varios registro
-- Insere 3 clientes em um único comando
-- ATENÇÃO: falta o ponto e vírgula no final
insert into cliente (nome, cidadeId) values ('Nicolas', 2), ('Helena', 1), ('Beatriz',3)

-- Mostra todos os registros da tabela cliente
select * from cliente;


-- Cria a tabela funcionario
create table funcionario (
	id int,
    nome varchar(100),
    cidadeId int not null,
    constraint fkFuncCidade foreign key (cidadeId) references cidade (id)
);

-- Copia os dados da tabela cliente para a tabela funcionario
-- ATENÇÃO: falta o ponto e vírgula no final
insert into funcionario (id, nome, cidadeid)
	select id, nome, cidadeid from cliente

-- Mostra todos os registros da tabela funcionario
select * from funcionario;