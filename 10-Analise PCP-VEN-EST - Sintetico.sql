Declare @FILDE Char(2),@FILFIM Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODPRODINI Char(10), @CODPRODFIM Char(10),
@PVNUMINI Char(6),@PVNUMFIM Char(6), @PVITEMINI Char(02), @PVITEMFIM Char(02), @DC_QUANT Real;

Set @FILDE = '01' 
Set @FILFIM = '01'
Set @DATADE = '20230101'
Set @DATAFIM = '20231231'
Set @CODPRODINI = '000000000'
Set @CODPRODFIM = '999999999'
Set @PVNUMINI = '405408'
Set @PVNUMFIM = '99999'
Set @PVITEMINI = '01'
Set @PVITEMFIM = '99'

-- PV Itens -- Itens Empenhados prduzidos
Select C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,
Sum(C6_QTDVEN) As C6_QTDVEN,Sum(C6_QTDENT) As C6_QTDENT,
Sum(C6_QTDVEN-C6_QTDENT) AS SALDO_PV,  



C9_QTDLIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And SC9.D_E_L_E_T_ = ''),0),
	

BLOQ = Sum(C6_QTDVEN)- Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
								Where C9_FILIAL = C6_FILIAL
								And C9_PEDIDO = C6_NUM 
								And SC9.D_E_L_E_T_ = ''),0),


SALDO_LIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And SC9.D_E_L_E_T_ = ''),0) - Sum(C6_QTDENT),


DC_QUANT = Isnull((Select Sum(DC_QUANT) From SDC010 SDC
					Where DC_FILIAL = C6_FILIAL
					and  DC_PEDIDO = C6_NUM 
					And SDC.D_E_L_E_T_ = ''),0),

BF_END = IsNull((Select Count(BF_LOCALIZ) From SDC010 SDC
			
				Inner Join SBF010 SBF
				On BF_FILIAL = DC_FILIAL 
				And BF_LOCALIZ = DC_LOCALIZ 
				And BF_QUANT > 0 
				And SBF.D_E_L_E_T_ = ''

				Where DC_FILIAL = C6_FILIAL 
				and  DC_PEDIDO = C6_NUM 
				And SDC.D_E_L_E_T_ = ''),0),

ZZF_RETRABALHO = Isnull((Select Sum(ZZF_METRAS) From ZZF010 ZZF 
						 Where ZZF_FILIAL = C6_FILIAL
						 And ZZF_PEDIDO = C6_NUM
						 And ZZF_STATUS In ('2','3','4','5','6','7','8','9','A')--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat     
						 And ZZF.D_E_L_E_T_ = ''),0),


ZZE_RETRABALHO_SEPARACAO = Isnull((Select Sum(ZZE_METRAE) From ZZE010 ZZE
									Where ZZE_FILIAL = C6_FILIAL
									And ZZE_PEDIDO = C6_NUM
									And ZZE_SALDO > 0
									And ZZE_SITUAC In ('1','') --ZZE_SITUAC 1=Encerrado;2=Em Aberto       
									And ZZE_STATUS In ('1','2','3','6','7') --ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO   
									And ZZE.D_E_L_E_T_ = ''),0),


PRODUZIR_GERAL = Isnull(SUM(Isnull(C6_QTDVEN,0)-Isnull(C6_QTDENT,0)) - 
								Isnull((Select Sum(DC_QUANT) From SDC010 SDC
										Where DC_FILIAL = C6_FILIAL 
										and  DC_PEDIDO = C6_NUM 
										And SDC.D_E_L_E_T_ = ''),0),0),

PRODUZIR_LIB = (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
									Where C9_FILIAL = C6_FILIAL
									And C9_PEDIDO = C6_NUM 
									And SC9.D_E_L_E_T_ = ''),0)) - (Isnull(Sum(C6_QTDENT),0))-
									(Isnull((Select Sum(DC_QUANT) From SDC010 SDC
											  Where DC_FILIAL = C6_FILIAL and  
											  DC_PEDIDO = C6_NUM 
											  And SDC.D_E_L_E_T_ = ''),0)),
					
