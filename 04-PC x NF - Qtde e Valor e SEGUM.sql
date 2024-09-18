-- PC x NF Entada Itens 
-- SC7 - PC
-- SD1 - NF Entrada Itens 
Select Distinct  C7_NUM,D1_DOC,C7_PRODUTO,C7_ITEM,D1_ITEMPC,D1_ITEM,C7_QUANT,C7_QTSEGUM,C7_UM,C7_SEGUM,C7_QUJE,C7_QTDACLA,(C7_QTSEGUM/C7_QUANT) as Fator_PC,
D1_QUANT,D1_QTSEGUM,D1_SEGUM,(D1_QTSEGUM/B1_CONV) as Fator_NF,(C7_PRECO/B1_CONV) as VAL_UNIT_PC,
B1_UM,B1_SEGUM,B1_CONV,B1_TIPCONV,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As SALDO_PC, D1_VUNIT,D1_TOTAL,C7_PRECO,C7_TOTAL,AIC_CODIGO,AIC_PQTDE,AIC_PPRECO,

	Case 
	When (D1_VUNIT-C7_PRECO) = 0 Then 'Unidade - VALOR CERTO'
	When (D1_VUNIT-C7_PRECO) > 0 Then 'Unidade - VALOR NF > PC - Acionar Compras-- Controle de Tolerancia '
	When (D1_VUNIT-C7_PRECO) < 0 Then 'Unidade - VALOR NF < PC - Aciobar Compras- - Controle de Tolerancia'
	Else 'Verificar'
	End AS Valor_Unidade,

	Case 
	When (D1_TOTAL-C7_TOTAL) = 0 Then 'Total - VALOR CERTO'
	When (D1_TOTAL-C7_TOTAL) > 0 Then 'Total - VALOR NF > PC - Acionar Compras - Controle de Tolerancia'
	When (D1_TOTAL-C7_TOTAL) < 0 Then 'Total - VALOR NF < PC - Acionar Compras- - Controle de Tolerancia'
	Else 'Verificar'
	End AS Status_,
	   	
	Case 
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) = 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'ATENDIDO'
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) > 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'PARCIAL'
	When C7_QUJE = 0 and C7_QTDACLA = 0   Then 'Em Aberto'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_ENCER = 'E'  Then 'Encerrado'
	When C7_ENCER = ' '  Then 'Nao Encerrado'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_RESIDUO = 'S'  Then 'Eliminado'
	When C7_RESIDUO = ' '  Then 'Nao Eliminado'
	Else 'Verificar'
	End AS Status_,
	   
	Case 
	When C7_CONAPRO = 'B' Then 'BLOQ'
	When C7_CONAPRO = 'L' Then 'LIB'
	When C7_CONAPRO = 'R' Then 'REJ'
	Else 'VERIFICAR'
	End As STATUS_LIB,

C7_ENCER, C7_RESIDUO,C7_CONAPRO, C7_APROV,AK_USER, USR_NOME,

SC7.* From SC7010 SC7

	LEFT Join SD1010 SD1 With(Nolock)
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	LEFT JOIN SAK010 SAK
	On AK_COD = C7_APROV
	And AK_FILIAL = C7_FILIAL
	And SAK.D_E_L_E_T_ = ''

	LEFT JOIN SYS_USR USR
	On AK_USER = USR.USR_ID
	And USR.D_E_L_E_T_ = ''
	   	 	
	Inner Join SB1010 SB1 
	On B1_COD = C7_PRODUTO
	And SB1.D_E_L_E_T_ = '' 

	
	Left Join AIC010 AIC
	On AIC_PRODUT = B1_COD
	--Or AIC_GRUPO = B1_GRUPO
	And AIC.D_E_L_E_T_ =''

	Left Join SA5010 SA5 
	On A5_FORNECE = D1_FORNECE
	And A5_LOJA = D1_LOJA
	And A5_PRODUTO = D1_COD
	And SA5.D_E_L_E_T_ = ''
		
Where C7_FILIAL = '01' and D1_DOC In ('000082405') 
--And D1_FORNECE In ('VOOB3S')
and C7_NUM In ('020786')
--and C7_PRODUTO In ('ME02000007','ME02000008','ME02000009')
--And C7_ITEM In ('0006')
and SC7.D_E_L_E_T_ ='' 
Order By 4



--Pedido de compras
Select Distinct C7_PRODUTO,C7_DESCRI,C7_QUANT,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_QTDACLA,C7_PRECO,
C7_NUM,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV,
Isnull(NULLIF(C7_PRECO,0)*NULLIF(C7_QUANT,0),0) As [VL_TOTAL_UM],
	
	Case
	When B1_TIPCONV = 'M' Then Isnull((NULLIF(C7_PRECO,0)/NULLIF(B1_CONV,0)),'') 
	When B1_TIPCONV = 'D' Then Isnull((NULLIF(C7_PRECO,0)*NULLIF(B1_CONV,0)),'')
	Else ''
	End As VL_UNI_SEGUM,

	Case
	When B1_TIPCONV = 'M' Then Isnull((NULLIF(C7_QTSEGUM,0)*(NULLIF(C7_PRECO,0)/NULLIF(B1_CONV,0))),'') 
	When B1_TIPCONV = 'D' Then Isnull((NULLIF(C7_QTSEGUM,0)*(NULLIF(C7_PRECO,0)*NULLIF(B1_CONV,0))),'')
	Else ''
	End As VL_TOTAL_SEGUM,


C7_ENCER,C7_RESIDUO,A5_PRODUTO,A5_CODPRF,
* From SC7010 SC7

	Inner Join SB1010 SB1
	On B1_COD = C7_PRODUTO 
	and SB1.D_E_L_E_T_ = ''

	Inner Join SA5010 SA5
	On A5_FORNECE = C7_FORNECE
	And A5_PRODUTO = C7_PRODUTO
	And SA5.D_E_L_E_T_= ''


Where C7_FILIAL = '01' and C7_NUM In ('020786') 
--and C7_PRODUTO In ('ME02000007','ME02000008','ME02000009')
and C7_ENCER = '' and C7_RESIDUO = '' 
and SC7.D_E_L_E_T_ = ''


-- Tolerancia 
--Select * From AIC010