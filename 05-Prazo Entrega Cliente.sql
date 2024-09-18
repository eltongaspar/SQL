-- PV Itens
Select ZZI_CODEVE,ZZI_EVENTO,C6_NUM,B1_BITOLA,C5_ZTPVEND,C6_ENTREG,C5_ENTREG,C6_DATCPL,C6_DATFAT,Z9_DTENTR,DatePart(DW,Z9_DTENTR )Z9_DTENTR,A1_PRZENTR, C6_XOPER,C5_OBS,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), C6_VDOBS)),'')As C6_VDOBS, DatePart(DW,C6_ENTREG ) As DIA_SEMANA_ENT,


	Case
	When DatePart(DW,C6_ENTREG ) = '1' Then 'DOMINGO'
	When DatePart(DW,C6_ENTREG ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA,

	Case
	When DatePart(DW,C6_DATFAT ) = '1' Then 'DOMINGO'
	When DatePart(DW,C6_DATFAT ) = '7' Then 'SABADO'
	When C6_DATFAT  =			    '' Then 'NAO FATURADO'
	ELSE 'DIA_UTIL'
	End As DIA_SEMANA_FAT,

	Case
	When DatePart(DW,Z9_DTENTR ) = '1' Then 'DOMINGO'
	When DatePart(DW,Z9_DTENTR ) = '7' Then 'SABADO'
	ELSE 'DIA_UTIL'
	End As DIA_SEMANA_SZ9

From SC6010 SC6

	Inner Join SC5010 SC5 
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And SC5.D_E_L_E_T_ = ''

	Left Join SZ9010 SZ9
	On Z9_FILIAL = C6_FILIAL
	And Z9_PRODUTO = C6_PRODUTO
	And Z9_PEDIDO = C6_NUM
	And Z9_ITEMPV = C6_ITEM
	And SZ9.D_E_L_E_T_ =''

	Inner Join SA1010 SA1
	On A1_COD = C6_CLI
	And A1_LOJA = C6_LOJA
	And SA1.D_E_L_E_T_ =''
	
	Inner Join SB1010 SB1
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	Left Join ZZI010 ZZI
	On ZZI_FILIAL = C5_FILIAL
	And ZZI_PEDIDO = C5_NUM
	And ZZI.D_E_L_E_T_ = ''
	And ZZI_CODEVE = '15'

Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '20240101'
and SC6.D_E_L_E_T_ =''
Order By 1 Asc







-- PV 
Select C5_FILIAL,C5_DTLICRE,Count(C5_DTLICRE) As QTDE,ZZI_CODEVE,
	Case
	When DatePart(DW,C5_ENTREG ) = '1' Then 'DOMINGO'
	When DatePart(DW,C5_ENTREG ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA

From SC5010 SC5

	Inner Join ZZI010 ZZI
	On ZZI_FILIAL = C5_FILIAL
	And ZZI_PEDIDO = C5_NUM
	And ZZI.D_E_L_E_T_ = ''
	And ZZI_CODEVE = '15'


Where DatePart(DW,C5_ENTREG ) In ('1','7')
And C5_DTLICRE >= '20240101'
and SC5.D_E_L_E_T_ =''
Group By C5_FILIAL,C5_DTLICRE,C5_ENTREG,ZZI_CODEVE
Order By 2 Asc



-- PVCab - Soma Filial 
Select C5_FILIAL,Count(C5_ENTREG) As QTDE
From SC5010
Where DatePart(DW,C5_ENTREG ) In ('1','7')
And C5_EMISSAO >= '20240101'
and D_E_L_E_T_ =''
Group By C5_FILIAL
Order By 1

-- PVCab
Select C5_FILIAL,Count(C5_ENTREG) As QTDE
From SC5010 SC5

	Inner Join ZZI010 ZZI
	On ZZI_FILIAL = C5_FILIAL
	And ZZI_PEDIDO = C5_NUM
	And ZZI.D_E_L_E_T_ = ''
	And ZZI.ZZI_CODEVE = '15'
	
Where DatePart(DW,C5_ENTREG ) In ('1','7')
And C5_EMISSAO >= '20240101'
and SC5.D_E_L_E_T_ =''
Group By C5_FILIAL
Order By 1



-- PV Itens - Soma Filial 
Select C6_FILIAL,Count(C6_ENTREG) AS QTDE
From SC6010 SC6

	Inner Join ZZI010 ZZI
	On ZZI_FILIAL = C6_FILIAL
	And ZZI_PEDIDO = C6_NUM
	And ZZI.D_E_L_E_T_ = ''
	And ZZI.ZZI_CODEVE = '15'

Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '20240101'
and SC6.D_E_L_E_T_ =''
Group By C6_FILIAL
Order By 1



-- PV Itens - Soma Filial 
Select C6_FILIAL,Count(C6_ENTREG) AS QTDE
From SC6010
Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '20240101'
and D_E_L_E_T_ =''
Group By C6_FILIAL
Order By 1








-- PV Itens Por Data 
Select C6_FILIAL,C6_ENTREG,Count(C6_ENTREG) AS QTDE,
	Case
	When DatePart(DW,C6_ENTREG ) = '1' Then 'DOMINGO'
	When DatePart(DW,C6_ENTREG ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA

From SC6010
Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '20240101'
and D_E_L_E_T_ =''
Group By C6_FILIAL,C6_ENTREG
Order By 2 Asc








