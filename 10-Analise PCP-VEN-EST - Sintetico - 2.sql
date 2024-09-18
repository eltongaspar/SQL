-- Analise PV Sintético

Declare @FILDE Char(2),@FILFIM Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODPRODINI Char(10), @CODPRODFIM Char(10),
@PVNUMINI Char(6),@PVNUMFIM Char(6), @PVITEMINI Char(02), @PVITEMFIM Char(02), @DC_QUANT Real;

Set @FILDE = '02' 
Set @FILFIM = '02'
Set @DATADE = '20230101'
Set @DATAFIM = '20241231'
Set @CODPRODINI = '00000000'
Set @CODPRODFIM = '999999999'
Set @PVNUMINI = '107473'
Set @PVNUMFIM = '107473'
Set @PVITEMINI = '01'
Set @PVITEMFIM = '99'


-- PV Itens -- Itens Empenhados prduzidos
Select C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM, Count(Distinct C6_ITEM) C6_QTDE_ITENS,
C9_QTDE_ITENS_LIB = Isnull((Select Count(Distinct C9_ITEM) From SC9010 SC9 With(Nolock)
							Where C9_FILIAL = C6_FILIAL
							And C9_PEDIDO = C6_NUM 
							And SC9.D_E_L_E_T_ = ''),0),
Sum(C6_QTDVEN) As C6_QTDVEN,Sum(C6_QTDENT) As C6_QTDENT,
Sum(C6_QTDVEN-C6_QTDENT) AS SALDO_PV,  



C9_QTDLIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And SC9.D_E_L_E_T_ = ''),0),
	

BLOQ = Sum(C6_QTDVEN)- Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
								Where C9_FILIAL = C6_FILIAL
								And C9_PEDIDO = C6_NUM 
								And SC9.D_E_L_E_T_ = ''),0),


SALDO_LIB = Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
					Where C9_FILIAL = C6_FILIAL
					And C9_PEDIDO = C6_NUM 
					And SC9.D_E_L_E_T_ = ''),0) - Sum(C6_QTDENT),


DC_QUANT = Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
					Where DC_FILIAL = C6_FILIAL
					and  DC_PEDIDO = C6_NUM 
					And SDC.D_E_L_E_T_ = ''),0),

BF_END = IsNull((Select Count(BF_LOCALIZ) From SDC010 SDC With(Nolock)
			
				Inner Join SBF010 SBF With(Nolock)
				On BF_FILIAL = DC_FILIAL 
				And BF_LOCALIZ = DC_LOCALIZ 
				And BF_QUANT > 0 
				And SBF.D_E_L_E_T_ = ''

				Where DC_FILIAL = C6_FILIAL 
				and  DC_PEDIDO = C6_NUM 
				And SDC.D_E_L_E_T_ = ''),0),

ZZF_RETRABALHO = Isnull((Select Sum(ZZF_METRAS) From ZZF010 ZZF With(Nolock)
						 Where ZZF_FILIAL = C6_FILIAL
						 And ZZF_PEDIDO = C6_NUM
						 And ZZF_STATUS In ('2','3','4','5','6','7','8','9','A')--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat     
						 And ZZF.D_E_L_E_T_ = ''),0),


ZZE_RETRABALHO_SEPARACAO = Isnull((Select Sum(ZZE_METRAE) From ZZE010 ZZE With(Nolock)
									Where ZZE_FILIAL = C6_FILIAL
									And ZZE_PEDIDO = C6_NUM
									And ZZE_SALDO > 0
									And ZZE_SITUAC In ('1','') --ZZE_SITUAC 1=Encerrado;2=Em Aberto       
									And ZZE_STATUS In ('1','2','3','6','7') --ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO   
									And ZZE.D_E_L_E_T_ = ''),0),


PRODUZIR_GERAL = Isnull(SUM(Isnull(C6_QTDVEN,0)-Isnull(C6_QTDENT,0)) - 
								Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
										Where DC_FILIAL = C6_FILIAL 
										and  DC_PEDIDO = C6_NUM 
										And SDC.D_E_L_E_T_ = ''),0),0),

PRODUZIR_LIB = (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
									Where C9_FILIAL = C6_FILIAL
									And C9_PEDIDO = C6_NUM 
									And SC9.D_E_L_E_T_ = ''),0)) - (Isnull(Sum(C6_QTDENT),0))-
									(Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
											  Where DC_FILIAL = C6_FILIAL and  
											  DC_PEDIDO = C6_NUM 
											  And SDC.D_E_L_E_T_ = ''),0)),
					
DateDiff(Day,Max(C6_ENTREG),Getdate()) As DIAS_ATRASO,

