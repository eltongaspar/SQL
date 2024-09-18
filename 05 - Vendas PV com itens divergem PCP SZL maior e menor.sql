--USE [IFC_P12]
--GO

/****** Object:  View [dbo].[BI_VW_PV_PCP_LANCES_MAIOR_MENOR]    Script Date: 05/06/2024 14:00:18 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--ALTER VIEW [dbo].[BI_VW_PV_PCP_LANCES_MAIOR_MENOR]
--AS



Select	

	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/

	RTRIM(LTRIM(ISNULL(SC6.C6_FILIAL,'')))														As CH_FILIAL,
	RTRIM(LTRIM(ISNULL(SC6.C6_CLI,'')))+'-'+RTRIM(LTRIM(ISNULL(SC6.C6_LOJA,'')))				As CH_CLIENTELOJA,
	RTRIM(LTRIM(ISNULL(SC6.C6_PRODUTO,'')))														As CH_PRODUTO,
	RTRIM(LTRIM(ISNULL(SC6.C6_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(SC6.C6_NUM,'')))				As CH_NUMPV,
	RTRIM(LTRIM(ISNULL(C9_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C9_PEDIDO,'')))					As CH_NUMVLIB,

	/*------------------------------------*/

	/*------------------------------------*/
	--Dados 
	RTRIM(LTRIM(ISNULL(SC6.C6_FILIAL, '')))					As FILIAL,
	RTRIM(LTRIM(ISNULL(A1_COD, '')))						As CLIENTE,
	RTRIM(LTRIM(ISNULL(A1_NOME, '')))						As CLIENTE_NOME, 
	RTRIM(LTRIM(ISNULL(SC6.C6_NUM, '')))					As PV_NUMERO,
	RTRIM(LTRIM(ISNULL(SC6.C6_PRODUTO, '')))				As PRODUTO,
	RTRIM(LTRIM(ISNULL(B1_DESC, '')))						As PRODUTO_DESCRICAO,
	RTRIM(LTRIM(ISNULL(SC6.C6_ITEM, '')))					As PV_ITEM,
	RTRIM(LTRIM(ISNULL(ZL_NUMBOB, '')))						As NUMERO_BOBINA,
	RTRIM(LTRIM(ISNULL(C9_FILIAL, '')))						As FILIAL_PVLIB,
	RTRIM(LTRIM(ISNULL(C9_PEDIDO, '')))						As PVLIB_NUMERO,
	RTRIM(LTRIM(ISNULL(C9_PRODUTO, '')))					As PRODUTO_PVLIB,
	RTRIM(LTRIM(ISNULL(C9_ITEM, '')))						As PVLIB_ITEM,
	RTRIM(LTRIM(ISNULL(ZE_FILIAL, '')))						As FILIAL_ETIQ,
	RTRIM(LTRIM(ISNULL(ZE_PEDIDO, '')))						As ETIQ_NUMERO_PV,
	RTRIM(LTRIM(ISNULL(ZE_ITEM, '')))						As ETIQ_PV_ITEM,
				
	RTRIM(LTRIM(ISNULL(C5_CONDPAG, '')))					As CONDICAO_PAGAMENTO,
	RTRIM(LTRIM(ISNULL(E4_DESCRI, '')))						As CONDICAO_PAG_DESCRICAO,
	RTRIM(LTRIM(ISNULL(C5_VEND1, '')))						As VENDEDOR_CODIGO,
	RTRIM(LTRIM(ISNULL(A3_NOME, '')))						As VENDEDOR_NOME,
	/*------------------------------------*/
		   
	/*------------------------------------*/
	--Status
	RTRIM(LTRIM(ISNULL(C5_NOTA, '')))						As NF,
	RTRIM(LTRIM(ISNULL(ZE_MOTIVO, '')))						As MOTIVO,
	RTRIM(LTRIM(ISNULL(C5_ZSTATUS, '')))					As STATUS_INTERNO_CODIGO,
	RTRIM(LTRIM(ISNULL(C5_TIPOLIB, '')))					As TIPO_LIBERACAO_CODIGO,
	RTRIM(LTRIM(ISNULL(C9_BLEST, '')))						As BLOQUEIO_ESTOQUE_CODIGO,
	RTRIM(LTRIM(ISNULL(C9_BLCRED, '')))						As BLOQUEIO_CREDITO_CODIGO,
	RTRIM(LTRIM(ISNULL(SC6.C6_BLQ, '')))					AS BLOQUEIO_PV_CODIGO,
	RTRIM(LTRIM(ISNULL(ZL_STATUS, '')))						As STATUS_PESAGEM_CODIGO,
	RTRIM(LTRIM(ISNULL(ZE_STATUS, '')))						As STATUS_ETIQ_CODIGO,
	Isnull(ZZF_STATUS,0)									As STATUS_RETRABALHO_CODIGO,
	RTRIM(LTRIM(ISNULL(C9_TPLIB, '')))						AS TIPO_LIBERACAO_CODIGO,
	RTRIM(LTRIM(ISNULL(C9_STATUS, '')))						As STATUS_LIBERACAO_CODIGO,
	RTRIM(LTRIM(ISNULL(C9_BLOQUEI, '')))					AS BLOQUEIO_LIBERACAO,
	/*------------------------------------*/		

	/*------------------------------------*/
	--Qtdes	
	Isnull(C9_QTDLIB,0)										As QTDE_LIBERADA,
	Isnull(SC6.C6_QTDVEN,0)									As QTDE_VENDIDA,
	Isnull(SC6.C6_QTDENT,0)									As QTDE_ENTREGUE,
	Isnull(SC6.C6_QTDEMP,0)									As QTDE_EMPENHADA,
	(SC6.C6_QTDVEN-SC6.C6_QTDENT)							As QTDE_SALDO,
	Isnull(SC6.C6_METRAGE,0)								As QTDE_METROS_LANCE,
	Isnull(SC6.C6_LANCES,0)									As QTDE_LANCES,
	Isnull(SC6.C6_QTDRES,0)									As QTDE_RESERVA,
	Isnull(ZL_METROS,0)										As QTDE_PRODUCAO, 
	Isnull(ZL_QTLANCE,0)									As QTDE_LANCES_PRODUCAO,
	Isnull(ZL_LANCE,0)										As QTDE_METROS_LANCES_PRODUCAO,	
	
	(ZL_METROS - SC6.C6_METRAGE)							As LANCES_DIFERENCAS,
	/*------------------------------------*/
	
	Case 
		When ZL_METROS < SC6.C6_METRAGE
		Then '<<<<<<<'

		When ZL_METROS > SC6.C6_METRAGE
		Then '>>>>>>>'

		When ZL_METROS = SC6.C6_METRAGE
		Then 'VVVVVVV'

		Else 'xxxxxxx'
	End As STATUS_LANCES,


		Case
			When C5_NOTA = '' Then 'PEDIDO EM ABERTO'
			When C5_NOTA = 'XXXXXX' Then 'ELIMINADO RESIDUO'
			When C5_NOTA <> '' and C5_NOTA Not In ('','XXXXXX') Then 'FINALIZADO'
			Else 'ANALISAR'
		End As STATUS_PV_MOTIVO,

	Case
		When SC6.C6_BLQ = '' Then 'PEDIDO EM ABERTO'
		When SC6.C6_BLQ = 'S' Then 'BLOQUEADO'
		When SC6.C6_BLQ = 'R'  Then 'RESIDUO'
		Else 'ANALISAR'
	End As STATUS_PV_ITEM_MOTIVO,

	Case 
		When C9_BLEST =  '' And C9_BLCRED = ''
		Then 'Liberado'

		When  C9_BLEST = '01' Or C9_BLCRED  <> '' And C9_BLCRED <> '10'
		Then '01-10 - Bloqueado por Credito'

		When  C9_BLCRED = '09' 
		Then '09 - Credito Rejeitado'

		When C9_BLEST  = '02' 
		Then '02 - Bloqueado por Estoque'		 

		When C9_BLEST  = '10' 
		Then '10 - Faturado'	

		Else 'Sem Status'
