-- Analise PV Consolidado

Declare @FILDE Char(2),@FILFIM Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODPRODINI Char(10), @CODPRODFIM Char(10),
@PVNUMINI Char(6),@PVNUMFIM Char(6), @PVITEMINI Char(02), @PVITEMFIM Char(02), @DC_QUANT Real;

Set @FILDE = '02' 
Set @FILFIM = '02'
Set @DATADE = '20230101'
Set @DATAFIM = '20240131'
Set @CODPRODINI = '00000000'
Set @CODPRODFIM = '999999999'
Set @PVNUMINI = '106770'
Set @PVNUMFIM = '106770'
Set @PVITEMINI = '01'
Set @PVITEMFIM = '99'

-- PV Itens -- Itens Empenhados prduzidos
Select C6_FILIAL,
Sum(C6_QTDVEN) As C6_QTDVEN,Sum(C6_QTDENT) As C6_QTDENT, Count(Distinct C6_ITEM) C6_QTDE_ITENS,

C9_QTDE_ITENS_LIB = Isnull((Select Count(Distinct C9_ITEM) From SC9010 SC9 With(Nolock)
							Where C9_FILIAL = C6_FILIAL
							And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
							and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
							--And C9_PEDIDO = C6_NUM 
							And SC9.D_E_L_E_T_ = ''),0),

C6_BLQ_ABERTO = (Select Count(SC6_2.C6_BLQ) From SC6010 SC6_2 With(Nolock)
					Where SC6_2.C6_BLQ = ''
					And SC6_2.C6_FILIAL = SC6.C6_FILIAL
					And SC6_2.C6_FILIAL Between @FILDE and @FILFIM  And SC6_2.C6_NUM Between @PVNUMINI and @PVNUMFIM 
					and SC6_2.C6_ITEM Between @PVITEMINI  and @PVITEMFIM --and C5_EMISSAO Between @DATADE and @DATAFIM
					--And SC6_2.C6_NUM = SC6.C6_NUM
					And SC6_2.D_E_L_E_T_ =''),

C6_BLQ_ELI_RES = (Select Count(SC6_2.C6_BLQ) From SC6010 SC6_2 With(Nolock)
					Where SC6_2.C6_BLQ = 'R'
					And SC6_2.C6_FILIAL = SC6.C6_FILIAL
					And SC6_2.C6_FILIAL Between @FILDE and @FILFIM  And SC6_2.C6_NUM Between @PVNUMINI and @PVNUMFIM 
					and SC6_2.C6_ITEM Between @PVITEMINI  and @PVITEMFIM --and C5_EMISSAO Between @DATADE and @DATAFIM
					--And SC6_2.C6_NUM = SC6.C6_NUM
					And SC6_2.D_E_L_E_T_ =''),

C6_BLQ_BLOQ = (Select Count(SC6_2.C6_BLQ) From SC6010 SC6_2 With(Nolock)
					Where SC6_2.C6_BLQ = 'S'
					And SC6_2.C6_FILIAL = SC6.C6_FILIAL
					And SC6_2.C6_FILIAL Between @FILDE and @FILFIM  And SC6_2.C6_NUM Between @PVNUMINI and @PVNUMFIM 
					and SC6_2.C6_ITEM Between @PVITEMINI  and @PVITEMFIM --and C5_EMISSAO Between @DATADE and @DATAFIM
					--And SC6_2.C6_NUM = SC6.C6_NUM
					And SC6_2.D_E_L_E_T_ =''),




Sum(C6_QTDVEN-C6_QTDENT) AS SALDO_PV,  



C9_QTDLIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
				    Where C9_FILIAL = C6_FILIAL
					And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
					and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
				    --And C9_PEDIDO = C6_NUM 
				    --And C9_PRODUTO = C6_PRODUTO
				    --And C9_ITEM = C6_ITEM
				    And SC9.D_E_L_E_T_ = ''),0),
	