ETIQUETAS_SZE = IsNull((Select Sum(ZE_QUANT) From SZE010 SZE With(Nolock)
						Where ZE_FILIAL = C6_FILIAL
						And ZE_PEDIDO = C6_NUM 
						And ZE_STATUS Not in  ('F','C')
						And SZE.D_E_L_E_T_ = ''),0),

PESAGEM_SZL = IsNull((Select Sum(ZL_LANCE) From SZL010 With(Nolock)
						Where ZL_FILIAL = C6_FILIAL 
						and ZL_PEDIDO = C6_NUM 
						and ZL_STATUS = 'P' 
						And D_E_L_E_T_ = ''),0),

PV_ATENDIDO_GERAL = (Isnull(Round((Nullif(((Isnull(Sum(C6_QTDENT),0)) + (Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
																				 Where DC_FILIAL = C6_FILIAL
																				 and DC_PEDIDO = C6_NUM 
																				 --And DC_PRODUTO = C6_PRODUTO
																				 --And DC_ITEM = C6_ITEM
																				 And SDC.D_E_L_E_T_ = ''),0))) /
					Nullif((Isnull(Sum(C6_QTDVEN),0)),0),0)*100),2),0)),


PV_ATENDIDO_LIB = Round((((((Isnull(Sum(C6_QTDENT),0))) + ((Isnull((Select Sum(DC_QUANT) From SDC010 SDC With(Nolock)
																			    Where DC_FILIAL = C6_FILIAL
																			     and DC_PEDIDO = C6_NUM 
																			     And SDC.D_E_L_E_T_ = ''),0)))) / 
				    (Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
							Where C9_FILIAL = C6_FILIAL
							And C9_PEDIDO = C6_NUM 
							And SC9.D_E_L_E_T_ = ''),0)))*100),2),							

LIB_PERC = (Isnull((Round((Round(Nullif(Isnull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
												Where C9_FILIAL = C6_FILIAL
												And C9_PEDIDO = C6_NUM 
												And SC9.D_E_L_E_T_ = ''),0),0),2)) /  (Round(Nullif(Isnull(Sum(C6_QTDVEN),0),0),2)),2)*100),0)),


BLOQ_PERC = (Round((((Isnull((Nullif(IsNull(Sum(C6_QTDVEN),0),0) / (Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
																				   Where C9_FILIAL = C6_FILIAL
																				   And C9_PEDIDO = C6_NUM 
																				   And SC9.D_E_L_E_T_ = ''),0),0))),0))*100)-100),2)),

ZZR_ORDEM_SEP_QUANT = Isnull((Select Sum(ZZR_QUAN) From ZZR010 ZZR With(Nolock)
					Where ZZR_FILIAL = C6_FILIAL
					And ZZR_PEDIDO = C6_NUM
					--And ZZR_PRODUT = C6_PRODUTO
					--And ZZR_ITEMPV = C6_ITEM
					 And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_LANCES = Isnull((Select Sum(ZZR_LANCES) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
								And ZZR_PEDIDO = C6_NUM
								--And ZZR_PRODUT = C6_PRODUTO
								--And ZZR_ITEMPV = C6_ITEM
								And ZZR.D_E_L_E_T_ = ''),0),

ZZR_ORDEM_SEP_EMBAL = Isnull((Select Sum(ZZR_EMBALA) From ZZR010 ZZR With(Nolock)
								Where ZZR_FILIAL = C6_FILIAL
									And ZZR_PEDIDO = C6_NUM
									--And ZZR_PRODUT = C6_PRODUTO
									--And ZZR_ITEMPV = C6_ITEM
									And ZZR.D_E_L_E_T_ = ''),0),


Case 
When (Select Top 1 (ZZR_SITUAC) From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 1
Then '1 - Em Montagem'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 2
Then '2 - Montado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 3
Then '3 - Carregado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 4
Then '4 - Expedido'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 9
Then '9 - Cancelado'

Else 'Analisar'
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado        
End As ZZR_SITUACAO,

ZZ9_ORCAR = (Isnull((Select Top 1 ZZ9_ORDCAR From ZZ9010 ZZ9 With(Nolock)
						
						Inner Join ZZR010 ZZR With(Nolock)
						On ZZR_FILIAL = C6_FILIAL
						And ZZR_PEDIDO = C6_NUM
						
						Where ZZR_FILIAL = ZZ9_FILIAL
						And ZZR_OS = ZZ9_ORDSEP
						And ZZ9.D_E_L_E_T_ = ''),'')),

ZZ9_CTE = (Isnull((Select Top 1 ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'')
					From ZZ9010 ZZ9 With(Nolock)

					Inner Join ZZR010 ZZR With(Nolock)
					On ZZR_FILIAL = C6_FILIAL
					And ZZR_PEDIDO = C6_NUM 

					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),

ZZ9_VOL = (Isnull((Select Top 1 ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSVOLU)),'')
					From ZZ9010 ZZ9 With(Nolock)

					Inner Join ZZR010 ZZR With(Nolock)
					On ZZR_FILIAL = C6_FILIAL
					And ZZR_PEDIDO = C6_NUM 

					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),
					
ZZ9_INFO = (Isnull((Select Top 1 ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSINFO)),'')
					From ZZ9010 ZZ9 With(Nolock)

					Inner Join ZZR010 ZZR With(Nolock)
					On ZZR_FILIAL = C6_FILIAL
					And ZZR_PEDIDO = C6_NUM 

					Where ZZR_FILIAL = ZZ9_FILIAL
					And ZZR_OS = ZZ9_ORDSEP
					And ZZ9.D_E_L_E_T_ = ''),'')),

