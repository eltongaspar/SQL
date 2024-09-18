-- Comando Sum - Somar
-- #Select# #SUM#(Coluna Tabela) #AS# Nome_Variavel_Temporaria #From3 Tabela
-- #Comandos Fixos#
Select SUM(B2_QATU) AS B2_ATUAL From SB2010

-- Comando Distinct - <>
-- #Select# #Distintic# (Coluna Tabela) #From# Tabela
Select DISTINCT B2_COD From SB2010


-- Comando Order BY - ordenar pesquisa
-- ASC - crescente
-- Desc - decrescente 
-- #Select# * #From# Tabela Order By Coluna Tabela #ASC or DESC#
Select * From SB2010
Order By B2_COD Desc

-- Comando Union - eliminar linhas duplicatas
-- #Select# Coluna1, Coluna2 #From# Tabela
-- Where Coluna = '?''
-- #Union# #Select# Coluna1,Coluna2 #From# Tabela
-- Where Coluna = '??'

Select B2_COD, B2_FILIAL From SB2010
Where B2_COD = '0100010001'
Union Select B6_PRODUTO, B6_FILIAL From SB6010 
Where B6_PRODUTO = '0100010001'


-- Comando Inserct - consulta tabelas e colunas com condição AND
-- #Select# Coluna1,Coluna2 #From# Tabela
--Where Coluna = '??'
-- #Inserct# #Select# Coluna1,Coluna2 #From# Tabela
--Where Coluna = '??'
Select B2_COD, B2_FILIAL From SB2010
Where B2_FILIAL = 'BA01'
Intersect Select B2_COD, B2_FILIAL From SB2010 
Where B2_COD = '0100010001'

-- Comando Except (Minus) - retira dados em excessão da consulta
-- #Select# Coluna1,Coluna2 #From# Tabela
--Where Coluna = '??'
-- #Except# #Select# Coluna1,Coluna2 #From# Tabela
--Where Coluna = '??'
Select B2_COD, B2_FILIAL From SB2010
Where B2_FILIAL = 'BA01'
Except
Select B2_COD, B2_FILIAL From SB2010
Where B2_COD = '0100010001'

-- Between - Consultas valores entre intervalos 
Select * From SB2010
Where B2_QATU Between 1 and 150000

-- Not Between - consulta valores entre intervalos (negação)
Select B2_COD, B2_QATU From SB2010
Where B2_QATU Not Between 1 and 15000

-- Like - consultas contendo uma determinada expressão '%'
-- '%XXX' Começa com XXX
-- 'XXX%' Termina com XXX
-- '%XXX%' Contém a expressão XXX
Select * From SB2010
Where B2_COD Like '%0'
-- Pesquisa negativa NOT
Select * From SB2010
Where B2_COD Not Like '%0%'

-- Consultas com Qtde de Caracteres '_'
-- Cada _ representa a qtde de caracteres a serem consultados
Select * From SB2010
Where B2_COD Like '__________'

-- Pesquisa Negativa NOT
Select * From SB2010
Where B2_COD Not Like '__________'

-- IN - consulta os membros de conjuntos 
Select B2_COD, B2_QATU From SB2010
Where B2_FILIAL = 'BA01'
And B2_COD IN (Select B6_PRODUTO From SB6010 Where B6_SALDO > 0)

--Tupla Variavel
Select B2_FILIAL, B6_FILIAL From SB2010 F, SB6010 E
Where F.B2_FILIAL = E.B6_FILIAL

-- ALL
Select B2_COD, B2_QATU, B2_VATU1 From SB2010
Where B2_COD >all (Select B6_PRODUTO From SB6010 Where B6_SALDO > 0)

--Some
Select B2_COD, B2_QATU, B2_VATU1, B6_PRODUTO From SB2010, SB6010
Where B2_COD >some (Select B6_PRODUTO From SB6010 Where B6_SALDO > 0)

-- Exists - retorna valores 
Select B2_COD, B2_QATU From SB2010
Where Exists (Select B6_PRODUTO From SB6010 Where B2_COD = B6_PRODUTO)

-- NOT Exists
Select B2_COD, B2_QATU From SB2010
Where NOT Exists (Select B6_PRODUTO From SB6010 Where B2_COD = B6_PRODUTO)

-- Group By
--A linguagem SQL possui algumas funções específicas para 
--cálculos em grupos de tuplas: 
--? média: avg
--? mínimo: min
--? máximo: max
--? total: sum
--? contar: count

--AVG
Select B2_COD, Avg (B2_QATU) From SB2010
Group By B2_COD

--Having > 
Select B2_COD, Avg (B2_QATU) From SB2010
Group By B2_COD
having AVG (B2_QATU) < 0

--MIN
Select B2_COD, MIN (B2_QATU) From SB2010
Group By B2_COD

--MAX
Select B2_COD, MAX (B2_QATU) From SB2010
Group By B2_COD

--Count
Select B2_COD, Count (B2_QATU) From SB2010
Group By B2_COD


--Case 
Select B1_TIPO, 
--Group By B1_TIPO
Case B1_TIPO
When 'PA' Then 'PRODUTO ACABADO'
WHEN 'MP' Then 'Materia-prima'
Else  'Classificar'
End AS TIPO_PROD

From SB1010


-- Case 


--Case 
Select B1_TIPO, 
--Group By B1_TIPO
Case B1_TIPO
When 'PA' Then 'PRODUTO ACABADO'
WHEN 'MP' Then 'Materia-prima'
Else  'Classificar'
End AS TIPO_PROD

From SB1010


-- Variavel 
Declare @VLATUAL Real, @CUSMED Real,@FILIAL Char(4), @CODPRD Char(10);
Set @FILIAL = 'BA06'
Set @CODPRD = '0100030035'
Set @VLATUAL = (Select Len (B2_VATU1) From SB2010 Where B2_COD = @CODPRD and B2_FILIAL = @FILIAL );
Set @CUSMED = (Select Len (B2_CM1) From SB2010 Where B2_COD = @CODPRD and B2_FILIAL = @FILIAL );
Select @CUSMED CUSMED, @VLATUAL VLATUAL, B2_COD, B2_FILIAL, B2_VATU1, B2_CM1 From SB2010
Where --@VLATUAL >= '12' or @CUSMED >= '12' And
B2_COD = @CODPRD and B2_FILIAL = @FILIAL