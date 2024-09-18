
--Ini
-- Saldo Fisico e Financeiro (Estoque) 
-- Tabela SG1 - Estruturas dos Produtos
-- Scricp para analise de casas decimais por Estrutura do Produto.
Declare @FILDE Char(4), @FILATE Char(4), @PROD Char(10), @CODPROD Char(10)
Set @FILDE = 'BA02'
Set @FILATE = 'BA02'
Set @PROD = '0110040209'
Set @CODPROD = '0110040209'
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