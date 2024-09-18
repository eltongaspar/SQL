-- Analise PV Análitico

Declare @FILDE Char(2),@FILFIM Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODPRODINI Char(10), @CODPRODFIM Char(10),
@PVNUMINI Char(6),@PVNUMFIM Char(6), @PVITEMINI Char(02), @PVITEMFIM Char(02), @DC_QUANT Real;

Set @FILDE = '03' 
Set @FILFIM = '03'
Set @DATADE = '20240101'
Set @DATAFIM = '20241231'
Set @CODPRODINI = '000000000'
Set @CODPRODFIM = '999999999'
Set @PVNUMINI = '005373'
Set @PVNUMFIM = '005373'
Set @PVITEMINI = '01'
Set @PVITEMFIM = '99'

-- PV Itens -- Itens Empenhados prduzidos
Select C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,C6_PRODUTO,B1_DESC,C6_ITEM,
Count(Distinct C6_ITEM) C6_QTDE_ITENS,
Count(Distinct C6_PRODUTO) C6_QTDE_PRODUTO,
Sum(C6_QTDVEN) As C6_QTDVEN,Sum(C6_QTDENT) As C6_QTDENT,
Sum(C6_QTDVEN-C6_QTDENT) AS SALDO_PV,

C9_QTDLIB_ITENS = Isnull((Select Count(Distinct C9_QTDLIB) From SC9010 SC9 With(Nolock)
				    Where C9_FILIAL = C6_FILIAL
				    And C9_PEDIDO = C6_NUM 
				    And C9_PRODUTO = C6_PRODUTO
				    And C9_ITEM = C6_ITEM
				    And SC9.D_E_L_E_T_ = ''),0),

TOTAL_LIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And C9_PRODUTO = C6_PRODUTO
					And C9_ITEM = C6_ITEM
					And SC9.D_E_L_E_T_ = ''),0),


BLOQ = Sum(C6_QTDVEN)- Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
							   Where C9_FILIAL = C6_FILIAL
						       And C9_PEDIDO = C6_NUM 
						       And C9_PRODUTO = C6_PRODUTO
						       And C9_ITEM = C6_ITEM
						       And SC9.D_E_L_E_T_ = ''),0),


SALDO_LIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And C9_PRODUTO = C6_PRODUTO
					And C9_ITEM = C6_ITEM
					And SC9.D_E_L_E_T_ = ''),0) - Sum(C6_QTDENT),


C6_QTDEVEN_C9_QTDE_LIB= Sum(C6_QTDVEN) - 
						 Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
								 Where C9_FILIAL = C6_FILIAL
								 And C9_PEDIDO = C6_NUM 
								 And C9_PRODUTO = C6_PRODUTO
								 And C9_ITEM = C6_ITEM
								 And SC9.D_E_L_E_T_ = ''),0),

DC_QUANT = Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
					Where DC_FILIAL = C6_FILIAL 
					and  DC_PEDIDO = C6_NUM 
					And DC_PRODUTO = C6_PRODUTO 
					And DC_ITEM = C6_ITEM  
					And SDC.D_E_L_E_T_ = ''),0),

BF_END = IsNull((Select Count(BF_LOCALIZ) From SDC010 SDC With(Nolock)
			
				Inner Join SBF010 SBF With(Nolock)
				On BF_FILIAL = DC_FILIAL 
				And BF_PRODUTO = DC_PRODUTO
				And BF_LOCALIZ = DC_LOCALIZ 
				And BF_QUANT > 0 
				And SBF.D_E_L_E_T_ = ''

				Where DC_FILIAL = C6_FILIAL 
				and  DC_PEDIDO = C6_NUM 
				And DC_PRODUTO = C6_PRODUTO 
				And DC_ITEM = C6_ITEM  
				And SDC.D_E_L_E_T_ = ''),0),

ZZF_RETRABALHO = Isnull((Select Sum(ZZF_METRAS) From ZZF010 ZZF With(Nolock)
						 Where ZZF_FILIAL = C6_FILIAL
						 And ZZF_PEDIDO = C6_NUM
						 And ZZF_ITEMPV = C6_ITEM
						 And ZZF_STATUS In ('2','3','4','5','6','7','8','9','A')--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat     
						 And ZZF.D_E_L_E_T_ = ''),0),


ZZE_RETRABALHO_SEPARACAO = Isnull((Select Sum(ZZE_METRAE) From ZZE010 ZZE With(Nolock)
									Where ZZE_FILIAL = C6_FILIAL
									And ZZE_PEDIDO = C6_NUM
									And ZZE_ITEMPV = C6_ITEM
									And ZZE_SALDO > 0
									And ZZE_SITUAC In ('1','') --ZZE_SITUAC 1=Encerrado;2=Em Aberto       
									And ZZE_STATUS In ('1','2','3','6','7') --ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO   
									And ZZE.D_E_L_E_T_ = ''),0),