C5_NOTA, 
Case
When C5_NOTA = '' Then 'PEDIDO EM ABERTO'
When C5_NOTA = 'XXXXXX' Then 'ELIMINADO RESIDUO'
When C5_NOTA <> '' and C5_NOTA Not In ('','XXXXXX') Then 'FINALIZADO'
Else 'ANALISAR'
End As PV_STATUS,


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
		And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) = 0 
Then 'ATENDIDO LIBERADO'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) < 0 
Then 'ATENDIDO MAIS QUE LIBERADO'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) > 0
Then 'ATENDIDO PARCIAL'

When (Select Sum(C9_QTDLIB) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') - Sum(C6_QTDENT) > 0 And Sum(C6_QTDENT) = 0
Then 'NAO ATENDIDO'


When (Select (Isnull(Sum(C9_QTDLIB),0)) From SC9010 SC9 With(Nolock)
		Where C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM 
		--And C9_PRODUTO = C6_PRODUTO
		--And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = '') = 0
Then 'NAO LIBERADO'


Else 'ANALISAR'
End As PV_STATUS_ATENDIDO,

--Status do Bloqueio Pedido
--loqueio Manual do Pedido, impede queeste Pedido seja liberado automaticamen-te, tambem utilizado para eliminacao deresiduo. 
--( "S" = Bloqueado, "N" ou " " =Nao Bloqueado, "R" = Residuo )


Case 
When (Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 1
Then '1 - Em Montagem'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 2
Then '2 - Montado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 3
Then '3 - Carregado'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 4
Then '4 - Expedido'

When(Select top 1 ZZR_SITUAC From ZZR010 ZZR With(Nolock)
		Where ZZR_FILIAL = C6_FILIAL
		And ZZR_PEDIDO = C6_NUM
		--And ZZR_PRODUT = C6_PRODUTO
		--And ZZR_ITEMPV = C6_ITEM
		And ZZR.D_E_L_E_T_ = '') = 9
Then '9 - Cancelado'

Else 'SEM MONTAGEM'
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado        
End As ZZR_SITUACAO

					

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

	/*Left Join ZZR010 ZZR With(Nolock)
	On ZZR_FILIAL = C6_FILIAL
	And ZZR_PEDIDO = C6_NUM
	--And ZZR_PRODUT = C6_PRODUTO
	--And ZZR_ITEMPV = C6_ITEM
	And ZZR.D_E_L_E_T_ = ''

	Left Join ZZ9010 ZZ9 With(Nolock)
	On ZZR_FILIAL = ZZ9_FILIAL
	And ZZR_OS = ZZ9_ORDSEP
	And ZZ9.D_E_L_E_T_ = '' */

Where C6_FILIAL Between @FILDE and @FILFIM  And C6_NUM Between @PVNUMINI 
and @PVNUMFIM and C6_ITEM Between @PVITEMINI  and @PVITEMFIM and C5_EMISSAO Between @DATADE and @DATAFIM

/*And ((Nullif(IsNull((Select Sum(C9_QTDLIB) From SC9010 SC9
					 Where C9_FILIAL = C6_FILIAL
					 And C9_PEDIDO = C6_NUM 
					 And SC9.D_E_L_E_T_ = ''),0),0))) - 
					 (C6_QTDENT) - 
					 Isnull((Select Sum(DC_QUANT) From SDC010 SDC
							 Where DC_FILIAL = C6_FILIAL and  
							 DC_PEDIDO = C6_NUM
							 And SDC.D_E_L_E_T_ = ''),0) > 0		*/		
										
										
And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,C5_NOTA,C6_BLQ
Order By 21,C6_FILIAL,C6_NUM desc



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