DateDiff(Day,Max(C6_ENTREG),Getdate()) As DIAS_ATRASO,

ETIQUETAS_SZE = IsNull((Select Sum(ZE_QUANT) From SZE010 SZE
						Where ZE_FILIAL = C6_FILIAL
						And ZE_PEDIDO = C6_NUM 
						And ZE_STATUS Not in  ('F','C')
						And SZE.D_E_L_E_T_ = ''),0),

PESAGEM_SZL = IsNull((Select Sum(ZL_LANCE) From SZL010
						Where ZL_FILIAL = C6_FILIAL 
						and ZL_PEDIDO = C6_NUM 
						and ZL_STATUS = 'P' 
						And D_E_L_E_T_ = ''),0),

PV_ATENDIDO_GERAL = (Isnull(Round((Nullif(((Isnull(Sum(C6_QTDENT),0)) + (Isnull((Select Sum(DC_QUANT) From SDC010 SDC
																				 Where DC_FILIAL = C6_FILIAL
																				 and DC_PEDIDO = C6_NUM 
																				 --And DC_PRODUTO = C6_PRODUTO
																				 --And DC_ITEM = C6_ITEM
																				 And SDC.D_E_L_E_T_ = ''),0))) /
					Nullif((Isnull(Sum(C6_QTDVEN),0)),0),0)*100),2),0)),


PV_ATENDIDO_LIB = Round((((((Isnull(Sum(C6_QTDENT),0))) + ((Isnull((Select Sum(DC_QUANT) From SDC010 SDC
																			    Where DC_FILIAL = C6_FILIAL
																			     and DC_PEDIDO = C6_NUM 
																			     And SDC.D_E_L_E_T_ = ''),0)))) / 
				    (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
									Where C9_FILIAL = C6_FILIAL
									And C9_PEDIDO = C6_NUM 
									And SC9.D_E_L_E_T_ = ''),0)))*100),2),							

LIB_PERC = (Isnull((Round((Round(Nullif(Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9
										Where C9_FILIAL = C6_FILIAL
										And C9_PEDIDO = C6_NUM 
										And SC9.D_E_L_E_T_ = ''),0),0),2)) /  (Round(Nullif(Isnull(Sum(C6_QTDVEN),0),0),2)),2)*100),0)),


BLOQ_PERC = (Round((((Isnull((Nullif(IsNull(Sum(C6_QTDVEN),0),0) / (Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9
																				   Where C9_FILIAL = C6_FILIAL
																				   And C9_PEDIDO = C6_NUM 
																				   And SC9.D_E_L_E_T_ = ''),0),0))),0))*100)-100),2))

					

From SC6010 SC6 With(NoLock) -- PV Itens

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And C5_NOTA Not In ('XXXXXX')
	And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1  With(NoLock) -- Produtos 
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''
	
	Inner Join SA1010 SA1  With(NoLock) -- Clientes 
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C6_FILIAL Between @FILDE and @FILFIM  And C6_NUM Between @PVNUMINI 
and @PVNUMFIM and C6_ITEM Between @PVITEMINI  and @PVITEMFIM and C5_EMISSAO Between @DATADE and @DATAFIM

And ((Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9
					 Where C9_FILIAL = C6_FILIAL
					 And C9_PEDIDO = C6_NUM 
					 And SC9.D_E_L_E_T_ = ''),0),0))) - 
					 (C6_QTDENT) - 
					 Isnull((Select Sum(DC_QUANT) From SDC010 SDC
							 Where DC_FILIAL = C6_FILIAL and  
							 DC_PEDIDO = C6_NUM
							 And SDC.D_E_L_E_T_ = ''),0) > 0										
										
										
And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM
Order By 21,C6_FILIAL,C6_NUM desc

-- SC6 - PV Itens 
-- SC5 - PV Cab.
-- SC9 - PV Liberado 
-- SZE - Etiquetas de Bobinas
-- SZL - Pesagem -- Status 
-- ZZF -- Controle sobre Retrabalho
-- ZZE -- CTRL RETRABALHO PROATIVA      


