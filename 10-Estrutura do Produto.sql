-- Relatório de Estrutura de produtos com componentes relacionados
SELECT PRD.B1_DESC DESCR_PRODUZIDO, COMP.B1_DESC DESCR_COMPONENTE, SG1010.*
FROM SG1010
INNER JOIN SB1010 PRD ON G1_COD=PRD.B1_COD AND PRD.D_E_L_E_T_=''
INNER JOIN SB1010 COMP ON G1_COMP=COMP.B1_COD AND COMP.D_E_L_E_T_=''
WHERE G1_FILIAL NOT IN ('XX99')
AND SG1010.D_E_L_E_T_=''
ORDER BY G1_FILIAL, G1_COD, G1_COMP


--Ini
-- Saldo Fisico e Financeiro (Estoque) 
-- Tabela SG1 - Estruturas dos Produtos
-- Scricp para analise de casas decimais por Estrutura do Produto.
Declare @FILDE Char(4), @FILATE Char(4), @PROD Char(10), @CODPROD Char(10)
Set @FILDE = '01'
Set @FILATE = '03'
Set @PROD = '000000000'
Set @CODPROD = '9999999999'
Select  Distinct SB2.B2_FILIAL, SB2.B2_COD PROD_COD, SB1.B1_DESC PROD_DES, SB2.B2_LOCAL, SB2.B2_VATU1, SB2.B2_CM1,
Len(SB2.B2_CM1) AS CUS_MED, Len(SB2.B2_VATU1) AS VL_ATUAL,

	Case 
	When Len(B2_VATU1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_VATUAL,

	Case 
	When Len(B2_CM1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_CM	
From SG1010 SG1

	-- Estoque
	Inner Join SB2010 SB2 With(NoLock)
	ON SG1.G1_COMP = SB2.B2_COD
	And SG1.G1_FILIAL = SB2.B2_FILIAL
	And SB2.D_E_L_E_T_ =''

	-- Cadastro de produtos 
	Inner Join SB1010 SB1 With(NoLock)
	On SG1.G1_COMP = SB1.B1_COD
	And SB1.D_E_L_E_T_ =''
	
Where G1_FILIAL Between @FILDE and @FILATE and G1_COD = @PROD or B1_COD = @CODPROD and SG1.D_E_L_E_T_ =''
Order BY 1,2

--Fim






--Ini
-- Saldo Fisico e Financeiro (Estoque)
---- Script Simples para analise de Total de caracteres numéricos na SB2
Select B2_FILIAL, B2_COD, B2_LOCAL, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL, Len(B2_CM1) AS CUS_MED From SB2010
Where B2_FILIAL = 'BA06'and B2_COD In ('0100030035','0400700001','0400700004','0550010072') and D_E_L_E_T_ = ''

--Fim

--Ini
-- Saldo Fisico e Financeiro (Estoque)
-- Script Simples para analise de Total de caracteres numéricos na SB2 com Case
Declare @FILINI Char(4), @FILFIM Char(4)
Set @FILINI = 'BA01'
Set @FILFIM = 'BA20'
Select B2_FILIAL, B2_COD, B2_LOCAL, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL, Len(B2_CM1) AS CUS_MED ,

Case 
When Len(B2_VATU1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VATUAL,

Case 
When Len(B2_CM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM

From SB2010
Where B2_FILIAL Between @FILINI and @FILFIM and 
B2_COD In ('0100030035','0400700001','0400700004','0550010072') and D_E_L_E_T_ = ''
--Fim


--Ini
-- Saldo Fisico e Financeiro (Estoque)
---- Script Simples para analise de Total de caracteres numéricos na SB2
Select B2_FILIAL, B2_COD, B2_LOCAL, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL, Len(B2_CM1) AS CUS_MED From SB2010
Where B2_FILIAL = 'BA06'and B2_COD In ('0100030035','0400700001','0400700004','0550010072') and D_E_L_E_T_ = ''

--Fim

--Ini
-- Saldo Fisico e Financeiro (Estoque)
-- Script Simples para analise de Total de caracteres numéricos na SB2 com Case
Declare @FILINI Char(4), @FILFIM Char(4), @CODPRODINI Char(10), @CODPRODFIM Char(10);
Set @FILINI = 'AA01'
Set @FILFIM = 'ZZ99'
Set @CODPRODINI = '0000000000'
Set @CODPRODFIM = '9999999999'

Select B2_FILIAL, B2_COD, B2_LOCAL, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL, Len(B2_CM1) AS CUS_MED ,

Case 
When Len(B2_VATU1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VATUAL,

Case 
When Len(B2_CM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM

From SB2010 With(NoLock)
Where B2_FILIAL Between @FILINI and @FILFIM and B2_COD Between @CODPRODINI and @CODPRODFIM
and B2_VATU1 <> 0 and B2_CM1 <> 0 
and  D_E_L_E_T_='' 

Order By 8,9
--Fim




--Ini
-- Saldo Fisico e Financeiro (Estoque) 
--Script para analise de Total de caracteres numericos na SB2 com variavel
Declare @VLATUAL Real, @CUSMED Real,@FILIALINI Char(4), @CODPRDINI Char(10)
Set @FILIALINI = 'BA06'
Set @CODPRDINI = '0100030035'

Set @VLATUAL = (Select Len (B2_VATU1) From SB2010 Where B2_COD = @CODPRDINI and B2_FILIAL = @FILIALINI);
Set @CUSMED = (Select Len (B2_CM1) From SB2010 Where B2_COD = @CODPRDINI and B2_FILIAL = @FILIALINI)
Select @CUSMED CUSMED, @VLATUAL VLATUAL, B2_COD, B2_FILIAL, B2_VATU1, B2_CM1,

	Case 
	When Len(B2_VATU1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_VATUAL,

	Case 
	When Len(B2_CM1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_CM


From SB2010
Where B2_COD = @CODPRDINI and B2_FILIAL = @FILIALINI
and D_E_L_E_T_=''

--Fim


--Ini
-- Saldo Fisico e Financeiro (Estoque) 
-- Tabela SG1 - Estruturas dos Produtos
-- Scricp para analise de casas decimais por Estrutura do Produto.
Declare @FILDE Char(4), @FILATE Char(4), @PROD Char(10)
Set @FILDE = 'BA06'
Set @FILATE = 'BA06'
Set @PROD = '0100030035'
Select  Distinct SB2.B2_FILIAL, SB2.B2_COD PROD_COD, SB1.B1_DESC PROD_DES, SB2.B2_LOCAL, SB2.B2_VATU1, SB2.B2_CM1,
Len(SB2.B2_CM1) AS CUS_MED, Len(SB2.B2_VATU1) AS VL_ATUAL,

	Case 
	When Len(B2_VATU1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_VATUAL,

	Case 
	When Len(B2_CM1) >= '12' Then '************'
	Else '0123456789'
	End AS Casas_Decimais_CM	
From SG1010 SG1

	-- Estoque
	Inner Join SB2010 SB2 With(NoLock)
	ON SG1.G1_COMP = SB2.B2_COD
	And SG1.G1_FILIAL = SB2.B2_FILIAL
	And SB2.D_E_L_E_T_ =''

	-- Cadastro de produtos 
	Inner Join SB1010 SB1 With(NoLock)
	On SG1.G1_COMP = SB1.B1_COD
	And SB1.D_E_L_E_T_ =''
	
Where G1_FILIAL Between @FILDE and @FILATE and G1_COD = @PROD and SG1.D_E_L_E_T_ =''
Order BY 1,2

--Fim

--Ini
-- Saldo Fisico e Financeiro (Estoque) 
-- Scrip Simples 
Select B2_FILIAL, B2_COD,B2_VATU1, B2_CM1, Len (B2_VATU1) VALATUA, Len (B2_CM1) CUSMED
From SB2010 
Where B2_COD = '0100030035' and B2_FILIAL ='BA06' and D_E_L_E_T_ =''

--Fim



--Ini
--- Produtos e Componentes

-- Tabela SG1 - Estruturas dos Produtos
Select * From SG1010
Where G1_FILIAL = 'BA06' and G1_COD = '0100030035'

-- Cadastro de Produtos
Select * From SB1010
Where B1_COD = '0100030035'

--Fim 