--''Liberado - 1 Bloqueado por Credito - 2 Bloqueado por Estoque - 09 Credito Rejeitado 
	End As STATUS_LIBERACAO_MOTIVO,

	Case
		When C5_ZSTATUS = '0' Then 'Normal'
		When C5_ZSTATUS=  '1' Then 'Em Separacao'
		When C5_ZSTATUS = '2'  Then 'Em Faturamento'
		Else 'ANALISAR'
	End As PV_STATUS_INTERNO_MOTIVO,
--0=Normal;1=Em Separacao;2=Em Faturamento  

	
	Case
		When C9_STATUS = '0' or C9_STATUS = '' Then 'Normal'
		When C9_STATUS=  '1' Then 'Em Separacao'
		When C9_STATUS = '2'  Then 'Em Faturamento'
		Else 'ANALISAR'
	End As STATUS_INTERNO_MOTIVO,
--0=Normal;1=Em Separacao;2=Em Faturamento    
			
	Case
		When ZE_STATUS = 'I' Then 'Importada'
		When ZE_STATUS=  'C' Then 'Cancelada'
		When ZE_STATUS = 'R' Then 'Recebida'
		When ZE_STATUS = 'P' Then 'A Liberar'
		When ZE_STATUS = 'E' Then 'Empenhada'
		When ZE_STATUS = 'F' Then 'Faturada'
		When ZE_STATUS = 'T' Then 'Estoque'
		When ZE_STATUS = 'A' Then 'Adiantada'
		When ZE_STATUS = 'X' Then 'Expedida'
		When ZE_STATUS = 'D' Then 'Devolução'
		When ZE_STATUS = 'V' Then 'Reservada'
		When ZE_STATUS = 'N' Then 'Reserva Confirmada'
		Else 'ANALISAR'
	End As ZE_STATUS_ETIQ_DESC,
