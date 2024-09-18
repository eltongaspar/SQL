-- ZP9 - Orcamento Itens Cores 
Select B1_XPORTAL,ZP9_NUM,ZP9_ITEM,B1_BOBINA,B1_ROLO,ZP9_TOTAL,ZP9_QUANT,B1_COD,B1_DESC,B1_XPORTAL,

	--Verifica Tipo de Acondicionamento 
	Case 
	When ZP6_ACOND = 'B' Then 'BOBINA'
	When ZP6_ACOND = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS RECOMENDACAO,


* From ZP9010 ZP9

	Inner Join SB1010 SB1
	On B1_COD = ZP9_CODPRO
	And SB1.D_E_L_E_T_ = ''

	Inner Join ZP6010 ZP6
	On ZP6_NUM = ZP9_NUM
	And ZP6_ITEM = ZP9_ITEM
    And ZP6.D_E_L_E_T_ = ''

Where ZP9_NUM = '375902'
And ZP9.D_E_L_E_T_ =' '
Order By 2
--Tipos de Acondionamento 
--{B','BOBINA'}
--{'R','ROLO'}
--{'C','CARRETEL PLASTICO'}
--{'M','CARRETEL MADEIRA'}
--{'L','BLISTER'}



 --Composição do Empenho         
 Select D_E_L_E_T_,* From SDC010
 Where DC_FILIAL = '01' 
 And DC_ORIGEM = 'ZP4'
 And DC_PEDIDO In ('023789','023790','023791','023792','023793','023794','023795','023800','023801','023803','023504','023805','023806')
 And D_E_L_E_T_ ='' 
 


 --Saldos por Endereço           
 Select * From SBF010
 Where BF_FILIAL = '01' 
 --and BF_PRODUTO In ('1150904401','1530904401','1141504401')
 --And BF_LOCALIZ In ('R00100','R00050','B00185')         
 And D_E_L_E_T_ ='' 

--RESERVAS PORTAL COBRECOM      
Select * From ZP4010
Where ZP4_FILIAL  In ('01','02','03') 
--And ZP4_STATUS In ('1')
And ZP4_CODIGO In ('023789','023790','023791','023792','023793','023794','023795','023800','023801','023803','023504','023805','023806')
And D_E_L_E_T_ = ''
--ZP4- Status - 1=Pendente;2=Atendida;3=Expirada;4=Cancelada     
Order By ZP4_DATA Desc

-- ZP5 - Orcamento Cab. *******
Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010

Where ZP5_DATA >= '20240701' and  D_E_L_E_T_ =''
And ZP5_STATUS Not In ('A','B','C')
And ZP5_NUM = '375902'
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado   

-- ZP6 - Orcamento Itens 
Select ZP6_NUMRES,* From ZP6010
Where ZP6_NUM = '375902'
And D_E_L_E_T_ =' '

-- PV Cab.
Select C5_DOCPORT,A1_NOME,* From SC5010 SC5
	Inner Join SA1010 SA1
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C5_FILIAL In ('01') and C5_NUM In ('419510')
And SC5.D_E_L_E_T_ = ''
-- C5_DOCPORT - Numero Orcamento Portal 

--PV Itens
Select * From SC6010 SC6
Where C6_FILIAL = '01' 
And C6_NUM In ('419510')
And D_E_L_E_T_ = ''
Order By C6_NUM

--PV Lib 
Select * From SC9010 SC9
Where C9_FILIAL = '01' 
And C9_PEDIDO In ('419510')
And D_E_L_E_T_ = ''

--Clientes 
Select * From SA1010
Where A1_COD = '042932'
And D_E_L_E_T_ = ''