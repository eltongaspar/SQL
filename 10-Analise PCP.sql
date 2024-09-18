

Select D3_FILIAL,D3_COD,SB1.B1_DESC,Sum(D3_QUANT) AS D3_QUANT,Sum(D3_CUSTO1) As D3_CUSTO,C2_PRODUTO,
Sum(NULLIF(C2_QUJE,0)/NULLIF(D3_QUANT,0)) As MED_QUANT, Sum(NULLIF(D3_CUSTO1,0)/NULLIF(C2_QUJE,0)) As MED_CUSTO
From SD3010 SD3

	Inner Join SB1010 SB1
	On SB1.B1_COD = D3_COD
	And SB1.D_E_L_E_T_ = ''
		
	Inner Join SC2010 SC2
	On C2_FILIAL = D3_FILIAL 
	And C2_OP = D3_OP
	And SC2.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1_C2
	On SB1_C2.B1_COD = C2_PRODUTO
	And SB1_C2.B1_TIPO = 'PA'
	And SB1_C2.D_E_L_E_T_ = ''


Where SB1.B1_COD Like('%MOD%') And D3_TM >= ('501') And D3_ESTORNO = ''
And D3_EMISSAO > '20231001'
And SD3.D_E_L_E_T_ = ''
Group By D3_FILIAL,D3_COD,SB1.B1_DESC,C2_PRODUTO
Order By 1,2




--Movimentações Internas 
Select D3_OP,* From SD3010 SD3
Where D3_EMISSAO = '20231031'
And SD3.D_E_L_E_T_ = ''

-- Ordens de Produção 
Select B1_TIPO,C2_OP,* From SC2010 SC2
	
	Inner Join SB1010 SB1
	On B1_COD = C2_PRODUTO
	And SB1.D_E_L_E_T_ = ''

Where C2_EMISSAO = '20231031' and B1_TIPO = 'PA'
And SC2.D_E_L_E_T_ = ''
Order By C2_NUM,C2_ITEM



-- Estrutura do produto 
Select * From SG1010 SG1
Where G1_COD Like('%MOD%') or G1_COMP Like('%MOD%')
And SG1.D_E_L_E_T_ = ''

