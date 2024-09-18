--PV Renegociação / Retrabalho
Select C6_FILIAL,C6_NUM,C6_PRODUTO,C6_ITEM,
Isnull(ZZV_PRODUT,'') as ZZV_PRODUT,Isnull(ZZF_PRODUT,'') as ZZF_PRODUT,
C6_XNEGOC,Isnull(ZZF_STATUS,'') As ZZF_STATUS,Isnull(ZZV_STATUS,'') As ZZV_STATUS,
C6_ZZPVORI,C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_QTDLIB,C6_SEMANA,
Isnull(ZZF_ID,'')				As ZZF_ID,
Isnull(ZZF_ZZEID,'')			as ZZF_ZZEID,
Isnull(ZZF_STATUS,'')			As ZZF_STATUS,
Isnull(ZZF_NUMBOB,'')			as ZZF_NUMBOB,
ISNULL(SDC_ZZF.DC_ORIGEM,'')	as Retrabalho_DC_ORIGEM,
ISNULL(SDC_ZZF.DC_ITEM,'')		as Retrabelho_DC_ITEM,
ISNULL(SDC_ZZF.DC_QUANT,'')		as Retrabalho_DC_QTD,
ISNULL(SDC_ZZF.DC_LOCALIZ,'')	as Retrabalho_DC_LOCALIZA,
ISNULL(SDC_ZZV.DC_ORIGEM,'')	as Renegociação_DC_ORIGEM,
ISNULL(SDC_ZZV.DC_ITEM,'')		as Renegociação_DC_ITEM,
ISNULL(SDC_ZZV.DC_QUANT,'')		as Renegociação_DC_QTD,
ISNULL(SDC_ZZV.DC_LOCALIZ,'')	as Renegociação_DC_LOCALIZA,

Case 
	When C6_XNEGOC = '1' Then 'Falta Iniciar atendimento'
	When C6_XNEGOC = '2' Then 'Em negociacao'
	When C6_XNEGOC = '3' Then 'Agendamento futuro'
	When C6_XNEGOC = '4' Then 'Falta aprovacao supervisao'
	When C6_XNEGOC = '5' Then 'Falta alterar pedido'
	When C6_XNEGOC = '6' Then 'Rejeitado cobrecom'
	When C6_XNEGOC = '7' Then 'Pedido Alterado'
	When C6_XNEGOC = '' Then 'NAO ESTA EM NEGOCIACAO'
	Else ''
	End as PV_Renegociacao_STATUS,


	Case 
		When ZZF_STATUS = '2' Then 'Ag.Sep'
		When ZZF_STATUS = '3' Then 'O.Sep.N.Imp'
		When ZZF_STATUS = '4' Then 'O.Sep.Imp'
		When ZZF_STATUS = '5' Then 'Sep.Parc'
		When ZZF_STATUS = '6' Then 'Sep.Tot'
		When ZZF_STATUS = '7' Then 'O.Ret.Imp'
		When ZZF_STATUS = '8' Then 'Ret.Parc'
		When ZZF_STATUS = '9' Then 'Ret.Tot'
		When ZZF_STATUS = 'A' Then 'Dest.Fat'
	Else ''
	End as Retrabalho_Status,

Case 
	When ZZV_STATUS = '1' Then 'Falta Iniciar atendimento'
	When ZZV_STATUS = '2' Then 'Em negociacao'
	When ZZV_STATUS = '3' Then 'Agendamento futuro'
	When ZZV_STATUS = '4' Then 'Falta aprovacao supervisao'
	When ZZV_STATUS = '5' Then 'Falta alterar pedido'
	When ZZV_STATUS = '6' Then 'Rejeitado cobrecom'
	When ZZV_STATUS = '7' Then 'Pedido Alterado'
	When ZZV_STATUS = '' Then 'NAO ESTA EM NEGOCIACAO'
	Else ''
	End as Renegociacao_STATUS,

* From SC6010 SC6

	Left Join ZZF010 ZZF -- Retrabalho
	On ZZF_FILIAL = C6_FILIAL
	And ZZF_PEDIDO = C6_NUM
	And ZZF_ITEMPV = C6_ITEM
	--And ZZF_STATUS In     
	And ZZF.D_E_L_E_T_ = ''

	Left Join ZZV010 ZZV With(Nolock) --CONTROLE NEGOCIO VENDAS       
	On ZZV_FILIAL = C6_FILIAL
	And ZZV_PEDIDO = C6_NUM
	And ZZV_PRODUT = C6_PRODUTO
	And ZZV_ITEM = C6_ITEM
	And ZZV.D_E_L_E_T_ = ''

	LEFT Join SDC010 SDC_ZZV WITH(NOLOCK) -- Composiçã do Empenho
	On SDC_ZZV.DC_FILIAL = ZZV_FILIAL
	And SDC_ZZV.DC_PEDIDO = ZZV_ID
	And SDC_ZZV.D_E_L_E_T_ = ''
			
	LEFT Join SDC010 SDC_ZZF WITH(NOLOCK) -- Composiçã do Empenho
	On SDC_ZZF.DC_FILIAL = ZZF_FILIAL
	And SDC_ZZF.DC_PEDIDO = ZZF_ZZEID
	And SDC_ZZF.D_E_L_E_T_ = ''
		