BLOQ = Sum(C6_QTDVEN)- Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
							   Where C9_FILIAL = C6_FILIAL
							   And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
								and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
						       --And C9_PEDIDO = C6_NUM 
						       --And C9_PRODUTO = C6_PRODUTO
						       --And C9_ITEM = C6_ITEM
						       And SC9.D_E_L_E_T_ = ''),0),


SALDO_LIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					Where C9_FILIAL = C6_FILIAL
					And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
					and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
					--And C9_PEDIDO = C6_NUM 
					--And C9_PRODUTO = C6_PRODUTO
					--And C9_ITEM = C6_ITEM
					And SC9.D_E_L_E_T_ = ''),0) - Sum(C6_QTDENT),


DC_QUANT = Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
					Where DC_FILIAL = C6_FILIAL 
					And DC_FILIAL Between @FILDE and @FILFIM  And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
					and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
					--and  DC_PEDIDO = C6_NUM 
					--And DC_PRODUTO = C6_PRODUTO 
					--And DC_ITEM = C6_ITEM  
					And SDC.D_E_L_E_T_ = ''),0),

BF_END = IsNull((Select Count(BF_LOCALIZ) From SDC010 SDC With(Nolock)
			
				Inner Join SBF010 SBF With(Nolock)
				On BF_FILIAL = DC_FILIAL 
				--And BF_PRODUTO = DC_PRODUTO
				--And BF_LOCALIZ = DC_LOCALIZ 
				--And BF_QUANT > 0 
				And SBF.D_E_L_E_T_ = ''

				Where DC_FILIAL = C6_FILIAL
				And DC_FILIAL Between @FILDE and @FILFIM  And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
				and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
				--and  DC_PEDIDO = C6_NUM 
				--And DC_PRODUTO = C6_PRODUTO 
				--And DC_ITEM = C6_ITEM  
				And SDC.D_E_L_E_T_ = ''),0),

ZZF_RETRABALHO = Isnull((Select Sum(ZZF_METRAS) From ZZF010 ZZF With(Nolock)
						 Where ZZF_FILIAL = C6_FILIAL
						 And ZZF_FILIAL Between @FILDE and @FILFIM  And ZZF_PEDIDO Between @PVNUMINI and @PVNUMFIM 
						 and ZZF_ITEMPV Between @PVITEMINI and @PVITEMFIM 
						 --And ZZF_PEDIDO = C6_NUM
						 --And ZZF_ITEMPV = C6_ITEM
						 And ZZF_STATUS In ('2','3','4','5','6','7','8','9','A')--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat     
						 And ZZF.D_E_L_E_T_ = ''),0),


ZZE_RETRABALHO_SEPARACAO = Isnull((Select Sum(ZZE_METRAE) From ZZE010 ZZE With(Nolock)
									Where ZZE_FILIAL = C6_FILIAL
									And ZZE_FILIAL Between @FILDE and @FILFIM  And ZZE_PEDIDO Between @PVNUMINI and @PVNUMFIM 
									and ZZE_ITEMPV Between @PVITEMINI and @PVITEMFIM 
									--And ZZE_PEDIDO = C6_NUM
									--And ZZE_ITEMPV = C6_ITEM
									And ZZE_SALDO > 0
									And ZZE_SITUAC In ('1','') --ZZE_SITUAC 1=Encerrado;2=Em Aberto       
									And ZZE_STATUS In ('1','2','3','6','7') --ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO   
									And ZZE.D_E_L_E_T_ = ''),0),


PRODUZIR_GERAL = Isnull(SUM(Isnull(C6_QTDVEN,0)-Isnull(C6_QTDENT,0)) - 
								Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
										Where DC_FILIAL = C6_FILIAL
										And DC_FILIAL Between @FILDE and @FILFIM  And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
										and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
										--and DC_PEDIDO = C6_NUM 
										--And DC_PRODUTO = C6_PRODUTO 
										--And DC_ITEM = C6_ITEM  
										And SDC.D_E_L_E_T_ = ''),0),0),

