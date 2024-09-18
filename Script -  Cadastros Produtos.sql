 /*--Produtos
Select B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,* 
From SB1010
where B1_COD In ('1850704401','1850604401')
And D_E_L_E_T_ = ''
--B1_XPORTAL
--Uso Portal  
--S=Sim;N=Nao;E=Especial  */

 --Produtos
Select B1_COD,
B1_NOME,Z1_APELIDO,B1_BITOLA,Z2_DESC,B1_CLASENC,SX5_CLASSE.X5_DESCRI,B1_COR,Z3_DESC,B1_ESPECIA,Z4_DESC,Z4_DETALHE,
Z1_NOME,Z1_PROCESS,Z1_VIAS,Z1_DESC2,Z4_DETALHE,
B1_XPORTAL,Z1_XPORTAL,
B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,

	Case 
		When B1_XPORTAL In ('S','E') and B1_TIPO = 'PA'
		Then 'OK'
		Else 'Error'
	End as 'Portal Produto',

	Case 
		When Z1_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Portal Nome-Familia',

	Case 
		When Z2_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Portal Bitola',
	
	Case 
		When Z3_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Cores Bitola',

	Case 
		When ZZZ_FILIAL = '' 
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And ZZZ_VLRMTR <= B1_BOBINA
		Then 'OK'
		Else 'Error'
	End as 'LancesxAcondicionamento',

	Case 
		When B1_XPORTAL In ('S','E') and B1_TIPO = 'PA'
		And Z1_XPORTAL In ('S','E')
		And Z2_XPORTAL In ('S','E')
		And Z3_XPORTAL In ('S','E')
		And ZZZ_FILIAL = '' 
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And ZZZ_VLRMTR <= B1_BOBINA
		Then 'OK'
		Else 'Produtos não ativo no Portal
			Motivo Verificar demais cadastros estão Ativos no Portal:
			Produto,Nome/Familia,Bitola, Cores'
	End as 'Produto Ativo Portal'

From SB1010 SB1
	
		Inner Join SZ1010 SZ1 --Nome-Familia-Classe Portal 
		On B1_NOME = Z1_COD
		And SZ1.D_E_L_E_T_ = '' 

		Inner Join SX5010 SX5_TP -- Tipos de Produtos
		On SX5_TP.X5_FILIAL = ''
		And SX5_TP.X5_TABELA = '02'
		And SX5_TP.X5_CHAVE = B1_TIPO
		And SX5_TP.D_E_L_E_T_ = '' 
				
		Inner Join SZ2010 SZ2 -- Bitola Portal
		On B1_BITOLA = Z2_COD
		And SZ2.D_E_L_E_T_ = '' 
						
		Inner Join SZ3010 SZ3 -- Cores Portal
		On B1_COR = Z3_COD
		And SZ3.D_E_L_E_T_ = '' 

						
		Inner Join SZ4010 SZ4 -- Especialidades
		On B1_ESPECIA = Z4_COD
		And SZ4.D_E_L_E_T_ = '' 

		Inner Join SX5010 SX5_CLASSE -- Classes 
		ON SX5_CLASSE.X5_FILIAL = '01'
		And SX5_CLASSE.X5_TABELA = 'Z1'
		And SX5_CLASSE.X5_CHAVE = B1_CLASENC
		And SX5_CLASSE.D_E_L_E_T_ = '' 


		Left Join ZZZ010 ZZZ -- Lances x Acondicionamento 
		On ZZZ_FILIAL = ''
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And ZZZ_VLRMTR <= B1_BOBINA


Where B1_COD In ('0240420401','0240421401', '0240422401', '0240423401','0240502401', '0240520401','0240521401', '0240522401', 
'0240523401','0240602401','0240620401','0240621401','0240622401','0240623401')
And SB1.D_E_L_E_T_ = ''


/*
-- Genericas - Tipos de produtos 
Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE = 'PA'
 and D_E_L_E_T_ =''

 -- Nome Produto 
 Select * From SZ1010
 Where Z1_COD In ('115','185') and D_E_L_E_T_ =''  

  -- Bitola
 Select * From SZ2010
 Where  D_E_L_E_T_ ='' and Z2_COD = '05'
 Order By Z2_XPORTAL

 --Campos
 Select * From SX3010
 Where X3_CAMPO = 'Z2_XPORTAL'
 And D_E_L_E_T_ =''

   -- Cores
 Select * From SZ3010
 Where  D_E_L_E_T_ =''
 And Z3_COD = '01'


 -- Classe
Select * From SX5010
Where X5_TABELA = 'Z1' 
 and D_E_L_E_T_ =''

   -- Especialidade
 Select * From SZ4010
 Where  D_E_L_E_T_ =''

 
 --LANCES X ACONDICIONAMENTO     
 Select * From ZZZ010
 Where ZZZ_BITOLA <> ('') and ZZZ_ACOND In ('B') and ZZZ_PROD In ('185')
  and D_E_L_E_T_ =''

-- Portal -- 
--SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 
WHERE Z2_COD IN( '08','04','05')

--Produtos Descriçao
Select * From SZ7010


-- SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 WHERE Z2_COD IN( '08','04','05')



-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD = 'PE4016A'  and D_E_L_E_T_ = ''

-- Produtos Complemento
Select * From SB5010
Where B5_COD = 'MC09000022'  and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD = 'MC09000022'  and D_E_L_E_T_ = ''*/
