-- ============================================================

-- EXERCÍCIO DA FACULDADE - BANCO DE DADOS / MYSQL

-- Curso: Análise e Desenvolvimento de Sistemas (ADS)

-- Conteúdo: ROUND, TRUNCATE, MOD, DIV, DAY, MONTH, YEAR, DAYNAME,
-- MONTHNAME, CURTIME, HOUR, MINUTE, ADDDATE e DATEDIFF

-- ============================================================


-- Seleciona o banco de dados aula para utilizar

use aula;



-- ============================================================

-- ROUND E TRUNCATE

-- ============================================================


-- Consulta o salário original, arredondado e truncado

-- ROUND arredonda o número para a quantidade de casas decimais informada
-- Exemplo: ROUND(1234.5678, 2) retorna 1234.57

-- TRUNCATE corta as casas decimais sem arredondar
-- Exemplo: TRUNCATE(1234.5678, 2) retorna 1234.56

-- O segundo argumento (2) é a quantidade de casas decimais

select salario, round(salario, 2), truncate(salario, 2)
from pessoa;

-- Como o salário já possui apenas 2 casas decimais,
-- o resultado das três colunas é igual

-- Com número negativo, atua antes da vírgula
-- Exemplo: ROUND(1234.5678, -2) retorna 1200 (arredonda nas centenas)

-- Atenção: TRUNCATE aqui é uma função
-- Não confundir com TRUNCATE TABLE, que apaga os registros da tabela



-- ============================================================

-- MOD E DIV

-- ============================================================


-- Consulta o resto da divisão e o resultado da divisão inteira

-- MOD retorna o resto da divisão
-- 10 dividido por 2 tem resto 0

-- DIV retorna a divisão inteira, sem a parte decimal
-- 10 div 2 retorna 5

-- Esta consulta não usa tabela, por isso não possui FROM

select mod (10, 2), 10 div 2;

-- Exemplo com divisão que não é exata:
-- MOD(10, 3) retorna 1 (resto)
-- 10 DIV 3 retorna 3 (descarta a parte decimal)
-- 10 / 3 retorna 3.3333 (divisão normal, com decimais)

-- Dividir por zero retorna NULL



-- ============================================================

-- DAY, MONTH E YEAR

-- ============================================================


-- Consulta o dia, o mês e o ano de uma data

-- DAY retorna o dia da data
-- MONTH retorna o mês da data (número de 1 a 12)
-- YEAR retorna o ano da data

-- A data é informada no formato AAAA-MM-DD

select day ('2030-12-31'),
month('2030-12-31'),
year('2030-12-31');



-- ============================================================

-- DAYNAME E MONTHNAME

-- ============================================================


-- Consulta o nome do dia da semana e o nome do mês de uma data

-- DAYNAME retorna o dia da semana por extenso
-- MONTHNAME retorna o mês por extenso

select dayname('2030-12-31'), monthname('2030-12-31');

-- Por padrão, os nomes aparecem em inglês (Tuesday e December)
-- Para português, execute antes: set lc_time_names = 'pt_BR';



-- ============================================================

-- CURTIME

-- ============================================================


-- Consulta a hora atual do servidor

-- CURTIME retorna a hora atual no formato HH:MM:SS

-- Não recebe argumentos
-- O resultado muda a cada execução

select curtime();



-- ============================================================

-- HOUR E MINUTE

-- ============================================================


-- Consulta a hora de um horário

-- HOUR extrai a hora do horário informado

select hour('12:00:10');


-- Consulta os minutos de um horário

-- MINUTE extrai os minutos do horário informado

select minute('12:00:10');

-- Também existe SECOND, que extrai os segundos



-- ============================================================

-- ADDDATE

-- ============================================================


-- Consulta a data resultante da soma de 30 dias a uma data

-- ADDDATE soma um intervalo de tempo a uma data

-- INTERVAL define a quantidade e a unidade do intervalo
-- 30 DAY = 30 dias

select adddate('2030-12-31', interval 30 day);

-- Outras unidades: MONTH (mês) e YEAR (ano)
-- Valor negativo subtrai do tempo
-- Exemplo: INTERVAL -1 MONTH volta um mês

-- Se o mês de destino for mais curto, ajusta para o último dia
-- Exemplo: 31/01 mais 1 MONTH resulta em 28/02 (ano não bissexto)



-- ============================================================

-- DATEDIFF

-- ============================================================


-- Consulta a quantidade de dias entre duas datas

-- DATEDIFF calcula a diferença em dias
-- Fórmula: primeira data menos segunda data

select datediff('2035-11-06', '2030-12-30');

-- Se a primeira data for anterior à segunda, o resultado é negativo
-- Por isso, informe primeiro a data mais recente

-- A hora, quando existe, é ignorada no cálculo