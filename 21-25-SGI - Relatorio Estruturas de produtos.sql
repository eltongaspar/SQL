
--Ini
-- Tabela SG1 - Estruturas dos Produtos
-- Scricpde Estrutura do Produto.
Declare @FILDE Char(4), @FILATE Char(4), @PRODINI Char(10), @CODPROD Char(10) , @PRODFIM Char(10)
Set @FILDE = 'BA01'
Set @FILATE = 'BA01'
Set @PRODINI = '0410070124'
Set @PRODFIM = '0410070124'
Set @CODPROD = '0410070124'

Select Distinct  G1_FILIAL FILIAL, G1_COD PRODUTO, SB1PROD.B1_DESC DESC_PRODUTO, G1_COMP COMPONENTE,
SB1COMP.B1_DESC DESC_COMP, G1_QUANT
From SG1010 SG1


	-- Cadastro de produtos 
	Inner Join SB1010 SB1COMP With(NoLock)
	On SG1.G1_COMP = SB1COMP.B1_COD
	And SB1COMP.D_E_L_E_T_ =''

	
	-- Cadastro de produtos 
	Inner Join SB1010 SB1PROD With(NoLock)
	On SG1.G1_COD = SB1PROD.B1_COD
	And SB1PROD.D_E_L_E_T_ =''
	
Where G1_FILIAL Between @FILDE and @FILATE and G1_COD Between @PRODINI and @PRODFIM
 and SB1PROD.B1_COD = @CODPROD and SG1.D_E_L_E_T_ =''
--Fim

/*
Select * From SG1010
Where G1_FILIAL = 'BA01' and G1_COMP = '0410070124' and D_E_L_E_T_ =''
*/