PRODUZIR_LIB = (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
									Where C9_FILIAL = C6_FILIAL
									And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
									and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
									--And C9_PEDIDO = C6_NUM 
									--And C9_PRODUTO = C6_PRODUTO
									--And C9_ITEM = C6_ITEM
									And SC9.D_E_L_E_T_ = ''),0)) - (Isnull(Sum(C6_QTDENT),0))-
									(Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
												Where DC_FILIAL = C6_FILIAL
												And DC_FILIAL Between @FILDE and @FILFIM  And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
												and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
												--and DC_PEDIDO = C6_NUM 
												--And DC_PRODUTO = C6_PRODUTO 
												--And DC_ITEM = C6_ITEM  
												And SDC.D_E_L_E_T_ = ''),0)),
					
DateDiff(Day,Max(C6_ENTREG),Getdate()) As DIAS_ATRASO,

ETIQUETAS_SZE = IsNull((Select Sum(ZE_QUANT) From SZE010 SZE With(Nolock)
						Where ZE_FILIAL = C6_FILIAL
						And ZE_FILIAL Between @FILDE and @FILFIM  And ZE_PEDIDO Between @PVNUMINI and @PVNUMFIM 
						and ZE_ITEM Between @PVITEMINI and @PVITEMFIM 
						--And ZE_PRODUTO = C6_PRODUTO
						--And ZE_PEDIDO = C6_NUM 
						--And ZE_ITEM = C6_ITEM
						And ZE_STATUS Not in  ('F','C')
						And SZE.D_E_L_E_T_ = ''),0),

PESAGEM_SZL = IsNull((Select Distinct Sum(ZL_LANCE) From SZL010 With(Nolock)
						Where ZL_FILIAL = C6_FILIAL
						And ZL_FILIAL Between @FILDE and @FILFIM  And ZL_PEDIDO Between @PVNUMINI and @PVNUMFIM 
						and ZL_ITEMPV Between @PVITEMINI  and @PVITEMFIM 
						--and ZL_PRODUTO = C6_PRODUTO 
						--and ZL_PEDIDO = C6_NUM 
						--and ZL_ITEMPV = C6_ITEM
						and ZL_STATUS = 'P' 
						And D_E_L_E_T_ = ''),0),



PV_ATENDIDO_GERAL = (Isnull(Round((Nullif(((Isnull(Sum(C6_QTDENT),0)) + (Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
																				 Where DC_FILIAL = C6_FILIAL
																				 And DC_FILIAL Between @FILDE and @FILFIM  
																				 And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
																				 and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
																				 --and DC_PEDIDO = C6_NUM 
																				 --And DC_PRODUTO = C6_PRODUTO
																				 --And DC_ITEM = C6_ITEM
																				 And SDC.D_E_L_E_T_ = ''),0))) /
					Nullif((Isnull(Sum(C6_QTDVEN),0)),0),0)*100),2),0)),


PV_ATENDIDO_LIB = Round((((((Isnull(Sum(C6_QTDENT),0))) + ((Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
																			    Where DC_FILIAL = C6_FILIAL
																				And DC_FILIAL Between @FILDE and @FILFIM  
																				And DC_PEDIDO Between @PVNUMINI and @PVNUMFIM 
																				and DC_ITEM Between @PVITEMINI and @PVITEMFIM 
																			    --and DC_PEDIDO = C6_NUM 
																			    --And DC_PRODUTO = C6_PRODUTO
																			    --And DC_ITEM = C6_ITEM
																			    And SDC.D_E_L_E_T_ = ''),0)))) / 
				    (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
							 Where C9_FILIAL = C6_FILIAL
							 And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
							 and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
							 --And C9_PEDIDO = C6_NUM 
							 --And C9_PRODUTO = C6_PRODUTO
							 --And C9_ITEM = C6_ITEM
							 And SC9.D_E_L_E_T_ = ''),0)))*100),2),																		
														