--ZE_STATUS 
--I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 

	Case
		When ZL_STATUS = 'A' Then 'A Processar'
		When ZL_STATUS=  'P' Then 'Processado'
		When ZL_STATUS = 'C' Then 'Cancelada'
		When ZL_STATUS = 'E' Then 'Erro Processamento'
		When ZL_STATUS = 'Q' Then 'Bloqueio CQ'
		Else 'ANALISAR'
	End As STATUS_PESAGEM_DESC,
--ZL_STATUS
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ                                                          


		SUBSTRING(SC6.C6_ZZPVORI,1,6)					As NUM_PV_IND, 
		SUBSTRING(SC6.C6_ZZPVORI,7,2)					As NUM_PV_ITEM_IND,
		Isnull(Sum(SC6IND.C6_QTDEMP),'')				As QTDE_EMPENHADA_IND,
		Isnull(Sum(SC6IND.C6_QTDVEN),'')				As QTDE_VENDIDA_IND,
		Isnull(Sum(SC6IND.C6_QTDENT),'')				As QTDE_ENTREGUE_IND

From SC5010 SC5 With(Nolock) --PV Cab

	Inner Join SC6010 SC6 With(Nolock) -- PV itens 
		On C5_FILIAL = SC6.C6_FILIAL
		And C5_NUM = SC6.C6_NUM
		And SC6.D_E_L_E_T_ = ''
	

	Left Join SZL010 SZL With(Nolock) --Pesagem
		On ZL_FILIAL = SC6.C6_FILIAL
		And ZL_PEDIDO = SC6.C6_NUM
		And ZL_ITEMPV = SC6.C6_ITEM
		And SZL.D_E_L_E_T_ = ''

	Left Join SZE010 SZE With(Nolock) -- Etiquetas
		On ZE_FILIAL = ZL_FILIAL
		And ZE_NUMBOB = ZL_NUMBOB
		And SZE.D_E_L_E_T_ = ''

	Left Join SE4010 SE4 With(Nolock) -- Condicao de pagamentos
		ON E4_CODIGO = C5_CONDPAG
		And SE4.D_E_L_E_T_ = ''

	Left Join SA3010 SA3 With(Nolock) -- Vendedores 
		ON A3_COD = C5_VEND1
		And SA3.D_E_L_E_T_ = ''

	Inner Join SC9010 SC9 With(Nolock) --PV IUtens Liberados
		On C9_FILIAL = SC6.C6_FILIAL
		And C9_PEDIDO = SC6.C6_NUM 
		And C9_PRODUTO = SC6.C6_PRODUTO
		And C9_ITEM = SC6.C6_ITEM
		And SC9.D_E_L_E_T_ = ''

	Left Join ZZF010 ZZF With(Nolock) -- CTRL SEPARACAO PROATIVA       
		On ZZF_PEDIDO = C6_NUM
		And ZZF_ITEMPV = C6_ITEM
		--And ZZF_STATUS In ('2','3','4','5','6','7','8','9','A')-
		And ZZF.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1  With(NoLock) -- Produtos 
		On B1_COD = C6_PRODUTO
		And SB1.D_E_L_E_T_ = ''
	
	Inner Join SA1010 SA1  With(NoLock) -- Clientes 
		On A1_COD = C5_CLIENTE
		And A1_LOJA = C5_LOJACLI
		And SA1.D_E_L_E_T_ = ''

	Left Join SC6010 SC6IND With(Nolock) -- PV Itens Industrializacao
		On SC6IND.C6_FILIAL = '01'
		And SC6IND.C6_CLI = '008918'
		And SC6IND.C6_LOJA = '01'
		And SC6IND.C6_NUM = SUBSTRING(SC6.C6_ZZPVORI,1,6)
		And SC6IND.C6_ITEM = Substring(SC6.C6_ZZPVORI,7,2)
		And SC6IND.C6_PRODUTO = SC6.C6_PRODUTO
		--And (C6_LOCAL = '10' OR C6_SEMANA = 'TAUTOM' ) 
		And SC6IND.D_E_L_E_T_ = ''
		
