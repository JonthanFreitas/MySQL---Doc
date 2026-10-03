-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- ============================================================

-- Cria a tabela aluno

create table aluno (

    id int, -- Identificador do aluno

    nome varchar(100) not null, -- Nome do aluno, não pode ficar vazio

    genero char(01), -- Armazena um único caractere para o gênero

    nascimento date, -- Armazena a data de nascimento

    estadoCivil char(01) check (estadoCivil in ('C', 'S', 'V', 'O')), 

    -- Estado civil: C = Casado, S = Solteiro, V = Viúvo, O = Outro


    salario decimal(10,2) unsigned default 0, 

    -- Salário com até 10 dígitos e 2 casas decimais

    -- UNSIGNED = não permite valores negativos

    -- DEFAULT 0 = se não informar, o salário será 0



    email varchar(120) unique 

    -- E-mail com até 120 caracteres e não permite valores duplicados

);

-- Insere vários registros na tabela aluno

insert into aluno values 

(1, 'Helena Magalhães', 'F', '2000-01-01', 'C', 12500.99, 'helena.magalhaes@email.com'),

(2, 'Nicolas Oliveira', 'M', '2002-12-10', 'S', 8500, 'nicolas.oliveira@email.com'),

(3, 'Ana Rosa Silva', 'F', '1996-12-31', 'S', 8500, 'ana.rosa@email.com'),

(4, 'Tales Heitor Souza', 'M', '2000-10-01', 'O', 7689, 'tales.heitor@email.com'),

(5, 'Bia Meireles', 'F', '2002-03-14', 'O', 9450, 'bia.meireles@email.com'),

(6, 'Pedro Filho', 'M', null, 'V', 6800, 'pedro.filho@email.com'),

-- NULL significa que a data de nascimento não foi informada

(7, 'Helena Soares', 'F', '1994-08-10', 'S', 8600, 'helena.soares@email.com');

-- Mostra todas as tabelas existentes no banco de dados selecionado

show tables;

-- Mostra todos os registros e todas as colunas da tabela aluno

select * from aluno;

-- Cria a tabela estado

create table estado (

    id int not null primary key auto_increment,

    -- ID da tabela, chave primária e preenchida automaticamente



    nome varchar(100) not null

    -- Nome do estado, obrigatório

);

-- Insere um estado informando manualmente o ID

insert into estado values (1, 'Parana');


-- Insere um estado informando apenas o nome

-- O ID será gerado automaticamente pelo AUTO_INCREMENT

insert into estado (nome) values ('Bahia');

-- Mostra a estrutura da tabela estado

describe estado;

-- Mostra todos os registros da tabela estado

select * from estado;

-- Cria a tabela cidade

create table cidade (

    id int not null primary key auto_increment,

    -- ID da cidade, chave primária e gerado automaticamente



    nome varchar(100) not null,

    -- Nome da cidade, obrigatório



    idEstado int,

    -- Armazena o ID do estado ao qual a cidade pertence



    constraint fkCidadeEstado 

    foreign key(idEstado) 

    references estado(id)

    -- Cria uma chave estrangeira

    -- Relaciona cidade.idEstado com estado.id

);

-- Insere a cidade Salvador relacionada ao estado de ID 2 (Bahia)

insert into cidade (nome, idEstado) values ('Salvador', 2);


-- Insere a cidade Curitiba relacionada ao estado de ID 1 (Parana)

insert into cidade (nome, idEstado) values ('Curitiba', 1);


-- Mostra todos os registros da tabela cidade

select * from cidade;


-- Adiciona uma nova coluna chamada telefone na tabela aluno

alter table aluno

add telefone varchar(100);


-- Adiciona a coluna ddd depois da coluna email

-- ZEROFILL adiciona zeros à esquerda na exibição do número

alter table aluno

add ddd int zerofill after email;

-- Altera o nome da coluna telefone para celular

-- Também define o tamanho como VARCHAR(12)

alter table aluno

change telefone celular varchar(12);


-- Altera apenas a definição da coluna celular

-- Aumenta o tamanho de 12 para 14 caracteres

alter table aluno

modify celular varchar(14);


-- Renomeia a tabela aluno para alunos

alter table aluno

rename to alunos;


-- Adiciona uma chave primária na coluna id

-- pkAlunos é o nome dado à restrição

alter table alunos

add constraint pkAlunos primary key(id);

-- Mostra a estrutura final da tabela alunos

describe alunos; 

-- Adiciona a coluna idCidade na tabela alunos
ALTER TABLE alunos 
ADD idCidade INT;

-- Cria a regra de Chave Estrangeira ligando alunos.idCidade com cidade.id
ALTER TABLE alunos
ADD CONSTRAINT fkAlunoCidade 
FOREIGN KEY (idCidade) 
REFERENCES cidade(id);