LIB_PERC = (Round((IsNull((Nullif(Sum(C6_QTDVEN) / Nullif((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
															Where C9_FILIAL = C6_FILIAL
															And C9_FILIAL Between @FILDE and @FILFIM  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
															and C9_ITEM Between @PVITEMINI  and @PVITEMFIM and C9_DATALIB Between @DATADE and @DATAFIM
															--And C9_PEDIDO = C6_NUM 
															--And C9_PRODUTO = C6_PRODUTO
															--And C9_ITEM = C6_ITEM
															And SC9.D_E_L_E_T_ = ''),0),0)*100),0)),2)),

BLOQ_PERC = (Round((((Isnull((Nullif(IsNull(Sum(C6_QTDVEN),0),0) / (Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
																					  Where C9_FILIAL = C6_FILIAL
																					  And C9_FILIAL Between @FILDE and @FILFIM  
																					  And C9_PEDIDO Between @PVNUMINI and @PVNUMFIM 
																				      and C9_ITEM Between @PVITEMINI  and @PVITEMFIM 
																					  and C9_DATALIB Between @DATADE and @DATAFIM
																					 --And C9_PEDIDO = C6_NUM 
																					 --And C9_PRODUTO = C6_PRODUTO
																					 --And C9_ITEM = C6_ITEM
																					 And SC9.D_E_L_E_T_ = ''),0),0))),0))*100)-100),2)),