Where	C5_FILIAL In ('01','02','03') 
		And ((ZL_METROS < SC6.C6_METRAGE) or (ZL_METROS > SC6.C6_METRAGE))
		And ZE_STATUS = 'P' And ZL_STATUS In ('P')
		And C5_NOTA Not In ('XXXXXX') -- Nao Eliminado Residuo 
		And C5_NOTA = ('') -- PV em Aberto
		And SC6.C6_QTDVEN <= SC6.C6_ENTREG -- Qtde já Entregues 
		And C9_BLEST  Not In ('10')  And C9_BLCRED Not In ('10') -- Não Faturado
		And C5_EMISSAO >= CONVERT(CHAR(8),DATEADD (YEAR, -3, GETDATE() ),112)
		And SC5.D_E_L_E_T_ = ''

Group By
		ZE_MOTIVO,C5_ZSTATUS,C5_TIPOLIB,C9_BLEST,C9_BLCRED,SC6.C6_BLQ,ZL_STATUS,ZE_STATUS,Isnull(ZZF_STATUS,0), C5_NOTA,C9_TPLIB,C9_STATUS,C9_BLOQUEI,
		SC6.C6_FILIAL,SC6.C6_NUM,A1_COD,A1_NOME, SC6.C6_PRODUTO,B1_DESC,SC6.C6_ITEM,C9_FILIAL,C9_PEDIDO,C9_PRODUTO,C9_ITEM,		
		C9_QTDLIB,SC6.C6_QTDVEN,SC6.C6_QTDENT,SC6.C6_QTDEMP,(SC6.C6_QTDVEN-SC6.C6_QTDENT),
		SC6.C6_QTDVEN,SC6.C6_METRAGE,SC6.C6_LANCES,SC6.C6_QTDRES,
		ZL_METROS, ZL_QTLANCE,ZL_LANCE,
		ZE_FILIAL,ZE_PEDIDO,ZE_PEDIDO,ZE_ITEM,
		ZL_NUMBOB,ZE_STATUS,C5_CONDPAG,E4_DESCRI,C5_VEND1,A3_NOME,
		SC6.C6_ZZPVORI,
		SC6.C6_CLI,SC6.C6_LOJA

Order By 1,2,4

-- Etiquetas
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa    

--ZL - Pesagem 
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ  

--C5 - Vendas
--C5_ZSTATUS = 0=Normal;1=Em Separacao;2=Em Faturamento
--C5.C5_TIPOLIB -> 'M'anual / 'P'riorizado / 'N'ormal


-- C9 - PV Liberação 
--C9_BLEST,C9_BLCRED
--'' Liberado - 1 Bloqueado por Credito - 2 Bloqueado por Estoque - 09 Credito Rejeitado - 10 Faturado 
--C9_STATUS
--0=Normal;1=Em Separação;2=Em Preparação;3=Em Faturamento        
--C9_BLOQUEI	Bloqueio	Bloqueio

--ZZF
--ZZF_STATUS
---2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat     

--Campos 
--Select * From SX3010
--Where X3_CAMPO In ('C9_BLEST','C9_BLCRED','C9_BLOQUEI')
--And D_E_L_E_T_ = ''

/*
--PV Itens 
Select D_E_L_E_T_,* From SC6010
Where C6_NUM = '419953' and C6_ITEM = '18'
--And D_E_L_E_T_ = ''
Order By C6_ITEM

--PV Liberados
Select D_E_L_E_T_,* From SC9010
Where C9_PEDIDO = '419953' and C9_ITEM = '18'
--And D_E_L_E_T_ = ''
Order By C9_ITEM

-- Pesagem
Select D_E_L_E_T_,* From SZL010
Where ZL_PEDIDO = '419953' and ZL_ITEMPV = '18'
--And D_E_L_E_T_ = ''

--Etiquetas
Select D_E_L_E_T_,* From SZE010
Where ZE_PEDIDO = '419953' and ZE_ITEM = '18'
--And D_E_L_E_T_ =
*/