PRODUZIR_GERAL = Isnull(SUM(Isnull(C6_QTDVEN,0)-Isnull(C6_QTDENT,0)) - 
								Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
										Where DC_FILIAL = C6_FILIAL 
										and DC_PEDIDO = C6_NUM 
										And DC_PRODUTO = C6_PRODUTO 
										And DC_ITEM = C6_ITEM  
										And SDC.D_E_L_E_T_ = ''),0),0),

PRODUZIR_LIB = (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
									Where C9_FILIAL = C6_FILIAL
									And C9_PEDIDO = C6_NUM 
									And C9_PRODUTO = C6_PRODUTO
									And C9_ITEM = C6_ITEM
									And SC9.D_E_L_E_T_ = ''),0)) - (Isnull(Sum(C6_QTDENT),0))-
									(Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
												Where DC_FILIAL = C6_FILIAL 
												and DC_PEDIDO = C6_NUM 
												And DC_PRODUTO = C6_PRODUTO 
												And DC_ITEM = C6_ITEM  
												And SDC.D_E_L_E_T_ = ''),0)),
					
DateDiff(Day,Max(C6_ENTREG),Getdate()) As DIAS_ATRASO,

ETIQUETAS_SZE = IsNull((Select Sum(ZE_QUANT) From SZE010 SZE With(Nolock)
						Where ZE_FILIAL = C6_FILIAL
						And ZE_PRODUTO = C6_PRODUTO
						And ZE_PEDIDO = C6_NUM 
						And ZE_ITEM = C6_ITEM
						And ZE_STATUS Not in  ('F','C')
						And SZE.D_E_L_E_T_ = ''),0),

PESAGEM_SZL = IsNull((Select Sum(ZL_LANCE) From SZL010 With(Nolock)
						Where ZL_FILIAL = C6_FILIAL 
						and ZL_PRODUTO = C6_PRODUTO 
						and ZL_PEDIDO = C6_NUM 
						and ZL_ITEMPV = C6_ITEM
						and ZL_STATUS = 'P' 
						And D_E_L_E_T_ = ''),0),



PV_ATENDIDO_GERAL = (Isnull(Round((Nullif(((Isnull(Sum(C6_QTDENT),0)) + (Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
																				 Where DC_FILIAL = C6_FILIAL
																				 and DC_PEDIDO = C6_NUM 
																				 And DC_PRODUTO = C6_PRODUTO
																				 And DC_ITEM = C6_ITEM
																				 And SDC.D_E_L_E_T_ = ''),0))) /
					Nullif((Isnull(Sum(C6_QTDVEN),0)),0),0)*100),2),0)),


Case 
When 
(Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
 Where C9_FILIAL = C6_FILIAL
 And C9_PEDIDO = C6_NUM 
 And C9_PRODUTO = C6_PRODUTO
 And C9_ITEM = C6_ITEM
 And SC9.D_E_L_E_T_ = '') > 0

Then 
Round((((((Isnull(Sum(C6_QTDENT),0))) + ((Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
													Where DC_FILIAL = C6_FILIAL
												    and DC_PEDIDO = C6_NUM 
												    And DC_PRODUTO = C6_PRODUTO
												    And DC_ITEM = C6_ITEM
												    And SDC.D_E_L_E_T_ = ''),0)))) / 
				    (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
									Where C9_FILIAL = C6_FILIAL
									And C9_PEDIDO = C6_NUM 
									And C9_PRODUTO = C6_PRODUTO
									And C9_ITEM = C6_ITEM
									And SC9.D_E_L_E_T_ = ''),0)))*100),2)

Else '0'
End As PV_ATENDIDO_LIB,				    															
														
LIB_PERC = (Round((IsNull((Nullif(Sum(C6_QTDVEN) / Nullif((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
															Where C9_FILIAL = C6_FILIAL
															And C9_PEDIDO = C6_NUM 
															And C9_PRODUTO = C6_PRODUTO
															And C9_ITEM = C6_ITEM
															And SC9.D_E_L_E_T_ = ''),0),0)*100),0)),2)),

BLOQ_PERC = (Round((((Isnull((Nullif(IsNull(Sum(C6_QTDVEN),0),0) / (Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
																					Where C9_FILIAL = C6_FILIAL
																					And C9_PEDIDO = C6_NUM 
																					And C9_PRODUTO = C6_PRODUTO
																					And C9_ITEM = C6_ITEM
																					And SC9.D_E_L_E_T_ = ''),0),0))),0))*100)-100),2)),
C5_NOTA, 
Case
When C5_NOTA = '' Then 'PEDIDO EM ABERTO'
When C5_NOTA = 'XXXXXX' Then 'ELIMINADO RESIDUO'
When C5_NOTA <> '' and C5_NOTA Not In ('','XXXXXX') Then 'FINALIZADO'
Else 'ANALISAR'
End As PV_STATUS,

