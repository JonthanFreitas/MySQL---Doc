-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: CREATE USER, FLUSH PRIVILEGES, SHOW GRANTS e GRANT

-- ============================================================


-- Seleciona o banco de dados aula para utilizar
-- Os comandos de usuário abaixo exigem uma conta com permissão
-- de administrador (como o root)

use aula;

-- ============================================================

-- CONSULTA INICIAL

-- ============================================================


-- Mostra todos os registros e todas as colunas da tabela pessoa

select * from pessoa;



-- ============================================================

-- CREATE USER

-- ============================================================


-- Cria um novo usuário no servidor MySQL

-- CREATE USER cria o usuário, mas ele ainda não tem permissão
-- para consultar ou alterar os dados

-- IDENTIFIED BY define a senha do usuário

-- O formato correto do nome é 'usuario'@'host'
-- Exemplo: 'aluno'@'localhost' (usuário aluno, acessando de localhost)

create user 'aluno@localhost' identified by '123';

-- Atenção às aspas: 'aluno@localhost' (tudo junto) cria um usuário
-- chamado aluno@localhost com host %, e não o usuário aluno do localhost
-- Para o usuário aluno, use as aspas separadas: 'aluno'@'localhost'

-- A senha 123 é fraca, serve apenas para o exercício



-- ============================================================

-- FLUSH PRIVILEGES

-- ============================================================


-- Recarrega as permissões do servidor

-- FLUSH PRIVILEGES atualiza a memória do servidor
-- com as tabelas de permissões

flush privileges;

-- Só é necessário quando as tabelas de permissões são alteradas
-- diretamente (com INSERT ou UPDATE na tabela mysql.user)
-- CREATE USER e GRANT já aplicam as mudanças na hora



-- ============================================================

-- SHOW GRANTS

-- ============================================================


-- Mostra as permissões do usuário

-- SHOW GRANTS lista os privilégios concedidos ao usuário

show grants for 'aluno@localhost';

-- Logo após o CREATE USER, aparece somente USAGE
-- USAGE significa que o usuário pode conectar, mas não tem
-- nenhuma permissão sobre os dados



-- ============================================================

-- GRANT

-- ============================================================


-- Concede ao usuário permissão para consultar e inserir dados no banco aula

-- GRANT concede privilégios a um usuário

-- SELECT permite consultar os dados
-- INSERT permite inserir novos registros

-- ON aula.* define onde a permissão vale
-- aula é o banco de dados e * representa todas as tabelas dele

-- TO indica qual usuário recebe a permissão

grant select, insert on aula.* to 'aluno@localhost';

-- O usuário continua sem permissão para UPDATE, DELETE,
-- CREATE e DROP, e para qualquer outro banco de dados

-- Para conferir, execute o SHOW GRANTS novamente
-- Para remover uma permissão, use REVOKE