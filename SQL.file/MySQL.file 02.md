```sql
-- ============================================================
-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL
-- Curso: Análise e Desenvolvimento de Sistemas (ADS)
-- ============================================================


-- Verifica se o banco de dados existe antes de criá-lo
-- IF NOT EXISTS evita um erro caso o banco já exista
create database if not exists aula;


-- Seleciona o banco de dados que será utilizado
use aula;


-- Mostra o banco de dados atualmente selecionado
select database();


-- Mostra as tabelas existentes no banco de dados selecionado
show tables;


-- Cria a tabela produto
create table produto (
    id int not null, -- Identificador do produto, não pode ser nulo
    descricao varchar(100), -- Descrição do produto, com até 100 caracteres
    preco decimal(8,2) -- Preço do produto, com até 8 dígitos e 2 casas decimais
);


-- Insere um produto informando as colunas e seus respectivos valores
insert into produto (id, descricao, preco)
values (1, 'Smartphone xpto', 1500.99);


-- Mostra todos os registros e todas as colunas da tabela produto
select * from produto;


-- Mostra os produtos ordenados pelo preço em ordem crescente
-- ASC é a ordenação crescente e é o padrão do ORDER BY
select * from produto
order by preco;


-- Mostra os produtos ordenados pelo preço em ordem decrescente
-- DESC = decrescente
select * from produto
order by preco desc;


-- Insere outro produto na tabela
-- Os valores seguem a mesma ordem das colunas da tabela
insert into produto
values (2, 'notebook i7 4gb ram', 2500);
```