ZZR_ORDEM_SEP_QUANT = Isnull((Select Sum(ZZR_QUAN) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_FILIAL Between @FILDE and @FILFIM  And ZZR_PEDIDO Between @PVNUMINI and @PVNUMFIM 
								and ZZR_ITEMPV Between @PVITEMINI  and @PVITEMFIM 
								--And ZZR_PEDIDO = C6_NUM
								--And ZZR_PRODUT = C6_PRODUTO
								--And ZZR_ITEMPV = C6_ITEM
								 And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_LANCES = Isnull((Select Sum(ZZR_LANCES) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_FILIAL Between @FILDE and @FILFIM  And ZZR_PEDIDO Between @PVNUMINI and @PVNUMFIM 
								and ZZR_ITEMPV Between @PVITEMINI  and @PVITEMFIM 
								--And ZZR_PEDIDO = C6_NUM
								--And ZZR_PRODUT = C6_PRODUTO
								--And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_EMBAL = Isnull((Select Sum(ZZR_EMBALA) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_FILIAL Between @FILDE and @FILFIM  And ZZR_PEDIDO Between @PVNUMINI and @PVNUMFIM 
								and ZZR_ITEMPV Between @PVITEMINI  and @PVITEMFIM 
								--And ZZR_PEDIDO = C6_NUM
								--And ZZR_PRODUT = C6_PRODUTO
								--And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),

Case
When C5_NOTA = '' Then Count (C5_NOTA)
Else '0'
End As PV_STATUS_EM_ABERTO,

Case
When C5_NOTA = 'XXXXXX' Then Count (C5_NOTA)
Else '0'
End As PV_STATUS_ELIM_RESIDUO,

Case
When C5_NOTA <> '' and C5_NOTA Not In ('','XXXXXX') Then Count (C5_NOTA)
Else '0'
End As PV_STATUS_FINALIZADO,


Case
When C6_BLQ = '' Then Count(C6_BLQ)
Else '0'
End As PV_STATUS_QTDE_ITEM_LIB,

Case
When C6_BLQ = 'S' Then Count(C6_BLQ)
Else '0'
End As PV_STATUS_QTDE_ITEM_BLOQ,

Case
When C6_BLQ = 'R' Then Count(C6_BLQ)
Else '0'
End As PV_STATUS_QTDE_ITEM_ELI_RESIDUO,


Case
When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		--And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) = 0 
Then Count(C6_ITEM)
Else '0'
End As 'ATENDIDO LIBERADO',

Case 
When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		--And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) < 0 
Then Count(C6_ITEM)
ELSE '0'
End As 'ATENDIDO MAIS QUE LIBERADO',

Case
When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		--And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) > 0
Then Count(C6_ITEM)
ELSE '0'
END As 'ATENDIDO PARCIAL',

Case
When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		--And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) = 0
Then Count(C6_ITEM)
ELSE '0'
End As 'NAO ATENDIDO',

Case
When (Select (Isnull(Sum(C9_QTDLIB),0)) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		--And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = 0
Then Count(C6_ITEM)
ELSE '0'
End As 'NAO LIBERADO',

Case 
When (Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC = '1'
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = '1'
Then Count(C6_ITEM)
Else '0'
End As '1 - Em Montagem',

Case
When(Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC = '2'
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = '2'
Then Count(C6_ITEM)
Else '0'
End As '2 - Montado',

Case
When(Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC = '3'
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = '3'
Then Count(C6_ITEM)
Else '0'
End As '3 - Carregado',

Case
When(Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC = '4'
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = '4'
Then Count(C6_ITEM)
Else '0'
End As '4 - Expedido',

Case
When(Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC = '9'
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = '9'
Then Count(C6_ITEM)
Else '0'
End As '9 - Cancelado',

Case
When(Select Isnull(Count(ZZR_SITUAC),0) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_SITUAC Not In ('1','2','3','4','9')
		--And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') Not In ('1','2','3','4','9')
Then Count(C6_ITEM)
Else '0'
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado        
End As 'SEM MONTAGEM'
			 
From SC6010 SC6 With(NoLock) -- PV Itens

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	--And C5_NOTA Not In ('XXXXXX')
	--And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''


/*	Left Join ZZR010 ZZR
	On ZZR_FILIAL = C6_FILIAL
	--	And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = ''

	Left Join ZZ9010 ZZ9
	On ZZR_FILIAL = ZZ9_FILIAL
	And ZZR_OS = ZZ9_ORDSEP
	And ZZ9.D_E_L_E_T_ = ''*/


	--Inner Join SB1010 SB1  With(NoLock) -- Produtos 
	--On B1_COD = C6_PRODUTO
	--And SB1.D_E_L_E_T_ = ''
	
	--Inner Join SA1010 SA1  With(NoLock) -- Clientes 
	--On A1_COD = C5_CLIENTE
	--And A1_LOJA = C5_LOJACLI
	--And SA1.D_E_L_E_T_ = ''

Where C6_FILIAL Between @FILDE and @FILFIM  And C6_NUM Between @PVNUMINI and @PVNUMFIM 
and C6_ITEM Between @PVITEMINI  and @PVITEMFIM --and C5_EMISSAO Between @DATADE and @DATAFIM

/*And ((Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					 Where C9_FILIAL = C6_FILIAL
					 --And C9_PEDIDO = C6_NUM 
					 --And C9_PRODUTO = C6_PRODUTO
					 --And C9_ITEM = C6_ITEM
					 And SC9.D_E_L_E_T_ = ''),0),0))) - 
					 (C6_QTDENT) - 
					 Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
							 Where DC_FILIAL = C6_FILIAL and  
							 DC_PEDIDO = C6_NUM
							-- And DC_PRODUTO = C6_PRODUTO 
							 --And DC_ITEM = C6_ITEM  
							 And SDC.D_E_L_E_T_ = ''),0) > 0*/

And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C5_NOTA,C6_BLQ
Order By C6_FILIAL




-- SC6 - PV Itens 
-- SC5 - PV Cab.
-- SC9 - PV Liberado 
-- SDC - Composicao do Empenho
-- SBF -- Saldos por Endereco
-- SZE -- Etiquetas de Bobinas
-- SZL -- Pesagem -- Status 
-- ZZF -- Controle sobre Retrabalho
-- ZZE -- CTRL RETRABALHO PROATIVA      
-- ZZ9 --Ordens de Carga
-- ZZR --LOG DAS ORDENS DE SEPARACAO   
    