C6_NOTA,


Case
When C6_BLQ = '' Then 'PEDIDO EM ABERTO'
When C6_BLQ = 'S' Then 'BLOQUEADO'
When C6_BLQ = 'R'  Then 'RESIDUO'
Else 'ANALISAR'
End As PV_STATUS_ITEM,


Case
When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) = 0 
Then 'ATENDIDO LIBERADO'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) < 0 
Then 'ATENDIDO MAIS QUE LIBERADO'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) > 0
Then 'ATENDIDO PARCIAL'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) = 0
Then 'NAO ATENDIDO'


When (Select (Isnull(Sum(C9_QTDLIB),0)) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = 0
Then 'NAO LIBERADO'


Else 'ANALISAR'
End As PV_STATUS_ATENDIDO,

C6_BLQ,
Case 
When C6_BLQ = 'S'
Then 'Bloqueado'
When C6_BLQ = ''
Then ''
When C6_BLQ = 'R'
Then 'Elinado Residuo'
Else 'Analisar'
End as C6_BLQ_STATUS,


--( "S" = Bloqueado, "N" ou " " =Nao Bloqueado, "R" = Residuo ).

--Status do Bloqueio Pedido
--Bloqueio Manual do Pedido, impede queeste Pedido seja liberado automaticamen-te, tambem utilizado para eliminacao de residuo. 
--( "S" = Bloqueado, "N" ou " " =Nao Bloqueado, "R" = Residuo )


Case 
When (Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 1
Then '1 - Em Montagem'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 2
Then '2 - Montado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 3
Then '3 - Carregado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 4
Then '4 - Expedido'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 9
Then '9 - Cancelado'

Else 'SEM MONTAGEM'
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado        
End As ZZR_SITUACAO,

														  
ZZR_ORDEM_SEP_QUANT = Isnull((Select Sum(ZZR_QUAN) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_PEDIDO = C6_NUM
								And ZZR_PRODUT = C6_PRODUTO
								And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_LANCES = Isnull((Select Sum(ZZR_LANCES) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_PEDIDO = C6_NUM
								And ZZR_PRODUT = C6_PRODUTO
								And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_EMBAL = Isnull((Select Sum(ZZR_EMBALA) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_PEDIDO = C6_NUM
								And ZZR_PRODUT = C6_PRODUTO
								And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),
									

ZZ9_ORCAR = (Isnull((Select ZZ9_ORDCAR From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = ''),'')),

ZZ9_STATUS = (Isnull((Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = ''),'')),

ZZ9_CTE = (Isnull((Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'')
					From ZZ9010 ZZ9 With(Nolock)
					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),

ZZ9_VOL = (Isnull((Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSVOLU)),'')
					From ZZ9010 ZZ9 With(Nolock)
					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),
					
ZZ9_INFO = (Isnull((Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSINFO)),'')
					From ZZ9010 ZZ9 With(Nolock)
					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),
                                                              
C9_FISCAL = (Isnull((Stuff((Select C9_NFISCAL From SC9010 SC9 With(Nolock)
							Where C9_FILIAL = C6_FILIAL
							And C9_PEDIDO = C6_NUM 
							And C9_PRODUTO = C6_PRODUTO
							And C9_ITEM = C6_ITEM
							And SC9.D_E_L_E_T_ = ''
							For XML Path ('')),1,1,'')),'')),

C6_QDTEMP = (IsNull(Sum(C6_QTDEMP),'')),
C6_QDTRES = (IsNull(Sum(C6_QTDRES),'')),


C9_BLEST = Isnull((Select Top 1 C9_BLEST From SC9010 SC9 With(Nolock)
				    Where C9_FILIAL = C6_FILIAL
				    And C9_PEDIDO = C6_NUM 
				    And C9_PRODUTO = C6_PRODUTO
				    And C9_ITEM = C6_ITEM
				    And SC9.D_E_L_E_T_ = ''),''),


C9_CRED = Isnull((Select Top 1 C9_BLCRED From SC9010 SC9 With(Nolock)
				    Where C9_FILIAL = C6_FILIAL
				    And C9_PEDIDO = C6_NUM 
				    And C9_PRODUTO = C6_PRODUTO
				    And C9_ITEM = C6_ITEM
				    And SC9.D_E_L_E_T_ = ''),''),

Case 
When (Select Top 1 C9_BLEST From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = '' 
		And 
		(Select Top 1 C9_BLCRED From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = ''
Then 'Liberado'

When ((Select Top 1 C9_BLEST From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = '01' 
		Or 
		(Select Top 1 C9_BLCRED From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') <> '')
		And
		(Select Top 1 C9_BLCRED From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') <> '10'
Then '01-10 - Bloqueado por Credito'

When (Select Top 1 C9_BLCRED From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = '09' 
Then '09 - Credito Rejeitado'

When (Select Top 1 C9_BLEST From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = '02' 
Then '02 - Bloqueado por Estoque'		 

When (Select Top 1 C9_BLEST From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = '10' 
Then '10 - Faturado'	

Else 'Sem Status'
--'' Liberado - 1 Bloqueado por Credito - 2 Bloqueado por Estoque - 09 Credito Rejeitado 
End As C9_BLEST_BLCRED,


Case
When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'C'
Then 'C - Cancelada'

When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'F'
Then 'F - Faturada'

When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'I'
Then 'I - Gerada'

When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'L'
Then 'L - Liberado Faturamento'

When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'G'
Then 'G - Liberada Financeiro'

When  (Select ZZ9_STATUS From ZZ9010 ZZ9 With(Nolock)
				Where ZZR_FILIAL = ZZ9_FILIAL
				And ZZR_OS = ZZ9_ORDSEP
				And ZZ9.D_E_L_E_T_ = '') = 'D'
Then 'D - Analise Financeiro'

Else 'Sem Status'
End As ZZ9_STATUS,

SD2_ITEM_QUANT_SC6 = Isnull((Select Sum(D2_QUANT) From SD2010 SD2 With(Nolock)
								Where D2_FILIAL = C6_FILIAL
								And D2_PEDIDO = C6_NUM 
								And D2_COD = C6_PRODUTO
								And D2_ITEMPV = C6_ITEM
								And SD2.D_E_L_E_T_ = ''),0),

SD2_ITEM_QUANT_SC9 = Isnull((Select Sum(D2_QUANT) From SD2010 SD2 With(Nolock)
								Inner Join SC9010 SC9 With(Nolock)
								On C9_FILIAL = C6_FILIAL
								And C9_PEDIDO = C6_NUM 
								And C9_PRODUTO = C6_PRODUTO
								And C9_ITEM = C6_ITEM
								And SC9.D_E_L_E_T_ = ''

								Where D2_FILIAL = C9_FILIAL
								And D2_PEDIDO = C9_PEDIDO
								And D2_COD = C9_PRODUTO
								And D2_ITEMPV = C9_ITEM
								And SD2.D_E_L_E_T_ = ''
								And SC9.D_E_L_E_T_ = ''),0),

FATURADO_SC6 = Sum(C6_VALOR),

FATURADO_SD2 = Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM 
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

DIF_FAT = Sum(C6_VALOR) - Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
								Where D2_FILIAL = C6_FILIAL
								And D2_PEDIDO = C6_NUM 
								And D2_COD = C6_PRODUTO
								And D2_ITEMPV = C6_ITEM
								And SD2.D_E_L_E_T_ = ''),0),

Case 
When
	Sum(C6_VALOR) - Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
							Where D2_FILIAL = C6_FILIAL
							And D2_PEDIDO = C6_NUM 
							And D2_COD = C6_PRODUTO
							And D2_ITEMPV = C6_ITEM
							And SD2.D_E_L_E_T_ = ''),0) = 0
Then 'FATURADO 100%'

When
	Sum(C6_VALOR) - Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
							Where D2_FILIAL = C6_FILIAL
							And D2_PEDIDO = C6_NUM 
							And D2_COD = C6_PRODUTO
							And D2_ITEMPV = C6_ITEM
							And SD2.D_E_L_E_T_ = ''),0) > 0
Then 'FATURADO PARCIAL'
End As STATUS_FAT,

Case 
When 
	Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
							Where D2_FILIAL = C6_FILIAL
							And D2_PEDIDO = C6_NUM 
							And D2_COD = C6_PRODUTO
							And D2_ITEMPV = C6_ITEM
							And SD2.D_E_L_E_T_ = ''),0) > 0
Then 
	(Sum(C6_VALOR) / Isnull((Select Sum(D2_TOTAL) From SD2010 SD2 With(Nolock)
							Where D2_FILIAL = C6_FILIAL
							And D2_PEDIDO = C6_NUM 
							And D2_COD = C6_PRODUTO
							And D2_ITEMPV = C6_ITEM
     						And SD2.D_E_L_E_T_ = ''),0))*100

Else 0
End As PERCEN_FAT,


NF_VAL_BRUT = Isnull((Select Distinct  Sum(F2_VALBRUT) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

NF_QTDE_ITEM = Isnull((Select Distinct  Count(F2_VALBRUT) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

E1_VAL = Isnull((Select Distinct  Sum(E1_VALOR) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

E1_SALDO = Isnull((Select Distinct  Sum(E1_SALDO) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

E1_LIQUIDADO = Isnull((Select Distinct  Sum(E1_VALLIQ) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

E1_QTDE_TIT = Isnull((Select Distinct  Count(E1_NUM) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						--And E1_SALDO = 0
						--And E1_BAIXA <> ''
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),
						

E1_QTDE_TIT_PAG = Isnull((Select Distinct  Count(E1_NUM) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						And E1_SALDO = 0
						And E1_BAIXA <> ''
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),


E1_QTDE_TIT_ABERTO = Isnull((Select Distinct  Count(E1_NUM) From SD2010 SD2 With(Nolock)
			
						Inner Join SF2010 SF2
						On F2_FILIAL = D2_FILIAL
						And F2_DOC = D2_DOC
						And SF2.D_E_L_E_T_ = ''

						Inner Join SE1010 SE1 
						On E1_FILIAL = F2_FILIAL
						And E1_NUM = F2_DOC
						And E1_TIPO = 'NF'
						And E1_SALDO > 0
						And E1_BAIXA = ''
						And SE1.D_E_L_E_T_ = ''
						
						Where D2_FILIAL = C6_FILIAL
						And D2_PEDIDO = C6_NUM
						And D2_DOC = C6_NOTA
						And D2_COD = C6_PRODUTO
						And D2_ITEMPV = C6_ITEM
						And SD2.D_E_L_E_T_ = ''),0),

C6_ZZPVORI,

NUM_PED_IND = Isnull((	Select SUBSTRING(SC6.C6_ZZPVORI,1,6) From SC6010 SC6IND With(NoLock) -- Industrializacao 
						Where SC6IND.C6_FILIAL = '01'
						And SC6IND.C6_CLI = '008918'
						And SC6IND.C6_LOJA = '01'
						And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
						And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
						Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
						And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
						--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
						And SC6IND.D_E_L_E_T_ = ''),''),
		
NUM_ITEM_IND = Isnull((Select SUBSTRING(SC6.C6_ZZPVORI,7,2) From SC6010 SC6IND With(NoLock) -- Industrializacao 
						Where SC6IND.C6_FILIAL = '01'
						And SC6IND.C6_CLI = '008918'
						And SC6IND.C6_LOJA = '01'
						And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
						And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
						Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
						And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
						--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
						And SC6IND.D_E_L_E_T_ = ''),''),

NUM_ITEM_QTDE_VEND_IND = Isnull((Select Sum(SC6.C6_QTDVEN) From SC6010 SC6IND With(NoLock) -- Industrializacao 
								Where SC6IND.C6_FILIAL = '01'
								And SC6IND.C6_CLI = '008918'
								And SC6IND.C6_LOJA = '01'
								And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
								And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
								Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
								And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
								--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
								And SC6IND.D_E_L_E_T_ = ''),''),

NUM_ITEM_QTDE_ENT_IND = Isnull((Select Sum(SC6.C6_QTDVEN) From SC6010 SC6IND With(NoLock) -- Industrializacao 
								Where SC6IND.C6_FILIAL = '01'
								And SC6IND.C6_CLI = '008918'
								And SC6IND.C6_LOJA = '01'
								And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
								And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
								Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
								And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
								--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
								And SC6IND.D_E_L_E_T_ = ''),''),

NUM_ITEM_QTDE_EMP_IND = Isnull((Select Sum(SC6.C6_QTDEMP) From SC6010 SC6IND With(NoLock) -- Industrializacao 
								Where SC6IND.C6_FILIAL = '01'
								And SC6IND.C6_CLI = '008918'
								And SC6IND.C6_LOJA = '01'
								And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
								And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
								Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
								And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
								--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
								And SC6IND.D_E_L_E_T_ = ''),''),				



IND_VEN = Isnull((Select Sum(SC6IND.C6_QTDVEN) From SC6010 SC6IND With(NoLock)
			Where SC6IND.C6_FILIAL = '01'
			And SC6IND.C6_CLI = '008918'
			And SC6IND.C6_LOJA = '01'
			And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
			And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
			Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
			And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
			And SC6IND.D_E_L_E_T_ = ''),''),


IND_ENT = Isnull((Select Sum(SC6IND.C6_QTDENT) From SC6010 SC6IND With(NoLock)
			Where SC6IND.C6_FILIAL = '01'
			And SC6IND.C6_CLI = '008918'
			And SC6IND.C6_LOJA = '01'
			And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
			And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
			Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
			And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
			And SC6IND.D_E_L_E_T_ = ''),''),

IND_EMP = Isnull((Select Sum(SC6IND.C6_QTDEMP) From SC6010 SC6IND With(NoLock)
			Where SC6IND.C6_FILIAL = '01'
			And SC6IND.C6_CLI = '008918'
			And SC6IND.C6_LOJA = '01'
			And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
			And (SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
			Or SC6IND.C6_ITEMIMP = Substring(SC6.C6_ZZPVORI,7,2))
			And SC6IND.C6_PRODUTO = Substring(SC6.C6_PRODUTO,1,10)
			And SC6IND.D_E_L_E_T_ = ''),''),


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
	End as ZZV_STATUS_DESC,

(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [ZZV_OBSF])),'')) As [ZZV_OBSF],
ISNULL(ZZV_NUMBOB,'') As ZZV_NUMBOB,ISNULL(ZZV_RESP,'') As ZZV_RESP,ISNULL(ZZV_NOMEC,'') As ZZV_NOMEC,ISNULL(ZZV_OBS01,'') As ZZV_OBS01,
ISNULL(ZZV_STATUS,'') As ZZV_STATUS,ISNULL(ZZV_ACOND,'') As ZZV_ACOND,ISNULL(ZZV_LANCES,'') As ZZV_LANCES,ISNULL(ZZV_METRAG,'') As ZZV_METRAG,
ISNULL(ZZV_ACONAL,'') As ZZV_ACONAL,ISNULL(ZZV_LANCEA,'') As ZZV_LANCEA,ISNULL(ZZV_METRAL,'') As ZZV_METRAL,ISNULL(ZZV_ACEITE,'') As ZZV_ACEITE,
ISNULL(ZZV_PROALT,'') As ZZV_PROALT,

--Analise Reservas Portal 
Isnull(ZP4_CODIGO,'') As Reserva_Codigo,
CASE
			WHEN ZP4.ZP4_STATUS = '1'
				THEN 'AGUARDANDO'
			WHEN ZP4.ZP4_STATUS = '2'
				THEN 'CONFIRMADA'
			WHEN ZP4.ZP4_STATUS = '3'
				THEN 'EXPIRADA'
			WHEN ZP4.ZP4_STATUS= '4'
				THEN 'CANCELADA'
			ELSE 'N/I'
	END										AS STATUS_RESERVA,

ISNULL(SDC_ZP4.DC_ORIGEM,'')	as Reserva_DC_ORIGEM,
ISNULL(SDC_ZP4.DC_ITEM,'')		as Reserva_DC_ITEM,
ISNULL(SDC_ZP4.DC_QUANT,'')		as Reserva_DC_QTD,
ISNULL(SDC_ZP4.DC_LOCALIZ,'')	as Reserva_DC_LOCALIZA,


ISNULL(SDC_ZZV.DC_ORIGEM,'')	as Renegociação_DC_ORIGEM,
ISNULL(SDC_ZZV.DC_ITEM,'')		as Renegociação_DC_ITEM,
ISNULL(SDC_ZZV.DC_QUANT,'')		as Renegociação_DC_QTD,
ISNULL(SDC_ZZV.DC_LOCALIZ,'')	as Renegociação_DC_LOCALIZA,

ISNULL(SDC_ZZF.DC_ORIGEM,'')	as Retrabaho_DC_ORIGEM,
ISNULL(SDC_ZZF.DC_ITEM,'')		as Retrabalho_DC_ITEM,
ISNULL(SDC_ZZF.DC_QUANT,'')		as Retrabalho_DC_QTD,
ISNULL(SDC_ZZF.DC_LOCALIZ,'')	as Retrabalho_DC_LOCALIZA,

-- Orçamentos Portal 

Isnull(ZP5_NUM,'') Orçamento_Portao_Numero,
CASE
			WHEN ZP5.ZP5_NUM IS NULL
				THEN 'NÃO'
			ELSE 
				CASE
					WHEN ZP5.ZP5_STATUS = '0'
						THEN 'REVISÃO'
					WHEN ZP5.ZP5_STATUS = '1'
						THEN 'MANUTENÇÃO'
					WHEN ZP5.ZP5_STATUS = '2'
						THEN 'AGUARDANDO APROVAÇÃO'
					WHEN ZP5.ZP5_STATUS = '3'
						THEN 'EM APROVAÇÃO'
					WHEN ZP5.ZP5_STATUS = '4'
						THEN 'AGUARDANDO CONFIRMAÇÃO'
					WHEN ZP5.ZP5_STATUS = '5'
						THEN 'CONFIRMADO'
					WHEN ZP5.ZP5_STATUS = '6'
						THEN 'NÃO APROVADO'
					WHEN ZP5.ZP5_STATUS = '7'
						THEN 'CANCELADO'
					WHEN ZP5.ZP5_STATUS = '8'
						THEN 'APROVAÇÃO TECNICA'
					WHEN ZP5.ZP5_STATUS = '9'
						THEN 'AGUARDANDO PROCESSAMENTO'
					WHEN ZP5.ZP5_STATUS = 'A'
						THEN 'EM PROCESSAMENTO'
					WHEN ZP5.ZP5_STATUS = 'B'
						THEN 'ERRO PROCESSAMENTO'
				END
	END										AS STATUS_PEDIDO_PORTAL,

Isnull(ZPA_NUM,'') as DOC_PORTAL,
Isnull(ZPA_NUMDOC,'') as DOC_PV,
--Isnull(ZP9_DESCOR,'') as ZP9_COR,
--Isnull(ZP6_ACOND,'') as ZP6_ACOND

ISNULL(C6_NUM, 'NÃO')				AS PEDIDO_INTERNO,
	CASE
		WHEN C5_NUM IS NULL
			THEN 'NÃO'
		ELSE
			CASE
				WHEN C5_LIBEROK = 'E' OR C5_NOTA <> '' OR C6_BLQ = 'R ' OR C6_QTDENT >= C6_QTDVEN
					THEN 'ENCER./CANC./BLOQ.'
				ELSE 'EM ABERTO'
			END											
	END										AS STATUS_PEDIDO_INTERNO,

	CASE
		WHEN C5_NUM IS NULL
			THEN 'NÃO'
		ELSE
			CASE
				WHEN C5_DTLICRE <> ''
					THEN 'LIB. CRED.'
				ELSE 'BLOQ. CRED'
			END											
	END										AS STATUS_PEDIDO_INTERNO,

--Verifica Tipo de Acondicionamento 
	Case 
	When C6_ACONDIC = 'B' Then 'BOBINA'
	When C6_ACONDIC = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

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


	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS RECOMENDACAO

From SC6010 SC6 With(NoLock) -- PV Itens

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	--And C5_NOTA Not In ('XXXXXX')
	--And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1  With(NoLock) -- Produtos 
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''
	
	Inner Join SA1010 SA1  With(NoLock) -- Clientes 
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

	Left Join ZZR010 ZZR With(Nolock) --LOG DAS ORDENS DE SEPARACAO
	On ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		And ZZR_PRODUT = C6_PRODUTO
		And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = ''

	Left Join ZZ9010 ZZ9 With(Nolock) --Ordens de Carga
	On ZZR_FILIAL = ZZ9_FILIAL
	And ZZR_OS = ZZ9_ORDSEP
	And ZZ9.D_E_L_E_T_ = ''

	Left Join ZZV010 ZZV With(Nolock) --CONTROLE NEGOCIO VENDAS       
	On ZZV_FILIAL = C6_FILIAL
	And ZZV_PEDIDO = C6_NUM
	And ZZV_PRODUT = C6_PRODUTO
	And ZZV_ITEM = C6_ITEM
	And ZZV.D_E_L_E_T_ = ''
	
	Left Join ZZF010 ZZF -- Retrabalhos
	On ZZF_FILIAL = C6_FILIAL
	And ZZF_PEDIDO = C6_NUM
	And ZZF_ITEMPV = C6_ITEM
	--And ZZF_STATUS In     
	And ZZF.D_E_L_E_T_ = ''
	
	Left Join ZP4010 ZP4 WITH(NOLOCK) -- Reservas Portal 
	ON C6_FILIAL  = ZP4_FILIAL
	AND C6_ZZNRRES = ZP4_CODIGO
	AND ZP4.D_E_L_E_T_ = '' 
	
	LEFT Join SDC010 SDC_ZP4 WITH(NOLOCK) -- Composiçã do Empenho
	On SDC_ZP4.DC_FILIAL = ZP4_FILIAL
	And SDC_ZP4.DC_PEDIDO = ZP4_CODIGO
	And SDC_ZP4.D_E_L_E_T_ = ''
	
	LEFT Join SDC010 SDC_ZZV WITH(NOLOCK) -- Composiçã do Empenho
	On SDC_ZZV.DC_FILIAL = ZZV_FILIAL
	And SDC_ZZV.DC_PEDIDO = ZZV_ID
	And SDC_ZZV.D_E_L_E_T_ = ''

	LEFT Join SDC010 SDC_ZZF WITH(NOLOCK) -- Composiçã do Empenho
	On SDC_ZZF.DC_FILIAL = ZZF_FILIAL
	And SDC_ZZF.DC_PEDIDO = ZZF_ZZEID
	And SDC_ZZF.D_E_L_E_T_ = ''
		
	LEFT Join ZP5010 ZP5 WITH(NOLOCK) -- Orçamentos Portal Cab.
	On ZP5_FILIAL = ''
	And C5_DOCPORT = ZP5_NUM
	And ZP5.D_E_L_E_T_ = ''

	LEFT Join ZPA010 ZPA WITH(NOLOCK) -- Documentos Orçamentos 
	On ZPA_FILIAL = ''
	And ZPA_CODFIL = ZP5_FILIAL
	And ZPA_NUM = ZP5_NUM
	And ZPA_NUMDOC = C5_NUM
	And ZPA_CODFIL = C5_FILIAL
	And ZPA.D_E_L_E_T_ = ''
	
	/*
	LEFT JOIN ZP6010 ZP6 WITH(NOLOCK) -- Orçamento Itens 
	ON ZP5_FILIAL = ''
	AND ZP6_NUM = ZP5.ZP5_NUM
	And C5_DOCPORT = ZP5_NUM
	AND ZP6.D_E_L_E_T_ = ''

	Left Join ZP9010 ZP9 WITH(NOLOCK) -- Orçamento Itens Cores 
	On ZP6_NUM = ZP9_NUM
	And ZP6_ITEM = ZP9_ITEM
	And C5_DOCPORT = ZP9_NUM
	And C6_NUM = C5_DOCPORT
	And C6_PRODUTO = ZP9_CODPRO
	And C6_ITEM = ZP9_ITEM
    And ZP9.D_E_L_E_T_ = ''*/

	/*Inner Join SC9010 SC9 
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM 
	And C9_PRODUTO = C6_PRODUTO
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''*/

	/*Left Join SD2010 SD2 With(Nolock)
	On D2_FILIAL = C6_FILIAL
	And D2_PEDIDO = C6_NUM
	And D2_COD = C6_PRODUTO
	And D2_DOC = C6_NOTA
	And D2_ITEMPV = C6_ITEM
	And SD2.D_E_L_E_T_ = ''

	Left Join SF2010 SF2 With(Nolock)
	On F2_FILIAL = D2_FILIAL
	And D2_DOC = D2_DOC 
	And SF2.D_E_L_E_T_ = ''*/


Where C6_FILIAL Between @FILDE and @FILFIM  And C6_NUM Between @PVNUMINI and @PVNUMFIM 
And C6_PRODUTO Between @CODPRODINI and @CODPRODFIM 
and C6_ITEM Between @PVITEMINI  and @PVITEMFIM and C5_EMISSAO Between @DATADE and @DATAFIM

/*And ((Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9
					 Where C9_FILIAL = C6_FILIAL
					 And C9_PEDIDO = C6_NUM 
					 And C9_PRODUTO = C6_PRODUTO
					 And C9_ITEM = C6_ITEM
					 And SC9.D_E_L_E_T_ = ''),0),0))) - 
					 (C6_QTDENT) - 
					 Isnull((Select Sum(DC_QUANT) From SDC010 SDC
							 Where DC_FILIAL = C6_FILIAL and  
							 DC_PEDIDO = C6_NUM
							 And DC_PRODUTO = C6_PRODUTO 
							 And DC_ITEM = C6_ITEM  
							 And SDC.D_E_L_E_T_ = ''),0) > 0 */

--And C6_ZZPVORI Like ('411810%')
--And C9_BLEST = '02'
And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,C6_PRODUTO,B1_DESC,C6_ITEM,C6_QTDVEN,ZZ9_ORDCAR,ZZR_OS,ZZR_FILIAL,C5_NOTA,C6_BLQ,C5_EMISSAO,C6_NOTA,C6_ZZPVORI,
ZZV_STATUS,ZZV_NUMBOB,ZZV_RESP,ZZV_NOMEC,ZZV_OBS01,ZZV_ACOND,ZZV_LANCES,ZZV_METRAG,ZZV_ACONAL,ZZV_LANCEA,ZZV_METRAL,ZZV_ACEITE,ZZV_PROALT,
(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [ZZV_OBSF])),'')),
ZP4_CODIGO,ZP4_STATUS,SDC_ZP4.DC_ORIGEM,SDC_ZP4.DC_ITEM,SDC_ZP4.DC_QUANT,SDC_ZP4.DC_LOCALIZ,ZP5_NUM,ZP5_STATUS,ZPA_NUM,ZPA_NUMDOC,
--ZP9_DESCOR,
C5_NUM,C5_LIBEROK,C6_QTDENT,C5_DTLICRE,C6_ACONDIC,C6_LANCES,B1_BOBINA,B1_ROLO,
SDC_ZZV.DC_ORIGEM,SDC_ZZV.DC_ITEM,SDC_ZZV.DC_QUANT,SDC_ZZV.DC_LOCALIZ,
SDC_ZZF.DC_ORIGEM,SDC_ZZF.DC_ITEM,SDC_ZZF.DC_QUANT,SDC_ZZF.DC_LOCALIZ,ZZF_STATUS,
C6_ACONDIC,C6_LANCES,B1_BOBINA,B1_ROLO
--Order By 1,4,2,5
Order By 7

-- C6_ZZPVORI - Campo Industrializacao
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
-- SF2 -- NF Saida Cab
-- SD2 -- NF Saida Itens
-- ZZV - CONTROLE NEGOCIO VENDAS       
-- ZP4 -- Reservas Portal 
-- ZP5 -- Orçamento Portal Cab.
-- ZPA - Documentos Portal 
-- ZP6 - Orçamento Itens 
-- ZP9 -- Orçamento Itens Cores 