Where C6_FILIAL = '01' 
And ZZV_ID In ('006362','006371')
--and C6_NUM In ('425342')  
--And C6_ITEM In ('29','30')
and SC6.D_E_L_E_T_ =''
--And C6_XNEGOC <> '' 
--C6_XNEGOC
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO

/*
				"ZZF_STATUS == '2'", "BR_AMARELO"	}) // AGUARDANDO SEPARAR
				"ZZF_STATUS == 'A'", "BR_MARROM"	}) // DIRETO FATURAMENTO
				"ZZF_STATUS == '3'", "BR_AZUL"	}) // ORDEM NAO IMPRESSA
				"ZZF_STATUS == '4'", "BR_PINK"	}) // ORDEM IMPRESSA
				"ZZF_STATUS == '5'", "BR_LARANJA"	}) // ORDEM PARCIAL
				"ZZF_STATUS == '6'", "BR_VIOLETA"}) // ORDEM SEPARADA TOTAL BAIXADA
				"ZZF_STATUS == '7'", "BR_BRANCO"	}) // ORDEM RETRABALHO IMPRESSO
				"ZZF_STATUS == '8'", "BR_CINZA"	}) // ORDEM RETRABALHO PARCIAL
				"ZZF_STATUS == '9'", "BR_PRETO"	}) // ORDEM RETRABALHO TOTAL
				"ZZF_STATUS == 'X'", "BR_VERMELHO"	}) // CANCELADO  
				"ZZF_STATUS == 'Y'", "BR_VERDE"	}) // RETRABALHO CANCELADO - FALTA CANCELAR SEPARACAO
				*/

--ZZV_STATUS
--ZZV_STATUS = '1' Then 'Falta Iniciar atendimento'
--ZZV_STATUS = '2' Then 'Em negociacao'
--ZZV_STATUS = '3' Then 'Agendamento futuro'
--ZZV_STATUS = '4' Then 'Falta aprovacao supervisao'
--ZZV_STATUS = '5' Then 'Falta alterar pedido'
--ZZV_STATUS = '6' Then 'Rejeitado cobrecom'
--ZZV_STATUS = '7' Then 'Pedido Alterado'
--ZZV_STATUS = '' Then 'NAO ESTA EM NEGOCIACAO'


/*
-- Renegociação 
Select ZZV_STATUS,ZZV_FILIAL,ZZV_PEDIDO,ZZV_PRODUT,ZZV_DESC,ZZV_ITEM,ZZV_ID,ZZV_OBS01,ZZV_NUMBOB,ZZV_DATA,ZZV_LANCES,ZZV_METRAG,ZZV_PROALT,ZZV_ACOND,
* From ZZV010
Where ZZV_ID In ('006356','006357')
Or ZZV_PEDIDO = '429466'
--And DC_ITEM In ('29','30')
and D_E_L_E_T_ =''

-- Composicao Empenho
Select * From SDC010
Where DC_PEDIDO In ('006356','006357','429466')
--And DC_ITEM In ('29','30')
and D_E_L_E_T_ =''
Order By DC_ITEM

--PV Itens 
Select C6_FILIAL,C6_PRODUTO,C6_ITEM,C6_XNEGOC,C6_QTDEMP,C6_RESERVA,
C6_QTDVEN,C6_QTDENT,C6_BLQ,
* From SC6010
Where C6_NUM = '429466' and C6_ITEM In ('29','30')
and D_E_L_E_T_ =''
Order By 3

--PV Lib.
Select C9_BLEST,* From SC9010
Where C9_PEDIDO = '429466' and (C9_ITEM In ('29','30') or C9_ITEMREM In ('29','30'))
and D_E_L_E_T_ =''
Order By C9_ITEM
--'' Liberado - 1 Bloqueado por Credito - 2 Bloqueado por Estoque - 09 Credito Rejeitado 

--ZZF Retrabalho 
Select * From ZZF010
Where ZZF_PEDIDO = '429466'
and D_E_L_E_T_ =''
Order By ZZF_ITEMPV

*/