
--Nota Fiscal Eletrônica
Select STATUS,STATUSCANC,STATUSMAIL,DOC_CHV,LOTE,* From SPED050
Where NFE_ID In ('1  000405914') and DATE_NFE >= '20240528' and D_E_L_E_T_ = ''

--Lotes de Nota Fiscal Eletrônica
Select LOTE,* From SPED052
Where LOTE In ('000000000092907')
and D_E_L_E_T_ = ''


--Lotes X Nota Fiscal Eletrônica
Select LOTE,* From SPED054
Where NFE_ID In ('1  000405914') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''

/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
--[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/


--Parametro para cancelamento de NF após 24 h
--MV_SPEDEXC
--Entrar no parametro da sua filial e colocar o numero de horas para o cancelamento da NF.
SELECT * FROM SX6010 WHERE X6_VAR='MV_SPEDEXC'	

--Define a quantidade de dias para transmissão do Cancelamento Extemporâneo.
--MV_CANCEXT
-- Parâmtro para todas empresas Padrão 1 Dias.
Select * From SX6010
Where X6_VAR = 'MV_CANCEXT'

-- Parametros - Datas de Ultimo Fechamento e Bloqueio de movimentação
Select * From SX6010
Where X6_VAR In ('MV_ULMES','MV_DBLQMOV')
and D_E_L_E_T_ = ''


--Ativar o Cancelamento da NF-e como Evento     
--T = Sim ou F = Não  
--MV_NFECAEV
Select * From SX6010
Where X6_VAR = 'MV_NFECAEV'



--Consulta Chave nas NFe de entrada.
--Desabilitar por Filial.
--MV_CHVNFE
--Informa se havera consulta da NFE/CTE no portal da SEFAZ .T.
 --= Sim; .F. = Nao.
 SELECT * FROM SX6010 WHERE X6_VAR='MV_CHVNFE'	


--Define quais Especies de Nota Fiscal permite    
--a geracao da Chave da DANFE.                      
Select * From SX6010
Where X6_VAR = 'MV_CHVESPE'


 Select * From SX5010
 Where X5_TABELA = '17'

 Select * From CC0010

 Select * From SX3010
 Where X3_CAMPO = ('RA_PIS')










-- NF Entrada Itens 
Select * From SFT010
Where FT_CLIEFOR = 'V008L2' and FT_NFISCAL In ('9531','9535')
and D_E_L_E_T_ = ''




--T9U - Informação do Contribuinte
Select * From T9U010
Where D_E_L_E_T_ = ''


--C1H - Participantes*/
Select C1H_CNPJ,C1H_CPF,* From C1H010
Where C1H_CNPJ = '09136712000107'
--Or C1H_CPF In ('05769891939','33464371832')
and D_E_L_E_T_ = ''


-- Fornecedores 
Select * From SA2010
Where A2_CGC In ('09136712000107')
and D_E_L_E_T_ = ''



Select * From SCR010

/*Solução

CR_STATUS='01' - Pendente em níveis anteriores

CR_STATUS='02' - Pendente

CR_STATUS='03' - Aprovado

CR_STATUS='04' - Bloqueado

CR_STATUS='05' - Aprovado/rejeitado pelo nível

CR_STATUS='06' - Rejeitado                                                                                                                             

CR_STATUS='07' - Documento Rejeitado ou Bloqueado por outro usuário.*/




-- Logs SC COT PC 

--COH - LOG do processo de Pedido de Compra
Select * From COI010

--COI  - LOG do Processo de Solicitação de Compra
Select * From COH010

--COK - LOG por Solicitação de compra do fornecedor
Select * From COK010


Select * From COI010
Where COI_NUMSC = '145050' and D_E_L_E_T_ =''

--COH - LOG do processo de Pedido de Compra
--COI  - LOG do Processo de Solicitação de Compra
--COK - LOG por Solicitação de compra do fornecedor


Select * From SX6010
Where X6_VAR = 'MV_HABLOG'


--LOG DAS ORDENS DE SEPARACAO   
SELECT ZZR_SITUAC, *
--UPDATE ZZR010 SET ZZR_SITUAC = '2'
FROM ZZR010
WHERE ZZR_FILIAL = '01'
AND ZZR_PEDIDO = '396199'
AND D_E_L_E_T_ = ''

-- Sched
Select *, 
ISNULL(CAST(CAST(TSK_PARM AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG
From SCHDTSK
Where TSK_DIA >= '20230818'  And TSK_ROTINA Like ('%FINA711%')                                                            
and D_E_L_E_T_ = ' '
/*Status
0 = "Aguardando execução"
1 = "Em execução"
2 = "Finalizada"
3 = "Falhou"
4 = "Permanente"
5 = "Descartada"*/

--
--XX0 - Cadastro de agents (Schedule)
Select * From XX0
Where D_E_L_E_T_ = ' '

--XX1 - Agendamento (Schedule)
Select * From XX1
Where XX1_ULTDIA >= '20240801'  And XX1_ROTINA Like ('%FINA713%')                                                            
and D_E_L_E_T_ = ' '

--XX2 - Agendamento x Empresa/Filial (Schedule)
Select * From XX2
Where D_E_L_E_T_ = ' '


/*
Tabelas XX do PROTHEUS
Segue abaixo as tabelas XX do Protheus:

XX0 - Cadastro de agents (Schedule)

XX1 - Agendamento (Schedule)

XX2 - Agendamento x Empresa/Filial (Schedule)

XX3 - Transações EAI

XX4 - Adapters EAI

XX5 - Relação de uso de rotinas/módulos

XX6 - Catalogo de personalizacoes

XX7 - "Itens do Catalogo de personalizacoes"

XX8 - Configuração de empresas

XX9 - Itens de configuração de empresas

XXA - Em desenvolvimento

XXB - Em desenvolvimento

XXC - Em desenvolvimento*/





--SPED FISCAL - 2 UM

-- Produtos
Select B1_UM,B1_SEGUM,B1_CONV,B1_TIPCONV,B1_COD,B1_DESC,* From SB1010
Where B1_SEGUM <> '' and B1_CONV = '0' --and B1_COD In ('MS01000222','AI02000847','MC10001100','MC10001099')
And D_E_L_E_T_ = ''



-- NF Entrada Itens
Select Distinct D1_COD CODIGO,B1_DESC PROD_DESC,B1_UM UM_PRODUTO,SAH.AH_DESCES UM_DESC,B1_SEGUM SEG_UM_PROD,SAH2.AH_DESCES SEG_UM_DESC,B1_CONV FATOR_CONVERT,
B1_TIPCONV,D1_UM UM_NF,D1_SEGUM SEG_UM_NF,D1_QTSEGUM QTDE_2UM_NF,B1_TIPO,X5_DESCRI TIPO, D1_DOC,D1_FORNECE, A2_NOME,D1_FILIAL,

	Case 
	When D1_SEGUM <> '' and D1_QTSEGUM = '0' Then '#######'
	Else '*******'
	End AS Status_

From SD1010 SD1
	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1. D_E_L_E_T_ = ''

	Inner Join SAH010 SAH
	On SAH.AH_UNIMED = B1_UM
	And SAH.D_E_L_E_T_ = ''

	Inner Join SAH010 SAH2
	On SAH2.AH_UNIMED = B1_SEGUM
	And SAH2.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5
	On X5_TABELA = '02' 
	And X5_CHAVE = B1_TIPO
	And SX5.D_E_L_E_T_ = ''

	Inner Join SA2010 SA2
	On D1_FORNECE = A2_COD
	And SA2.D_E_L_E_T_ = ''

Where D1_FILIAL In ('01','02','03') and D1_EMISSAO Between '20231201' and '20231231'
And B1_SEGUM <> '' and B1_CONV = '0'
and D1_SEGUM <> '' and D1_QTSEGUM = '0'
And SD1.D_E_L_E_T_ = ''
Order By D1_FILIAL,D1_COD

--Seg.Un.Medi. (B1_SEGUM)
--Fator Conv. (B1_CONV)
--Tipo de Conv (B1_TIPCONV)
--Cod Barras (B1_CODBAR) - Valido  a partir de Janeiro de 2022



-- PV - Itens 
Select C6_SEMANA, * From SC6010
Where C6_ENTREG >= '20230101' and D_E_L_E_T_ =''

Select Max(C7_NUM) From SC7010

-- Lista de Repasse 
Select Z9_SEMANA,* From  SZ9010
Where Z9_SEMANA >= '2023001' and D_E_L_E_T_ =''











-- TEs 
Select * From SF4010
Where F4_CODIGO In ('703','829')

-- NF Itens Saida 
Select D2_DOC,D2_IDENTB6,* From SD2010
Where D2_FILIAL = '01' and D2_DOC = '000369776'
and D_E_L_E_T_ =''

-- Estoque Terceiros 
Select B6_IDENT,* From SB6010
Where B6_FILIAL = '01' and B6_DOC = '000369776'
and D_E_L_E_T_ =''


Select D2_DOC,D2_IDENTB6,D2_COD,B6_IDENT,* From SD2010 SD2

	Left Join SB6010 SB6
	On D2_FILIAL = B6_FILIAL
	And D2_COD = B6_PRODUTO
	And D2_DOC = B6_DOC
	And D2_IDENTB6 = B6_IDENT
	And SB6.D_E_L_E_T_ =''

Where D2_FILIAL = '01' and D2_DOC = '000369776'
and SD2.D_E_L_E_T_ =''

Select * From TRD01SP


---- ZZR Aglutinação Ordens de Separação
Select * From ZZR010
Where ZZR_PEDIDO In ('102789')
and D_E_L_E_T_= ''
--Alterar Campo Situação para 2 - Montado
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado      

--Ordens de Carga
Select * From ZZ9010
Where ZZ9_ORDSEP Like ('%102789%')-- or ZZ9_ORDSEP Like ('%102446%')
and D_E_L_E_T_= ''

----Bobinas 
SELECT *
FROM SZE010
WHERE ZE_FILIAL In ('02','01')
AND ZE_PEDIDO Like ('%102789%') 
--AND ZE_STATUS = 'E'
AND D_E_L_E_T_ = ''


-- PV 
Select * From SC6010
WHERE C6_FILIAL In ('02')
AND C6_NUM Like ('%102789%') 
--AND ZE_STATUS = 'E'
AND D_E_L_E_T_ = ''

-- NF Saida Itens
Select * From SD2010 
Where D2_FILIAL = '01' and D2_DOC = '000078493'
AND D_E_L_E_T_ = ''



Select * From SX3010
Where X3_ARQUIVO In ('ZZR')




 -- Clientes 
 Select A1_MENPAD,M4_FORMULA,* From SA1010 SA1

  -- Produtos
Select B1_ALIQISS,B1_CODISS, * From SB1010
Where B1_COD = 'MC13000952'  and D_E_L_E_T_ = ''

-- Fornecedor
Select A2_RECISS,* From SA2010
Where A2_COD In ('V0080Q') and D_E_L_E_T_ = ''


-- NF Saida Cab. 
Select F2_FILIAL,F2_DOC, 
F2_ICMFRET,F2_VALICM,F2_BASEICM,F2_ICMSRET,F2_BRICMS,F2_ICMAUTO,F2_ICMSDIF,F2_VALTST,F2_BASETST,F2_NFICMST,*
From SF2010
Where F2_FILIAL In ('01','02','03') And F2_DOC In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
and D_E_L_E_T_ =''
Order By 6 Desc,1,2

--F2_ICMFRET	ICMS Frete	Valor do Frete / Seguro
--F2_VALICM	Vlr.ICMS	Valor do ICMS
--F2_BASEICM	Base p/ICMS	Base de Calculo para ICM
--F2_ICMSRET	ICMS Retido	ICMS Retido na Fonte
--F2_BRICMS	Base ICM Sol	Base ICMS Solidario
--F2_ICMAUTO	Vl.Icm Frete	Valor do ICMs Frete
--F2_ICMSDIF	Icms. Dif.	Icms Diferido
--F2_VALTST	Val. ST tran	Valor ICMS ST transporte
--F2_BASETST	Base ST tran	Base ICMS ST transporte
--F2_NFICMST	Cod.NF IcmSt	Codigo ICMS ST pela NFS



-- NF Saida Itens 
Select D2_FILIAL,D2_DOC,D2_TES,D2_CLIENTE,D2_LOJA,D2_EMISSAO,A1_NOME, A1_CGC,A1_TIPO,
D2_VALICM,D2_PICM,D2_BRICMS,D2_BASEORI,D2_BASEICM,D2_ICMSRET,D2_ICMFRET,D2_ALIQSOL,D2_FTRICMS,D2_VRDICMS,D2_ALIQTST,D2_DESCICM,D2_VALTST,
D2_BASETST,D2_ALIQCMP,D2_DIFAL,D2_ICMSCOM,D2_ALFCCMP,D2_ICMSDIF,*
From SD2010 SD2
	
	Inner Join SB1010 SB1
	On B1_COD = D2_COD
	And SB1.D_E_L_E_T_ =''

	Inner Join SA1010 SA1
	On A1_COD = D2_CLIENTE
	And A1_LOJA = D2_LOJA
	And SA1.D_E_L_E_T_ =''



Where D2_FILIAL In('01','02','03') and D2_DOC In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
And D2_EMISSAO >= '20230101'
and SD2.D_E_L_E_T_ =''
Order By 11 desc,1,2

--D2_VALICM	Vlr.ICMS	Valor do ICM do Item
--D2_PICM	Aliq. ICMS	Aliquota de ICMS
--D2_BRICMS	Ret. ICMS	Base de Retencao ICMS
--D2_BASEORI	B.Orig ICMS	Base Original do ICMS
--D2_BASEICM	Base ICMS	Base do ICMS do Item
--D2_ICMSRET	ICMS Solid.	Valor do ICMS Solidario
--D2_ICMFRET	Icms Frete	Icms Frete
--D2_ALIQSOL	Alq ICMS Sol	Aliq. ICMS Sol.
--D2_FTRICMS	Fat.Desc.ICM	Fator de Reducao Desc.ICM
--D2_VRDICMS	Val.Desc.ICM	Valor de Reducao Desc.ICM
--D2_ALIQTST	Aliq ST tran	Aliq. ICMS ST transporte
--D2_DESCICM	Ded.ICMS	Deducao do ICM do Item
--D2_VALTST	Val. ST tran	Valor ICMS ST transporte
--D2_BASETST	Base ST tran	Base ICMS ST transporte
--D2_ALIQCMP	Aliq Comp.	Aliq. ICMS complementar
--D2_DIFAL	ICMS Difal	ICMS Comple. UF Destino
--D2_ICMSCOM	ICMS Comple.	Valor ICMS Complementar
--D2_ALFCCMP	FECP Comp.	FECP ICMS complementar
--D2_ICMSDIF	Vlr.ICMS Dif	Valor do ICMS Diferido

-- NF Entrada Cabecalho
Select F1_FILIAL,F1_DOC,
F1_BASEICM,F1_VALICM,F1_BRICMS,F1_ICMSRET,F1_ICMS,*
From SF1010
Where F1_FILIAL In ('01','02','03') And F1_DOC In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
and D_E_L_E_T_ =''
Order By 6 Desc,1,2

--F1_BASEICM	Base p/ICMS	Base de calculo para ICM
--F1_VALICM	Vlr.ICMS	Valor do ICMS
--F1_BRICMS	Base ICM Sol	Base ICMS Solidario
--F1_ICMSRET	ICMS Solid.	Valor ICMS Solidario
--F1_ICMS	ICMS	ICMS


-- NF Entrada Itens
Select D1_FILIAL,D1_DOC,D1_TES,D1_FORNECE,D1_LOJA,B1_PICMRET,B1_PICMENT,A2_NOME, A2_CGC,A2_TIPO,
D1_VLSLXML,D1_VALICM,D1_PICM,D1_ICMSRET,D1_BRICMS,D1_BASEICM,D1_ICMSCOM,D1_VRDICMS,D1_ALIQCMP,D1_DESCICM,D1_FTRICMS,D1_ALFCCMP,D1_DIFAL,
D1_ICMSDIF,D1_VALANTI,D1_ALIQSOL,D1_BASNDES,D1_ICMNDES,D1_ALQNDES,*
From SD1010 SD1
	
	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ =''

	Inner Join SA2010 SA2
	On A2_COD = D1_FORNECE
	And A2_LOJA = D1_LOJA
	And SA2.D_E_L_E_T_ =''
		
Where D1_FILIAL In ('01','02','03') And D1_DOC In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
and D1_FORNECE In ('V00693','000048')
And D1_EMISSAO >= '20230101'
and SD1.D_E_L_E_T_ =''
Order By 8 Desc,1,2

--D1_VLSLXML	ICMS ST For.	ICMS ST Fornecedor
--D1_VALICM	Vlr.ICMS	Valor do ICM do Item
--D1_PICM	Aliq. ICMS	Aliquota de ICMS
--D1_ICMSRET	ICMS Solid.	Valor do ICMS Solidario
--D1_BRICMS	Ret. ICMS	Base de Retencao ICMS
--D1_BASEICM	Base Icms	Valor Base do Icms
--D1_ICMSCOM	ICMS Comple.	Valor ICMS Complementar
--D1_VRDICMS	Val.Desc.ICM	Valor de Reducao Desc.ICM
--D1_ALIQCMP	Aliq Comp	Aliq. ICMS complementar
--D1_DESCICM	Desc. ICMS	Desconto ICMS
--D1_FTRICMS	Fat.Desc.ICM	Fator de Reducao Desc.ICM
--D1_ALFCCMP	FECP Comp.	FECP ICMS complementar
--D1_DIFAL	ICMS Difal	ICMS Comple. UF Destino
--D1_ICMSDIF	Vlr.ICMS Dif	Valor do ICMS Diferido
--D1_VALANTI	Val Ant.ICMS	Valor Antecipacao ICMS
--D1_ALIQSOL	Aliq ICMS So	Aliq ICMS Solidario
--D1_BASNDES	B.ICMS ST An	Base ICMS ST Anterior
--D1_ICMNDES	ICMS ST Ante	Valor ICMS ST Anterior
--D1_ALQNDES	A.ICMS ST An	Aliq. ICMS ST Anterior



-- Livro Fiscal Cab.
Select F3_FILIAL,F3_NFISCAL,
F3_ALIQICM,F3_BASEICM,F3_VALICM,F3_ISENICM,F3_OUTRICM,F3_ICMSRET,F3_ICMSCOM,F3_ICMAUTO,F3_BASERET,F3_ICMSDIF,F3_TRFICM,
F3_OBSICM,F3_SOLTRIB,F3_SIMPLES,F3_CREDACU,F3_ANTICMS,F3_VALANTI,F3_BASETST,F3_VALTST,F3_VL43080,F3_MOTICMS,F3_BASNDES,F3_ICMNDES,
F3_DIFAL,F3_BSICMOR,*
From SF3010
Where F3_FILIAL In ('01','02','03') And F3_NFISCAL In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
And F3_EMISSAO >= '20230101'
and D_E_L_E_T_ =''
Order By 8 Desc,1,2

--F3_ALIQICM	Aliq. ICMS	Aliquota de ICMS
--F3_BASEICM	Base p/ICMS	Base de ICMS
--F3_VALICM	ICMS Tribut.	ICMS Tributado
--F3_ISENICM	ICMS Isento	ICMS Isento
--F3_OUTRICM	ICMS Outros	ICMS Outros
--F3_ICMSRET	ICMS Retido	ICMS Retido
--F3_ICMSCOM	ICMS Complem	ICMS Complementar
--F3_ICMAUTO	Icms autonom	Icms sobre frete autonomo
--F3_BASERET	Bs Icms Ret	Base do ICMS Retido
--F3_ICMSDIF	ICM Diferido	ICMS Diferido
--F3_TRFICM	Trf.Deb/Crd.	Transf. Debito e Credito
--F3_OBSICM	Icm Observ.	Icms na observacao
--F3_SOLTRIB	ICM.Sol.Trib	ICMS solidario tributado
--F3_SIMPLES	Simples	Vlr do ICMS do SIMPLES/SC
--F3_CREDACU	Cr Acum ICMS	Credito Acumulado de ICMS
--F3_ANTICMS	Antecip.ICMS	Antecipacao Tribut. ICMS
--F3_VALANTI	Val Ant.ICMS	Valor Antecipacao ICMS
--F3_BASETST	Base ST tran	Base ICMS ST transporte
--F3_VALTST	Val. ST tran	Valor ICMS ST transporte
--F3_VL43080	Vl.43080	Vl.ICMS s/ Debito
--F3_MOTICMS	Mot.Desone.	Mot.Desone. ICMS
--F3_BASNDES	B.ICMS ST An	Base ICMS ST Recolh. Ant.
--F3_ICMNDES	ICMS ST Ant.	Valor ICMS ST Anterior
--F3_DIFAL	Difal ICMS	Difal Origem/Destino
--F3_BSICMOR	BS.ICMS Ori.	Valor Original Base ICMS


-- Livro Fiscal Itens
Select FT_FILIAL,FT_NFISCAL,FT_TES,
FT_ALIQICM,FT_BASEICM,FT_VALICM,FT_ISENICM,FT_OUTRICM,FT_ICMSRET,FT_ICMSCOM,FT_ICMSDIF,FT_TRFICM,FT_OBSICM,FT_SOLTRIB,FT_ICMAUTO,FT_CLASFIS,FT_ANTICMS,
FT_BASETST,FT_ALIQTST,FT_VALTST,FT_VALANTI,FT_ALIQSOL,FT_PAUTST,FT_PAUTIC,FT_MOTICMS,FT_DESCICM,FT_PSTANT,FT_BSICMOR,FT_FTRICMS,FT_BASNDES,FT_DESPICM,
FT_ICMNDES,FT_DIFAL,FT_VRDICMS,FT_VICEFET,FT_RICEFET,FT_VICPRST,FT_VSTANT,FT_PICEFET,FT_BSTANT,FT_BICEFET,FT_COLVDIF,FT_ALFCCMP,
FT_ALQNDES,*
From SFT010
Where FT_FILIAL In ('01','02') And FT_NFISCAL In ('000136860','000136861','000136862','000137060','000137061','000137062','000371870','000371871')
And FT_EMISSAO >= '20230101'
and D_E_L_E_T_ =''
Order By 9 Desc,1,2

--FT_ALIQICM	Aliq. ICMS	Aliquota ICMS
--FT_BASEICM	Base ICMS	Valor da Base de ICMS
--FT_VALICM	Valor ICMS	Valor do ICMS
--FT_ISENICM	Vlr Isen ICM	Valor Isento do ICMS
--FT_OUTRICM	Vlr Out ICMS	Valor Outros do ICMS
--FT_ICMSRET	Vlr ICMS Ret	Valor do ICMS Retido ST
--FT_ICMSCOM	Vlr ICMS Com	Valor ICMS Complementar
--FT_ICMSDIF	Vlr ICMS Dif	Valor do ICMS DIferido
--FT_TRFICM	Vlr ICMS Trf	Valor do ICMS Transferido
--FT_OBSICM	Vlr ICM Obs	Valor ICMS impresso Obs
-- FT_SOLTRIB	ICMS Sol Tri	Vlr ICMS Solidario Tribut
--FT_ICMAUTO	ICMS Frt Aut	ICMS sobre frete autonomo
--FT_CLASFIS	Sit.Tribut.	Situacao Tributaria ICMS
--FT_ANTICMS	Antecip.ICMS	Antecipacao Tribut. ICMS
--FT_BASETST	Base ST tran	Base ICMS ST transporte
--FT_ALIQTST	Aliq ST tran	Aliq. ICMS ST transporte
--FT_VALTST	Val. ST tran	Valor ICMS ST transporte
--FT_VALANTI	Val Ant.ICMS	Valor Antecipacao ICMS
--FT_ALIQSOL	Aliq ICMS So	Aliq ICMS Solidario
--FT_PAUTST	ICMS ST Paut	Valor do ICMS ST de Pauta
--FT_PAUTIC	ICMS Pauta	Valor do ICMS de Pauta
--FT_MOTICMS	Mot.Desone.	Mot.Desone. ICMS
--FT_DESCICM	Desc.ICMS	Valor do desconto do ICMS
--FT_PSTANT	% Ret Ant.	Perc. ICMS Ret. Anterior
--FT_BSICMOR	BS.ICMS Ori.	Valor Original Base ICMS
--FT_FTRICMS	Fat.Desc.ICM	Fator de Reducao Desc.ICM
--FT_BASNDES	B.ICMS ST An	Base ICMS ST Recolh. Ant.
--FT_DESPICM	Vl Desp ICMS	Valor desp. Base ICMS
--FT_ICMNDES	ICMS ST Ant.	Valor ICMS ST Anterior
--FT_DIFAL	Difal ICMS	Difal Origem/Destino
--FT_VRDICMS	Val.Desc.ICM	Valor de Reducao Desc.ICM
--FT_VICEFET	ICMS Eeftivo	Valor ICMS Efetivo
--FT_RICEFET	Red.ICMS Efe	Perc.Reducao ICMS Efetivo
--FT_VICPRST	ICMS Substit	ICMS Substituto
--FT_VSTANT	Vl Ret Ant	ICMS Retido Anterior
--FT_PICEFET	% ICMS Efet	Percentual ICMS Efetivio
--FT_BSTANT	Bc. Ret. Ant	Base ICMS Retido Anterior
--FT_BICEFET	BC ICMS Efet	BAse Calculo ICMS Efetivo
--FT_COLVDIF	Col ICMS Dif	Coluna ICMS Diferido
--FT_ALFCCMP	FECP Comp.	FECP ICMS complementar
--FT_ALQNDES	A.ICMS ST An	Aliq. ICMS ST Anterior


-- TES
Select F4_CODIGO,F4_TEXTO,F4_CONSUMO,F4_ANTICMS,
F4_CRDICMA,F4_ICM,F4_CREDICM,F4_BASEICM,F4_LFICM,F4_COMPL,F4_INCSOL,F4_STDESC,F4_BSICMST,F4_CREDST,F4_DESPICM,F4_SITTRIB,F4_ICMSDIF,F4_TRFICM,F4_OBSICM,
F4_PICMDIF,F4_IPIANT,F4_DSPRDIC,F4_ICMSST,F4_MKPCMP,F4_LFICMST,F4_ALICRST,F4_REDANT,F4_BSRDICM,F4_ANTICMS,F4_ICMSTMT,F4_DICMFUN,F4_STLIQ,F4_BSICMRE,F4_RDBSICM
F4_IPIVFCF,F4_STREDU,F4_CRICMST,F4_PARTICM,F4_CREDACU,F4_DUPLIST,F4_BCPCST,F4_DBSTCSL,F4_DBSTIRR,F4_CRICMS,F4_SOMAIPI,F4_PCREDAC,F4_PAUTICM,F4_COMPRED
F4_TRFICST,F4_MOTICMS,F4_DIFAL,F4_FTRICMS,F4_CRLEIT,F4_COLVDIF,F4_BICMCMP,*
From SF4010
Where F4_CODIGO In ('949','521','501','038','017') And D_E_L_E_T_ = '' 

--F4_CRDICMA	Cr. ICM.Ant	Credita ICM Anterior
--F4_ICM	Calcula ICMS	Calcula ICMS (SN)?
--F4_CREDICM	Cred. ICMS	Credita ICM?
--F4_BASEICM	%Red.do ICMS	% Reducao da Base de ICMS
--F4_LFICM	L.Fisc. ICMS	T/I/O/Nao/Zerado/Observ
--F4_COMPL	Calc.Dif.Icm	Calcula Dif. Icm ?
--F4_INCSOL	Agrega Solid	Agrega ICMS retido na NF.
--F4_STDESC	Bs.ICMS ST	Base do ICMS ST
--F4_BSICMST	%Red.ICMS ST	% Reducao de ICMS ST
--F4_CREDST	Crd.ICMS ST	Credita ICMS ST ?
--F4_DESPICM	Desp.Ac.ICMS	Desp.Base ICMS ?
--F4_SITTRIB	Sit.Trib.ICM	Situacao Trib. do ICMS
--F4_ICMSDIF	ICM Diferido	Diferimento de ICMS
--F4_TRFICM	Trf.Deb/Crd.	Transf. Debito ou Credito
--F4_OBSICM	Icms Observ.	Icms na Observacao
--F4_PICMDIF	Perc.ICM DIF	Perc.do ICMS Diferido
--F4_IPIANT	IPI.BC.Ant	IPI.BC.ICMS Antecipado
--F4_DSPRDIC	Desp.Ac.ICM	Desp.Ac.Reducao de ICMS
--F4_ICMSST	ICMS s/ST	ICMS s/ST
--F4_MKPCMP	Mkp ICM.Comp	Markup ICMS complementar
--F4_LFICMST	LF ICMS-ST	Livro Fiscal ICMS-ST
--F4_ALICRST	Alq. Crd. ST	Aliquota Credito ICMSST
--F4_REDANT	%Red. Antec.	Reducao Antecip. ICMS
--F4_BSRDICM	Bas.Calc.Red	Acres.Desp.Base.Calc.Red.
--F4_ANTICMS	Antecip.ICMS	Antecipacao Tribut. ICMS
--F4_ICMSTMT	Ded.ICM.ST	Deduz o ICMS Prop.?
--F4_DICMFUN	Ded.ICMS Fun	Ded.ICMS Funr
--F4_STLIQ	Calc.ST Liq.	Calcula ICMS ST Liquido
--F4_BSICMRE	Base ST Dif	Base St Diferenciado
--F4_RDBSICM	Red.Car.ICMS	Reduz Carga Tribut. ICMS
--F4_IPIVFCF	IPI Bs.ICMS	IPI Bs.ICMS Venda Futura
--F4_STREDU	Reducao ST	Reducao de Base - ICMS-ST	
--F4_CRICMST	Cont ICMS-ST	Cont Restituicao ICMS-ST
--F4_PARTICM	Part ICM	Partilha de ICMS
--F4_CREDACU	Cr Acum ICMS	Credito Acumulado de ICMS
--F4_DUPLIST	Duplicata ST	Gera Duplicata do ICMS ST
--F4_BCPCST	PS/CF ST BC	PS/CF ST Compoe BC ICM ST
--F4_DBSTCSL	Csll/Icm Ret	Csll/Icms Ret BC?
--F4_DBSTIRR	Irrf/Icm Ret	Irrf/Icms Ret BC?
--F4_CRICMS	Contr.ICMS	Controle Cred.ICMSArt.271
--F4_SOMAIPI	IPI Bs.ICMST	IPI Bas.Calc.ICMS-ST
--F4_PCREDAC	%Cr Acu ICMS	Perc Cred Acumul ICMS
--F4_PAUTICM	Paut.ICMS PP	Pauta ICMS Proprio
--F4_COMPRED	Cons.Red.Cmp	Cons. red. ICMS no comp.
--F4_TRFICST	Cons.ICMS ST	Considera o ICMS ST custo
--F4_MOTICMS	Mot.Desone.	Mot.Desone. ICMS
--F4_DIFAL	Calc. Difal	Calcula Difal ICMS
--F4_FTRICMS	Fat.Desc.ICM	Fator de Reducao Desc.ICM
--F4_CRLEIT	Art.488-MG	Trata Art.488 RICMS-MG
--F4_COLVDIF	Col ICMS Dif	Coluna ICMS Diferido
--F4_BICMCMP	Red.BCIC Com	Reduz ICMS Complementar



-- NF Saida Itens 
Select Distinct D2_TES
From SD2010
Where D2_FILIAL In('01','02') and D2_DOC In ('000207520','000368981')
and D_E_L_E_T_ =''


Select Distinct D2_COD
From SD2010
Where D2_FILIAL In('01','02') and D2_DOC In ('000207520','000368981')
and D_E_L_E_T_ =''


Select Distinct *
From SD2010
Where D2_FILIAL In('01','02') and D2_DOC In ('000207520','000368981')
and D_E_L_E_T_ =''


Select * From SF1010
Where F1_CHVNFE = '50230802544042000208550010001371771596667342'
and D_E_L_E_T_ =''



Select * From SA5010
Where A5_PRODUTO = 'MC20000040'
and D_E_L_E_T_ =''

--Estoques
Select * From SB1010
Where B1_COD = '2000000006I'
and D_E_L_E_T_ =''

--NF Entrada Itens
Select D1_DOC,D1_EMISSAO,D1_FILIAL,D1_CUSTO,D1_TES,D1_NFORI,D1_IDENTB6,* From SD1010
Where D1_DOC = '000076884'
And D1_EMISSAO >= '20230501'
and D_E_L_E_T_ =''

-- NF Saida Itens 
Select D2_DOC,D2_EMISSAO,D2_FILIAL,D2_CUSTO1,D2_TOTAL,(D2_TOTAL/D2_QUANT) CM,D2_PRUNIT,D2_QUANT,
D2_TES,D2_NFORI,D2_IDENTB6,*
From SD2010
Where D2_DOC In ('000129475','000129867','000129910')
And D2_EMISSAO >= '20230401'
and D_E_L_E_T_ =''


--NF Entrada Itens
Select D1_DOC,D1_EMISSAO,D1_FILIAL,D1_CUSTO,D1_TOTAL,(D1_TOTAL/D1_QUANT) CM,D1_VUNIT,D1_QUANT,
D1_TES,D1_NFORI,D1_IDENTB6,* From SD1010
Where D1_NFORI In ('000129475','000129910','000129867')
--And D1_EMISSAO >= '20230501'
and D_E_L_E_T_ =''



-- Estoque Terceiros 
Select B6_IDENT,B6_SALDO,
B6_CUSTO1,(B6_PRUNIT*B6_QUANT) TOTAL_CALC,B6_PRUNIT,(B6_CUSTO1/B6_QUANT)CM,
* From SB6010
Where B6_DOC In ('000076884','000129475')
And B6_EMISSAO >= '20230501'
and D_E_L_E_T_ =''
Order By 1




-- Movimentos Internos 
Select D3_CUSTO1,(D3_CUSTO1/D3_QUANT) AS D3_CM,D3_QUANT,
* From SD3010
Where D3_FILIAL In ('01') and D3_CF <> ''  and D3_EMISSAO Between '20240301' and '20240331' 
and D_E_L_E_T_ = '' and D3_ESTORNO = '' and D3_COD In ('ME01000250')
--And D3_DOC In ('000076766','000076767','000076884','000076885','000129475','000129867','000129910')
Order By  1  desc
-- D3_CUSTO1 -- Custos
-- D3_CF *Tipo de Requisicao/devolucao
-- D3_TM - Tipo Movimento
-- dbo.userlgi_normal (D3_USERLGI) - usuario


-- Saldos Iniciais
Select * From SB9010
Where B9_COD  In ('MOD300111','ME01000250')
And B9_DATA >= '20240201'
and D_E_L_E_T_ = ''

-- Estoques 
Select B2_QFIM,B2_QATU,B2_VFIM1,B2_VATU1,B2_CM1,* From SB2010
Where B2_COD In ('MOD300111','ME01000250')
and D_E_L_E_T_ = ''




--Inventario 
Select * From SB7010
Where B7_COD In ('ME01000250')
And B7_FILIAL = '01' 
And B7_DATA >= '20240330'
and D_E_L_E_T_ = ''

-- Produtos 
Select * From SB1010
Where B1_COD In ('MOD300111','ME01000250')
And  D_E_L_E_T_ = ''

--UM
Select * From SAH010
Where AH_UNIMED In ('ML','HR')
And  D_E_L_E_T_ = ''

Select D3_CUSTO1,(D3_CUSTO1/D3_QUANT) AS D3_CM,D3_QUANT,
* From SD3010
Where D3_FILIAL In ('01','02','03') and D3_CF <> ''  and D3_EMISSAO Between '20230501' and '20230530' 
and D_E_L_E_T_ = '' --and D3_COD = '2000000006I'
And D3_CUSTO1 In ('1133312.97')
Order By 1 desc



--NF Entrada
Select F1_DOC,F1_EMISSAO,F1_FILIAL,* From SF1010
Where F1_DOC = '000076884'
And F1_EMISSAO >= '20230501'
and D_E_L_E_T_ =''


-- NF Saida Itens 
Select F2_DOC,F2_EMISSAO,F2_FILIAL,* From SF2010
Where F2_DOC In ('000076884','000129475','000129867','000129910')
And F2_EMISSAO >= '20230401'
and D_E_L_E_T_ =''



-- Estoques
Select * From SB2010
Where B2_COD = '2000000006I'
and D_E_L_E_T_ =''


-- Saldos Iniciais 
Select * From SB9010
Where B9_COD = '2000000006I' and B9_DATA >= '20230401'
and D_E_L_E_T_ =''




-- Tipos de movimentação
Select * From SF5010
Where F5_CODIGO = '007' and D_E_L_E_T_ = ''

-- Contra Prova Contab.
Select * From CTK010

--Rastreamento Contab.
Select * From CV3010

-- Lançamentos Contab.
Select CT2_FILIAL,CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
* From CT2010
Where CT2_FILIAL = '01'
And CT2_DATA Between '20230601' and '20230601'
And CT2_KEY = '011  000355749   NF'
and D_E_L_E_T_ =''

--CABECA DE LOTE DE TRANSF. BENS
Select * From TRC01SP

Select * From SX2010
Where X2_CHAVE Like '%TRC%'





-- Lançamentos Contab.
Select CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
CTK_VLR01,CTK_HIST,CV3_VLR01,CV3_HIST,*
From CT2010 CT2 With(Nolock)

	-- Contra Prova Contab.
	Left Join CTK010 CTK With(Nolock)
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK_KEY = CT2_KEY
	And CTK_FILIAL = CT2_FILIAL
	And CTK_VLR01 = CT2_VALOR
	And CTK_ITEMC = CT2_ITEMC
	and CTK.D_E_L_E_T_ =''

	-- Rastreamento Contab.
	Left Join CV3010 CV3 With(Nolock)
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3_KEY = CT2_KEY
	And CV3_FILIAL = CT2_FILIAL
	And CV3_VLR01 = CT2_VALOR
	And CV3_ITEMC = CT2_ITEMC
	and CV3.D_E_L_E_T_ =' '


	--CABECA DE LOTE DE TRANSF. BENS
	Left Join TRC01SP TRC With(Nolock)
	On TRC_SEQUEN = CT2_SEQUEN
	and TRC.D_E_L_E_T_ =' '

	
Where CT2_FILIAL = '01'
And CT2_DATA Between '20230601' and '20230601'
--and CT2_KEY = '011  000355749   NF'
and CT2.D_E_L_E_T_ =''

Select * From FKW010

Select * From FKY010




-- Projeto Zica
--Aprovadores
Select * From SAK010

--Grupos de Compras
Select * From SAL010

--DBL - Entidades Contabeis X Grp Apr
Select * From DBL010

--Clasees de Valor 
Select * From CTH010

--DHM - Tipo de Compra X Aprovador
Select * From DHM010

-- SRS - Alçadas de Aprovação 
Select * From SCR010

--Saldos Aprovadores 
Select * From SCS010

-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_APRPCEC','MV_ALTPDOC')

Select * From SYS_USR
Where USR_CODIGO = 'RAFAEL'

--Grupo de Compras
Select * From SAJ010
Where AJ_USER = '000000'

--Estoque
Select B2_QPEDVEN,* From SB2010
Where Len(B2_QPEDVEN) > 12
Order By 1 Desc

Select * From SA1010
Where A1_CGC In (' 51818848000163')
And D_E_L_E_T_ =''


-- PC
Select C7_FILIAL,Count(C7_NUM) As QTDE From SC7010
Where C7_FILIAL In ('01','02','03')
And C7_EMISSAO >= '20230101'
And D_E_L_E_T_ =''
Group By C7_FILIAL



--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
* From SPED050
Where NFE_ID In ('1  000374258') and DATE_NFE >= '20230101' and D_E_L_E_T_ = ''

--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where NFE_ID In ('1  000374257') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''


-- PV - Itens 
Select C6_NUM,C6_SEMANA,C6_ITEMPC,C6_NUMPCOM,C6_ITPDCLI,Len(C6_ITPDCLI)C6_ITPDCLI_TAM, * From SC6010
Where C6_FILIAL = '01' And C6_ITPDCLI <> '' and D_E_L_E_T_ = ''
and Len(C6_ITPDCLI) > 6

-- Campos 
Select * From SX3010
Where X3_CAMPO = 'C6_ITPDCLI'

Select B6_IDENT,* From SB6010
Where B6_PRODUTO = 'MC07000032' --and B6_SALDO > 0
And D_E_L_E_T_ =''
Order By 1



-- Bancos 
Select * From SA6010
Where A6_COD In ('001') and D_E_L_E_T_ =''

-- Contas a receber 
Select * From SE1010
Where E1_NUMBCO = '26855926232518040'
And D_E_L_E_T_ =''

--Tab. Genericas 
Select * From SX5010
Where X5_TABELA = 'ZW'


--SEE - Comunicacao Remota
Select * From SEE010
Where EE_CODIGO = '001'

--FI0 - Cabec Log Processamento CNAB
Select * From FI0010 
Where FI0_IDARQ = 'A876918309'
And D_E_L_E_T_ =''

--FI1 - Detalhe do Log Processamento
Select * From FI1010 
Where FI1_IDARQ  In ('A876918309')
And D_E_L_E_T_ =''

--FI2 Ocorrências CNAB
Select * From FI2010

--FOQ - CADASTRO DE ARQUIVOS CNAB
Select * From FOQ010



-- NF Entrada Cb.
Select F1_GF,* From SF1010
Where F1_CHVNFE In ('35230951254159000173550010010636681350649520','35230951254159000173550010010630881233774913')
and D_E_L_E_T_ = ''
Order By F1_EMISSAO

--Campos 
Select * From SX3010
Where X3_CAMPO = 'F1_GF'
and D_E_L_E_T_ = ''



-- PV Itens 
Select * From SC5010
Where C5_NUM In ('399456')
And D_E_L_E_T_ =' '



-- Etiquetas de Bobinas
Select ZE_RESERVA,ZE_CTRLE,* From SZE010
Where ZE_PEDIDO In ('399456') and D_E_L_E_T_ = ''

-- PV Liberados 
Select * From SC9010
Where C9_PEDIDO In ('399456')
And D_E_L_E_T_ =' '



-- Pesagem 
Select * From SZL010
Where ZL_NUMBOB In ('2258458','2259615')
And D_E_L_E_T_ =' '

--VOLUMES DAS NOTAS FISCAIS     
Select * From SZN010
Where ZN_PEDIDO >= '399456'
And D_E_L_E_T_ =' '


--Produto 
Select B1_MSBLQL,* From SB1010
Where B1_COD = 'MC20000002'
And D_E_L_E_T_ =' '

-- Fornecedor 
Select A2_MSBLQL,* From SA2010
Where A2_COD = '000002'
And D_E_L_E_T_ =' '



--PC 
Select C7_FILIAL,Count(C7_NUM) QTDE From SC7010
Where C7_EMISSAO >= '20230101'
and D_E_L_E_T_ = ''
Group By C7_FILIAL

-- Cidades 
Select * FRom CC2010
Where D_E_L_E_T_ = ''

-- Contas a pagar	
Select Distinct E2_TIPO, E2_PREFIXO From SE2010
Where D_E_L_E_T_ = ''
Order By 1

Select * From SE2010
Where E2_TIPO = 'FOL' and D_E_L_E_T_ = ''

-- ProdutoxCliente 
Select * From SA7010
Where A7_CLIENTE = '026104' and A7_LOJA = '02' and A7_PRODUTO = '1320104401'
And D_E_L_E_T_ = ''

--INCABPP2V0.50PV - CABO PP 2 VIAS 0.50MM AZUL/PRET EM PVC E>70 GRAUS(B02000)
--INCABPP2V0.50PV - CABO PP 2 VIAS 0.50MM AZUL/PRET EM PVC E>70 GRAUS 

-- Clientes 
Select A1_XCLICOD,A1_XTRCCOD,* From SA1010
Where A1_CGC = '22085520000268'
And D_E_L_E_T_ = ''

-- Produtos 
Select B1_DESC,* From SB1010
Where B1_COD = '1320104401'  
And D_E_L_E_T_ = ''

-- NF Saida Itens
Select * From SD2010
Where D2_DOC = '000365092'
And D_E_L_E_T_ = ''

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_CLNFPRO'




-- Produtos - Ativo no portal ou nao 
--S=Sim;N=Nao;E=Especial                                                                                                          
SELECT B1_XPORTAL,* FROM SB1010 
WHERE B1_COD IN ('3671004501','3671104501','3671204501','3671304501')     
and D_E_L_E_T_ = ''


-- Campos 
Select * From SX3010
Where X3_CAMPO In ('B1_XPORTAL','B1_MSBLQL','B1_QB','B1_BLQVEN')


Select * From SZ1010
Order By Z1_COD

Select * From ZP6010

/*        Cabo HEPR TS 1x25mm²
3671104501        Cabo HEPR TS 1x35mm²
3671204501        Cabo HEPR TS 1x50mm²
3671304501        Cabo HEPR TS 1x70mm²*/

-- NF Saida Itens 
Select D2_DOC,* From SD2010
Where D2_FILIAL = '01' and D2_DOC = '000375094' 
and D_E_L_E_T_ =''


-- NF Saida Cab. 
Select F2_DOC,* From SF2010
Where F2_FILIAL = '01' and F2_DOC = '000375094' 
and D_E_L_E_T_ =''




--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
* From SPED050
Where NFE_ID In ('1  000375094') and DATE_NFE >= '20230101' and D_E_L_E_T_ = ''

--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where NFE_ID In ('1  000375094') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''


--Lotes de Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_LOTE)),'') AS [XML_LOTE],
LOTE,* From SPED052
Where LOTE In ('000000000082880','000000000082883','000000000082884')
and D_E_L_E_T_ = ''


/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/


--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where LOTE In ('000000000082880','000000000082883','000000000082884') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''

Select * From SX6010
Where X6_VAR = 'MV_TAFVLRE'




Select * From SX2010
Where X2_CHAVE = 'ZZF'

--SZE -> Tabela de Bobinas
Select * From SZE010
Where ZE_FILIAL In ('01') and ZE_NUMBOB In ('2259930') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')


--SZL > Controle de 
Select * From SZL010
Where ZL_FILIAL In ('01') and D_E_L_E_T_ ='' and ZL_NUMBOB = '2259930'

 





Select * From SZK010

select * from SCJ010




--Parametros 
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_CREDCLI')
And D_E_L_E_T_ =' '

Select *From ZZ1010

--FK1 – Baixas a Receber
Select * From FK1010



-- Contas a Receber 
Select E1_FILIAL, E1_CLIENTE, E1_NOMCLI,E1_NUM,E1_TIPO,Sum(E1_VALOR) AS TOTAL, Count(E1_PARCELA) As Parcelas, 
(Sum(E1_VALOR)-Sum(E1_VALLIQ)) As Saldo, SUM(E1_VALLIQ)-Sum(E1_VALOR) As Diferenca, Sum(E1_SALDO) As Saldo_,

	Case 
	When E1_VENCTO < '20230926' and E1_BAIXA ='' And E1_SALDO > '0' and D_E_L_E_T_ ='' 
	Then Sum(E1_SALDO)
	End As Vencido,

	Case 
	When E1_VENCTO >= '20230927' and E1_BAIXA ='' And E1_SALDO > '0' and D_E_L_E_T_ ='' 
	Then Sum(E1_SALDO)
	End As Vencer 

From SE1010

Where E1_FILIAL In ('01','02','03') and D_E_L_E_T_ ='' 
And E1_BAIXA ='' And E1_SALDO > '0' and E1_EMISSAO >= '20100101'
And E1_CLIENTE In ('031622')
Group By E1_FILIAL,E1_CLIENTE,E1_NOMCLI,E1_NUM,E1_TIPO,E1_VENCTO,E1_BAIXA,D_E_L_E_T_,E1_SALDO



-- Contas a Receber 
Select Distinct  E1_CLIENTE, E1_NOMCLI,Sum(E1_VALOR) AS TOTAL,  
(Sum(E1_VALOR)-Sum(E1_VALLIQ)) As Saldo, SUM(E1_VALLIQ)-Sum(E1_VALOR) As Diferenca, Sum(E1_SALDO) As Saldo_,

	Case 
	When E1_VENCTO < '20230926' and E1_BAIXA ='' And E1_SALDO > '0' and D_E_L_E_T_ ='' 
	Then IsNull(Sum(Case When E1_SALDO <> Null or E1_SALDO <> '' Then E1_SALDO Else 0 End),'0')
	End As Vencido,

	Case 
	When E1_VENCTO >= '20230927' and E1_BAIXA ='' And E1_SALDO > '0' and D_E_L_E_T_ ='' 
	Then Sum(E1_SALDO)
	End As Vencer 


From SE1010
Where E1_FILIAL In ('01','02','03') and D_E_L_E_T_ ='' 
And E1_BAIXA ='' And E1_SALDO > '0' and E1_EMISSAO >= '20100101'
And E1_CLIENTE Between ('031730') and ('031730')
Group By E1_CLIENTE,E1_NOMCLI,E1_VENCTO,E1_BAIXA,E1_SALDO,D_E_L_E_T_









--Considera a tabela 63(SX5) e ZV(SX5), os sabados caso MV_SABFERI = 'S' 

-- Genericos  
Select * From SX5010
Where X5_TABELA In ('63','ZV')
and D_E_L_E_T_ ='' 

--Apmto.Producao e Paradas      
Select * From SZV010
Where ZV_DTAPONT >= '20230101'
and D_E_L_E_T_ ='' 

-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_SABFERI','MV_IFCPRZ9')
and D_E_L_E_T_ =''


-- PV 
Select C5_ENTREG,C5_EMISSAO,C5_DTLICRE, DATEDIFF(Day,C5_DTLICRE,C5_ENTREG) As DIF_DIAS,
	Case
	When DatePart(DW,C5_ENTREG ) = '1' Then 'DOMINGO'
	When DatePart(DW,C5_ENTREG ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA_ENT,

	Case
	When DatePart(DW,C5_DTLICRE ) = '1' Then 'DOMINGO'
	When DatePart(DW,C5_DTLICRE ) = '7' Then 'SABADO'
	ELSE 'DIA_UTIL'
	End As DIA_SEMANA_LIBCRED,

* From SC5010
Where DatePart(DW,C5_ENTREG ) In ('1','7')
And C5_DTLICRE >= '20220101'
and D_E_L_E_T_ =''
Order By 4 Asc

-- PV Itens
Select C6_ENTREG,C6_DATCPL,C6_DATFAT,C6_XOPER,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), C6_VDOBS)),'')As C6_VDOBS,
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

* From SC6010
Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '202201101'
and D_E_L_E_T_ =''
Order By 2 Asc

-- PV Liberados 
Select C9_DATENT,DatePart(DW,C9_DATENT ) As DIA_SEMANA,C9_DATALIB,
	Case
	When DatePart(DW,C9_DATENT ) = '1' Then 'DOMINGO'
	When DatePart(DW,C9_DATENT ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA2,
* From SC9010
Where DatePart(DW,C9_DATENT ) In ('1','7')
And C9_DATALIB >= '20230101'
and D_E_L_E_T_ =''
Order By 2 Asc



-- PV Itens
Select C6_ENTREG,C6_DATCPL,C6_DATFAT,Z9_DTENTR,DatePart(DW,Z9_DTENTR )Z9_DTENTR, C6_XOPER,C5_OBS,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), C6_VDOBS)),'')As C6_VDOBS,
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
	ELSE 'ANALISAR'
	End As DIA_SEMANA_SZ9,

* From SC6010 SC6

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
	
Where DatePart(DW,C6_ENTREG ) In ('1','7')
And C6_DATCPL >= '202309101'
and SC6.D_E_L_E_T_ =''
Order By 2 Asc

--COMPLEMENTO DA OP             
Select Z9_DTENTR,

Case
	When DatePart(DW,Z9_DTENTR ) = '1' Then 'DOMINGO'
	When DatePart(DW,Z9_DTENTR ) = '7' Then 'SABADO'
	ELSE 'ANALISAR'
	End As DIA_SEMANA_SZ9,

* From SZ9010
Where DatePart(DW,Z9_DTENTR ) In ('1','7')
And Z9_DTENTR >= '202301101'
and D_E_L_E_T_ =''

-- NF Saida Itens * Produto NCM 
Select B1_POSIPI,* From SD2010 SD2
Inner Join SB1010 SB1
On B1_COD = D2_COD
And SB1.D_E_L_E_T_ =''

Where D2_DOC = '000006011' and D2_FILIAL = '03'
and SD2.D_E_L_E_T_ =''

Select * From RGB010




    

--CDA - Lancamentos documento fiscal
Select * From CDA010

-- CC7 - AMARRACAO TES X LANC. APUR.
Select * From CC7010

--CC6 - LANCAMENTOS APURACAO DO ICMS
Select * From CC6010
Where CC6_STUF In ('SP') or CC6_CODLAN = 'SP90090104'
and D_E_L_E_T_ =''

--CE0 - REFLEXO LANCAMENTO NF
Select * From CE0010

--CCE - Informacoes complementares
Select * From CCE010


--SFX - Complemento de comun/telecom
Select * From SFX010

-- TES
Select * From SF4010

--Apuração de ICMS (MATA953 - Tabela CDH)
Select * From CDH010
Where CDH_DTINI >= '20230901' and CDH_DTFIM <= '20230930'
and D_E_L_E_T_ =''
Order By CDH_FILIAL,CDH_TIPOIP,CDH_SEQUEN,CDH_LINHA

--Apuração de IPI (MATA952 - Tabela CDP) 
Select * From CDP010
Where CDP_DTINI >= '20230901' and CDP_DTFIM <= '20230930'
and D_E_L_E_T_ =''
Order By CDP_FILIAL,CDP_TIPOIP,CDP_SEQUEN,CDP_LINHA


--Informações adicionais da Apuração (MATA017 - Tabela CDV - tag cBenef).
Select * From CDV010
Where CDV_PERIOD >= '20230901' and CDV_PERIOD <= '20230930'
and D_E_L_E_T_ =''
Order By CDV_FILIAL,CDV_PERIOD,CDV_SEQ





-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_TAFVLRE','MV_SPDTC95')

--Genericas
Select Distinct X5_TABELA,Count(X5_TABELA) From SX5010
Where X5_DESCRI Like ('%ICMS%')
Group By X5_TABELA

Select A1_LC,A1_MSALDO,* From SA1010
Where A1_LC > 0
and D_E_L_E_T_ =''
Order By 1





--T95 - Ret Contrib Prev - Serv Tomad
Select * From T95010
Where T95_PERAPU In ('082023') and T95_CODPAR In ('FV008L201')
and D_E_L_E_T_ =''

--T96 - Detalhamento de NFS
Select * From T96010
Where T96_ID = '9968a52c-4843-043c-26b8-8fd5abe4df23'
and D_E_L_E_T_ =''


--T97 - Tipos de Serviços NF
Select * From T97010
Where T97_ID = '9968a52c-4843-043c-26b8-8fd5abe4df23'
and D_E_L_E_T_ =''


--C20 - Capa do Documento Fiscal
Select C20_CODCTA,* From C20010
Where C20_CODPAR = '86cf815b-e039-a13d-3b41-626ec7b0bac8' and C20_NUMDOC In ('9743','9785')                                       
and D_E_L_E_T_ = ''

--C21 - Informacoes Compl de Doc Fis
Select  * From C21010
Where C21_CHVNF In ('000000000202433','000000000202442')                                 
and D_E_L_E_T_ = ''

--C29 - Faturas
Select  * From C29010
Where C29_CHVNF In ('000000000202433','000000000202442')  and C29_NUMTIT In ('9743','9785')                                       
and D_E_L_E_T_ = ''

--C2F - Tributos Capa Documento Fiscal
Select * From C2F010
Where C2F_CHVNF In ('000000000202433','000000000202442')                                        
and D_E_L_E_T_ = ''


-- C30 - Itens do Documento Fiscal  
Select C30_CTACTB,C30_CODITE,* From C30010
Where C30_CHVNF In ('000000000202442','000000000202433') and C30_CTACTB = '5a4b3eb1-0d99-8865-9586-cc517a932d06'
and D_E_L_E_T_ =''

--C35 - Trib Itens Documento Fiscal  
Select * From C35010
Where C35_CODITE = 'ff973080-d4b8-0063-9734-4113a83581cb' and C35_CHVNF In ('000000000202442','000000000202433')
and D_E_L_E_T_ =''



--C1H - Participantes
Select * From C1H010
Where C1H_ID = '86cf815b-e039-a13d-3b41-626ec7b0bac8'

--V0C - Inf. Bases e Trib. consolidado
Select * From V0C010
Where V0C_PERAPU = '082023'
and D_E_L_E_T_ =''

--V0D - Ocorrencias Registradas
Select * From V0D010
Where D_E_L_E_T_ =''

--V0E - Informacoes Consolidadas
Select * From V0E010
Where V0E_ID = 'fb7831dc-f914-abe2-d1bc-b6d309cb37f3'

--V0E - Informacoes Consolidadas
Select * From V0W010
Where V0W_PERAPU = '082023' and V0W_CNPJ10 = '09136712000107'
And D_E_L_E_T_ =''

-- Centro de Custo 
Select CTT_FPAS,CTT_CODTER,* From CTT010

-- Empresas 
Select M0_FPAS,* From SYS_COMPANY

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_TAFVLRE'

-- NF Entrada Itens - Retenção IRRF
Select Distinct D1_BASEIRR,D1_ALIQIRR,D1_VALIRR,D1_DOC,D1_FILIAL,D1_FORNECE,D1_LOJA,A2_NOME,
* From SD1010 SD1
	
		Inner Join SF1010 SF1
		On F1_FILIAL = D1_FILIAL
		And F1_DOC = D1_DOC
		And F1_LOJA = D1_LOJA
		And F1_FORNECE = D1_FORNECE
		And F1_LOJA = D1_LOJA
		And SF1.D_E_L_E_T_ =''

		Inner Join SA2010 SA2
		On A2_COD = D1_FORNECE
		And A2_LOJA = D1_LOJA
		And SA2.D_E_L_E_T_ =''

Where D1_EMISSAO Between '20230901' And '20230930' and D1_VALIRR > 0 And D1_BASEIRR > 0 And D1_ALIQIRR >0 
And SD1.D_E_L_E_T_ =''
Order By 6,7,4


-- Contas a Pagar 
Select * From SE2010
Where E2_EMISSAO >= '20230901' And E2_IRRF > 0
And D_E_L_E_T_ =''

Select * From SE2010
Where E2_EMISSAO >= '20230901' And E2_TIPO In ('TX') 
And D_E_L_E_T_ =''




--D1_BASEIRR	Base de IRRF	Base de calculo do IRRF	
--D1_ALIQIRR	Aliq. IRRF	Aliquota de IRRF	
--D1_VALIRR	Valor IRRF	Valor do IRRF




--SC 
Select C1_EMISSAO,C1_FILIAL, C1_PRODUTO, C1_PEDIDO, C1_COTACAO, C1_NUM, C1_FORNECE, C1_LOJA, * From SC1010
Where C1_FILIAL = '01' and C1_NUM In('148159','149160')  and D_E_L_E_T_ = ''


--Cotações
SELECT C8_TXMOEDA,C8_MOEDA,C8_EMISSAO,C8_FILIAL, C8_PRODUTO, C8_NUMPED,C8_NUM,C8_NUMSC, C8_FORNECE, C8_LOJA, * FROM SC8010 
WHERE C8_FILIAL In ('01','02','03') AND C8_TXMOEDA = '0'  and C8_MOEDA = '2' AND D_E_L_E_T_='' 


-- Moedas 
Select * From SM2010
Where M2_DATA >= '20231001'
and D_E_L_E_T_ = ''

-- Parametros 
Select * From SX6010
Where X6_VAR Like ('%ZZ_CMPNATN%') Or X6_VAR Like ('%ZZ_SCKMURL%')
and D_E_L_E_T_ = ''

-- PC
Select * From SC7010
where C7_NUM In ('013220')
and D_E_L_E_T_ = ''

-- Sys Company
Select * From SYS_COMPANY

-- Generica 
Select * From SX5010
Where X5_TABELA = '13' and X5_CHAVE = '5102'
and D_E_L_E_T_ = ''




-

Select * From SX2010
Where X2_CHAVE = 'ZZE'

Select  * From SX3010
Where X3_ARQUIVO = 'ZZE'

--Movimentos Internos 
Select D3_LOCALIZ,* From SD3010
Where D3_COD = '1190602401' and D3_EMISSAO = '20230930' and D3_DOC = 'DESMONT'
and D_E_L_E_T_ =''




-- Clientes 
Select * From SA1010
Where A1_COD In ('014236','008918') and A1_LOJA = '01' 
and D_E_L_E_T_ =''


-- /*----SDC - Composicao do Empenho
Select * From SDC010
Where DC_PRODUTO = '1530404423' and DC_LOCALIZ = 'R00100'
and D_E_L_E_T_ =''


--AAAX({5256207,7615440})

Select * From SE4010


-- PV Itens
Select C6_PRODUTO,B1_XPORTAL,B1_BOBINA,B1_ROLO,B1_CARRETE,B1_CARMAD,C6_QTDVEN,C6_LANCES,C6_METRAGE,C6_ACONDIC,C6_NOTA,C6_DATFAT,

	--Verifica Tipo de Acondicionamento 
	Case 
	When C6_ACONDIC = 'B' Then 'BOBINA'
	When C6_ACONDIC = 'R' Then 'ROLO'
	When C6_ACONDIC = 'C' Then 'CARRETEL PLASTICO'
	When C6_ACONDIC = 'M' Then 'CARRETEL MADEIRA'
	When C6_ACONDIC = 'L' Then 'BLISTER'
		Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA ou Carretel
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA 
	Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When C6_ACONDIC = 'C' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_CARRETE 
	Then '*******ANALISAR METRAGEM MÁXIMA CARRETEL PLASTICO*******'
	When C6_ACONDIC = 'M' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_CARMAD
	Then '*******ANALISAR METRAGEM MÁXIMA CARRTEL MADEIRA*******'
	When C6_ACONDIC = 'L' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******ANALISAR METRAGEM MÁXIMA BLISTER*******'

	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	When C6_ACONDIC = 'C' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_CARRETE 
	Then 'METRAGEM MÁXIMA CARRETEL PLASTICO VÁLIDA'
	When C6_ACONDIC = 'M' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_CARMAD 
	Then 'METRAGEM MÁXIMA CARRETEL MADEIRA VÁLIDA'
	When C6_ACONDIC = 'L' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA BLISTER VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'C' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_CARRETE 
	Then '*******VERIFICAR CADASTRO PRODUTO CARRETEL PLASTICO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'M' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_CARMAD 
	Then '*******VERIFICAR CADASTRO PRODUTO CARRETEL MADEIRA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'L' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO BLISTER MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	
	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA BOBINA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'C' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_CARRETE 
	Then 'METRAGEM MÁXIMA CARRETEL PLASTICO NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'M' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_CARMAD 
	Then 'METRAGEM MÁXIMA CARRETEL MADEIRA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'L' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA BLISTER NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	Else 'VERIFICAR'
	End AS RECOMENDACAO,


C5_LUCROBR
From SC6010 SC6

	--Produtos
	Inner Join SB1010 SB1
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	--Produtos
	Inner Join SC5010 SC5
	On C5_NUM = C6_NUM
	And C5_FILIAL = C6_FILIAL 
	And SC5.D_E_L_E_T_ = ''



Where C6_FILIAL = '02' and C6_NUM In ('107984')
And C6_NOTA = '' and C6_DATFAT = ''
And SC6.D_E_L_E_T_ = ''
Order By 13,12





--PV Itens 
Select * From SC5010
Where C5_FILIAL = '02'And C5_NUM In ('104211')
and D_E_L_E_T_ = ''
Order By 1


--PV Itens 
Select C6_ITEMIMP,C6_LANCES,C6_NUM,C6_QTDVEN,C6_QTDENT,C6_SEMANA,(C6_QTDVEN - C6_QTDENT) As SALDO, C6_QTDEMP,C6_DATFAT,C6_NOTA,C6_ITEM,* From SC6010
Where C6_FILIAL = '02' and C6_PRODUTO Like ('%1091104201%') and C6_NUM In ('104211')
and D_E_L_E_T_ = ''
Order By 1


-- PV Liberados 
Select * From SC9010
Where C9_FILIAL = '02' And C9_PRODUTO = '1091104201' And C9_PEDIDO In ('104211')
And D_E_L_E_T_ =' '

---- Etiquetas de Bobinas
Select ZE_SITUACA,* From SZE010
Where ZE_PRODUTO In ('1091104201') and ZE_PEDIDO In ('000001')
And ZE_NUMBOB = '2268974'
--And ZE_CLIENTE In ('043796','023162')
and ZE_STATUS Not in  ('F','C')
and D_E_L_E_T_ = ''
--I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 



                                                



--COMPLEMENTO DA OP             
Select Z9_IMPETIQ,Z9_ETIQIMP,Z9_PEDIDO,Z9_ITEMPV, Z9_QTDETQ ,
* From SZ9010 SZ9

Where Z9_FILIAL = '02' And  Z9_PRODUTO Like ('%1091104201%') and Z9_SALDO > 0 and Z9_PEDIDO In ('104211')
And SZ9.D_E_L_E_T_ ='' 



--PRODUTO FORA PCP              
Select * From ZZD010
Where ZZD_COD = '1091104201'
and D_E_L_E_T_ =''


-- Validação Troca Etiqueta 
-- SZ9 x SC6 
-- SZ9 - Complemento da OP
-- SC6 - Pedido de Vendas Item 
Select Z9_IMPETIQ,Z9_ETIQIMP,Z9_QTDETQ,C6_LANCES,C6_ITEMIMP,Z9_PEDIDO,Z9_ITEMPV,

	Case 
	When Z9_QTDETQ >= C6_LANCES Or  Z9_ETIQIMP >= C6_LANCES
	Then 'xxxErroxxx'
	Else '***OK***'
	End As Status_

From SZ9010 SZ9

	Inner Join SC6010 SC6
	On C6_FILIAL = Z9_FILIAL
	And SubString(C6_PRODUTO,1,10) = Z9_PRODUTO
	And C6_NUM = Z9_PEDIDO
	And SC6.D_E_L_E_T_ = ''

Where Z9_FILIAL = '02' And  Z9_PRODUTO Like ('%1091104201%')  and Z9_PEDIDO In ('104211')
And SZ9.D_E_L_E_T_ ='' 

--Z9_QTDETQ >= C6_LANCES ou Z9_ETIQIMP >= C6_LANCES - C6_ITEMIMP


-- Validação Troca Etiqueta 
-- SC6 x SZ9 
-- SC6 - Pedido de Vendas Item 
-- SZ9 - Complemento da OP
Select Distinct C6_PRODUTO,Z9_IMPETIQ,Z9_ETIQIMP,Z9_QTDETQ,C6_LANCES,C6_ITEMIMP,C6_ITEM,Z9_ITEMPV,
C6_NUM,Z9_PEDIDO,C6_QTDVEN,C6_QTDENT,C6_SEMANA,
(C6_QTDVEN - C6_QTDENT) As SALDO, C6_QTDEMP,C6_DATFAT,C6_NOTA,

	Case 
	When Z9_QTDETQ >= C6_LANCES Or  Z9_ETIQIMP >= C6_LANCES
	Then 'xxxErroxxx'
	Else '***OK***'
	End As Status_


From SC6010 SC6

	Inner Join SZ9010 SZ9
	On Z9_FILIAL = C6_FILIAL
	And Z9_PRODUTO = SubString(C6_PRODUTO,1,10)
	And Z9_PEDIDO = C6_NUM	
	And SZ9.D_E_L_E_T_ = ''


Where C6_FILIAL = '02' and C6_PRODUTO Like ('%1091104201%') and C6_NUM In ('104211')
and SC6.D_E_L_E_T_ = '' And Z9_IMPETIQ = 'S'
Order By 1
--Z9_QTDETQ >= C6_LANCES ou Z9_ETIQIMP >= C6_LANCES - C6_ITEMIMP

--DKD - Complemento Itens da NF
Select * From DKD010


--ENTRADAS PARA RETRABALHO      
Select * From ZZU010


     
                            


Select * From SX2010
Where X2_CHAVE In ('ZZE','ZZF','ZZU')

Select * From SX3010
Where X3_CAMPO In ('ZZE_STATUS','ZZE_SITUAC','ZZF_STATUS')
Select * From SC5010




Select C6_FILIAL,C6_PRODUTO,C6_ITEM,Sum(C6_QTDVEN) AS QT_VENDAS, Sum(C6_QTDLIB) As LIB
From SC5010 SC5
	Inner Join SC6010 SC6
	On C6_FILIAL = C5_FILIAL
	And C6_NUM = C5_NUM
	And SC6.D_E_L_E_T_ = ''
	   
Where C6_FILIAL = '01' and C6_NUM = '405408'
And C6_ITEM Between '01' and '99'
And SC5.D_E_L_E_T_ = ''
Group By C6_FILIAL,C6_PRODUTO,C6_ITEM



Select Sum(C6_QTDVEN) AS QT_VENDAS, Sum(C6_QTDLIB) As LIB
From SC5010 SC5
	
	Inner Join SC6010 SC6
	On C6_FILIAL = C5_FILIAL
	And C6_NUM = C5_NUM
	And SC6.D_E_L_E_T_ = ''

	Inner Join SC9010 SC9
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''
	   
Where C6_FILIAL = '01' and C6_NUM = '405408'
And C6_ITEM Between '01' and '99'
And SC5.D_E_L_E_T_ = ''
Group By C6_FILIAL



Select TESTES = (Select Sum(C6_QTDVEN) TOTAL_VEND 
				 From SC6010 SC6
				 Where C6_FILIAL = '01' and C6_NUM >= '405408'
				 And SC6.D_E_L_E_T_ = '')
				
From SC6010 SC6
Where C6_FILIAL = '01' and C6_NUM >= '405408'
And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C6_NUM,C6_PRODUTO,C6_ITEM




Select C5_FILIAL,C5_NUM,Sum(C6_QTDVEN) TOTAL_VEND,C5_TOTAL 
From SC5010 SC5
		
		Inner Join SC6010 SC6
		On C6_FILIAL = C5_FILIAL
		And C6_NUM = C5_NUM
		And SC6.D_E_L_E_T_ = ''

Where C5_FILIAL = '01' and C5_NUM = '405408'
And SC5.D_E_L_E_T_ = ''
Group By C5_FILIAL,C5_NUM,C5_TOTAL


Select C6_QTDVEN,C6_QTDLIB,C9_QTDLIB,* From SC6010 SC6

	Inner Join SC9010 SC9
	On C9_FILIAL = C6_FILIAL
		And C9_PEDIDO = C6_NUM
		And C9_PRODUTO = C6_PRODUTO
		And C9_ITEM = C6_ITEM
		And SC9.D_E_L_E_T_ = ''
			   
Where C6_FILIAL = '01' and C6_NUM >= '0000000'
--And C5_EMISSAO >= '20231001'
And C6_QTDVEN <> C9_QTDLIB
And SC6.D_E_L_E_T_ = ''


Select Count(C6_QTDVEN) AS QT_VENDAS, Count(C6_QTDLIB) As LIB
From SC6010 SC6

where C6_FILIAL = '01' and C6_NUM = '405408'
And D_E_L_E_T_ = ''

Select C6_QTDVEN,C6_QTDLIB
From SC6010 SC6

where C6_FILIAL = '01' and C6_NUM = '405408'
And D_E_L_E_T_ = ''


Select * From SC5010 SC5
Where C5_FILIAL = '01' and C5_NUM = '405408'
And SC5.D_E_L_E_T_ = ''



-- NF Entarda  Cab.
Select F1_CHVNFE,D_E_L_E_T_,* From SF1010 With(Nolock)
Where F1_CHVNFE In ('35231102544042000119550010003803061451671351')
And D_E_L_E_T_ = ''
Order By F1_DOC

-- NF Saida Itens
Select D1_TES,* From SD1010
Where D1_FILIAL = '02' and D1_DOC In ('000380306') 
and D_E_L_E_T_ = ''

--TES
Select * From SF4010
Where F4_CODIGO = '038'
and D_E_L_E_T_ = ''

-- Mov. Internas 
Select * From SD3010
where D3_FILIAL = '02' and D3_COD In ('MR01000002')
--And D3_EMISSAO >= 
--and D3_DOC = '000380306'
and D_E_L_E_T_ = ''

--Estoque 
Select B2_FILIAL,B2_COD,B1_DESC,B2_QATU,* From SB2010 SB2

	Inner Join SB1010 SB1
	On B1_COD = B2_COD
	And SB1.D_E_L_E_T_ = ''
	
Where B2_COD In ('MR01000002') and B2_FILIAL = '02'
and SB2.D_E_L_E_T_ = ''






--Nota Fiscal Eletrônica
Select STATUS,STATUSCANC,STATUSMAIL,DOC_CHV,LOTE,* From SPED050
Where NFE_ID In ('1  000135050') and DATE_NFE >= '20230701' and D_E_L_E_T_ = ''

--Lotes de Nota Fiscal Eletrônica
Select LOTE,* From SPED052
Where LOTE In ('000000000035355')
and D_E_L_E_T_ = ''


--Lotes X Nota Fiscal Eletrônica
Select LOTE,* From SPED054
Where NFE_ID In ('1  000135050') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''

/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/



--Processamento de NF TSS
Select * From TSSTR1  
Where D_E_L_E_T_ = ''

-- Genericos 
Select * From SX5010
Where X5_TABELA In ('13')
And D_E_L_E_T_ = ''
Order By  X5_CHAVE

Select * From SC7010

Select * From SC1010

Select * From SC8010 

Select * From SCR010
Select * From DBM010

--Analise SC-PC-COT 
Select C7_FILIAL, C7_NUM, C7_ITEM,C1_EMISSAO,C8_EMISSAO,C7_EMISSAO,
DateDiff(Day,C1_EMISSAO,C8_EMISSAO) As DIAS_SCxCOT,
DateDiff(Day,CR_EMISSAO,CR_DATALIB) As DIAS_SCR_LIB_EMISSAO,
DateDiff(Day,C8_EMISSAO,CR_DATALIB) As DIAS_LIB_EMISSAO,
* From SC7010 SC7	   	 

	Inner Join SC8010 SC8 -- COTACAO
	On C8_FILIAL = C7_FILIAL
	And C8_NUMPED = C7_NUM
	And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Inner Join SC1010 SC1 --Solicitçao PC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''
	
	Inner Join SCR010 SCR -- Aprovacao PC 
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_STATUS In ('03','05')
	And SCR.D_E_L_E_T_ = ''

Where C7_FILIAL = '01' and C7_EMISSAO Between '20231001' and '20231031'
And C7_CONAPRO  = 'L'
And SC7.D_E_L_E_T_ = ''
Order By 8
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.




--Analise SC-PC-COT 
Select C7_FILIAL,C7_NUM,
DateDiff(Day,C1_EMISSAO,C8_EMISSAO) As DIAS_SCxCOT,
DateDiff(Day,CR_EMISSAO,CR_DATALIB) As DIAS_SCR_LIB_EMISSAO,
DateDiff(Day,C8_EMISSAO,CR_DATALIB) As DIAS_LIB_EMISSAO
From SC7010 SC7	   	 

	Inner Join SC8010 SC8 -- COTACAO
	On C8_FILIAL = C7_FILIAL
	And C8_NUMPED = C7_NUM
	--And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Inner Join SC1010 SC1 --Solicitçao PC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	--And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''
	
	Inner Join SCR010 SCR -- Aprovacao PC 
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_STATUS In ('03','05')
	And SCR.D_E_L_E_T_ = ''

Where C7_FILIAL = '01' and C7_EMISSAO Between '20231001' and '20231031'
And C7_CONAPRO  = 'L'
And SC7.D_E_L_E_T_ = ''
Group By C7_FILIAL,C7_NUM,C1_EMISSAO,C8_EMISSAO,CR_EMISSAO,CR_DATALIB
Order By 4
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.



Select 
AVG(DateDiff(Day,C1_EMISSAO,C8_EMISSAO)) As MEDIA_SCxCOT,
AVG(DateDiff(Day,CR_EMISSAO,CR_DATALIB)) As MEDIA_CR_COTxCR_LIB,
AVG(DateDiff(Day,C8_EMISSAO,CR_DATALIB)) As MEDIA_COTXLIB
From SC7010 SC7	   	 

	Inner Join SC8010 SC8 -- COTACAO
	On C8_FILIAL = C7_FILIAL
	And C8_NUMPED = C7_NUM
	--And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Inner Join SC1010 SC1 --Solicitçao PC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	--And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''
	
	Inner Join SCR010 SCR -- Aprovacao PC 
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_STATUS In ('03','05')
	And SCR.D_E_L_E_T_ = ''

Where C7_FILIAL = '01' and C7_EMISSAO Between '20230101' and '20231231'
And C7_CONAPRO  = 'L'
And SC7.D_E_L_E_T_ = ''
--Group By C7_FILIAL,C7_NUM,C1_EMISSAO,C8_EMISSAO,CR_EMISSAO,CR_DATALIB
--Order By 4


/*
"1" // Falta iniciar atendimento 
"2" // Em negociacao
"3" // Agendamento futuro
"4" // Falta aprovacao supervisao
"5" // Falta alterar pedido
"6" // Rejeitado cobrecom
"7" // Pedido Alterado
"" // NAO ESTA EM NEGOCIACAO
*/		


-- Tabelas 
Select * From SX2010
Where X2_CHAVE In ('ZP4','ZZV','ZZZ','ZZE')
And D_E_L_E_T_ = ''

-- Campos
Select * From SX3010
Where X3_ARQUIVO  In ('ZP4','ZZV','ZZZ','ZZE') and X3_CAMPO In ('ZP4_STATUS','ZZV_STATUS')
And D_E_L_E_T_ = ''

--PV Itens 
Select C6_SEMANA,* From SC6010
Where C6_FILIAL = '01' and C6_NUM In ('403131','403149') and C6_PRODUTO In ('1091404201')
And D_E_L_E_T_ = ''

--TES
Select * From SF4010
Where F4_CODIGO In ('623','364')


  --CTRL RETRABALHO PROATIVA      
 Select ZZE_ID,ZZE_STATUS,ZZE_SITUAC,* From ZZE010
 Where ZZE_ID = '058430'
 And D_E_L_E_T_ =''

 --SZL - Pesagem 
Select ZL_STATUS,ZL_COMENTS,ZL_MOTIVO,* From SZL010 With(Nolock)
Where ZL_FILIAL = '01' and ZL_NUM In ('339053','339054','339055')
And D_E_L_E_T_ = '' 


Select * From SX3010
Where X3_CAMPO = 'ZL_STATUS'
-- A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ                                                          




-- Tabelas
Select * From SX2010
Where X2_CHAVE In ('ZZI','ZBA')
And D_E_L_E_T_ = '' 

-- Campos
Select * From SX3010
Where X3_ARQUIVO = 'SZE' And X3_CAMPO = 'DC_TPLIB'
And D_E_L_E_T_ = '' 
                                                                              



Select * From ZP5010

--SZE -> Tabela de Bobinas
Select ZE_STATUS,ZE_CONDIC,ZE_SITUACA,* From SZE010
Where ZE_FILIAL In ('01') and ZE_PEDIDO In ('406170') 
and D_E_L_E_T_ ='' 
and ZE_STATUS Not in  ('F','C')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa                                                                                                           



--PV Itens 
Select R_E_C_N_O_,C6_SEMANA,C6_RESERVA,C6_QTDEMP,* From SC6010
Where C6_FILIAL In ('02') and C6_NUM In ('112703')
And D_E_L_E_T_ = '' 


--PV Itens Lib.
Select R_E_C_N_O_,C9_RESERVA,* From SC9010
Where C9_FILIAL In ('02') and C9_PEDIDO In ('112703')
And D_E_L_E_T_ = '' 

-- USUARIOS PORTAL COBRECOM      
Select * From ZP1010
Where ZP1_CODIGO = '000149'
And D_E_L_E_T_ =' '

--SA3 - Vendedores
Select * From SA3010
Where A3_COD = '159035'
And D_E_L_E_T_ =' '


--AAAX({nRecC6,nRecC9})









-- NF Entrada Cab. 
Select Distinct F1_DOC,F1_VALBRUT,X5_DESCRI,F1_ESPECIE,F1_TIPO,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,
	--N = NF Normal C = Compl. Preco D = Devolucao I = NF Compl. ICMS P = NF Compl. IPI B = NF Beneficiamento
* From SF1010 SF1

	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''
	
Where F1_FILIAL = '01' and F1_DOC In ('000367269') 
and SF1.D_E_L_E_T_ =''

-- NF Entrada Itens 
Select D1_DOC,* From SD1010
Where D1_FILIAL = '01' and D1_DOC = '000367269' --and D2_COD Like '%1150702401%'
and D_E_L_E_T_ =''




Select * From CTK010





-- Lançamentos Contabeis
Select CT2_LP,CT2_SEQLAN,CT5_DESC,CT5_HIST,
CT2_TPSALD,X5_DESCRI,* From CT2010 CT2 With(Nolock)

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = 'SL'
	And X5_FILIAL = CT2_FILIAL
	And X5_CHAVE = CT2_TPSALD
	And SX5.D_E_L_E_T_ = ''

	Inner Join CT5010 CT5 -- Lanc. Padrao
	On CT2_LP = CT5_LANPAD 
	And CT2_SEQLAN = CT5_SEQUEN
	And CT5.D_E_L_E_T_ = ''

Where  CT2_FILIAL In ('01') and CT2_VALOR In ('10614.10') --and CT2_HIST Like ('%000367269%')
And CT2_DATA Between '20231001' and '20231031'
And CT2.D_E_L_E_T_ =' '
Order By CT2.R_E_C_N_O_



-- Lancamentos Padrão
Select * From CT5010
Where D_E_L_E_T_ =' '

--MANUT. TIT. RECEBER           
Select * From ZBA010
Where ZBA_NUM In ('000367269','000366792')
and D_E_L_E_T_ =''


-- Contra Prova Contabil 
Select CTK_TPSALD,X5_DESCRI,* From CTK010 CTK With(Nolock)

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = 'SL'
	And X5_FILIAL = CTK_FILIAL
	And X5_CHAVE = CTK_TPSALD
	And SX5.D_E_L_E_T_ = ''
	
Where  CTK_FILIAL  = '01' and CTK_VLR01 = '10614.10'
And CTK_DATA Between '20230701' and '20230731'
--And CTK_LOTE = '8840'
And CTK.D_E_L_E_T_ =' '




Select * From CT2010
Where CT2_SEQUEN In ('0030829135','0030829137','0030830340','0030830343','0030830579')
And D_E_L_E_T_ =' '
Order By CT2_SEQUEN,CT2_LINHA


-- Genericas 
Select * FRom SX5010
Where X5_TABELA In ('05','SL','42','MQ')
And D_E_L_E_T_ =' '
Order By X5_TABELA

-- Lançamentos Contab.
Select CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
CTK_VLR01,CTK_HIST,CV3_VLR01,CV3_HIST,CT2_TPSALD,CTK_TPSALD,*
From CT2010 CT2 With(Nolock)

	-- Contra Prova Contab.
	Left Join CTK010 CTK With(Nolock)
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK_KEY = CT2_KEY
	And CTK_FILIAL = CT2_FILIAL
	And CTK_VLR01 = CT2_VALOR
	And CTK_ITEMC = CT2_ITEMC
	and CTK.D_E_L_E_T_ =''

	-- Rastreamento Contab.
	Left Join CV3010 CV3 With(Nolock)
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3_KEY = CT2_KEY
	And CV3_FILIAL = CT2_FILIAL
	And CV3_VLR01 = CT2_VALOR
	And CV3_ITEMC = CT2_ITEMC
	and CV3.D_E_L_E_T_ =' '


	--CABECA DE LOTE DE TRANSF. BENS
	Left Join TRC01SP TRC With(Nolock)
	On TRC_SEQUEN = CT2_SEQUEN
	and TRC.D_E_L_E_T_ =' '

	
Where CT2_FILIAL In ('01','02','03')
And CT2_DATA Between '20230701' and '20230731'
and CT2_TPSALD = '9'
and CT2.D_E_L_E_T_ =''






-- NF Saida Cab.
Select * From SF2010
Where F2_FILIAL = '02' and F2_DOC = '000142622'
And D_E_L_E_T_ =''

-- NF Saida Itens 
Select D2_ITEMPV,* From SD2010
Where D2_FILIAL = '02' and D2_DOC = '000142622'
And D_E_L_E_T_ =''
Order By 1



-- Pedido de Vendas - Cab.
Select C5_ZZPVDIV,C5_NOTA,C5_LIBEROK,C5_ZSTATUS, * From SC5010
Where C5_FILIAL = '01' and C5_NUM In ('402913')  and D_E_L_E_T_ =''


--Orçamento
Select * From ZP9010
Where ZP9_NUM = '342740'
 and D_E_L_E_T_ =''
 Order By ZP9_ITEM


-- PV - Liberados 
Select C9_BLEST,* From SC9010
Where C9_FILIAL = '02' and C9_PEDIDO In ('104014') and D_E_L_E_T_ =''







-- Estoque Poder Terceiros 
Select B6_QULIB,B6_SALDO,B6_QUANT,* From SB6010
Where B6_CLIFOR = '008918' and B6_LOJA = '01'
And B6_PRODUTO = '2010000000' and B6_SALDO > 0
And D_E_L_E_T_ = ''



-- Estoque 
Select * From SB2010
Where B2_COD = '2010000000' 
And D_E_L_E_T_ = ''


-- Estoque Terceiros Sum
Select B6_FILIAL, B6_PRODUTO, Sum(B6_QULIB) As B6_QULIB,Sum(B6_SALDO) As B6_SALDO,Sum(B6_QUANT) As B6_QUANT From SB6010
Where B6_CLIFOR = '008918' and B6_LOJA = '01'
And B6_PRODUTO = '2010000000' and B6_SALDO > 0
And D_E_L_E_T_ = ''
Group By B6_FILIAL, B6_PRODUTO

-- Estoque Sum
Select B2_FILIAL,B2_COD,Sum(B2_QATU) As B2_QATUA From SB2010
Where B2_COD = '2010000000' 
And D_E_L_E_T_ = ''
Group By B2_FILIAL,B2_COD

--Estoque Sum
Select B2_COD,Sum(B2_QATU) As B2_QATUA From SB2010
Where B2_COD = '2010000000' 
And D_E_L_E_T_ = ''
Group By B2_COD



-- Clientes
Select  Max(A1_COD) FROM SA1010
Where A1_COD Like ('%044%') and D_E_L_E_T_ = ''
Order By 1

--TTAT_LOG
Select TTAT_UNQ,TTAT_DTIME,* FRom SA1010_TTAT_LOG
Where TTAT_UNQ Like '%406222%' and TTAT_USER In ('roberta.marques')
And TTAT_FIELD = 'A1_COD'


-- Clientes
Select A1_COD FROM SA1010
Where D_E_L_E_T_ = ''
Order By 1



--Nota Fiscal Eletrônica
Select STATUS,STATUSCANC,STATUSMAIL,DOC_CHV,LOTE,* From SPED050
Where NFE_ID In ('1  000381863','1  000381845','1  000381846','1  000381847','1  000381848','1  000381849','1  000382020',
'1  000382021','1  000382022','1  000381851','1  000381852','1  000381853','1  000381854','1  000381855','1  000381856',
'1  000381857','1  000381858','1  000381859','1  000381860','1  000381861','1  000381861','1  000381867','1  000381868',
'1  000381869','1  000381870')
and DATE_NFE >= '20230701' and D_E_L_E_T_ = ''


--Nota Fiscal Eletrônica
Select STATUS,STATUSCANC,STATUSMAIL,DOC_CHV,LOTE,DATE_NFE,DESCMAIL,* 
From SPED050
Where STATUSMAIL = '3'
and DATE_NFE >= '20231120' 
and D_E_L_E_T_ = ''
Order By 5

SELECT  * FROM SPED000 WHERE PARAMETRO IN 
('MV_SMTPSRV','MV_SMTPAAC',
 'MV_SMTPFAC','MV_SMTPFPS',
 'MV_SMTPADM','MV_SMTPAUT',
 'MV_SMTPSSL', 'MV_SMTPTLS',
 'MV_AUTDIST', 'MV_NFEDISD') 
AND ID_ENT IN (SELECT ID_ENT FROM SPED001 WHERE CNPJ = '99999999999999')

SELECT NFE_ID,ID_ENT,
       MODELO,EMAIL,
       STATUSMAIL,STATUS,
       STATUSCANC, NFE_PROT, 
       MODALIDADE, AMBIENTE
FROM SPED050
WHERE NFE_ID = 'XXX'



--Lotes de Nota Fiscal Eletrônica
Select LOTE,* From SPED052
Where LOTE In ('000000000036417')
and D_E_L_E_T_ = ''


--Lotes X Nota Fiscal Eletrônica
Select LOTE,* From SPED054
Where NFE_ID In ('1  000142870') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''



/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/


-- NF Saida Cab. 
Select F2_DOC,* From SF2010
Where F2_FILIAL = '02' and F2_DOC = '000142870' 
and D_E_L_E_T_ =''

Select D2_DOC,* From SD2010
Where D2_FILIAL = '02' and D2_DOC = '000142870' 
and D_E_L_E_T_ =''


-- NF Saida Cab. 
Select F1_DOC,* From SF1010
Where F1_FILIAL = '02' and F1_DOC = '000142870' 
and D_E_L_E_T_ =''

Select D1_DOC,* From SD1010
Where D1_FILIAL = '02' and D1_DOC = '000142870' 
and D_E_L_E_T_ =''







-- Estoque / Produtos 
Select B2_COD,B1_TIPO,B1_DESC,B1_LOCPAD,Isnull(D1_DOC,'') As D1_DOC, Isnull(D4_OP,0) As D4_OP, Isnull(C2_NUM,0) As C2_NUM,
Isnull(D3_DOC,0) As D3_DOC,
Isnull(D1_DTDIGIT,'') As D1_DTDIGIT,Isnull(D1_EMISSAO,'') As D1_EMISSAO,Isnull(D1_TES,'') As D1_TES,
Isnull(F4_TEXTO,'') As F4_TEXTO,Isnull(F4_ESTOQUE,'') As F4_ESTOQUE, 
Isnull(D3_TM,'') As D3_TM ,Isnull(F5_TEXTO,'') As F5_TEXTO, Isnull(F5_TIPO,'') As F5_TIPO,
B2_QATU,B2_QEMP,B2_RESERVA,
Isnull(D1_QUANT,0) As D1_QUANT,Isnull(C2_QUANT,0) As C2_QUANT,Isnull(C2_QUJE,0) As C2_QUJE, Isnull(D3_QUANT,0) as D3_QUANT,
Isnull(C7_QUANT,'') As C7_QUANT,Isnull(C7_QUJE,'') As C7_QUJE,Isnull(C7_QTDACLA,'') As C7_QTDACLA,
Isnull(D4_QUANT,0) As D4_QUANT, Isnull(D4_QTDEORI,0) As D4_QTDEORI,
Isnull(C2_DATRF,0) As C2_DATRF,
Isnull(B1_UM,0) As B1_UM,Isnull(C2_UM,0) As C2_UM,Isnull(D1_UM,0) As D1_UM, Isnull(C7_UM,0) As C7_UM
From SB2010 SB2 With(Nolock)
	
	Inner Join SB1010 SB1 With(Nolock) --Produtos
	On B1_COD = B2_COD
	and SB1.D_E_L_E_T_ =''

	LEFT Join SD1010 SD1 With(Nolock) --NF Entrada Itens 
	ON SD1.D1_COD = B2_COD
	And SD1.D_E_L_E_T_ = ''

	Left Join SF4010 SF4 With(Nolock) --TES
	On D1_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ = ''

	Left Join SC7010 SC7 With(Nolock) --PC
	On C7_PRODUTO = B2_COD
	And SC7.D_E_L_E_T_ = ''

	Left Join SC2010 SC2 With(Nolock) --Ordens de Produção  
	On C2_PRODUTO = B2_COD
	And SC2.D_E_L_E_T_ = ''

	Left Join SD4010 SD4 With(Nolock) --Empenhos 
	On D4_COD = B2_COD
	--And D4_QUANT > 0
	And D4_DATA >= '20231101'
	And SD4.D_E_L_E_T_ = ''

	Left Join SD3010 SD3 With(Nolock) --Moviemtos Internos
	On D3_COD = B2_COD
	And D3_TM >= 500
	And D3_ESTORNO = ''
	And D3_EMISSAO >= '20231101'
	And SD3.D_E_L_E_T_ = ''

	Left Join SF5010 SF5
	On D3_TM = F5_CODIGO 
	And SF5.D_E_L_E_T_ = ''

Where B2_COD In ('PE5054A','PE5055A','PE4702A')and SB2.D_E_L_E_T_ =''

--Tipo de movimentacao para transacoes doestoque, sendo: 
--(R) - Requisicao - Codigos > que 500 
--(D) - Devolucao - Codigos < ou = 500 
--(P) - Producao - Codigos < ou = 500



-- Ordens de produção 
Select Max(C2_NUM) From SC2010
Where C2_FILIAL = '02' and C2_NUM Like ('085%')
And D_E_L_E_T_ = ''

-- Produtos 
Select B1_COD,B1_DESC,B1_POSIPI,* From SB1010
Where B1_COD = 'IM01000001' 
And D_E_L_E_T_ = ''

-- Fornecedores 
Select * From SA2010
Where A2_COD = 'VOOYSW'
And D_E_L_E_T_ = ''

--N = NF Normal C = Compl. Preco D = Devolucao I = NF Compl. ICMS P = NF Compl. IPI B = NF Beneficiamento




--ZXMSHCAD - Cadasto Cliente Cobrecom
-- Clientes

Select  Max(A1_COD) FROM SA1010

Where A1_COD Like ('%044%') and D_E_L_E_T_ = ''

Order By 1



--TTAT_LOG

Select TTAT_UNQ,TTAT_DTIME,* FRom SA1010_TTAT_LOG

Where TTAT_UNQ Like '%406268%'

And TTAT_FIELD = 'A1_COD'





-- Clientes

Select A1_COD FROM SA1010

Where D_E_L_E_T_ = ''

Order By 1

--Paramtros 
Select * From SX6010
Where X6_VAR = 'MV_NFEAFSD '

-- NF Ent
Select F1_CHVNFE,* From SF1010
Where F1_FILIAL = '01' and F1_DOC = '000382843'
Order By 1 Desc

-- NF Ent
Select F1_CHVNFE,* From SF1010
Where F1_FORNECE = 'VOOYSW'
Order By 1 Desc



--NF Ent Itens 
Select D1_DOC,D1_II,D1_X_BSII,D1_X_DESAD,D1_X_VLII,* From SD1010
Where D1_FILIAL = '01' and D1_DOC In ('000382684','000382843')
Order By 1 Desc

--NF Ent Itens 
Select D1_DOC,D1_II,D1_X_BSII,D1_X_DESAD,D1_X_VLII,* From SD1010
Where D1_FORNECE = 'VOOYSW'
Order By 1


--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
* From SPED050
Where NFE_ID In ('1  000382618') and DATE_NFE >= '20230101' and D_E_L_E_T_ = ''

Select * From SX3010
Where X3_CAMPO In ('D1_II','D1_X_BSII','D1_X_DESAD','D1_X_VLII')

Select * From SEB010

 /*
Nro Bytes (EE_NRBYTES) = 240
Formato Data (EE_TIPODAT) = 4
*/
SELECT EE_NRBYTES,EE_TIPODAT,* FROM SEE010 
WHERE
EE_CODIGO = '237' 
AND D_E_L_E_T_ = ''

/*
Ocorr Banco (EB_REFBAN)= 01
Ocorr Sist (EB_OCORR)= 02
Tipo (EB_TIPO) = D
*/
SELECT EB_TIPO,EB_OCORR,EB_REFBAN,* 
FROM SEB010
WHERE
EB_BANCO = '237' 
AND D_E_L_E_T_ = ''

--Pesagem de Materiais
Select ZL_UNMOV,ZL_STATUS,* From SZL010
Where ZL_NUM In ('342571','343859','343870')
AND D_E_L_E_T_ = '' and ZL_STATUS  In ('A')


Select Count(E2_NUM) TOTAL_ From SE2010
Where D_E_L_E_T_ = ''
Union All
-- Contas a pagar 
Select Count(E2_NUM) TOTAL_XXX From SE2010
Where D_E_L_E_T_ = '*'

-- Contas a pagar 
Select MAX(R_E_C_N_O_) R_E_C_N_O_ From SE2010

-- Usuários Portal Cobrecom 
Select * From ZP1010
Where ZP1_CODIGO = '000317'
And  D_E_L_E_T_ = ''

Select * From SX5010
Where X5_CHAVE Like ('%FINA%')

Select * From SXB010
Where XB_ALIAS Like ('%FIN%')

--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL = '02' and BF_PRODUTO = '1090804201'and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ ='' and BF_LOCALIZ = 'B00400'

-- Estoque 
Select * From SB2010
Where B2_FILIAL = '01'and B2_COD = '1090804201'
And D_E_L_E_T_ = ''




Select * From SE2010
Select * From SIF010


/*ORDEM DE CARGA - EXISTENTES DEVEM SER FINABLQ E SEMCARGA*/
SELECT MAX(ZZ9_ORDCAR)
FROM ZZ9010
WHERE ZZ9_FILIAL = '01'
AND ZZ9_ORDCAR NOT LIKE 'SEM%'
AND ZZ9_ORDCAR NOT LIKE 'FIN%'
AND	D_E_L_E_T_ = ''

/*ALTERAR AS QUE FORAM GERADAS INCORRETAMENTE*/
/*ORDEM DE CARGA - EXISTENTES DEVEM SER FINABLQ E SEMCARGA*/
SELECT *
--UPDATE ZZ9010 SET ZZ9_ORDCAR = '00015184'
FROM ZZ9010
WHERE ZZ9_FILIAL = '01'
--AND ZZ9_ORDCAR LIKE 'SEM%'
--AND ZZ9_ORDCAR LIKE 'FIN%'
AND ZZ9_ORDCAR = 'SEMCARGB'
AND	D_E_L_E_T_ = ''


/*ORDENS AGLUTINADAS COMECAM COM OS*/
SELECT MAX(ZZR_OS)
FROM ZZR010
WHERE ZZR_FILIAL = '01'
AND ZZR_OS LIKE 'OS%'
AND D_E_L_E_T_ = ''


/*VERIFICAR AS QUE FORAM GERADAS INCORRETAMENTE*/
SELECT ZZR_OS, *
FROM ZZR010
WHERE ZZR_FILIAL = '01'
--AND ZZR_OS LIKE 'OS%'
AND ZZR_OS <> ''
AND ZZR_OS NOT LIKE 'OS%'
AND ZZR_PEDIDO + ZZR_SEQOS <> ZZR_OS
AND ZZR_DATA >= '20231101'
AND D_E_L_E_T_ = ''

/*ACERTAR ORDEM DE PRODUCAO*/
SELECT MAX(C2_NUM)
FROM SC2010
WHERE C2_FILIAL = '02'
AND C2_NUM LIKE '0%'
AND C2_EMISSAO >= '20231201' --DATA ANTES DO RESET DO LICENSE (ULTIMO DIA COM A SEQ CORRETO)
AND D_E_L_E_T_ = ''

-- Clientes
Select  Max(A1_COD) FROM SA1010
Where A1_COD Like ('044%') and D_E_L_E_T_ = ''
Order By 1


-- Clientes
Select A1_COD FROM SA1010
Where D_E_L_E_T_ = ''
Order By 1

-- Parametros 
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD, * From SX6010
Where X6_VAR In ('MV_BX10925')
And D_E_L_E_T_ = ''


-- Usuários x Rotinas 
SELECT M_NAME, 
       M_ID, I_ID, I_TP_MENU, I_ITEMID, I_FATHER, F_FUNCTION, I_STATUS, I_ORDER, I_TABLES, I_ACCESS, I_DEFAULT, I_RESNAME, I_TYPE, I_OWNER, F_DEFAULT
       , I_MODULE, I18N1.N_DESC N_PT, I18N2.N_DESC N_ES, I18N3.N_DESC N_EN, KW1.K_DESC K_PT, KW2.K_DESC K_ES, KW3.K_DESC K_EN
FROM MPMENU_MENU MPN
jOIN MPMENU_ITEM MPI ON I_ID_MENU = M_ID AND MPI.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_FUNCTION MPF ON F_ID = I_ID_FUNC AND MPF.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N1 ON I18N1.N_PAREN_ID = I_ID AND I18N1.N_LANG = '1' AND I18N1.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N2 ON I18N2.N_PAREN_ID = I_ID AND I18N2.N_LANG = '2' AND I18N2.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N3 ON I18N3.N_PAREN_ID = I_ID AND I18N3.N_LANG = '3' AND I18N3.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW1 ON KW1.K_ID_ITEM = I_ID AND KW1.K_LANG = '1' AND KW1.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW2 ON KW2.K_ID_ITEM = I_ID AND KW2.K_LANG = '2' AND KW2.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW3 ON KW3.K_ID_ITEM = I_ID AND KW3.K_LANG = '3' AND KW3.D_E_L_E_T_ = ' '
WHERE F_FUNCTION IN ('CTBA010','CTBA080')
AND '#' <> SUBSTRING(M_NAME,1,1) 
AND MPN.D_E_L_E_T_ = ' ' 
ORDER  BY I_ORDER

-----------------------------------------------
-- Usuários com acesso 
SELECT DISTINCT USR.*
FROM SYS_USR_MODULE USRMOD (NOLOCK)
JOIN SYS_USR USR (NOLOCK)
  ON USR.USR_ID = USRMOD.USR_ID 
WHERE USR_CODMOD like '%SIGACTB%'
and USR_MSBLQL <> '1'

-- Titulos a pagar 
Select E2_BAIXA,E2_SALDO,E2_PIS,E2_CSLL,E2_COFINS,* From SE2010
Where E2_BAIXA = '' and E2_SALDO > '0' 
And (E2_PIS > 0 or E2_CSLL > 0 or E2_COFINS > 0)
And D_E_L_E_T_ = ''




--PV Liberado 
Select C9_BLCRED,C9_BLEST,* From SC9010
Where C9_FILIAL = '01' and C9_PEDIDO = '406922'
And D_E_L_E_T_ = ''


--PV Liberado 
Select C6_QTDEMP,* From SC6010
Where C6_FILIAL = '01' and C6_NUM = '406922'
And D_E_L_E_T_ = ''

----Ordem de Carga 
Select * From ZZ9010
Where ZZ9_FILIAL = '01' and ZZ9_ORDSEP = '40692201'
And D_E_L_E_T_ = ''

-- Ordem de separação 
Select ZZR_SITUAC,* From ZZR010
Where ZZR_FILIAL = '01' and ZZR_PEDIDO = '406922'
And D_E_L_E_T_ = ''


--35231251254159000173550010010866421018688341

--NF Entrada Cab. 
Select F1_FILIAL,Isnull(F1_ORIGEM,'') As F1_ORIGEM, F1_ESPECIE, X5_DESCRI,
F1_BASEIPI,F1_VALIPI,F1_IPI,
	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_ ,
*
From SF1010 SF1

	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

Where F1_CHVNFE In ('35231251254159000173550010010866421018688341')
And SF1.D_E_L_E_T_ = ''

-- NF Entrada Itens 
Select D1_TES,D1_TESACLA,D1_VALIPI,D1_IPI,D1_BASEIPI,D1_PEDIDO,D1_ITEMPC,* From SD1010
Where D1_FILIAL = '01' and D1_FORNECE = '000002' and D1_LOJA = '01' and D1_DOC = '001086642'
And D_E_L_E_T_ = ''


--Pedido de compras
Select C7_NUM,C7_ITEM,C7_DESCRI,C7_IPI,C7_VALIPI,C7_BASEIPI,C7_QUANT,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_ENCER,C7_RESIDUO,C7_QTDACLA,C7_NUM,* From SC7010
Where C7_FILIAL = '01' and C7_NUM In ('013800') and C7_ITEM = '0009'
and D_E_L_E_T_ =''



--TES
Select F4_IPI,* From SF4010
Where F4_CODIGO In ('005','001')
And D_E_L_E_T_ = ''
--Help de Campo: Para o ambiente Brasil: Calcula ou nao o IPI. Neste campo responda "S" para incidencia de IPI, 
--"N"para nao incidencia de IPI, "R" para comerciante nao atacadista. Para o ambiente Colombia: Calcula ou nao o IVA. 
--Neste campo responda "S" para incidencia de IVA, "N"para nao incidencia de IVA.

-- Produtos 
Select B1_COD,B1_DESC,B1_IPI,B1_TE,B1_IMPORT,* From SB1010
Where B1_COD = '2120402004' 
And D_E_L_E_T_ = ''

-- Produtos 
Select BZ_IPI,* From SBZ010
Where BZ_COD = '2120402004' 
And D_E_L_E_T_ = ''

-- Generica 
Select * From SX5010
Where X5_TABELA = 'DJ'
And D_E_L_E_T_ = ''

-- Fornecedores 
Select * From SA2010
Where A2_COD = '000002'
And D_E_L_E_T_ = ''






--NF Entrada Itens
Select D1_FORNECE,D1_DOC,D1_EMISSAO,D1_FILIAL,D1_CUSTO,D1_TES,D1_NFORI,D1_IDENTB6,* From SD1010
Where D1_DOC = '29245'
And D1_EMISSAO >= '20231101'
and D_E_L_E_T_ =''


--Complemento Fiscal (F2Q)
Select F2Q_NATREN,* From F2Q010
Where F2Q_PRODUT In ('SV05000049')
and D_E_L_E_T_ =''

--DHR - NF x Natureza de Rendimento
Select FKX_CODIGO,FKX_DESCR,ISNULL(CAST(CAST(FKX_DESEXT AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS FKX_DESEXT,
A2_CGC,A2_NOME,D1_COD, B1_DESC,
* From DHR010 DHR
	Inner Join FKX010 FKX
	On FKX_CODIGO = DHR_NATREN
	And FKX.D_E_L_E_T_ =''

	Inner Join SA2010 SA2
	On A2_COD = DHR_FORNEC
	And A2_LOJA = DHR_LOJA
	And SA2.D_E_L_E_T_ =''

	Inner Join SD1010 SD1
	On DHR_FILIAL = D1_FILIAL 
	And DHR_FORNEC = D1_FORNECE
	And DHR_LOJA = D1_LOJA
	And DHR_DOC = D1_DOC
	And DHR_ITEM = D1_ITEM
	And SD1.D_E_L_E_T_ =''

	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ =''

Where DHR_FILIAL = '01' and DHR_DOC = '29245' and DHR_FORNEC = 'VOOYTB'
and DHR.D_E_L_E_T_ =''

Select * From SB1010

--FKX - Naturezas de Rendimento
Select * From FKX010
Where FKX_CODIGO = '15014' 
and D_E_L_E_T_ =''

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_CADPROD'
and D_E_L_E_T_ =''

--Campos
Select * From SX3010
Where X3_CAMPO In ('DHR_ITEM','D1_ITEM')
and D_E_L_E_T_ =''

-- Retrabalhos 
Select ZZE_SITUAC,ZZE_STATUS,* From ZZE010
Where ZZE_FILIAL = '02' and ZZE_ID In ('000009','000012','000013','000016','000020')
And D_E_L_E_T_ = ''
--ZZE_SITUAC - 1=Encerrado;2=Em Aberto                                                                                                         
--ZZE_STATUS - 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO     



--| S-1200 | TAFA250 |  C91   | - Remuneração de trabalhador vinculado ao Regime Geral de Previdência Social
--TAFA250 => S-1200 => C91, T6W, CRN, C1G, T14, C9K, C9L, C9M, T6Y, T6Z, C9N, C9O, C9P, C9Q, C9R, C9V

/*
EVENTO | ROTINA  | TABELA | DETALHES
| -----------------------   |
| S-1000 | TAFA050 |  C1E   | - Informações do Empregador/Contribuinte/Órgão Público
| S-1005 | TAFA253 |  C92   | - Tabela de Estabelecimentos, Obras ou Unidades de Órgãos Públicos
| S-1010 | TAFA232 |  C8R   | - Tabela de Rubricas
| S-1020 | TAFA246 |  C99   | - Tabela de Lotações Tributárias
| S-1030 | TAFA235 |  C8V   | - Tabela de Cargos/Empregos Públicos
| S-1035 | TAFA467 |  T5K   | - Tabela de Carreiras Públicas
| S-1040 | TAFA236 |  C8X   | - Tabela de Funções e Cargos em Comissão
| S-1050 | TAFA238 |  C90   | - Tabela de Horários/Turnos de Trabalho
| S-1060 | TAFA389 |  T04   | - Tabela de Ambientes de Trabalho
| S-1070 | TAFA051 |  C1G   | - Tabela de Processos Administrativos/Judiciais
| S-1080 | TAFA248 |  C8W   | - Tabela de Operadores Portuários
| S-1200 | TAFA250 |  C91   | - Remuneração de trabalhador vinculado ao Regime Geral de Previdência Social
| S-1202 | TAFA413 |  C91   | - Remuneração de servidor vinculado a Regime Próprio de Previdência Social – RPPS
| S-1207 | TAFA470 |  T62   | - Benefícios Previdenciários - RPPS
| S-1210 | TAFA407 |  T3P   | - Pagamentos de Rendimentos do Trabalho
| S-1250 | TAFA272 |  CMR   | - Aquisição de Produção Rural
| S-1260 | TAFA414 |  T1M   | - Comercialização da Produção Rural Pessoa Física
| S-1270 | TAFA408 |  T2A   | - Contratação de Trabalhadores Avulsos Não Portuários
| S-1280 | TAFA410 |  T3V   | - Informações Complementares aos Eventos Periódicos
| S-1295 | TAFA477 |  T72   | - Solicitação de Totalização para Pagamento em Contingência
| S-1298 | TAFA416 |  T1S   | - Reabertura dos Eventos Periódicos
| S-1299 | TAFA303 |  CUO   | - Fechamento dos Eventos Periódicos
| S-1300 | TAFA412 |  T3Z   | - Contribuição Sindical Patronal
| S-2190 | TAFA403 |  T3A   | - Admissão de Trabalhador – Registro Preliminar
| S-2200 | TAFA278 |  C9V   | - Cadastramento Inicial do Vínculo e Admissão/Ingresso de Trabalhador
| S-2205 | TAFA275 |  T1U   | - Alteração de Dados Cadastrais do Trabalhador
| S-2206 | TAFA276 |  T1V   | - Alteração de Contrato de Trabalho
| S-2210 | TAFA257 |  CM0   | - Comunicação de Acidente de Trabalho
| S-2220 | TAFA258 |  C8B   | - Monitoramento da Saúde doTrabalhador
| S-2230 | TAFA261 |  CM6   | - Afastamento Temporário
| S-2240 | TAFA264 |  CM9   | - Condições Ambientais do Trabalho - Fatores de Risco
| S-2241 | TAFA404 |  T3B   | - Insalubridade, Periculosidade e Aposentadoria Especial
| S-2250 | TAFA263 |  CM8   | - Aviso Prévio
| S-2260 | TAFA484 |  T87   | - Convocação para Trabalho Intermitente
| S-2298 | TAFA267 |  CMF   | - Reintegração
| S-2299 | TAFA266 |  CMD   | - Desligamento
| S-2300 | TAFA279 |  C9V   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Início
| S-2306 | TAFA277 |  T0F   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Alteração Contratual
| S-2399 | TAFA280 |  T92   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Término
| S-2400 | TAFA469 |  T5T   | - Cadastro de Benefícios Previdenciários - RPPS
| S-3000 | TAFA269 |  CMJ   | - Exclusão de Eventos
| S-5001 | TAFA423 |  T2M   | - Informações das contribuições sociais consolidadas por trabalhador
| S-5002 | TAFA422 |  T2G   | - Imposto de Renda Retido na Fonte
| S-5011 | TAFA425 |  T2V   | - Informações das contribuições sociais consolidadas por contribuinte
| S-5012 | TAFA426 |  T0G   | - Informações do IRRF consolidadas por contribuinte*/
-----------------------------

Select * From  C91010

--Opcoes do ComboBox: 0=Reg.Valido;1=Reg.Invalido;2=Reg.Transmitido;3=Reg.Transmitido com inconsistencias;4=Reg.Transmitido valido;9=Em Processamento
--Grupo de Campos: 079 (Status do Registro TAF )
--Help de Campo: Campo de uso interno do sistema. Deve representar neste campo o status do registro: (Vazio) = Registro Novo 0 = Registro Valido (integracao) 
--1 = Registro invalido (integracao) 2 = Registro transmitido 3 = Registro transmitido com inconsistencia(s) 4 = Registro transmitido valido






Select D2_DOC,* From SD2010
Where D2_FILIAL = '02' and D2_DOC = '000144091' 
and D_E_L_E_T_ =''

-- TES 
Select * From SF4010
Where F4_CODIGO In ('849','050')
and D_E_L_E_T_ =''

-- Clientes 
Select A1_CGC,* From SA1010
Where A1_COD = '000048' and A1_LOJA = '01' or  A1_CGC In ('02544042000208','37223708000111')
and D_E_L_E_T_ =''

--Sys Company
Select M0_CGC,* From SYS_COMPANY
Where M0_CODFIL In ('01','02')
and D_E_L_E_T_ =''


-- Forcedores
Select A2_CGC,* From SA2010
Where A2_COD In ('V00693','000048') and A2_LOJA = '01' or A2_CGC In ('02544042000208','37223708000111')
and D_E_L_E_T_ =''




-- Contas a pagar
Select * From SE2010
Where E2_FORNECE = '000002' 
And E2_BAIXA = ''
And E2_EMISSAO >= '20231201'
And D_E_L_E_T_ = ''

-- NF Entarda Cab 
Select * From SF1010
Where F1_FORNECE = '000002'
And F1_EMISSAO >= '20231201'
And D_E_L_E_T_ = ''

 
 -- Contas a pagar 
 Select F1_DOC,E2_NUM,E2_PARCELA,F1_VALBRUT,E2_VALOR,E2_CODBAR,* From SF1010 SF1
 
	Left Join SE2010 SE2
	On E2_FILIAL = F1_FILIAL
	And E2_FORNECE = F1_FORNECE
	And E2_LOJA = F1_LOJA
	And E2_NUM = F1_DOC 
	And E2_TIPO = 'NF'

Where F1_EMISSAO >= '20231201'
And F1_FORNECE = '000002'
And SF1.D_E_L_E_T_ = ''
Order By 1

 -- Contas a pagar 
 Select E2_VALOR,Count(E2_VALOR) as QTDE From SE2010 SE2
 Where E2_EMISSAO >= '20231201'
And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_VALOR
Order By 2


 -- Contas a pagar 
 Select E2_VENCTO,Count(E2_VENCTO) as QTDE From SE2010 SE2
 Where E2_EMISSAO >= '20231201'
And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_VENCTO
Order By 2


 -- Contas a pagar 
 Select E2_VALOR,E2_VENCTO,Count(E2_VALOR) as QTDE_VAL,Count(E2_VENCTO) AS QTDE_VENTO From SE2010 SE2
 Where E2_EMISSAO >= '20231201'
And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_VALOR,E2_VENCTO
Order By 3 Desc

 -- Contas a pagar 
Select E2_FORNECE,E2_VALOR,E2_VENCTO,Count(E2_VALOR) as QTDE_VAL,Count(E2_VENCTO) AS QTDE_VENTO From SE2010 SE2
Where E2_EMISSAO >= '20231201'
And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_FORNECE,E2_VALOR,E2_VENCTO
Having Count(E2_VALOR) > 1 and Count(E2_VENCTO) > 1
Order By 4 Desc


-- ZP5 - Orcamento Cab. *******

Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,

ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,

ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,

* From ZP5010

Where ZP5_NUM = '361525' and  D_E_L_E_T_ ='' 

--ZP5_STATUS 

--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado          



-- ZP6 - Orcamento Itens 

Select * From ZP6010

Where ZP6_NUM = '395913'

And D_E_L_E_T_ =' '



-- USUARIOS PORTAL COBRECOM      

Select * From ZP1010

Where ZP1_CODIGO = '000107'

And D_E_L_E_T_ =' '




-- Casas Decimais        
Declare @FILINI Char(4), @FILFIM Char(4), @CODPRODINI Char(10), @CODPRODFIM Char(10);
Set @FILINI = '01'
Set @FILFIM = '03'
Set @CODPRODINI = '0000000000'
Set @CODPRODFIM = '9999999999'

Select B2_FILIAL, B2_COD,B1_DESC, B2_LOCAL,B2_QATU,B1_CUSTD, B2_VATU1, B2_CM1,B2_VFIM1,
Len(B2_VATU1) AS VL_ATUAL_CASAS, Len(B2_CM1) AS CUS_MED_CASAS, Len(B2_VFIM1) AS VL_FIM,
(B2_CM1*B2_QATU) As VL_FIM_CALC,Len(B2_CM1*B2_QATU) As VL_FIM_CALC_CASAS,

Case 
When Len(B2_VATU1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VATUAL,

Case 
When Len(B2_CM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM,

Case 
When Len(B2_VFIM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM,

Case 
When Len(B2_CM1*B2_QATU) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VLFIM_CALC

From SB2010 SB2 With(NoLock)

	Inner Join SB1010 SB1 With(NoLock)
	On SB1.B1_COD = B2_COD
	And SB1.D_E_L_E_T_ = ''

Where B2_FILIAL Between @FILINI and @FILFIM  
and  SB2.D_E_L_E_T_=''   
And (Len(B2_VATU1) >= 12
Or Len(B2_CM1) >= 12
Or Len(B2_VFIM1) >= 12 Or Len(B2_CM1*B2_QATU) >= 12)
--and B2_COD In('')
Order By 14

--SD2 - Itens de Venda da NF
SELECT D2_CUSTO1,D2_DOC, *
FROM SD2010
WHERE R_E_C_N_O_ = 5914756

-- Mov. Interna
Select D3_CUSTO1,D3_QUANT,(D3_CUSTO1/D3_QUANT) AS Teste,* From SD3010
Where D3_COD = 'SC01000001'
And D3_EMISSAO Between '20231001' and '20231031'
And D3_ESTORNO = ''
and D_E_L_E_T_ =''
Order By 3

--Produtos
Select * From SB1010
Where B1_COD = 'SC01000001'

--Saldos Iniciais 
Select Distinct B1_COD  /*,B1_DESC,B1_TIPO,B1_MSBLQL,B9_CM1,B9_QINI,B9_VINI1,

Case 
When B1_MSBLQL = '1' Then 'B'
When B1_MSBLQL = '2' Then 'L'
Else '###' 
End as Status_s,

**/ From SB9010 SB9
	
	Inner Join SB1010 SB1 -- Produtos
	On B1_COD = B9_COD
	And SB1.D_E_L_E_T_ =''

	Inner Join SD1010 SD1 -- NF Entrada Itens
	On D1_COD = B9_COD
	And D1_EMISSAO Between '20230901' and '20230930'
	And SD1.D_E_L_E_T_ =''

	Inner Join SD2010 SD2 -- NF Saida Itens 
	On D2_COD = B9_COD
	And D2_EMISSAO Between '20230901' and '20230930'
	And SD2.D_E_L_E_T_ =''

		Inner Join SD3010 SD3
	On D3_COD = B9_COD
	And D3_EMISSAO Between '20230901' and '20230930'
	And SD3.D_E_L_E_T_ =''

Where B9_DATA <> '20230930'
And B9_QINI > 0
And (B9_QINI < 0 or B9_VINI1 < 0 Or B9_CM1 < 0 )
--And B9_COD = 'SC01000001'
and SB9.D_E_L_E_T_ =''



-- Fornecedor 
Select A2_CGC,A2_MSBLQL,* From SA2010
Where A2_COD = 'VOOYK9' and D_E_L_E_T_ =''
or A2_CGC = '02801096000112'





-- Produto x Fornecedor 
Select A5_NCMPRF,A5_DESCPRF,* From SA5010
Where A5_FORNECE In ('VOOYK9') and A5_PRODUTO = 'AI02000874' and D_E_L_E_T_ ='' 
And A5_CODPRF = '800MMFD'





-- PV - Itens 
Select C6_FILIAL,C6_NUM,C6_PRODUTO,C6_ITEM,C6_DESCRI,C6_SEMANA,C6_ITEMPC,C6_NUMPCOM,C6_ITPDCLI, * From SC6010
Where C6_FILIAL = '02' and C6_NUM In ('105844')  and D_E_L_E_T_ =''
And C6_ITEM = '10'

-- PV - Liberados 
Select C9_FILIAL,C9_PEDIDO,C9_PRODUTO,C9_ITEM,C9_DESCRI,C9_BLEST,* From SC9010
Where C9_FILIAL = '02' and C9_PEDIDO In ('105844') and D_E_L_E_T_ =''
And C9_ITEM = '10'

-- Pedido de Vendas - Cab.
Select C5_ZZPVDIV,* From SC5010
Where C5_FILIAL = '02' and C5_NUM In ('105844')  and D_E_L_E_T_ =''

Select B1_COD,
choose (Len(B1_COD),'1010101101') 
From SB1010

Select Choose(1,'Primeiro','Segundo') From SB1010


-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV,B1_POSIPI,B1_MSBLQL, * From SB1010
Where B1_COD = '2000000006I'  and D_E_L_E_T_ = ''

-- Produtos
Select B2_COD,B2_RESERVA, * From SB2010
Where B2_COD = '2000000006I'  and B2_FILIAL = '02'
and D_E_L_E_T_ = ''

-- PV Itens 
Select C6_FILIAL,C6_NUM,C6_QTDVEN,C6_QTDENT,(C6_QTDVEN-C6_QTDENT) As SALDO,C6_QTDLIB,Isnull(C9_QTDLIB,'') As C9_QTDLIB ,
B2_TOTAL = (Select Sum(B2_QATU) From SB2010 SB2 Where B2_COD = C6_PRODUTO And B2_FILIAL = C6_FILIAL and SB2.D_E_L_E_T_ = ''),
B2_RESERVA = (Select Sum(B2_RESERVA) From SB2010 SB2 Where B2_COD = C6_PRODUTO And B2_FILIAL = C6_FILIAL and SB2.D_E_L_E_T_ = ''),
(Select Sum(B2_QATU) From SB2010 SB2 Where B2_COD = C6_PRODUTO And B2_FILIAL = C6_FILIAL and SB2.D_E_L_E_T_ = '')-(C6_QTDVEN-C6_QTDENT) AS SALDO_GERAL,
* From SC6010 SC6
	
	Inner Join SC5010 SC5
	On C5_FILIAL = C6_FILIAL 
	And C5_NUM = C6_NUM 
	And C5_NOTA Not In ('XXXXXX')
	And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Left Join SC9010 SC9
	On C6_FILIAL = C9_FILIAL
	And C6_NUM = C9_PEDIDO
	And C6_PRODUTO = C6_PRODUTO
	And SC9.D_E_L_E_T_ = ''

Where C6_PRODUTO In ('2000000006I')
And (C6_QTDVEN-C6_QTDENT) > 0
And SC6.D_E_L_E_T_ =' '

--PV Liberados 
Select * From SC9010
Where C9_FILIAL = '02' and C9_PRODUTO = '2000000006I'
And C9_NFISCAL = ''
And D_E_L_E_T_ =' '

-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_VLESOC','MV_TAFVLES')
And D_E_L_E_T_ =' '

-- Movimentos Internos 
Select D3_CUSTO1,(D3_CUSTO1/D3_QUANT) AS D3_CM,D3_QUANT,D3_CF,
* From SD3010
Where D3_FILIAL In ('01') and D3_CF <> ''  and D3_EMISSAO Between '20230901' and '20230930' 
and D_E_L_E_T_ = '' and D3_ESTORNO = '' and D3_COD = 'PF1820A'
--And D3_DOC In ('000076766','000076767','000076884','000076885','000129475','000129867','000129910')
Order By 1 desc
-- D3_CUSTO1 -- Custos
-- D3_CF *Tipo de Requisicao/devolucao
-- D3_TM - Tipo Movimento
-- dbo.userlgi_normal (D3_USERLGI) - usuario


--Estoque Terceiros
Select SB6.B6_FILIAL, SB6.B6_CLIFOR,A1_NOME,A2_NOME,SB6.B6_PRODUTO,B1_DESC,SB6.B6_DOC,SB6.B6_FILIAL, 
Isnull(SD1.D1_FORNECE,'')D1_FORNECE, Isnull(SD1.D1_DOC,'') D1_DOC,Isnull(SD1.D1_NFORI,'') D1_NFORI,
Isnull(SD2.D2_CLIENTE,'') D2_CLIENTE, Isnull(SD2.D2_DOC,'') D2_DOC, 
Isnull(SB6.B6_CUSTO1,'') B6_CUSTO1, Isnull(SD1.D1_CUSTO,'') D1_CUSTO, Isnull(SD2.D2_CUSTO1,'') D2_CUSTO1,
Isnull((SB6.B6_CUSTO1 - SD1.D1_CUSTO),'') As DIF_CUSTO_ENTRADA, Isnull((SB6.B6_CUSTO1 - SD2.D2_CUSTO1),'') As DIF_CUSTO_SAIDA,
Isnull(SD1.D1_EMISSAO,'')D1_EMISSAO,Isnull(SD2.D2_EMISSAO,'') D2_EMISSAO, B6_EMISSAO,
Isnull(SB6.B6_LOJA,'') B6_LOJA,Isnull(SD1.D1_LOJA,'') D1_LOJA,Isnull(SD2.D2_LOJA,'') D2_LOJA,SB6.B6_IDENT,B6_SALDO,
Isnull(D1_QUANT,0) As D1_QUANT ,Isnull(D2_QUANT,0) As D2_QUANT ,Isnull(B6_QUANT,0) As B6_QUANT
From SB6010 SB6

	-- SD1 - NF Entrada Itens
	Left Join SD1010 SD1
	On SD1.D1_FILIAL = SB6.B6_FILIAL 
	And SD1.D1_LOJA = SB6.B6_LOJA
	And SD1.D1_FORNECE = SB6.B6_CLIFOR
	And SD1.D1_DOC = SB6.B6_DOC 
	And SD1.D1_COD = SB6.B6_PRODUTO
	And SD1.D1_IDENTB6 = SB6.B6_IDENT
	And SD1.D_E_L_E_T_ = ''

	    -- SD2 - NF Saida Itens
	LEFT Join SD2010 SD2
	On SD2.D2_FILIAL = SB6.B6_FILIAL 
	And SD2.D2_LOJA = SB6.B6_LOJA
	And SD2.D2_CLIENTE = SB6.B6_CLIFOR
	And SD2.D2_DOC = SB6.B6_DOC 
	And SD2.D2_COD = SB6.B6_PRODUTO
	And SD2.D_E_L_E_T_ = ''

	Left Join SA1010 SA1
	On SD2.D2_LOJA = SA1.A1_LOJA
	And SD2.D2_CLIENTE = SA1.A1_COD
	And SA1.D_E_L_E_T_ = ''

	Left Join SA2010 SA2
	On SD1.D1_LOJA = SA2.A2_LOJA
	And SD1.D1_FORNECE = SA2.A2_COD
	And SA2.D_E_L_E_T_ = ''

	Left Join SB1010 SB1
	On B1_COD = B6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

		   
Where B6_FILIAL In ('01','02','03') 
--And B6_SALDO > 0
--and B6_CLIFOR In ('000130') 
and B6_DOC In ('000396870')
--And SB6.B6_PRODUTO In ('000396870')
And SB6.B6_EMISSAO Between '20240101' And '20240731'
And SB6.D_E_L_E_T_ = ''
Order By SB6.B6_DOC



-- Ajuste SB6 quando tem diferença no Fechameno de Custos
-- SB6 Desbalanceada 

SELECT * -- D1_CUSTO, B6_CUSTO1, D1_QUANT, B6_QUANT, * 
--UPDATE SB6010 SET B6_CUSTO1 = D1_CUSTO, B6_QUANT = D1_QUANT
FROM SB6010 B6
--INNER JOIN SD1010 D1 ON D1_FILIAL = B6_FILIAL AND B6_IDENT = D1_IDENTB6 AND D1_DOC = B6_DOC AND D1_SERIE = B6_SERIE AND D1_COD = B6_PRODUTO AND D1_QUANT = B6_QUANT AND D1.D_E_L_E_T_ = B6.D_E_L_E_T_
WHERE --B6_FILIAL = '01'
--AND B6_IDENT = 'Sw358J'
B6_DOC = ''
AND B6.D_E_L_E_T_ = ''


-- Lançamentos Contab.
Select CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
CTK_VLR01,CTK_HIST,CV3_VLR01,CV3_HIST,CT2_TPSALD,CTK_TPSALD,*
From CT2010 CT2 With(Nolock)

	-- Contra Prova Contab.
	Left Join CTK010 CTK With(Nolock)
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK_KEY = CT2_KEY
	And CTK_FILIAL = CT2_FILIAL
	And CTK_VLR01 = CT2_VALOR
	And CTK_ITEMC = CT2_ITEMC
	and CTK.D_E_L_E_T_ =''

	-- Rastreamento Contab.
	Left Join CV3010 CV3 With(Nolock)
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3_KEY = CT2_KEY
	And CV3_FILIAL = CT2_FILIAL
	And CV3_VLR01 = CT2_VALOR
	And CV3_ITEMC = CT2_ITEMC
	and CV3.D_E_L_E_T_ =' '


	--CABECA DE LOTE DE TRANSF. BENS
	Left Join TRC01SP TRC With(Nolock)
	On TRC_SEQUEN = CT2_SEQUEN
	and TRC.D_E_L_E_T_ =' '

	
Where CT2_FILIAL In ('01')
And CT2_DATA Between '20230901' and '20230930'
and CT2_TPSALD = '9'
and CT2.D_E_L_E_T_ =''


-- Contra Prva Contabil 
Select * From CTK010 With(Nolock)
Where  CTK_TPSALD  = '9'
And CTK_DATA Between '20230901' and '20230930'
--And CTK_LOTE = '8840'
And D_E_L_E_T_ =' '

-- Lançamentos Contabeis
Select * From CT2010 With(Nolock)
Where  CT2_TPSALD  = '9'
And CT2_DATA Between '20230901' and '20230930'
--And CT2_LOTE = '008840'
And D_E_L_E_T_ =' '
Order By CT2_FILIAL, CT2_LOTE, CT2_SBLOTE,CT2_DOC

Select * From SE1010

-- Contas a Receber 
Select E1_FILIAL,E1_NUMBCO,E1_PORTADO,E1_AGEDEP,E1_CONTA,
E1_NUM,E1_CLIENTE,E1_NOMCLI,E1_TIPO,E1_PARCELA,
Ltrim(Rtrim(ZB1_BANCO)) + '9'+ 'X' + 
Ltrim(Rtrim(Replace(Convert(Char,(DateDiff(Day,Max(E1_VENCTO),'1997-10-07'))),'-',''))) +
Ltrim(Rtrim(Replicate('0', 10 - Len(Replace(E1_VALOR,'.',''))) + Convert(Char,Replace(E1_VALOR,'.','')))) + 
Ltrim(Rtrim(ZB1_AGENCI)) + Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))) + Ltrim(Rtrim(SubString(E1_NUMBCO,1,11))) + Ltrim(Rtrim(ZB1_CONTA)) + '0'
AS COD_BAR,

Len
(Ltrim(Rtrim(ZB1_BANCO)) + '9'+ 'X' + 
Ltrim(Rtrim(Replace(Convert(Char,(DateDiff(Day,Max(E1_VENCTO),'1997-10-07'))),'-',''))) +
Ltrim(Rtrim(Replicate('0', 10 - Len(Replace(E1_VALOR,'.',''))) + Convert(Char,Replace(E1_VALOR,'.','')))) + 
Ltrim(Rtrim(ZB1_AGENCI)) + Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))) + Ltrim(Rtrim(SubString(E1_NUMBCO,1,11))) + Ltrim(Rtrim(ZB1_CONTA)) + '0')
As QTDE_DIG,

Ltrim(Rtrim(ZB1_BANCO)) + '9'+ Ltrim(Rtrim(ZB1_AGENCI)) + SubString(Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))),1,1)  + 'A' +
SubString(Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))),2,2) + Ltrim(Rtrim(SubString(E1_NUMBCO,1,9))) + 'B' + 
Ltrim(Rtrim(SubString(E1_NUMBCO,10,2))) + Ltrim(Rtrim(ZB1_CONTA)) + '0' + 'C' + 
'D' + 
Ltrim(Rtrim(Replace(Convert(Char,(DateDiff(Day,Max(E1_VENCTO),'1997-10-07'))),'-',''))) + 
Ltrim(Rtrim(Replicate('0', 10 - Len(Replace(E1_VALOR,'.',''))) + Convert(Char,Replace(E1_VALOR,'.',''))))
AS LINHA_DIG,

Len(
Ltrim(Rtrim(ZB1_BANCO)) + '9'+ Ltrim(Rtrim(ZB1_AGENCI)) + SubString(Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))),1,1)  + 'A' +
SubString(Ltrim(Rtrim(Replace(ZB1_CARTEI,'"',''))),2,2) + + Ltrim(Rtrim(SubString(E1_NUMBCO,1,9))) + 'B' +
Ltrim(Rtrim(SubString(E1_NUMBCO,10,2))) +Ltrim(Rtrim(ZB1_CONTA)) + '0' + 'C' + 
'D' + 
Ltrim(Rtrim(Replace(Convert(Char,(DateDiff(Day,Max(E1_VENCTO),'1997-10-07'))),'-',''))) + 
Ltrim(Rtrim(Replicate('0', 10 - Len(Replace(E1_VALOR,'.',''))) + Convert(Char,Replace(E1_VALOR,'.',''))))
)
As QTDE_LIN_DIG

From SE1010 SE1
	
	Left Join ZB1010 ZB1
	On ZB1_FILIAL = E1_FILIAL 
	And ZB1_BANCO = E1_PORTADO
	And ZB1_AGENCI = E1_AGEDEP
	And ZB1_CONTA = E1_CONTA
	And ZB1.D_E_L_E_T_ =' '
	
Where E1_SALDO > 0 and E1_BAIXA = '' and E1_NUMBCO <> ''
And  ZB1_BANCO = '237' and ZB1_AGENCI = '0559' and ZB1_CONTA = '0037658'
And E1_CLIENTE = '010355'
And SE1.D_E_L_E_T_ =' '
Group By E1_FILIAL,E1_NUMBCO,E1_PORTADO,E1_AGEDEP,E1_CONTA,
ZB1_BANCO,ZB1_AGSDIG,ZB1_CARTEI,E1_VALOR,E1_NOMCLI,ZB1_AGENCI,ZB1_CONTA,
E1_NUM,E1_CLIENTE,E1_NOMCLI,E1_TIPO,E1_PARCELA

Select * From ZBA010

Select * From SX2010
Where X2_CHAVE Like ('ZB%')

--CONF. BOLETOS BANCARIOS       
Select ZB1_AGSDIG+Substring(ZB1_CARTEI,2,2) ,* From ZB1010
Where ZB1_BANCO = '237' and ZB1_AGENCI = '0559' and ZB1_CONTA = '0037658'
And D_E_L_E_T_ =' '

--SEE - Comunicacao Remota
Select * From SEE010



Select * From SB6010
Where B6_TIPO Not In ('E','D')
And D_E_L_E_T_ =' '




-- Representantes 
Select A3_EMAIL,* From SA3010
Where A3_EMAIL Like ('%adilton%')
and D_E_L_E_T_ =''



-- SF1 - NF Entrada 
-- Industraização / Transferencias 
Select F1_OBSTRF,* From SF1010

-- SF1 - NF Entrada - Indicador 
Select Distinct F1_DOC,F1_FORNECE, F1_FILIAL,Isnull(F1_ORIGEM,'') As F1_ORIGEM,F1_ESPECIE, X5_DESCRI,F1_OBSTRF,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_
	
From SF1010 SF1

	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

Where F1_DOC = '000384060' and F1_FILIAL In ('02') 
and SF1.D_E_L_E_T_ =''
-- And  F1_OBSTRF =  ''
--and F1_ORIGEM NOT IN('AtuDocFr','cbcInTrC')
Group By F1_DOC,F1_FORNECE,F1_FILIAL,F1_ORIGEM,F1_ESPECIE,X5_DESCRI,F1_OBSTRF
Order By 1,3 Desc

-- Parametros 
Select * From SX5010
Where X5_TABELA = '42' and X5_CHAVE = 'SPED' and X5_FILIAL = '02'
And D_E_L_E_T_ = ''


-- SF1 - NF Entrada - Verificação 
Select  F1_ORIGEM,F1_FILIAL,F1_DOC,F1_TIPO,F1_ESPECIE,F1_OBSTRF,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_
	
From SF1010
Where F1_DOC = '000384060' and D_E_L_E_T_ ='' 
Order By 1










Select * From SFT010 SFT
Where FT_CHVNFE = '35231202544042000119550010003862431910676608'
And SFT.D_E_L_E_T_ = ''





-- PV Itens 
Select * From SC6010
Where C6_NUM = '407111' and C6_PRODUTO = '5060504401'
And D_E_L_E_T_ =' '


-- PV Liberados
Select * From SC9010
Where C9_PEDIDO = '407111' and C9_PRODUTO In ('5060504401')  
And D_E_L_E_T_ =' ' 

-- PV Itens 
Select Sum(C6_QTDVEN) From SC6010
Where C6_NUM = '407111' and C6_PRODUTO = '5060504401'
And D_E_L_E_T_ =' '

-- PV Liberados
Select Sum(C9_QTDLIB) From SC9010
Where C9_PEDIDO = '407111' and C9_PRODUTO In ('5060504401')  
And D_E_L_E_T_ =' '



 --SDC - Composicao do Empenho
 -- Verificar Produtos e Qtde e Filial e PV = ZE_CTRLE e Sattus <> ('F','C')
 -- Endereço DC_LOCALIZ = BF_LOCALIZ
Select * From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = '5060504401'and DC_QUANT > 0
and D_E_L_E_T_ ='' and DC_PEDIDO In ('407111')-- and DC_LOCALIZ = 'R00100'

Select Sum (DC_QUANT) From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = '5060504401'and DC_QUANT > 0
and D_E_L_E_T_ ='' and DC_PEDIDO In ('407111')-- and DC_LOCALIZ = 'R00100'

--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO = '1140902401' and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ ='' and BF_LOCALIZ = 'R00100'

Select Sum(BF_QUANT) From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO = '5060504401' and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ ='' 
and BF_LOCALIZ In ('B03000','B03035','B03041','B03036','B03036','B02989',         
'B03041','B03050','B03048','B03071','B03062','B03044','B03046','B02062',         
'B01030','B01048','B03035','B02020')         

--SZE -> Tabela de Bobinas
Select ZE_STATUS,ZE_CONDIC,ZE_SITUACA,* From SZE010
Where ZE_FILIAL In ('01') and ZE_PRODUTO In ('5060504401') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
And ZE_PEDIDO In ('407111')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa   

Select Sum(ZE_QUANT) From SZE010
Where ZE_FILIAL In ('01') and ZE_PRODUTO In ('5060504401') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
And ZE_PEDIDO In ('407111')


     

Select Sum(ZL_LANCE) From SZL010 With(Nolock)
Where ZL_FILIAL In ('02') and ZL_NUM In ('574959') and D_E_L_E_T_ ='' and ZL_PEDIDO = ''
And ZL_STATUS Not In ('C','A')

--Parametros 
SELECT * FROM SX6010 WHERE X6_VAR In ('MV_ULMES','MV_DBLQMOV')	



Select * From  SF1010
Where F1_DOC = '000143686' --and F1_EMISSAO between  '20231101' and '20231130'
and D_E_L_E_T_ =''

Select * From SF3010
Where F3_CHVNFE = '50231202544042000208550010001439201940676251'


-- Parametros 

Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2, X6_CONTEUD,* From SX6010

Where X6_VAR In ('MV_UFBASDP') 

--MV_UFBDST

--NF Entrada 
Select Count(F1_CHVNFE) As NFE,Sum(F1_VALBRUT) As TOTAL  From SF1010
Where F1_EMISSAO >= '20240101'
and D_E_L_E_T_ =''

--NF Saida
Select Count(F2_CHVNFE) As NFE, Sum(F2_VALBRUT) As TOTAL From SF2010
Where F2_EMISSAO >= '20240101'
and D_E_L_E_T_ =''



-- Mov. Interna 
Select * From SD3010
Where D3_FILIAL = '02' and D3_COD = '2000000006I' and D3_DOC  = '000142869'
and D_E_L_E_T_ =''




Select * From ZZE010
Where ZZE_ID = '059991'
and D_E_L_E_T_ =''




-- NF Entrada Cab.
Select F1_CHVNFE,S_T_A_M_P_,F1_DTLANC ,* From SF1010
Where F1_FORNECE = 'V008J9' and F1_DOC In ('13089')
and D_E_L_E_T_ = ''
Order By F1_DOC

-- NF Entrada Itens 
Select * From SD1010
Where D1_FORNECE = 'V008J9' and D1_DOC In ('13089')
and D_E_L_E_T_ = ''

-- Contas a Pagar 
Select S_T_A_M_P_,* From SE2010
Where E2_FORNECE = 'V008J9' and E2_NUM In ('13089')
and D_E_L_E_T_ = ''


-- Livro Fiscal Cab.
Select S_T_A_M_P_,F3_CHVNFE,F3_DTLANC,* From SF3010
Where F3_CLIEFOR = 'V008J9' and F3_NFISCAL In ('13089')
and D_E_L_E_T_ = ''


-- Livro Fiscal Itens
Select S_T_A_M_P_,FT_CHVNFE,* From SFT010
Where FT_CLIEFOR = 'V008J9' and FT_NFISCAL In ('13089')
and D_E_L_E_T_ = ''

-- Fornecedor
Select * From SA2010
wHERE A2_COD = 'V008J9'
and D_E_L_E_T_ = ''



----SDS - Cabecalho importacao XML NF-e
Select DS_CHAVENF,* From SDS010
Where DS_DOC = '13089'
And D_E_L_E_T_ = ''

--SDT - Itens importacao XML NF-e
Select DT_DOC,* From SDT010
Where DT_FILIAL = '02' --and DT_DOC In ('000032558') and D_E_L_E_T_ = ''
And DT_FORNEC In ('V008J9')

-- SE2 - Contas a pagar
Select * From SE2010
Where E2_NUM = '13089' and E2_FORNECE = 'V008J9'
And D_E_L_E_T_ = ''

-- Movimentos Internos 
Select D3_CUSTO1,D3_CF, * From SD3010 With(Nolock)
Where D3_FILIAL = '02' and D3_DOC In ('13089')
and D_E_L_E_T_ = '' and D3_ESTORNO = '' 
Order By 1 desc
-- D3_CUSTO1 -- Custos
-- D3_CF *Tipo de Requisicao/devolucao
-- D3_TM - Tipo Movimento
-- dbo.userlgi_normal (D3_USERLGI) - usuario



--CV8 - Log de Processamento
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), CV8_DET)),'') AS [DET],
* From CV8010
Where CV8_DATA >= '20231101'  and D_E_L_E_T_ =''
And CV8_PROC In ('CTBANFE')
Order By CV8_DATA Asc

-- Logs SF1
Select TTAT_UNQ,* From SF1010_TTAT_LOG
Where TTAT_UNQ Like ('02%') and TTAT_UNQ Like ('%V008J9%')
And TTAT_DELET = ''
Order By 1


-- Contra Prova Contabil 
Select D_E_L_E_T_,R_E_C_N_O_,CTK_RECDES,CTK_RECCV3,CTK_RECORI,CTK_TABORI,CTK_ROTINA,CTK_ORIGEM,CTK_KEY,
* From CTK010 With(Nolock)
Where  CTK_FILIAL = '02'
And CTK_HIST Like ('%13089%') And CTK_HIST Like ('%TARCHIANI%')
--And D_E_L_E_T_ =' '
Order By CTK_DATA
--CTK_RECORI - RECNO Origem - SD1 
--CTK_RECCV3 - RECNO relacionamento - CV3
--CTK_RECDES - RECNO Destino - CT2 

--CV3 - Rastreamento Lancamento
Select  D_E_L_E_T_,CV3_TABORI,CV3_RECORI,CV3_RECDES,CV3_IDORIG,CV3_IDDEST,CV3_KEY,
* From CV3010 With(Nolock)
Where CV3_FILIAL = '02'
And CV3_HIST Like ('%13089%') And CV3_HIST Like ('%TARCHIANI%')
--CV3_TABORI	Tab.Origem	Tabela Origem Lancamento	
--CV3_RECORI	Reg.Origem	Registro na Tabela Origem
--CV3_RECDES	Reg.Destino	Registro Destino Lancto.	
--CV3_IDORIG	ID Origem	ID de Origem Conciliador	
--CV3_IDDEST	ID Destino	ID Destino Conciliador

-- Lançamentos Contabeis
Select D_E_L_E_T_,CT2_HIST,R_E_C_N_O_,CT2_MANUAL,CT2_TPSALD,CT2_ORIGEM,CT2_ROTINA,CT2_KEY,CT2_DTCV3,
* From CT2010 With(Nolock)
Where CT2_FILIAL = '02'
And CT2_HIST Like ('%13089%') And CT2_HIST Like ('%TARCHIANI%')
--And D_E_L_E_T_ =' '
Order By CT2_DATA
--CT2_MANUAL
-- Campo indicativo se este lancamento contabil foi gerado por outro modulo (2)ou foi digitado no Sigactb (1).
--CT2_DTCV3	Data Rastrea	Data para Rastreamento




--Numeracoa de Documentos 
Select * From CTF010
Where CTF_FILIAL = '02'
And CTF_LOTE In ('000001','008850') And CTF_SBLOTE = '001' And CTF_DOC In ('000003','000023')
And CTF_DATA >= '20231101'
Order By CTF_DATA

-- Lançamentos Contab.
Select CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
CTK_VLR01,CTK_HIST,CV3_VLR01,CV3_HIST,CT2_TPSALD,CTK_TPSALD,*
From CT2010 CT2 With(Nolock)

	-- Contra Prova Contab.
	Left Join CTK010 CTK With(Nolock)
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK_KEY = CT2_KEY
	And CTK_FILIAL = CT2_FILIAL
	And CTK_VLR01 = CT2_VALOR
	And CTK_ITEMC = CT2_ITEMC
	and CTK.D_E_L_E_T_ =''

	-- Rastreamento Contab.
	Left Join CV3010 CV3 With(Nolock)
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3_KEY = CT2_KEY
	And CV3_FILIAL = CT2_FILIAL
	And CV3_VLR01 = CT2_VALOR
	And CV3_ITEMC = CT2_ITEMC
	and CV3.D_E_L_E_T_ =' '


	--CABECA DE LOTE DE TRANSF. BENS
	Left Join TRC01SP TRC With(Nolock)
	On TRC_SEQUEN = CT2_SEQUEN
	and TRC.D_E_L_E_T_ =' '

	
Where CT2_FILIAL In ('01')
And CT2_DATA Between '20230901' and '20230930'
and CT2_TPSALD = '9'
and CT2.D_E_L_E_T_ =''



SELECT *
FROM CT2010
WHERE CT2_FILIAL = '03'
AND R_E_C_N_O_ IN (
SELECT CTK_RECDES
FROM CTK010 WITH(NOLOCK)
WHERE CTK_FILIAL = '03'
AND CTK_RECORI = 1016131
AND D_E_L_E_T_  =''
)


-- NF Entrada Cab.
Select F1_CHVNFE,S_T_A_M_P_,F1_DTLANC ,* From SF1010
Where F1_FORNECE = 'V008J9' and F1_DOC In ('13089')
and D_E_L_E_T_ = ''
Order By F1_DOC

-- NF Entrada Itens 
Select D1_TES,D1_TESACLA,R_E_C_N_O_,* From SD1010
Where D1_FORNECE = 'V008J9' and D1_DOC In ('13089')
and D_E_L_E_T_ = ''

--TES
Select * From SF4010
Where F4_CODIGO = '039'
and D_E_L_E_T_ = ''

-- Contas a Pagar 
Select S_T_A_M_P_,* From SE2010
Where E2_FORNECE = 'V008J9' and E2_NUM In ('13089')
and D_E_L_E_T_ = ''


-- Livro Fiscal Cab.
Select S_T_A_M_P_,F3_CHVNFE,F3_DTLANC,* From SF3010
Where F3_CLIEFOR = 'V008J9' and F3_NFISCAL In ('13089')
and D_E_L_E_T_ = ''


-- Livro Fiscal Itens
Select S_T_A_M_P_,FT_CHVNFE,* From SFT010
Where FT_CLIEFOR = 'V008J9' and FT_NFISCAL In ('13089')
and D_E_L_E_T_ = ''

-- Fornecedor
Select * From SA2010
wHERE A2_COD = 'V008J9'
and D_E_L_E_T_ = ''



-- Contra Prova Contabil 
Select D_E_L_E_T_,R_E_C_N_O_,CTK_RECDES,CTK_RECCV3,CTK_RECORI,CTK_TABORI,CTK_ROTINA,CTK_ORIGEM,CTK_KEY,
* From CTK010 With(Nolock)
Where  CTK_FILIAL = '02'
And CTK_HIST Like ('%13089%') And CTK_HIST Like ('%TARCHIANI%')
--And D_E_L_E_T_ =' '
Order By CTK_DATA
--CTK_RECORI - RECNO Origem - SD1 
--CTK_RECCV3 - RECNO relacionamento - CV3
--CTK_RECDES - RECNO Destino - CT2 

--CV3 - Rastreamento Lancamento
Select  D_E_L_E_T_,CV3_TABORI,CV3_RECORI,CV3_RECDES,CV3_IDORIG,CV3_IDDEST,CV3_KEY,
* From CV3010 With(Nolock)
Where CV3_FILIAL = '02' And CV3_RECORI = 993429
--And CV3_HIST Like ('%13089%') And CV3_HIST Like ('%TARCHIANI%')
--CV3_TABORI	Tab.Origem	Tabela Origem Lancamento	
--CV3_RECORI	Reg.Origem	Registro na Tabela Origem
--CV3_RECDES	Reg.Destino	Registro Destino Lancto.	
--CV3_IDORIG	ID Origem	ID de Origem Conciliador	
--CV3_IDDEST	ID Destino	ID Destino Conciliador

-- Lançamentos Contabeis
Select D_E_L_E_T_,CT2_HIST,R_E_C_N_O_,CT2_MANUAL,CT2_TPSALD,CT2_ORIGEM,CT2_ROTINA,CT2_KEY,CT2_DTCV3,
* From CT2010 With(Nolock)
Where CT2_FILIAL = '02'
And CT2_HIST Like ('%13089%') And CT2_HIST Like ('%TARCHIANI%')
--And D_E_L_E_T_ =' '
Order By CT2_DATA
--CT2_MANUAL
-- Campo indicativo se este lancamento contabil foi gerado por outro modulo (2)ou foi digitado no Sigactb (1).
--CT2_DTCV3	Data Rastrea	Data para Rastreamento


-- Parametros 
Select * From SX6010
Where X6_FIL <> '01' And X6_VAR In ('MV_ULMES','MV_DBLQMOV')
And D_E_L_E_T_ =' '

-- SE2 - Contas a pagar
Select E2_TIPO,E2_NUMCX,* From SE2010
Where E2_NUM = '13089' and E2_FORNECE = 'V008J9'
And D_E_L_E_T_ = ''

-- SE5 - MOV Bancaria
Select  E5_TIPO,* From SE5010
Where E5_NUMERO = '13089' and E5_FORNECE = 'V008J9'
And D_E_L_E_T_ = ''

--E2_NUMCX = 003033




-- Campos
Select * From SX3010
Where X3_CAMPO = 'C00_STATUS'


-- Clientes com CPPJ <> 


-- Soma Geral 
Select Count(A1_CGC) As QTDE From SA1010
Where D_E_L_E_T_ = '' And A1_EST Not In ('EX','')
Having Count(A1_CGC) > 1

-- Clientes com mesmo CNPJ
Select A1_CGC,Count(A1_CGC) As QTDE From SA1010
Where D_E_L_E_T_ = '' And A1_EST Not In ('EX','')
Group By A1_CGC
Having Count(A1_CGC) > 1
Order By 2 Desc


-- Exemplo
Select * From SA1010 
Where A1_CGC = '71476527000135'
And D_E_L_E_T_ = ''
Order By A1_COD

-- Fornecedores
Select * From SA2010
Where A2_CGC = '05531250000171'
And D_E_L_E_T_ = ''

--NF Entarda  
Select F1_EMISSAO,* From SF1010
Where F1_FORNECE = 'VOP004'
And D_E_L_E_T_ = ''

--NF Entarda  Itens
Select D1_EMISSAO,D1_CF,* From SD1010
Where D1_FORNECE = 'VOP004'
And D_E_L_E_T_ = ''
Order By 1

----LOG DAS ORDENS DE SEPARACAO 
Select * From ZZR010
Where ZZR_PEDIDO = '409940'
And ZZR_DOC = ''
And D_E_L_E_T_ = ''

--Estoque 
Select B2_RESERVA,B2_QPEDVEN,* From SB2010
Where B2_FILIAL = '01'And B2_COD = '2010000000'
And D_E_L_E_T_ = ''




SELECT C6_SEMANA, C6_ZZPVORI, *
FROM SC6010
WHERE C6_FILIAL = '02'
AND C6_NUM = '106699'
AND C6_ITEM = '06'
AND D_E_L_E_T_ = ''


SELECT C9_BLCRED, C9_BLEST, *
--UPDATE SC9010 SET C9_PRODUTO = '1111604401'
FROM SC9010
WHERE C9_FILIAL = '02'
AND C9_PEDIDO = '106699'
AND C9_ITEM = '06'
AND D_E_L_E_T_ = ''


-- NF Saida Cab. 
Select F2_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F2_ESPECIE,SX5_TP.X5_DESCRI,F2_TIPO,D2_COD,D2_DESCRI,D2_ITEMPV,C6_ACONDIC,B1_TIPO,C5_NUM, D2_TES,F4_TEXTO,F4_DUPLIC,F4_ESTOQUE,
D2_QUANT,C6_QTDVEN,C6_QTDENT,C9_QTDLIB,
B2_QTATU = Isnull((Select Sum(B2_QATU) From SB2010 SB2
			Where B2_FILIAL = D2_FILIAL
			And B2_COD = D2_COD
			And SB2.D_E_L_E_T_ = ''),0),	

FIN_SALDO = Isnull((Select Sum(E1_SALDO) From SE1010 SE1
					Where E1_FILIAL = F2_FILIAL
					And E1_NUM = F2_DOC
					And E1_CLIENTE = F2_CLIENTE
					And E1_LOJA = F2_LOJA
					And SE1.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E1_VALLIQ) From SE1010 SE1
					Where E1_FILIAL = F2_FILIAL
					And E1_NUM = F2_DOC
					And E1_CLIENTE = F2_CLIENTE
					And E1_LOJA = F2_LOJA
					And SE1.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E1_SALDO) From SE1010 SE1
					Where E1_FILIAL = F2_FILIAL
					And E1_NUM = F2_DOC
					And E1_CLIENTE = F2_CLIENTE
					And E1_LOJA = F2_LOJA
					And E1_SALDO > 0 
					And E1_BAIXA = ''
					And SE1.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E1_SALDO) From SE1010 SE1
					Where E1_FILIAL = F2_FILIAL
					And E1_NUM = F2_DOC
					And E1_CLIENTE = F2_CLIENTE
					And E1_LOJA = F2_LOJA
					And E1_SALDO = 0 
					And E1_BAIXA <> ''
					And SE1.D_E_L_E_T_ = ''),0),
					

	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F2_TIPO = 'N' Then 'NF Normal'
	When F2_TIPO = 'C' Then 'Compl. Preco'
	When F2_TIPO = 'D' Then 'Devolucao'
	When F2_TIPO = 'I' Then ' NF Compl. ICMS'
	When F2_TIPO = 'P' Then 'NF Compl. IPI'
	When F2_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,


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


*From SF2010 SF2 With(Nolock)

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F2_CLIENTE
	And A1_LOJA = F2_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F2_CLIENTE
	And A2_LOJA = F2_LOJA

	Inner Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F2_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F2_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD2010 SD2 With(Nolock) -- NF Sadia Itens
	On D2_FILIAL = F2_FILIAL
	And D2_CLIENTE = F2_CLIENTE
	And D2_LOJA = F2_LOJA  
	And D2_DOC = F2_DOC
	And SD2.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 With(Nolock) --Produtos 
	On D2_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F2_FILIAL

	/*Inner Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D2_FILIAL
	And B2_COD = D2_COD 
	And SB2.D_E_L_E_T_ = ''*/

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F2_CHVNFE
	And F3_FILIAL = F2_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F2_CHVNFE
	And FT_ITEM = D2_ITEM
	And FT_FILIAL = F2_FILIAL
	And FT_CLIEFOR = D2_CLIENTE
	And FT_LOJA = D2_LOJA
	And SFT.D_E_L_E_T_ = ''

	Left Join SC6010 SC6 With(Nolock) -- PV Itens 
	On C6_FILIAL = D2_FILIAL
	And C6_NOTA = D2_DOC
	And C6_NUM = D2_PEDIDO
	And C6_ITEM = D2_ITEMPV

	Left Join SC5010 SC5 With(Nolock) -- PV 
	On C5_FILIAL = C6_FILIAL 
	And C5_NUM = C6_NUM 
	And SC5.D_E_L_E_T_ = ''

	Left Join SC9010 SC9 With(Nolock) --PV Liberados
	On C9_FILIAL = C5_FILIAL 
	And C9_PEDIDO = C5_NUM
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 With(Nolock) -- TES
	On D2_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ =''

Where F2_DOC = '000141040' and F2_FILIAL = '02'
and SF2.D_E_L_E_T_ =''


Select * From SC6010




-- Analise NF Entrada - Valição duplicidade
Declare @FILDE Char(2), @FILATE Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODFORNECDE Char(6), @CODFORNECFIM Char(6),
@NFNUMINI Char(6),@NFNUMFIM Char(6), @LOJADE Char(2), @LOJAATE Char(2)
Set @FILDE = '01' 
Set @FILATE = '03'
Set @DATADE = '20231201'
Set @DATAFIM = '20231231'
Set @CODFORNECDE = '000000'
Set @CODFORNECFIM  = '999999'
Set @NFNUMINI = '00000000'
Set @NFNUMFIM = '999999999'
Set @LOJADE = '00'
Set @LOJAATE = '99'

Select F1_FILIAL,A2_CGC,F1_VALBRUT,F1_EMISSAO,Count(F1_DOC) AS NF,
NF_NUM = (Isnull((Stuff((Select F1_DOC From SF1010 SF1S
							Where SF1S.F1_FILIAL = SF1.F1_FILIAL
							And SF1S.F1_FORNECE = SF1.F1_FORNECE 
							And SF1S.F1_LOJA = SF1.F1_LOJA 
							And SF1S.F1_EMISSAO Between @DATADE and @DATAFIM
							And SF1S.F1_VALBRUT =  SF1.F1_VALBRUT
							And SF1S.F1_EMISSAO = SF1.F1_EMISSAO							
							And SF1S.D_E_L_E_T_ = ''
							Order By F1_DOC
							For XML Path ('')),1
							
							
							,1,'')),'')),

Case 
When Count(F1_DOC) > 1 Then 'xxx Analisar xxx'
When Count(F1_DOC) = 1 Then 'vvv Validado vvv'
Else 'xxxErrorxxx'
End As Status_
From SF1010 SF1

	Inner Join SA2010 SA2
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''

Where F1_FILIAL Between @FILDE and @FILATE
And F1_FORNECE Between @CODFORNECDE and @CODFORNECFIM
And F1_LOJA Between @LOJADE and @LOJAATE
And F1_DOC Between @NFNUMINI and @NFNUMFIM
And F1_EMISSAO Between @DATADE and @DATAFIM
--And F1_FORNECE Not in  ('000002')
And SF1.D_E_L_E_T_ = ''
Group By A2_CGC,F1_FORNECE,F1_FILIAL,F1_LOJA,F1_VALBRUT,F1_EMISSAO
Having Count(F1_DOC) > 1
Order By 5 desc


--TABELA METAS BI               
Select * From ZZP010

Select * From SX2010
Where X2_CHAVE = 'ZZP'

Select C6_ZZPVORI,* From SC6010
Where C6_FILIAL = 02 and C6_NUM = '103357'
And D_E_L_E_T_ = ''

Select C6_ZZPVORI,* From SC6010
Where C6_FILIAL = 01 and C6_NUM = '403028'
And D_E_L_E_T_ = ''






-- Produtos 
-- Estrutura Codigo do Produto

 -- Nome Produto  - 03 - POS 1-3
Select * From SZ1010
Where Z1_COD Like ('8%')
And  D_E_L_E_T_ =''
Order By Z1_COD

   -- Bitola - 02 - POS 4-5
 Select * From SZ2010
 Where  D_E_L_E_T_ =''


 -- Cores - 02 - POS 6-7
 Select * From SZ3010
 Where  D_E_L_E_T_ =''

 -- Classe - 01 - POS 8
Select * From SX5010
Where X5_TABELA = 'Z1' 
 and D_E_L_E_T_ =''

-- Especialidade - 02 - POS 9-10
 Select * From SZ4010
 Where  D_E_L_E_T_ =''

-- Tipo - náo compoe codigo do produto
Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE = 'PA'
 and D_E_L_E_T_ =''











-- Analise se PV esta conforme Cadastro de Produtos
-- 
-- PV Itens
Select C6_NUM,C6_ITEM,C6_PRODUTO,B1_XPORTAL,B1_BOBINA,B1_ROLO,C6_QTDVEN,C6_LANCES,C6_METRAGE,C6_ACONDIC,

	--Verifica Tipo de Acondicionamento 
	Case 
	When C6_ACONDIC = 'B' Then 'BOBINA'
	When C6_ACONDIC = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

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
	End AS RECOMENDACAO,


C5_LUCROBR
From SC6010 SC6 With(Nolock)

	--Produtos
	Inner Join SB1010 SB1 With(Nolock)
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	--Produtos
	Inner Join SC5010 SC5 With(Nolock)
	On C5_NUM = C6_NUM
	And C5_FILIAL = C6_FILIAL 
	And SC5.D_E_L_E_T_ = ''



Where C6_FILIAL = '01' and C6_NUM In ('417858')
and C6_ACONDIC <> 'B' 
And SC6.D_E_L_E_T_ = ''
Order By 1,2

--Tipos de Acondionamento 
--{B','BOBINA'}
--{'R','ROLO'}
--{'C','CARRETEL PLASTICO'}
--{'M','CARRETEL MADEIRA'}
--{'L','BLISTER'}


-- Generica s
Select * From SX5010
Where X5_TABELA = 'S2'
And D_E_L_E_T_ = ''

-- TES
Select * From SF4010
Where F4_CODIGO = '434'
And D_E_L_E_T_ = ''

--NF Entrada 
Select * From SF1010
Where F1_DOC = '000104888'
And F1_FORNECE = 'V00251'
And D_E_L_E_T_ = ''

--NF Entrada 
Select D1_CF,D1_TES,D1_EMISSAO,* From SD1010
Where D1_FILIAL = '02'
And D1_FORNECE = 'V00251'
And D_E_L_E_T_ = ''
Order By 3

--Livros Fiscais Cab.
Select F3_CFO,* From SF3010
Where F3_NFISCAL = '000104888'
And F3_CLIEFOR = 'V00251'
And D_E_L_E_T_ = ''

--Livros Fiscais Itens 
Select FT_CFOP,* From SFT010
Where FT_NFISCAL = '000104888'
And FT_CLIEFOR = 'V00251'
And D_E_L_E_T_ = ''

-- Parametros 
Select * From SX6010
where X6_VAR = 'MV_ESTADO '
And D_E_L_E_T_ = ''

--Empresas 
Select * From SYS_COMPANY



                                                  




 -- Pesagem 
Select ZL_UNMOV,ZL_STATUS,ZL_COMENTS,* From SZL010
Where ZL_FILIAL = '01' and ZL_NUM In ('361590') 
and D_E_L_E_T_ ='' 

--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,ZE_STATUS,ZE_CONDIC,ZE_SITUACA,ZE_SEQOS,* From SZE010
Where ZE_FILIAL In ('01') and ZE_PRODUTO In ('1141404401') 
and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
And ZE_NUMBOB In ('2293339')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa   


-- SC2 - OPs
Select * From SC2010
Where C2_FILIAL = '02'and C2_PRODUTO = '1140902401'
And C2_EMISSAO >= '20240101'
and D_E_L_E_T_ ='' 



-- Excessão Fscal 
Select * From SF7010

-- Genericas 
Select * From SX5010
Where X5_TABELA In ('21')
And D_E_L_E_T_ =''


-- Fornecedor 
Select A2_SIMPNAC,A2_GRPTRIB,* From SA2010
Where A2_GRPTRIB <> ''
And D_E_L_E_T_ =''

-- Fornecedor 
Select A2_SIMPNAC,A2_GRPTRIB,* From SA2010
Where A2_COD = 'VOPACJ' and A2_LOJA = '01' 
And D_E_L_E_T_ =''

-- Produtos
Select B1_GRTRIB,B1_ORIGEM,* From SB1010
Where B1_COD = 'SV05000020'
And D_E_L_E_T_ =''

-- TES 
Select F4_PISCOF,F4_SITTRIB,* From SF4010
Where F4_CODIGO In ('034')
And F4_PISCOF = '3'
And D_E_L_E_T_ = ''
--F4_PISCOF
--1=PIS;2=COFINS;3=Ambos;4=Nao Considera
--F4_SITTRIB 
--Informar o codigo da Tributacao do ICMS conforme a Tabela B da Situacao Tributaria.

-- Excessao Fiscal 
Select F7_GRTRIB,F7_ALIQPIS,F7_ALIQCOF,F7_ORIGEM,* From SF7010
--Where F7_ALIQPIS > 0 or F7_ALIQCOF > 0
--And D_E_L_E_T_ = ''
Order By 1
--F7_GRTRIB
--Grupo Trib: Código do grupo de tributação cadastrado.
--F7_TIPOCLI
--Tipo de Cliente: Tipo do cliente para o qual a regra se aplica. 
--O tipo de cliente é uma informação inserida no Cadastro de Clientes. 
--Caso informado * (asterisco), a regra será válida para todos os clientes.
--F7_GRPCLI 
--Grp.Cli/For: Junto com o tipo de cliente/fornecedor, faz a vinculação da exceção fiscal com o cadastro do cliente/fornecedor. 
--Não existe um cadastro para grupo de cliente/fornecedor, 
--portanto é necessário se atentar no valor preenchido nesse campo para que seja o mesmo no cadastro do cliente/fornecedor.
--F7_ALIQPIS
--Aliq.PIS: Alíquota do PIS que será utilizada sempre que a exceção fiscal for aplicada.
--F7_ALIQCOF
--Aliq.Cof.: Alíquota do COFINS que será utilizada sempre que a exceção fiscal for aplicada.
--F7_ORIGEM
--Origem: Informe o Código de Origem do Produto que será utilizado como chave para utilização da Exceção Fiscal.
--F7_SITTRIB
--Sit Trib: Informe o Código de Situação Tributária do ICMS que será utilizado como chave para utilização da Exceção Fiscal.

-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_ESTADO','MV_TPSOLCF')
And D_E_L_E_T_ = ''


--Genericas
Select * From SX5010 
Where X5_TABELA In ('21','S0','S2') and X5_FILIAL = '01'
And D_E_L_E_T_ = ''
Order By X5_TABELA

-- Grupo Tributação 
-- S0 - Origem do Produto 
-- S2 - Situação da Tributação 




-- Naturezas Financeiras 
Select ED_CALCCOF,ED_CALCPIS,* From SED010
Where ED_CODIGO = 'D0316'
And D_E_L_E_T_ = ''


Select F7_GRTRIB,F7_GRPCLI,F7_ALIQPIS,F7_ALIQCOF,F7_ORIGEM,F7_TIPOCLI,
A2_GRPTRIB,A2_COD,A2_NOME,
B1_GRTRIB,B1_TIPO,B1_COD,B1_DESC,B1_GRUPO,
A1_GRPTRIB,A1_COD,A1_NOME,A1_TIPO,
* From SF7010 SF7

	Left Join SA2010 SA2
	On A2_GRPTRIB = F7_GRPCLI
	And SA2.D_E_L_E_T_ = ''

	Left Join SB1010 SB1
	On B1_GRTRIB = F7_GRTRIB
	And SA2.D_E_L_E_T_ = ''

	Left Join SA1010 SA1
	On A1_GRPTRIB = F7_GRPCLI
	And A1_TIPO = F7_TIPOCLI
	And SA1.D_E_L_E_T_ = ' '

Where F7_FILIAL = '01' And F7_GRTRIB = '007' and F7_GRPCLI = '007'
--And F7_ALIQPIS > 0 or F7_ALIQCOF > 0
And SF7.D_E_L_E_T_ = ''




-- NF Entrada PIS 
Select D1_ALQPIS,D1_ALQCOF,* From SD1010
Where D1_COD = 'SV05000020'
And D_E_L_E_T_ = ''

Select Distinct D1_TES From SD1010 SD1

	Inner Join SF4010 SF4
	On D1_TES = F4_CODIGO 

Where D1_COD = '2010000000'
And F4_PISCOF = '3'
And SD1.D_E_L_E_T_ = ''





-- Excessao Fiscal - TESxNF Entrada x Fornecedor x Produto 
Select D1_COD,D1_ALQPIS,D1_ALQCOF,D1_TES,F4_TEXTO,
A2_GRPTRIB,A2_COD,A2_NOME,
B1_GRTRIB,B1_TIPO,B1_COD,B1_DESC,B1_GRUPO,
F7_GRTRIB,F7_GRPCLI,F7_ALIQPIS,F7_ALIQCOF,F7_ORIGEM,F7_TIPOCLI,
FT_ALIQPIS,FT_ALIQCOF,
FT_BASECOF,FT_VALCOF,FT_BASEPIS,FT_VALPIS,
D1_BASECOF,D1_VALCOF,D1_BASEPIS,D1_VALPIS,

* From SD1010 SD1

	Inner Join SF4010 SF4
	On D1_TES = F4_CODIGO 

	Inner Join SB1010 SB1
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SA2010 SA2
	On A2_COD = D1_FORNECE
	And A2_LOJA = D1_LOJA
	And SA2.D_E_L_E_T_ = ''

	Inner Join SF7010 SF7
	On A2_GRPTRIB = F7_GRPCLI
	And  B1_GRTRIB = F7_GRTRIB
	And SF7.D_E_L_E_T_ = ''

	Inner Join SFT010 SFT 
	On D1_FILIAL = FT_FILIAL
	And D1_DOC = FT_NFISCAL
	And D1_COD = FT_PRODUTO
	And SFT.D_E_L_E_T_ = ''

Where F7_GRPCLI <> '' And F7_GRPCLI <> ''
And F4_PISCOF = '3'
And (D1_ALQPIS > '0' or D1_ALQCIDE > '0')
And SD1.D_E_L_E_T_ = ''





-- Produto x Fornecedor 
Select A5_UMNFE,* From SA5010
Where A5_FORNECE In ('000130') and A5_PRODUTO In ('PE4029A') and D_E_L_E_T_ ='' 


-- Pedidos de compras - Soma
Select C7_PRODUTO,C7_NUM,C7_UM,C7_SEGUM,Sum(C7_QUANT)As QUANT, Sum (C7_QTSEGUM) As QUANT2,Sum(C7_QUJE) AS ENTREGUE,Sum(C7_QTDACLA) AS CLASSIFICAR From SC7010
Where C7_FILIAL = '01' and C7_NUM In ('015702' ) and D_E_L_E_T_ = ''
--and C7_FORNECE In ('V00329')  
and C7_PRODUTO = 'PE4029A'
and C7_ENCER = '' and C7_RESIDUO = ''
--and (C7_QUANT<C7_QUJE)
Group By  C7_PRODUTO,C7_NUM,C7_UM,C7_SEGUM



----SDS - Cabecalho importacao XML NF-e
Select * From SDS010
Where DS_CHAVENF = '35240208221212000100550000000272761030272763'
And D_E_L_E_T_ = ''

--SDT - Itens importacao XML NF-e
Select DT_TES,DT_DOC,* From SDT010
Where DT_FILIAL = '01' and DT_DOC In ('001086642') and D_E_L_E_T_ = ''
And DT_FORNEC In ('000002')
And D_E_L_E_T_ = ''


--PV Itens 
Select * From SC6010
Where C6_FILIAL = '02' and C6_NUM = '106770'
And C6_ITEM = '17'
And D_E_L_E_T_ = ''

--PV Lib
Select * From SC9010
Where C9_FILIAL = '02' and C9_PEDIDO = '106770'
And C9_ITEM = '17'
And D_E_L_E_T_ = ''

--Estoque 
Select * From SB2010
Where B2_FILIAL ='02' And  B2_QATU > 0 and B2_LOCAL = '20'
And D_E_L_E_T_ = ''

-- Estoque por Endereço
Select * From SBF010
Where BF_FILIAL = '02' and BF_QUANT > 0 and BF_LOCAL = '20'
And D_E_L_E_T_ = ''

Select B2_COD,Sum(B2_QATU) From SB2010
Where B2_FILIAL ='02' And  B2_QATU > 0 and B2_LOCAL = '20'
And D_E_L_E_T_ = ''
Group By B2_COD

Select BF_PRODUTO, Sum(BF_QUANT) From SBF010
Where BF_FILIAL = '02' and BF_QUANT > 0 and BF_LOCAL = '20'
And D_E_L_E_T_ = ''
Group By BF_PRODUTO


----SBF - Saldos por Endereco x SDC - Composicao do Empenho - Ajustes
SELECT BF_FILIAL, BF_PRODUTO, BF_LOCAL, BF_LOCALIZ, BF_QUANT, BF_EMPENHO, 
--update SBF010 set BF_EMPENHO = 
		(SELECT ISNULL(SUM(SB2.B2_QATU),0) QTDSB2
		FROM SB2010 SB2  With(Nolock)
		WHERE BF_FILIAL = B2_FILIAL
		AND BF_PRODUTO = B2_COD
		AND BF_LOCAL = B2_LOCAL
		And BF_LOCAL = '20'
		And B2_LOCAL = '20'
		AND BF_LOCALIZ = 'PROD_PCF'
		And BF_QUANT >0
		And B2_QATU > 0
		AND BF.D_E_L_E_T_ = SB2.D_E_L_E_T_) As SB2_QUANT
FROM SBF010 BF With(Nolock)
WHERE BF_FILIAL IN ('01','02')
		AND BF_LOCALIZ = 'PROD_PCF'
		And BF_LOCAL = '20'
		And BF_QUANT >0
AND BF_QUANT <>
		(SELECT ISNULL(SUM(SB2_E.B2_QATU),0) QTDSB2
		FROM SB2010 SB2_E  With(Nolock)
		WHERE BF_FILIAL = B2_FILIAL
		AND BF_PRODUTO = B2_COD
		AND BF_LOCAL = B2_LOCAL
		AND BF_LOCALIZ = 'PROD_PCF'
		And BF_LOCAL = '20'
		And B2_LOCAL = '20'
		And BF_QUANT >0
		And B2_QATU > 0
		AND BF.D_E_L_E_T_ = SB2_E.D_E_L_E_T_)
AND BF.D_E_L_E_T_ = ''
Order By 2


Select B2_FILIAL,BF_FILIAL,B2_COD,BF_PRODUTO,B2_LOCAL,BF_LOCAL,B2_QATU,BF_QUANT,
(B2_QATU - BF_QUANT) As QUANT_DIF,
	Case
	When B2_QATU - BF_QUANT = 0
	Then '*******'
	Else 'XXXXXXX'
	End as Valid,
	
* From SBF010 SBF
	
	Left Join SB2010 SB2
	On B2_FILIAL = BF_FILIAL
	And B2_COD = BF_PRODUTO
	And BF_LOCAL = B2_LOCAL
	And B2_QATU > 0
	And B2_LOCALIZ = ''
	And SB2.D_E_L_E_T_ = ''

Where BF_FILIAL In ('02') and BF_LOCAL In ('20') and BF_LOCALIZ In ('PROD_PCF')
And BF_QUANT > 0
And (B2_QATU - BF_QUANT)  <> 0
And SBF.D_E_L_E_T_ = ''
Order By 10


--SBF - Saldos por Endereco x SB2 Estoque - Desbalanceamento
Select BF_FILIAL,BF_PRODUTO,BF_LOCAL,
Sum(BF_QUANT) As BF_QUANT, Isnull(Sum(B2_QATU),0) As B2_QATU,
(Isnull(Sum(BF_QUANT),0))-(Isnull(Sum(B2_QATU),0)) As DIF,
Isnull(Count(B2_COD),0) as B2_COD, Isnull(Count(BF_PRODUTO),0) as BF_PRODUTO

From SBF010 SBF
	
	Left Join SB2010 SB2
	On B2_FILIAL = BF_FILIAL
	And B2_COD = BF_PRODUTO
	And BF_LOCAL = B2_LOCAL
	And BF_QUANT = B2_QATU
	And B2_QATU > 0
	And B2_LOCALIZ = ''
	And SB2.D_E_L_E_T_ = ''

Where BF_FILIAL In ('02') and BF_LOCAL In ('20') and BF_LOCALIZ In ('PROD_PCF')
And BF_QUANT > 0
And SBF.D_E_L_E_T_ = ''
Group By BF_FILIAL,BF_PRODUTO,BF_LOCAL
Having Count(B2_COD) = 0 or (Sum(BF_QUANT)-Sum(B2_QATU)) <0 Or (Sum(BF_QUANT)-Sum(B2_QATU)) >0

Select * From SD1010
Where D1_DOC = '000390382'

--Clientes 
Select A1_EMAIL,* From SA1010
Where A1_CGC = '05164667000909 ' Or (A1_COD = '009713'And A1_LOJA = '01')
And D_E_L_E_T_ = ''



-- PV Itens 
Select * From SC6010
Where C6_FILIAL = '02' And C6_NUM = '106770'
And C6_ITEM = '17'
And D_E_L_E_T_ = ''


-- PV Lib
Select C9_ITEMREM,* From SC9010
Where C9_FILIAL = '02' And C9_PEDIDO = '107982'
--And C9_ITEM = '17'
And D_E_L_E_T_ = ''





-- Portal - Cab. Orcamento 
Select ZP5_STATUS,* From ZP5010
Where ZP5_NUM In ('362074') --or ZP5_CLIENT = '028171'
And D_E_L_E_T_ = ''
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado          

-- ITENS ORCAMENTOS PORTAL   
Select * From ZP6010
Where ZP6_NUM In ('362074')
And D_E_L_E_T_ = ''




--PV Cab. 
Select C5_DOCPORT,* From SC5010 SC5
Where C5_FILIAL = '02' 
And (C5_DOCPORT = '362074' or C5_NUM = '107982')
And D_E_L_E_T_ = ''


--PV Itens  
Select C6_NUM,* From SC6010 SC6
Where C6_FILIAL = '02' 
And C6_NUM In ('107982','108060')
And D_E_L_E_T_ = ''
Order By C6_ITEM

--PV Lib
Select * From SC9010 SC9
Where C9_FILIAL = '02' 
And C9_PEDIDO In ('107982','108060')
And D_E_L_E_T_ = ''

--CORES ITENS ORCAMENTOS        
Select * From ZP9010
Where ZP9_NUM = '395913'
And D_E_L_E_T_ = ''


-- Clientes 
Select * From SA1010 
Where A1_COD = '015824'
And D_E_L_E_T_ = ''




-- EDI CTE 
Select 
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_OBS)),'') AS [OBS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_EDIMSG)),'') AS [MGS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_ZZMSG)),'') AS [ZZMGS],
GXG_EDISIT, GXG_DTIMP,GXG_CTE,

	Case 
	When GXG_EDISIT = '1'  Then 'Importado'
	When GXG_EDISIT = '2'  Then 'Importado com Erro'
	When GXG_EDISIT = '3'  Then 'Rejeitado'
	When GXG_EDISIT = '4'  Then 'Processado'
	When GXG_EDISIT = '5'  Then 'Erro Impeditivo'
	Else 'ANALISAR'
	End AS Status_EDI,

* From GXG010
Where GXG_FILIAL In ('01','02','03') and GXG_DTEMIS >= '20240101'
And GXG_EDISIT In ('2','3','5')
And GXG_CTE In ('35240813445356000180570020000011781000377571','31240734327498000709570130000010891727091371')
And D_E_L_E_T_ = ''
Order By 4,5




Select GXG_FILIAL,GXG_EDISIT, Count(GXG_EDISIT)QTDE,
	Case 
	When GXG_EDISIT = '1'  Then 'Importado'
	When GXG_EDISIT = '2'  Then 'Importado com Erro'
	When GXG_EDISIT = '3'  Then 'Rejeitado'
	When GXG_EDISIT = '4'  Then 'Processado'
	When GXG_EDISIT = '5'  Then 'Erro Impeditivo'
	Else 'ANALISAR'
	End AS Status_EDI


From GXG010
Where GXG_FILIAL In ('01','02','03') and GXG_DTEMIS >= '20240101'
And D_E_L_E_T_ = ''
Group By GXG_FILIAL,GXG_EDISIT

--FX7 - Configuracoes Gerais TSS
Select * From FX7010

Select F1_CHVNFE,F1_ESPECIE,* From SF1010
Where F1_EMISSAO >= '20240101'
And F1_ESPECIE = 'CTE'
And D_E_L_E_T_ = ''

Select * From SX2010
Where X2_CHAVE = 'ZP9'

-- Links TSS 
Select * From SPED158

-- Parametros 
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2, X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_UFBDST ','MV_UFBASDP') 
And D_E_L_E_T_ = ''


-- Campos
Select * From SX3010
Where X3_CAMPO Like ('C00%')





 -- Pesagem -- Status 
Select ZL_FILIAL,ZL_STATUS,Count(ZL_STATUS)As STATUS_,
	Case 
	When ZL_STATUS = 'A' Then 'A PROCESSAR'
	When ZL_STATUS = 'E' Then 'ERRO'
	When ZL_STATUS = 'Q' Then 'BLOQUEIO CQ'
	When ZL_STATUS = 'P' Then 'PROCESSADO'
	Else 'ANALISAR'
	End as OBS_

From SZL010
Where ZL_STATUS In ('A','E','Q','P')
And ZL_DATA >= '20240905'
And D_E_L_E_T_ =' '
Group By ZL_FILIAL,ZL_STATUS
Order By 1,2


--SZL > Controle de Pesagem
Select ZL_UNMOV,ZL_TIPO,ZL_STATUS,ZL_COMENTS,
	Case 
	When ZL_STATUS = 'A' Then 'A PROCESSAR'
	When ZL_STATUS = 'E' Then 'ERRO'
	When ZL_STATUS = 'Q' Then 'BLOQUEIO CQ'
	When ZL_STATUS = 'P' Then 'PROCESSADO'
	Else 'ANALISAR'
	End as OBS_,
* From SZL010
Where ZL_FILIAL In ('01') --and ZL_STATUS In ('A','C','E','Q')
And ZL_NUM In ('445136')
And D_E_L_E_T_ ='' 
-- ZL_TIPO - P=Producao;D=Prod.+1500Kg;R=Retrabalho;T=Troca Etiqueta;S=Sucata;F=Troca Filial;U=Prod.Unimov
-- ZL_STATUS - A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ      

-- SD3 - Mov. Internos
Select D3_ZZUNMOV, * From SD3010
Where D3_ZZUNMOV In ('2958155','2958172')
And D3_ESTORNO = ''
--And D3_DTLANC >= '20240101'
And D_E_L_E_T_ ='' 

-- TM 
Select * From SF5010
Where F5_CODIGO In ('504','006')
And D_E_L_E_T_ ='' 





-- NF Ent Itens 
Select D1_DOC,D1_FILIAL,D1_COD, B1_DESC,B1_TIPO, SX5.X5_DESCRI,B1_GRUPO,BM_DESC,F1_FORNECE,A2_NOME,F1_ESPECIE,SX5ESP.X5_DESCRI,
D1_QUANT,D1_VUNIT,D1_TOTAL,
(D1_QUANT*D1_VUNIT) As D1_CUS_CALC, (D1_TOTAL/D1_VUNIT) As D1_QUANT_CALC,
D1_TES, F4_TEXTO,F4_TIPO,F4_ESTOQUE

From SD1010 SD1 With(Nolock)

	Inner Join SB1010 SB1 With(Nolock) -- Produtos
	On D1_COD = B1_COD
	And SD1.D_E_L_E_T_ = ''
		
	Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
	On X5_TABELA = '02' 
	And X5_CHAVE = B1_TIPO
	And SX5.D_E_L_E_T_ = ''

	Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
	On BM_GRUPO = B1_GRUPO
	And SBM.D_E_L_E_T_ = ''

	Inner Join SF1010 SF1 With(Nolock) -- NF Entrada Cab
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''

	Inner Join SA2010 SA2 -- Fornecedores 
	On D1_FORNECE = A2_COD
	And SA2.D_E_L_E_T_ = ''
		
	Inner Join SX5010 SX5ESP
	On SX5ESP.X5_FILIAL = F1_FILIAL
	And SX5ESP.X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And SX5ESP.X5_CHAVE = F1_ESPECIE
	And SX5ESP.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 
	On F4_CODIGO = D1_TES
	And SF4.D_E_L_E_T_ = ''
		
Where D1_FILIAL In ('01') and D1_COD In ('2100400000')
And F1_EMISSAO Between '20240101' and '20240131'
And B1_TIPO = 'MP'
And SD1.D_E_L_E_T_ = ''



-- Campos
Select * From SX3010
Where X3_CAMPO In ('F7_GRTRIB','F7_GRPCLI','A1_GRPTRIB','A2_GRPTRIB','B1_GRTRIB')
And D_E_L_E_T_ = ''
Order By X3_TAMANHO

/*4 - Verifique no configurador se o tamanho campos abaixo estão corretos:
Obs.: Se o tamanho de algum deles estiver diferente, a exceção fiscal não será aplicada corretamente.
F7_GRTRIB = CARACTER, 6
F7_GRPCLI = CARACTER, 3
A1_GRPTRIB = CARACTER, 3
A2_GRPTRIB = CARACTER, 3
B1_GRTRIB = CARACTER, 6*/

--Campos
Select * From SX3010
Where X3_CAMPO In ('B1_PPIS','B1_PCOFINS','F7_ALIQPIS','F7_ALIQCOF','D1_ALQIMP5','D1_ALQIMP6','D2_ALQIMP5','D2_ALQIMP6','FT_ALIQPIS','FT_ALIQCOF')
And D_E_L_E_T_ = ''
Order By X3_TAMANHO

/*No cadastro de Produtos: SB1 (B1_PPIS, B1_PCOFINS) 
Grupo de tributação (Caso utilize exceção fiscal) SF7 (F7_ALIQPIS, F7_ALIQCOF) 
Notas de entrada SD1 (D1_ALQIMP5(PIS), D1_ALQIMP6(COFINS)) 
Notas de saída SD2 (D2_ALQIMP5(PIS), D2_ALQIMP6(COFINS)) 
Livro Fiscal Item SFT (FT_ALIQPIS, FT_ALIQCOF)
Exemplo para alteração dos campos:
Tamanho 7
Decimal 4*/


--SR0 - Itens de Beneficios***
--RG2 - HISTORICO DE BENEFICIOS
--SR0 - Itens de Beneficios
--RFO - Definicao de Beneficios
--SRN - Meios de Transporte
--SM7 - Cadastro de beneficios***


-- PV 
Select C5_SEMANA,* From SC5010
Where C5_FILIAL = '01' and C5_NUM = '412792'
And D_E_L_E_T_ = ''

-- PV 
Select C6_SEMANA,* From SC6010
Where C6_FILIAL = '01' and C6_NUM = '412792'
And D_E_L_E_T_ = ''

-- Lanc. Contabeis 
Select * From CT2010
Where CT2_HIST Like ('%000000386%')
And CT2_DATA Between '20240101' and '20240131'
And D_E_L_E_T_ = ''

-- NF Entrada 
Select * From SF1010
Where F1_FORNECE = 'V00AM8' and F1_DOC = '000000386'
And D_E_L_E_T_ = ''

-- Fornecedores
Select A2_ZZITEM,* From SA2010
Where A2_COD In ('V00AM8','VOPAMA','VOPAVS','VOOB21')
And D_E_L_E_T_ = ''

--Genericas
Select * From SX5010
Where X5_TABELA = '42' And X5_CHAVE Like ('CTE%')
And D_E_L_E_T_ = ''




Select * From SD1010
Where D1_DOC In ('000144091')
And D1_FILIAL = '01'
and D_E_L_E_T_ =''

-- Contra Prova Contab.
Select CTK_TPSALD,CTK_TABORI,* From CTK010 With(Nolock)
Where CTK_ITEMD In ('FV00AM801','FVOPAMA01','FVOPAVS01','FVOOB2101')
And CTK_DATA Between '20240101' and '20240131'
and D_E_L_E_T_ =''

--Rastreamento Contab.
Select CV3_TABORI,* From CV3010
Where CV3_ITEMD In ('FV00AM801','FVOPAMA01','FVOPAVS01','FVOOB2101')
And CV3_DTSEQ Between '20240101' and '20240131'
and D_E_L_E_T_ =''

-- Lançamentos Contabeis 
Select * From CT2010

-- Fornecedores
Select * From SA2010
Where A2_COD In ('V00AM8','VOPAMA','VOPAVS','VOOB21')
And D_E_L_E_T_ = ''


-- LAnçamentos PAdrao
Select * From CT5010
Where CT5_LANPAD In ('678') and CT5_VLR01 Like ('%017%')
And CT5_LANPAD In ('650')
and D_E_L_E_T_ =''
Order By CT5_SEQUEN

--TES
Select * From SF4010
Where F4_CODIGO In ('017','034','061','165','174')
and D_E_L_E_T_ =''

-- Contra Prova Contab.
Select CTK_TPSALD,CTK_TABORI,* From CTK010 With(Nolock)
Where CTK_ITEMD In ('FV00AM801','FVOPAMA01','FVOPAVS01','FVOOB2101')
And CTK_DATA Between '20240201' and '20240229'
and D_E_L_E_T_ =''

--Rastreamento Contab.
Select CV3_TABORI,* From CV3010
Where CV3_TABORI In ('SD1') and CV3_LP In ('650') --and CV3_LPSEQ In ('010')
And CV3_DTSEQ Between '20240201' and '20240229'
and D_E_L_E_T_ =''






-- Pedido de Vendas - Cab.
Select C5_ZZPVDIV,C5_ENDENT1,C5_ENDENT2,C5_OBS,C5_NOTA,C5_DTLICRE, * From SC5010
Where C5_FILIAL In ('02') and C5_NUM In ('108605')  and D_E_L_E_T_ =''

-- PV - Liberados 
Select C9_BLEST,C9_NFISCAL,* From SC9010
Where C9_FILIAL = '02' and C9_PEDIDO In ('108605') and D_E_L_E_T_ =''

-- Pedido de Vendas Itens
Select C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_DATFAT,C6_NOTA, * From SC6010
Where C6_FILIAL = '02' and C6_NUM In ('108605')  and D_E_L_E_T_ =''
--And C6_DATFAT = '' and C6_NOTA = ''
Order By 6





Select 
	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,

* From SF1010

Where F1_DOC In ('000144091')
And F1_FILIAL = '01'
and D_E_L_E_T_ =''

Select D1_CUSTO,* From SD1010
Where D1_DOC In ('000144091')
And D1_FILIAL = '01'
and D_E_L_E_T_ =''



Select 
Case 
	When F2_TIPO = 'N' Then 'NF Normal'
	When F2_TIPO = 'C' Then 'Compl. Preco'
	When F2_TIPO = 'D' Then 'Devolucao'
	When F2_TIPO = 'I' Then ' NF Compl. ICMS'
	When F2_TIPO = 'P' Then 'NF Compl. IPI'
	When F2_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

* From SF2010
Where F2_DOC In ('000144091')
And F2_FILIAL = '02'
and D_E_L_E_T_ =''


Select D2_CUSTO1,* From SD2010
Where D2_DOC In ('000144091')
And D2_FILIAL = '02'
and D_E_L_E_T_ =''

--Campos
 Select * From SX3010
 Where X3_CAMPO In ('A2_BANCO','A2_AGENCIA','A2_DVAGE','A2_NUMCON','A2_DVCTA')
 and D_E_L_E_T_ =''

 -- C/C Fornecedores 
 Select * From FIL010
  and D_E_L_E_T_ =''

 -- Fornecedores 
 Select A2_CGC,A2_NOME,A2_BANCO, A2_AGENCIA, A2_DVAGE, A2_NUMCON,A2_DVCTA,
 * From SA2010
 Where (A2_BANCO <> '' or A2_AGENCIA <> '' or A2_DVAGE <> '' or A2_NUMCON <> '' or A2_DVCTA <> '')
  and D_E_L_E_T_ =''

  -- Parametros 
  Select X6_VAR,X6_CONTEUD,X6_DESCRIC,X6_DESC1,X6_DESC2,* From SX6010
  Where X6_VAR In ('MV_IPIOUT','MV_EIPIOUT','MV_IPIDEV','MV_EIPIDEV')
  and D_E_L_E_T_ =''






-- PC x NF Entada Itens 
-- SC7 - PC
-- SD1 - NF Entrada Itens 
Select B1_MSBLQL,B2_COD,B1_TIPO,B1_DESC,B1_LOCPAD,B2_QATU,
C7_NUM,D1_DOC,C7_ITEM,D1_ITEMPC,D1_ITEM,C7_QUANT,C7_QUJE,C7_QTDACLA,D1_QUANT,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As SALDO_PC, C7_ENCER, C7_RESIDUO,C7_CONAPRO, C7_APROV,AK_USER, USR_NOME,
	
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

* From SC7010 SC7

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

	Inner Join SB2010 SB2
	On B2_COD = C7_PRODUTO
	And SB2.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1
	On B1_COD = C7_PRODUTO
	And SB1.D_E_L_E_T_ = ''
	   	 
Where C7_NUM In ('019677')
and SC7.D_E_L_E_T_ ='' and SD1.D_E_L_E_T_ = ''

-- Parametros 
Select * FRom SX6010
Where X6_VAR = 'MV_ZZB1F4E'
And D_E_L_E_T_ =''




-- NF Entrada Cab. 
Select F1_DTLANC,F1_ORIGEM,F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO = 0 
					And E2_BAIXA <> ''
					And SE2.D_E_L_E_T_ = ''),0),
	
	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When DS_CHAVENF <> '' 
	Then 'PRE_NOTA'
	Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,
	
	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C7_RESIDUO  = 'S' and D1_PEDIDO <> ''
	Then 'Finalizado' 
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Aberto'
	End RESIDUO,

	Case 
	When C7_ENCER = 'E' and D1_PEDIDO <> ''
	Then 'Encerrado'
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Não Encerrado'
	End Encerrado,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS



From SF1010 SF1 With(Nolock)

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Left Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	Left Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Left Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F1_FILIAL

	Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
	On DS_CHAVENF = F1_CHVNFE
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And SDT.D_E_L_E_T_ = ''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00.D_E_L_E_T_ = ''

	LEFT Join SC7010 SC7 With(Nolock) -- PC
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	Left Join SC8010 SC8 With(Nolock) -- Cotacao
	On C8_FILIAL = C7_FILIAL 
	And C8_NUMPED = C7_NUM 
	And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Left Join SC1010 SC1 With(Nolock) -- SC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''

	Left Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And B2_QATU > 0
	And SB2.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_FILIAL = F1_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''
	
Where F1_CHVNFE In ('35240221667700000104550010000027491603402684')
And F1_FILIAL = '01'
and SF1.D_E_L_E_T_ =''



-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD In ('ME02000007','ME02000008','ME02000009')  and D_E_L_E_T_ = ''


-- Fornecedor 
Select A2_CGC,* From SA2010
Where A2_COD = 'VOOB3S' and D_E_L_E_T_ =''

-- Produto x Fornecedor 
Select * From SA5010
Where A5_FORNECE In ('VOOB3S') and A5_PRODUTO In ('ME02000007','ME02000008','ME02000009')
and D_E_L_E_T_ ='' 


-- Compras 
Select D1_FORNECE,A2_NOME,C7_PRODUTO,C7_DESCRI,C7_NUM,D1_DOC,C7_ITEM,D1_ITEMPC,D1_ITEM,C7_QUANT,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_QTDACLA,D1_QUANT,D1_QTSEGUM,
B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As SALDO_PC, C7_ENCER, C7_RESIDUO,C7_CONAPRO, C7_APROV,AK_USER, USR_NOME,
	
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
	
	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,

* From SC7010 SC7

	LEFT Join SD1010 SD1 With(Nolock)
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	Left Join SF1010 SF1
	On D1_FILIAL = F1_FILIAL
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And SF1.D_E_L_E_T_ = ''

	LEFT JOIN SAK010 SAK
	On AK_COD = C7_APROV
	And AK_FILIAL = C7_FILIAL
	And SAK.D_E_L_E_T_ = ''

	LEFT JOIN SYS_USR USR
	On AK_USER = USR.USR_ID
	And USR.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1
	On B1_COD = C7_PRODUTO 
	and SB1.D_E_L_E_T_ = ''

	/*Inner Join SA5010 SA5
	On A5_FORNECE = C7_FORNECE
	And A5_PRODUTO = C7_PRODUTO
	And SA5.D_E_L_E_T_= ''*/

	Inner Join SA2010 SA2 
	On A2_COD = C7_FORNECE
	And SA2.D_E_L_E_T_= ''	
	   	 
Where C7_FILIAL = '01' And C7_NUM In ('016642') 
And C7_PRODUTO In ('ME02000007','ME02000008','ME02000009')
And C7_ITEM In ('0002','0003','0008','0009','0014')
--And D1_DOC In ('000002749')
and SC7.D_E_L_E_T_ ='' 
Order By 7


-- Controle de Recebimeto / Tolerancia 
Select * From AIC010
Where AIC_PRODUT In ('ME02000007','ME02000008','ME02000009')
and D_E_L_E_T_ ='' 

-- Pre Nota Cab.
Select * From SDS010
Where DS_CHAVENF = '35240221667700000104550010000027491603402684'
and D_E_L_E_T_ =''

--Pre Nota Itens 
Select * From SDT010
Where DT_FILIAL = '01' And DT_DOC = '000002749' and DT_FORNEC = 'VOOB3S' and DT_LOJA = '01'
and D_E_L_E_T_ =''

-- NF Entrada Cab.
Select * From SF1010
Where F1_CHVNFE In ('35240221667700000104550010000027491603402684')
and D_E_L_E_T_ =''

--NF Entrada Itens 
Select * From SD1010
Where D1_DOC = '000002749' and D1_FILIAL = '01' and D1_FORNECE = 'VOOB3S' and D1_LOJA = '01'
and D_E_L_E_T_ =''


-- Logs portal Vendas ********
Select ISNULL(CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP2010
Where ZP2_CODIGO Like ('%000381245') 

-- ZP3 - Orcamento Msg *******
Select ISNULL(CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP3010
Where ZP3_NUMORC In ('395086')
And D_E_L_E_T_ =' '

-- Orçamentos
Select   * From ZP4010
Where ZP4_CODIGO = '395086'



-- ZP9 - Orcamento Itens Cores 
Select * From ZP9010 ZP9
Where ZP9_NUM = '395086'
And ZP9.D_E_L_E_T_ =' '
Order By ZP9_ITEM      

--ITENS ORCAMENTOS PORTAL       
Select * From ZP6010
Where ZP6_NUM = '395086'
And D_E_L_E_T_ =' '

Select * From SX2010
Where X2_CHAVE = 'ZP6'

-- TES Inteligente 
Select ISNULL(CAST(CAST(FM_ZREGRA AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS FM_ZREGRA,
ISNULL(CAST(CAST(FM_JSBUILD AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS FM_JSBUILD,
* From SFM010
Where FM_ZREGRA Like ('%C5_TIPOCLI%') 
and D_E_L_E_T_ =''

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

Where ZP9_NUM = '395086'
And ZP9.D_E_L_E_T_ =' '
Order By 2
--Tipos de Acondionamento 
--{B','BOBINA'}
--{'R','ROLO'}
--{'C','CARRETEL PLASTICO'}
--{'M','CARRETEL MADEIRA'}
--{'L','BLISTER'}


-- SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 
WHERE Z2_COD IN( '08','04','05')


--Produtos
Select B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,* 
From SB1010
where B1_COD Like ('1520604433%')
And D_E_L_E_T_ = ''
--B1_XPORTAL
--Uso Portal  
--S=Sim;N=Nao;E=Especial  



  -- ZP5 - Orcamento Cab. *******
Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010
Where ZP5_NUM In ('395086') and  D_E_L_E_T_ =''
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado ;9= Aguardando Processamento         

-- ZP6 - Orcamento Itens 
Select * From ZP6010
Where ZP6_NUM In ('388055')
And D_E_L_E_T_ =' '

-- ZP9 - Orcamento Itens 
Select * From ZP9010
Where ZP9_NUM In ('388055')
And D_E_L_E_T_ =' '



--DOCUMENTOS ORCAMENTOS         
Select * From ZPA010
Where ZPA_NUM In ('396627')
--or ZPA_NUMDOC In ('107982','108060')
And D_E_L_E_T_ = ''

-- PV Cab.
Select C5_DOCPORT,A1_NOME,* From SC5010 SC5
	Inner Join SA1010 SA1
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C5_FILIAL In ('01','02') and C5_NUM In ('429769')
And SC5.D_E_L_E_T_ = ''
-- C5_DOCPORT - Numero Orcamento Portal 

-- Logs portal Vendas ********
Select ISNULL(CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP2010
Where ZP2_CODIGO = '395086'
And D_E_L_E_T_ = ''

-- ZP3 - Orcamento Msg *******
Select ISNULL(CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP3010
Where ZP3_NUMORC = ('395086')
And D_E_L_E_T_ =' '


Select * From ZPA010
Where ZPA_NUMDOC = '395086'

-- COMPLEMENTO DA OP             
Select Z9_IMPETIQ,Z9_QTDETQ,Z9_ETIQIMP,* From SZ9010
Where Z9_FILIAL = '02' and Z9_PEDIDO = '108185' and Z9_ITEMPV = '02'
And D_E_L_E_T_ =' '
Order By Z9_ITEMPV

-- PV 
Select C6_LANCES,* From SC6010
Where C6_FILIAL = '02' and C6_NUM = '108185' and C6_ITEM = '02'
And D_E_L_E_T_ =' '

--If (SZ9->Z9_QTDETQ >= SC6->C6_LANCES) .and. (SZ9->Z9_IMPETIQ == "S") 
--SZ9->Z9_ETIQIMP < SC6->C6_LANCES

-- PESAGEM DE MATERIAIS          
Select * From SZL010

--SZ9->Z9_ETIQIMP < SC6->C6_LANCES

--Z9_ETIQIMP = 0
--C6_LANCES = 1

/*If SZ9->Z9_ETIQIMP < SC6->C6_LANCES
					RecLock("SZ9",.F.)
					SZ9->Z9_ETIQIMP := SZ9->Z9_ETIQIMP+1
					// SZ9->Z9_IMPETIQ	:= "S"
					MsUnLock()
				Else
					Alert("Não existe Saldo para liberação da troca de etiquetas.")
					_lVolta := .F.
				EndIf*/

-- Moviemnos Internos 
Select F5_CODIGO,F5_TIPO,F5_TEXTO,

	Case 
	When Substring(D3_CF,1,2) =  'PR' Then 'Requisicao'
	When Substring(D3_CF,1,2) =  'DE' Then 'Devolucao'
	Else '*******'
	End AS TM_REQ_DEV,

	Case 
	When Substring(D3_CF,3,3) =  '0' Then 'Manual'
	When Substring(D3_CF,3,3) =  '1' Then 'Auto'
	When Substring(D3_CF,3,3) =  '2' Then 'Processo'
	When Substring(D3_CF,3,3) =  '3' Then 'Mat. Indireto'
	When Substring(D3_CF,3,3) =  '4' Then 'Transf. Armazem'
	Else '*******'
	End AS TM_REQ_DEV,

* From SD3010 SD3

	Left Join SF5010 SF5
	On D3_TM = F5_CODIGO
	And SF5.D_E_L_E_T_ =' '

Where D3_SEQCALC In ('20231201117996','20231201002546')
--And D3_COD In ('Q1150605401''SV05000030')
--And D3_TM <= 500 
And SD3.D_E_L_E_T_ =' '

--Campo D3_CF
--Tipo de Requisicao/devolu
--Tipo de requisicao (RE) ou de devolucao(DE) de Materiais. 
--Na terceira posicaoinformar : 0- Manual, 1- Automatico,2- Requisicao de Processo, 3- Req.de MatIndireto,4- Transferencia entre Armazens


-- NF Entrada Cab. 
Select F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO = 0 
					And E2_BAIXA <> ''
					And SE2.D_E_L_E_T_ = ''),0),
	
	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When DS_CHAVENF <> '' 
	Then 'PRE_NOTA'
	Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,
	
	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C7_RESIDUO  = 'S' and D1_PEDIDO <> ''
	Then 'Finalizado' 
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Aberto'
	End RESIDUO,

	Case 
	When C7_ENCER = 'E' and D1_PEDIDO <> ''
	Then 'Encerrado'
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Não Encerrado'
	End Encerrado,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,



*From SF1010 SF1 With(Nolock)

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Inner Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Entrada Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F1_FILIAL

	Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
	On DS_CHAVENF = F1_CHVNFE
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And SDT.D_E_L_E_T_ = ''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00.D_E_L_E_T_ = ''

	LEFT Join SC7010 SC7 With(Nolock) -- PC
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	Left Join SC8010 SC8 With(Nolock) -- Cotacao
	On C8_FILIAL = C7_FILIAL 
	And C8_NUMPED = C7_NUM 
	And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Left Join SC1010 SC1 With(Nolock) -- SC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''

	Inner Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And SB2.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_FILIAL = F1_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''

	Left Join SE2010 SE2 With(Nolock)
	On E2_FILIAL = D1_FILIAL
	And E2_FORNECE = D1_FORNECE
	And E2_LOJA = D1_LOJA
	And E2_NUM = D1_DOC
	And SE2.D_E_L_E_T_ = ''
	
Where E2_FORNECE In ('VP648') and E2_LOJA In ('01')
And F1_EMISSAO Between ('20240101') and ('20240229')
and SF1.D_E_L_E_T_ =''

Select * From SE2010

-- Contas a Pagar x Mov. Bancaria 
Select E2_EMISSAO,E5_DATA, E2_NUM,E5_NUMERO,E2_VALOR,E5_VALOR,E2_SALDO,E2_VALLIQ,E2_PARCELA,E5_PARCELA,E2_TIPO,E5_TIPO,E5_HISTOR,
* From SE2010 SE2
	Left Join SE5010 SE5
	On E5_FILIAL = E2_FILIAL
	And E5_CLIFOR = E2_FORNECE
	And E5_LOJA = E5_LOJA
	And E5_NUMERO = E2_NUM
	And E2_TIPO = E2_TIPO
	And E5_PARCELA = E2_PARCELA
	And SE5.D_E_L_E_T_ = ''

Where E2_FORNECE In ('VOP648') and E2_LOJA In ('01')
And E2_EMISSAO Between '20240101' and '20240229' and SE2.D_E_L_E_T_ = ''
--And (E2_VALOR-E5_VALOR) > 0
--And E2_TIPO Not In ('FOL')
Order By 2,3

--Contas a pagar
Select E2_FILIAL,E2_FORNECE,E2_NOMFOR,E2_NUM,E2_TIPO,Sum(E2_VALOR) AS TOTAL, Count(E2_PARCELA) As Parcelas  From SE2010
Where E2_FILIAL In ('01','02','03') 
And E2_FORNECE In ('VOP648') and E2_LOJA In ('01')
and D_E_L_E_T_ ='' 
And E2_BAIXA ='' and E2_SALDO > '0' and E2_VENCTO Between '20240101' and '20240229'
Group By E2_FILIAL,E2_FORNECE,E2_NOMFOR,E2_NUM,E2_TIPO



-- Genericas
Select * From SX5010
Where X5_CHAVE = 'MDF'
And D_E_L_E_T_ = ''


-- NF Saida Cab. x Ordem Carga
Select F2_FILIAL, F2_DOC,F2_CHVNFE,ZZ9_ORDCAR,ZZ9_ORDSEP
From ZZ9010 ZZ9
	Inner Join SF2010 SF2
	On F2_FILIAL = ZZ9_FILIAL
	And F2_DOC = ZZ9_DOC
	And ZZ9.D_E_L_E_T_ =''

where F2_EMISSAO Between '20240101' and '20243101' And SF2.D_E_L_E_T_ =''
And F2_CHVNFE <> '' --and ZZ9_STATUS Not in ('F')
Group By F2_FILIAL, F2_DOC,F2_CHVNFE,ZZ9_ORDCAR,ZZ9_ORDSEP
Order By 1,2


--CC0 – Manifesto Documentos Fiscais
Select CC0_VEICUL,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), CC0_XMLMDF)),'') AS [CC0_XMLMDF],
* From CC0010
Where D_E_L_E_T_ = ''

-- NF Saida Cab.
Select F2_NUMMDF,F2_SERMDF,F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,F2_CHVNFE,F2_DOC,
* From SF2010
Where F2_SERMDF <> '' and F2_NUMMDF <> ''
And D_E_L_E_T_ = ''
Order By 1



-- Genericas 
Select X5_CHAVE,* From SX5010
Where X5_TABELA = 'PT'
And D_E_L_E_T_ = ''

-- Parametros 
Select X6_CONTEUD,* From SX6010
Where  X6_VAR = 'MV_SERMAN'
And D_E_L_E_T_ = ''

--DTX - Manifesto de Carga
Select * From DTX010

-- Transportadoras 
Select A4_EMAIL,* From SA4010
Where A4_EMAIL In ('leandro@leofran.com.br','robson@leofran.com.br','natalia@leofran.com.br')
Or A4_COD In ('980427')
And D_E_L_E_T_ =''


--Veiculos 
Select * From DA3010

-- Motoristas
Select * From DA4010

-- NF SaidaCab x Veiculos 
Select F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,DA3_DESC,* From SF2010 SF2

	Inner Join DA3010 DA3 -- Veiculos
	On F2_VEICUL1 = DA3_COD
	And F2_FILIAL = DA3_FILIAL
	And DA3.D_E_L_E_T_ = ''

Where (F2_VEICUL1 <> '' or F2_VEICUL2 <> '' or F2_VEICUL3 <> '')
And SF2.D_E_L_E_T_ =''
Order By SF2.F2_EMISSAO


--CC0 - Manifesto Documentos Fiscais
Select * From CC0010
Where D_E_L_E_T_ =''
--CC0_STATUS	Status	Status MDFe
--Status da Situacao do Manifesto Eletronico de Documentos Fiscais: 
--1=Transmitido; 2=Nao Transmitido; 3=Autorizado; 4=Nao Autorizado; 5=Cancelado; 6=Encerrado
--CC0_STATEV	Status Event	Status do Evento
--Help de Campo: Status dos Eventos do Manifesto Eletronico de Documentos Fiscais (Cancelamento e Encerramento): 
--1=Evento nao realizado; 2=Evento realizado; 3=Evento vinculado; 4=Evento nao vinculado
--CC0_CODRET	Cod. Retorno	Codigo Retorno
--Help de Campo: Codigo de Retorno da Sefaz para o Manifesto Eletronico de Documentos Fiscais
--CC0_MSGRET	Msg. Retorno	Mensagem de Retorno
--Help de Campo: Mensagem de Retorno da Sefaz para o Manifesto Eletronico de Documentos Fiscais
--CC0_STAINT	Status Integ	Status Integracao
--Opcoes do ComboBox: 1=Sim;2=Nao
--Help de Campo: Indica se as notas do manifesto ja foram enviadas ao portal coleta/entrega.


-- DUT - Tipos de Veiculos
Select * From DUT010
Where D_E_L_E_T_ =''

--DA3 - Veiculos
Select * From DA3010
Where D_E_L_E_T_ =''

--DA4 - Motoristas
Select * From DA4010
Where D_E_L_E_T_ =''

-- Genericas Tipos de Veiculos (MU) e Tipos Carroceria (MV)
Select * From SX5010
Where X5_TABELA In ('MV','MU')
And D_E_L_E_T_ =''
Order By  X5_TABELA



-- CC0 - MDFE
SELECT ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), CC0_XMLMDF)),'') AS OBSF2, *
FROM CC0010
WHERE D_E_L_E_T_ = ''

-- Genericas
Select X5_CHAVE,* From SX5010
Where X5_TABELA = '01' and X5_CHAVE = '500'
And D_E_L_E_T_ = ''

-- Parametros 
Select * From SX6010
Where X6_VAR =  ('ZZ_SERIMDF')


-- Alteracao F2_VEICULO em Lote 
SELECT Z9.ZZ9_FILIAL AS [FILIAL],
 Z9.ZZ9_ORDCAR AS [ORDCAR],
 Z9.ZZ9_ORDSEP AS [ORDSEP],
 Z9.ZZ9_DOC AS [DOC], 
 Z9.ZZ9_SERIE AS [SERIE], 
 ISNULL(F2.R_E_C_N_O_,0)  AS [RECNO_F2],
 ISNULL(F2.F2_TRANSP,'')  AS [OLD_TRANSP],
 ISNULL(F2.F2_VEICUL1,'') AS [OLD_VEIC1], 
 ISNULL(F2.F2_VEICUL2,'') AS [OLD_VEIC2], 
 ISNULL(F2.F2_VEICUL3,'') AS [OLD_VEIC3]  
 FROM ZZ9010 Z9      

 LEFT JOIN SF2010 F2 
 ON  Z9.ZZ9_FILIAL = F2.F2_FILIAL 
 AND Z9.ZZ9_DOC    = F2.F2_DOC 
 AND Z9.ZZ9_SERIE  = F2.F2_SERIE 
 AND F2.D_E_L_E_T_ = Z9.D_E_L_E_T_ 

WHERE Z9.ZZ9_FILIAL = '01'
--AND Z9.ZZ9_ORDCAR = '"+cOrdCarga+"'"
AND Z9.D_E_L_E_T_ = ''
AND (Z9.ZZ9_DOC <> '' OR Z9.ZZ9_DOC > 0)
And ZZ9_ORDCAR = '00012592'

--NF Entrada 
Select F1_VEICUL1,F1_VEICUL2,F1_VEICUL3,* From SF1010


-- Data Entrega - Vendas 
-- Função cbcPortMain
-- Portaria - Saida de Notas Fiscais 
Select F2_DTENTR,F2_CHVNFE,* From SF2010
Where F2_DTENTR <> '' and F2_CHVNFE Like ('35090902544042000119550010000000029999999970')
and F2_FILIAL = '01'
And D_E_L_E_T_ = ''
Order By F2_DOC



-- Titulos a pagar 
Select E2_BAIXA,E2_SALDO,E2_PIS,E2_CSLL,E2_COFINS,* From SE2010
Where E2_BAIXA = '' and E2_SALDO > '0' 
And (E2_PIS > 0 or E2_CSLL > 0 or E2_COFINS > 0)
And D_E_L_E_T_ = ''




Select Distinct D1_DOC,D1_FORNECE,D1_PICM,D1_ALIQIRR,D1_ALIQISS,D1_ALIQINS,D1_ALIQSOL,D1_ALQPIS,D1_ALQCOF,D1_ALIQCMP,
Count(D1_ITEM) as Count_
From SD1010
Where D1_EMISSAO Between '20240201' and '20240229'
And D_E_L_E_T_ =''
Group By D1_DOC,D1_FORNECE,D1_PICM,D1_ALIQIRR,D1_ALIQISS,D1_ALIQINS,D1_ALIQSOL,D1_ALQPIS,D1_ALQCOF,D1_ALIQCMP
Having Count(D1_ITEM) >= 2
Order By 2,1





--ZZI - Log Movtos Pedidos de Vendas  
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZI_OBS)),'') As Obs_ ,
* From ZZI010
Where ZZI_FILIAL = '02' and ZZI_PEDIDO = '108522'
And D_E_L_E_T_ = ''
Order By ZZI_DATA,ZZI_HORA






--Genericas - Transportadoras Z6
Select * From SX5010
Where X5_TABELA = '00' and X5_CHAVE = 'Z6'
And D_E_L_E_T_ =' '
Order By X5_CHAVE

Select * From SX5010
Where X5_TABELA = 'Z6'
And D_E_L_E_T_ =' '
Order By X5_CHAVE

--Logs Eventos Carregamentos NFe Transportadoras - EDI
Select Distinct ChaveNFe  from DocumentoTracking


--Transportadoras 
Select A4_HPAGE,* From SA4010
Where D_E_L_E_T_ =' '


--PC
Select C7_EMISSAO,C7_CONAPRO,
* From SC7010


-- Documentos com alçadas de aprovação 
Select * From SCR010
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.

Select * From DBM010


--SCR - Documentos com Alcada
--Select * From SCR010
--Where CR_FILIAL = 'BA03' and CR_NUM = '018333' and D_E_L_E_T_ =''



--SCR - Documentos com Alcada com Inner Join

Declare @APROV Varchar (50)
--Set @APROV_NOME = (Select USR_NOME From SYS_USR USR_APRV)
Select  USR.USR_ID USR_ID, USR.USR_NOME USR_NOME, SAK.AK_COD, SAK.AK_NOME, 
		
		Case 
			When CR_STATUS = '01'
				Then 'Aguardando nivel anterior'
			When CR_STATUS = '02'
				Then 'Pendente'
			When CR_STATUS = '03'
				Then 'Liberado'
			When CR_STATUS = '04'
				Then 'Bloqueado'
			When CR_STATUS = '05'
				Then 'Liberado outro aprov.'
			When CR_STATUS = '06'
				Then 'Rejeitado'
			When CR_STATUS = '07'
				Then 'Rej/Bloq outro aprov.'
			Else 
				'Verificar'
			End as Status_,

* From SCR010 SCR

	-- Usuários x Usuários
	Inner Join SYS_USR USR With (NOLOCK)
	On USR_ID = CR_USER
	And USR.D_E_L_E_T_ = ''
	--Set  @APROV = CR_APROV

	-- Aprovadores
	Inner Join SAK010 SAK With (NOLOCK)
	ON SAK.AK_COD = CR_APROV
	AND SAK.AK_FILIAL = CR_FILIAL
	AND SAK.D_E_L_E_T_ = ''

	-- Usuários x Aprovadores
	Inner Join SYS_USR USR_APROV With (NOLOCK)
	On USR_APROV.USR_ID = SAK.AK_COD
	And USR.D_E_L_E_T_ = ''

	-- PC
	Inner Join SC7010 SC7
	On	C7_FILIAL = CR_FILIAL
	And C7_NUM = CR_NUM
	And SC7.D_E_L_E_T_ = ''
	
Where CR_FILIAL In ('01') and CR_NUM >= '018000' and SCR.D_E_L_E_T_ =''  
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.

-- Clientes 
Select A1_EMAIL,A1_EMAILCT,* From SA1010
Where A1_COD = '016100'
And D_E_L_E_T_ = ''

--PV
Select * From SC5010
Where C5_NUM = '416798'
And D_E_L_E_T_ = ''

--Campos
Select * From SX3010
Where X3_CAMPO In ('A1_EMAIL','A1_EMAILCT')
And D_E_L_E_T_ = ''

--COT
Select C8_GRUPCOM,* From SC8010
Where C8_FILIAL = '01' and C8_NUM = '012490'
And D_E_L_E_T_ = ''

--SY1 - Compradores
Select Y1_GRUPCOM,* From SY1010 
where Y1_COD = '007'
And D_E_L_E_T_ = ''

--SAJ - Grupo Compras
Select * From SAJ010
Where AJ_USER = '000255'
And D_E_L_E_T_ = ''

--Produtos 
Select B1_MSBLQL,B1_GRUPCOM,* From SB1010
Where B1_COD = 'MC15003447'  
Or B1_GRUPCOM <> ''
And D_E_L_E_T_ = ''

-- Fornecedor 
Select A2_MSBLQL,* From SA2010
Where A2_COD = 'V00392'
And D_E_L_E_T_ = ''

-- NF Entarda Itens
Select D1_EMISSAO,* From SD1010
Where D1_COD = 'MC15003447'
And D_E_L_E_T_ = ''

-- PC 
Select C7_GRUPCOM,* From SC7010
Where C7_PRODUTO = 'MC15003447' or C7_GRUPCOM <> ''
And D_E_L_E_T_ = ''

--PV
Select C5_CLIOK, * From SC5010
Where D_E_L_E_T_ = ''

-- Clientes 
Select A1_REVIS,* From SA1010
Where D_E_L_E_T_ = ''
--A1_REVIS = 1=Sim;2=Nao;3=Rev.Anteior                                                                                                       

-- Fornecedores 
Select * From SA2010
Where D_E_L_E_T_ = ''

--Orçamentos
Select * FRom SCJ010
Where D_E_L_E_T_ = ''


-- PC 
Select CR_FILIAL,C7_FILIAL,CR_NUM,C7_NUM,CR_TIPO,CR_APROV,C7_APROV,CR_LIBAPRO,AK_NOME,
Isnull(DateDiff(Day,Max(C7_EMISSAO),CR_DATALIB),'')  As DIAS_LIB
From SC7010 SC7 -- PC 

	Left Join SCR010 SCR -- Controle de documentos
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_LIBAPRO <> ''
	And CR_DATALIB <> ''
	And SCR.D_E_L_E_T_ = ''

	Left Join SAK010 SAK -- Aprovadores 
	On AK_FILIAL = CR_FILIAL
	And AK_COD = CR_LIBAPRO
	And SAK.D_E_L_E_T_ = '' 

Where C7_EMISSAO >= '20230301'
And C7_NUM = '014867'
And SC7.D_E_L_E_T_ = ''
Group By CR_FILIAL,C7_FILIAL,CR_NUM,C7_NUM,CR_TIPO,CR_APROV,C7_APROV,CR_LIBAPRO,AK_NOME,
CR_DATALIB



Select * From SCR010
Where CR_NUM = '014867'
And D_E_L_E_T_ = ''
Order By CR_FILIAL,CR_NUM

Select * From SAK010


Select * From SCR010
Where CR_EMISSAO >= '20230101'
And CR_NUM = '014167'
And D_E_L_E_T_ = ''

Select C7_FILIAL,C7_NUM,C7_CONAPRO,C7_APROV,CR_LIBAPRO,CR_DATALIB,CR_TIPO,CR_DATALIB,CR_LIBAPRO,
Isnull(DateDiff(Day,Max(C7_EMISSAO),CR_DATALIB),'')  As DIAS_LIB
From SC7010 SC7

	Left Join SCR010 SCR -- Controle de documentos
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_LIBAPRO <> ''
	And CR_DATALIB <> ''
	And SCR.D_E_L_E_T_ = ''


Where C7_EMISSAO >= '20240301'
--And C7_NUM = '014167'
And C7_CONAPRO = 'L'
And SC7.D_E_L_E_T_ = ''
Group By C7_FILIAL,C7_NUM,C7_CONAPRO,C7_APROV,CR_LIBAPRO,CR_DATALIB,CR_TIPO
Order By 1,2


Select Distinct C7_FILIAL,C7_NUM  From SC7010 SC7

	Left Join SCR010 SCR -- Controle de documentos
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	--And CR_LIBAPRO <> ''
	And CR_DATALIB <> ''
	And SCR.D_E_L_E_T_ = ''


Where C7_EMISSAO >= '20240101'
--And C7_NUM = '014167'
And C7_CONAPRO = 'L'
And SC7.D_E_L_E_T_ = ''


Select * From SX5010
Where X5_TABELA = '21'
And X5_CHAVE = '007'
And D_E_L_E_T_ = ''

--PC 
Select C7_FRETE,C7_TPFRETE,* From SC7010
Where D_E_L_E_T_ = ''

--NF Entada 
Select F1_FRETE,F1_DESPESA,F1_FOB_R,F1_CIF,* From SF1010
Where D_E_L_E_T_ = ''

--NF Entada Itens 
Select D1_CIF,D1_SEGURO,D1_DESPESA,*  From SD1010
Where D_E_L_E_T_ = ''


-- NF Entrada Cab e Item - CTE
Select Distinct D1_COD From SF1010 SF1 With(Nolock)

	Inner Join SD1010 SD1 With(Nolock)
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_SERIE = D1_SERIE
	And F1_FORNECE = D1_FORNECE
	aND F1_LOJA = D1_LOJA
	And SD1.D_E_L_E_T_= ''

Where F1_ESPECIE = 'CTE'
And F1_EMISSAO Between '20240201' and '20240228'
And SF1.D_E_L_E_T_ = ''

-- Movimentos Internos
Select * From SD3010
Where D3_COD In ('SV05000020','SV05000021')
And D3_EMISSAO Between '20240201' and '20240228'
And D_E_L_E_T_ = ''



-- NF Entrada Cab. - Custos CTE
Select Distinct  F1_VALBRUT,
F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_LOJA,'') A2_LOJA,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
SubString(CT2_ITEMC,2,6) AS FORNEC_CONTAB,SubString(CT2_ITEMC,8,2) As LOJA_CONTAB,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,
D1_COD,F4_TEXTO,F4_ESTOQUE,
Isnull(D3_DOC,0) As D3_DOC,
Isnull(D3_TM,'') As D3_TM ,Isnull(F5_TEXTO,'') As F5_TEXTO, Isnull(F5_TIPO,'') As F5_TIPO,
D1_TES, F4_TEXTO,D1_OPER,SX5_DJ.X5_DESCRI,
--CT2_HIST,CTK_HIST,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 With(Nolock) -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO = 0 
					And E2_BAIXA <> ''
					And SE2.D_E_L_E_T_ = ''),0),
	
	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_ ,
	

	Case 
	When DS_CHAVENF <> '' 
	Then 'PRE_NOTA'
	Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,
	
	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '1' Then 'Envio de Evento não realizado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '2' Then 'Envio de Evento realizado (Aguardando processamento)'
	When  C00_CHVNFE <> '' and C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
	When  C00_CHVNFE <> '' and C00_CODEVE = '4' Then 'vento rejeitado (Verifique o monitor para saber os motivos)'
	Else 'Verifivcar'
	End As Status_Evento,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '1' Then 'Uso autorizado da NFe'
	When  C00_CHVNFE <> '' and C00_SITDOC = '2' Then 'Uso denegado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '3' Then 'NFe cancelada'
	Else 'Verifivcar'
	End As Status_SITUACAO_COC,

	Case 
	When C7_RESIDUO  = 'S' and D1_PEDIDO <> ''
	Then 'Finalizado' 
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Aberto'
	End RESIDUO,

	Case 
	When C7_ENCER = 'E' and D1_PEDIDO <> ''
	Then 'Encerrado'
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Não Encerrado'
	End Encerrado,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,

	Case When CTK_SEQUEN <> '' Then 'Com Contra Prova Contab'
	Else 'Sem Contra Prova Contab'
	End as STATUS_FISCAL_ITENS,

	Case When CT2_SEQUEN <> '' Then 'Com Lanc. Contabil'
	Else 'Sem Lanc.Contabil'
	End as STATUS_FISCAL_ITENS,

	Case When CV3_SEQUEN <> '' Then 'Com Rastreamento Contab.'
	Else 'Sem Rastreamento Contab'
	End as STATUS_FISCAL_ITENS



From SF1010 SF1 With(Nolock) -- NF Entrada Cab.

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Inner Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F1_FILIAL

	Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
	On DS_CHAVENF = F1_CHVNFE
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And SDT.D_E_L_E_T_ = ''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00.D_E_L_E_T_ = ''

	LEFT Join SC7010 SC7 With(Nolock) -- PC
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	Left Join SC8010 SC8 With(Nolock) -- Cotacao
	On C8_FILIAL = C7_FILIAL 
	And C8_NUMPED = C7_NUM 
	And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Left Join SC1010 SC1 With(Nolock) -- SC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''

	Inner Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And SB2.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_FILIAL = F1_FILIAL
	And F3_CLIEFOR = F1_FORNECE
	And F3_LOJA = F1_LOJA
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = D1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 With(Nolock) -- TES
	On D1_TES = F4_CODIGO
	and SF4.D_E_L_E_T_ =''

	Left Join SD3010 SD3 With(Nolock) --Mov.Internos 
	On D3_FILIAL = D1_FILIAL 
	And D3_COD = D1_COD
	And D3_DOC = F1_DOC
	And SD3.D_E_L_E_T_ = ''

	Left Join SF5010 SF5 With(Nolock) -- Tipos de Movimentos 
	On D3_TM = F5_CODIGO 
	And SF5.D_E_L_E_T_ = ''
	
	Left Join CT2010 CT2 With(Nolock) -- Lanc. Contabeis
	On CT2_FILIAL = F1_FILIAL
	And SubString(CT2_ITEMC,2,6) = F1_FORNECE
	--And SubString(CT2_ITEMC,8,2) = F1_LOJA
	And CT2_LOTE = '008810'
	And CT2_SBLOTE = '001'
	And CT2_HIST Like ('FRETE%')
	And CT2_VALOR = F1_VALBRUT
	And SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(F1_DOC)) + RTrim(F1_DOC)
	And CT2.D_E_L_E_T_ = ''

	Left Join CTK010 CTK With(Nolock) -- Lanc. Contabeis
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK.D_E_L_E_T_ = ''

	Left Join CV3010 CV3 With(Nolock) --CV3 - Rastreamento Lancamento
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 -- TES
	On D1_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ = ''

	Left Join SX5010 SX5_DJ --TIPO DE MOVIMENTACAO DE MATERIAL  
	On SX5_DJ.X5_TABELA = 'DJ'
	And SX5_DJ.X5_FILIAL = D1_FILIAL
	And SX5_DJ.X5_CHAVE = D1_OPER
	And SX5_DJ.D_E_L_E_T_ = ''


Where F1_ESPECIE = 'CTE' and F1_FORNECE In ('VOPACJ','VOP004') 
And F1_EMISSAO Between '20240301' and '20240331'
And SF1.D_E_L_E_T_ = ''
Order By 1

Select * From SX5010 --TIPO DE MOVIMENTACAO DE MATERIAL                       
Where X5_TABELA = 'DJ'


-- Lanc. Contabeis x Contra Prova contabel - Frete 
Select CTK_KEY,CT2_KEY,CT2_HIST,CTK_HIST,
* From CT2010 CT2

	Inner Join CTK010 CTK
	On CTK_KEY = CT2_KEY
	And CTK.D_E_L_E_T_ = ''

Where CT2_LOTE Like ('008810') 
And CT2_HIST Like ('FRETE%')
And CT2_DATA Between '20240101' and '20240331'
And CT2.D_E_L_E_T_ = ''


-- Contra prova contabel - Frete 
Select SubString(CTK_ITEMC,2,6),SubString(CTK_ITEMC,8,2),
* From CTK010
Where CTK_DATA Between '20240201' and '20240228'
And CTK_HIST Like ('FRETE%')
And D_E_L_E_T_ = ''

-- Lancamentos Contabeis - Frete 
Select SubString(CT2_ITEMC,2,6),SubString(CT2_ITEMC,8,2),
* From CT2010 CT2
Where CT2_LOTE Like ('008810') 
And CT2_HIST Like ('FRETE%')
And CT2_DATA Between '20240101' and '20240331'
And SubString(CT2_ITEMC,2,6) = 'V009G5'
And CT2.D_E_L_E_T_ = ''
Order By CT2_HIST

Select * From SF1010
Where F1_ESPECIE = 'CTE'
and D_E_L_E_T_ = ''

    



--C00 - Manifesto do destinatario
Select C00_STATUS,C00_SITDOC,C00_CODEVE,
	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '1' Then 'Envio de Evento não realizado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '2' Then 'Envio de Evento realizado (Aguardando processamento)'
	When  C00_CHVNFE <> '' and C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
	When  C00_CHVNFE <> '' and C00_CODEVE = '4' Then 'Evento rejeitado (Verifique o monitor para saber os motivos)'
	Else 'Verifivcar'
	End As Status_Evento,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '1' Then 'Uso autorizado da NFe'
	When  C00_CHVNFE <> '' and C00_SITDOC = '2' Then 'Uso denegado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '3' Then 'NFe cancelada'
	Else 'Verifivcar'
	End As Status_SITUACAO_COC,

* From C00010

Where C00_CHVNFE  In ('35240419740721000166550010000008351045197062')
And C00_DTEMI >= '20240201'
and D_E_L_E_T_ =''
Order By C00_DTEMI

--C00_CODEVE (Status do Evento)
--1 = Envio de Evento não realizado
--2 = Envio de Evento realizado (Aguardando processamento)
--3 = Evento vinculado com sucesso
--4 = Evento rejeitado (Verifique o monitor para saber os motivos)

--C00_SITDOC (Situação do Documento), pode ter os seguintes conteúdos:
--1 = Uso autorizado da NFe
--2 = Uso denegado
--3 = NFe cancelada

--C00_STATUS - Status da Manifestacao
--0 = 'Desconhecido'
--1 = 'Confirmação da Operação'
--2 = 'Ciencia da Operação'
--3 = 'Desconhecimento da Operação'
--4 = 'Operação não Recebida'



-- Produtos 
Select B1_TS,B1_TE,* From SB1010
Where B1_COD In ('ME02000007','ME02000008','ME02000009')
And D_E_L_E_T_ ='' 

Select * From SX3010
Where X3_CAMPO = 'B1_TS'

-- TES
Select * From SF4010
Where F4_CODIGO In	('707','501')
And D_E_L_E_T_ ='' 


-- PC x NF Entada Itens 
-- SC7 - PC
-- SD1 - NF Entrada Itens 
Select C7_NUM,D1_DOC,C7_PRODUTO,C7_ITEM,D1_ITEMPC,D1_ITEM,C7_QUANT,C7_QUJE,C7_QTDACLA,D1_QUANT,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As SALDO_PC, C7_ENCER, C7_RESIDUO,C7_CONAPRO, C7_APROV,AK_USER, USR_NOME,
	
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

* From SC7010 SC7

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
	   	 
Where C7_FILIAL = '01' and C7_NUM In ('018645') 
And C7_PRODUTO In ('ME02000007','ME02000008','ME02000009')
--And (C7_QUANT-C7_QUJE-C7_QTDACLA) >0
--And C7_ITEM In ('0003','0004','0010','0011','0018')
and SC7.D_E_L_E_T_ ='' 


-- NF Entrada Itens 
Select Distinct  D1_FORNECE,D1_LOJA From SD1010
Where D1_COD In   ('ME02000008')
And D1_EMISSAO >= '20240101'
and D_E_L_E_T_ ='' 

-- Fornecedor 
Select * From SA2010
Where A2_COD In ('V00329','VOOB3S')
and D_E_L_E_T_ ='' 



-- Moviemnos Internos 
Select F5_CODIGO,F5_TIPO,F5_TEXTO,

	Case 
	When Substring(D3_CF,1,2) =  'PR' Then 'Requisicao'
	When Substring(D3_CF,1,2) =  'DE' Then 'Devolucao'
	Else '*******'
	End AS TM_REQ_DEV,

	Case 
	When Substring(D3_CF,3,3) =  '0' Then 'Manual'
	When Substring(D3_CF,3,3) =  '1' Then 'Auto'
	When Substring(D3_CF,3,3) =  '2' Then 'Processo'
	When Substring(D3_CF,3,3) =  '3' Then 'Mat. Indireto'
	When Substring(D3_CF,3,3) =  '4' Then 'Transf. Armazem'
	Else '*******'
	End AS TM_REQ_DEV,

* From SD3010 SD3

	Left Join SF5010 SF5
	On D3_TM = F5_CODIGO
	And SF5.D_E_L_E_T_ =' '

Where D3_COD In ('1150704401')
And D3_DOC = 'P069537'
And D3_EMISSAO Between '20210831' and '20210910'
And D3_ESTORNO = ''
and SD3.D_E_L_E_T_ = ''

--Campo D3_CF
--Tipo de Requisicao/devolu
--Tipo de requisicao (RE) ou de devolucao(DE) de Materiais. 
--Na terceira posicaoinformar : 0- Manual, 1- Automatico,2- Requisicao de Processo, 3- Req.de MatIndireto,4- Transferencia entre Armazens






--Campos
Select * From SX3010
Where X3_ARQUIVO In ('ZZE','SZE') and X3_CAMPO In ('ZZE_STATUS','ZZE_SITUAC','ZE_STATUS')
And D_E_L_E_T_ = ''


-- Retrabalhos 
Select ZZE_STATUS,ZZE_SITUAC,* From ZZE010
Where ZZE_FILIAL = '01' and ZZE_ID In ('009062','062152') Or ZZE_NUMBOB In ('1608029 ')
And D_E_L_E_T_ = ''
--ZZE_SITUAC - Situação do Retrabalho - 1=Encerrado;2=Em Aberto                                                                                                         
--ZZE_STATUS - Status - 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO         



 


--Estoque Terceiros
Select SB6.B6_FILIAL, SB6.B6_CLIFOR,SB6.B6_PRODUTO,SB6.B6_DOC,SB6.B6_FILIAL, 
Isnull(SD1.D1_FORNECE,'')D1_FORNECE, Isnull(SD1.D1_DOC,'') D1_DOC,Isnull(SD1.D1_NFORI,'') D1_NFORI,
Isnull(SD2.D2_CLIENTE,'') D2_CLIENTE, Isnull(SD2.D2_DOC,'') D2_DOC, 
Isnull(SB6.B6_CUSTO1,'') B6_CUSTO1, Isnull(SD1.D1_CUSTO,'') D1_CUSTO, Isnull(SD2.D2_CUSTO1,'') D2_CUSTO1,
Isnull((SB6.B6_CUSTO1 - SD1.D1_CUSTO),'') As DIF_CUSTO_ENTRADA, Isnull((SB6.B6_CUSTO1 - SD2.D2_CUSTO1),'') As DIF_CUSTO_SAIDA,
Isnull(SD1.D1_EMISSAO,'')D1_EMISSAO,Isnull(SD2.D2_EMISSAO,'') D2_EMISSAO,
Isnull(SB6.B6_LOJA,'') B6_LOJA,Isnull(SD1.D1_LOJA,'') D1_LOJA,Isnull(SD2.D2_LOJA,'') D2_LOJA,SB6.B6_IDENT,D1_IDENTB6,D2_IDENTB6,
Isnull(SD1.D1_QUANT,'') D1_QUANT, Isnull(D1_VUNIT,'') D1_VALUNIT, Isnull(D1_CUSTO,'') D1_CUSTO,
Isnull(SD2.D2_QUANT,'') D2_QUANT, Isnull(D2_PRCVEN,'') D2_PRCVEN, Isnull(D2_TOTAL,'') D2_TOTAL,
Isnull(SB6.B6_SALDO,'') B6_SALDO,Isnull(SB6.B6_QUANT,'') B6_QUANT,B6_TIPO,
Isnull(SD1.D1_QUANT*D1_VUNIT,'') D1_TOTAL, Isnull(SD1.D1_CUSTO/D1_QUANT,'') D1_VALUNIT,
Isnull(SD2.D2_QUANT*D2_PRCVEN,'') D2_TOTAL, Isnull(SD2.D2_CUSTO1/D2_QUANT,'') D2_VALUNIT
From SB6010 SB6

	-- SD1 - NF Entrada Itens
	Left Join SD1010 SD1
	On SD1.D1_FILIAL = SB6.B6_FILIAL 
	And SD1.D1_LOJA = SB6.B6_LOJA
	And SD1.D1_FORNECE = SB6.B6_CLIFOR
	And SD1.D1_DOC = SB6.B6_DOC 
	And SD1.D1_COD = SB6.B6_PRODUTO
	And SD1.D1_IDENTB6 = SB6.B6_IDENT
	And SD1.D_E_L_E_T_ = ''

	    -- SD2 - NF Saida Itens
	LEFT Join SD2010 SD2
	On SD2.D2_FILIAL = SB6.B6_FILIAL 
	And SD2.D2_LOJA = SB6.B6_LOJA
	And SD2.D2_CLIENTE = SB6.B6_CLIFOR
	And SD2.D2_DOC = SB6.B6_DOC 
	And SD2.D2_COD = SB6.B6_PRODUTO
	And SD2.D_E_L_E_T_ = ''

		   
Where B6_FILIAL In ('01','02','03') and B6_CLIFOR In ('V009R4')  
--And B6_DOC In ('234645','234646','234672','234673')
And B6_SALDO > 0
And SB6.B6_PRODUTO In ('MC20000041')
Order By SB6.B6_IDENT


--PC - Varios Itens SD1 x PC SC7 
SELECT *
FROM SDT010 SDT WITH(NOLOCK)
INNER JOIN SDS010 SDS WITH(NOLOCK) ON DT_FILIAL = DS_FILIAL
									AND DT_DOC = DS_DOC
									AND DT_SERIE = DS_SERIE
									AND DT_FORNEC = DS_FORNEC
									AND DT_LOJA = DS_LOJA
									AND SDT.D_E_L_E_T_ = SDS.D_E_L_E_T_
WHERE DT_FILIAL = '02'
AND SDT.D_E_L_E_T_ = ''
AND DS_CHAVENF = '35240419740721000166550010000008351045197062'



Select * From SX6010
Where X6_VAR = 'ZZ_CTEODI'
And D_E_L_E_T_ = ''



Select * From SB1010
Where B1_DESC Like ('%ADAPTADOR%')
And D_E_L_E_T_ = ''

-- Genéricas

Select X5_CHAVE,* From SX5010
Where X5_TABELA In ('01','02') and X5_CHAVE = '500'
And D_E_L_E_T_ = ''





-- PV Itens 
Select * FRom SC6010
Where C6_NUM = '411689' and C6_ITEM = '01'
And D_E_L_E_T_ = ''

-- PV 
Select * FRom SC5010
Where C5_NUM = '411689' 
And D_E_L_E_T_ = ''

--Vendedores 
Select * From SA3010


--Pesagem
Select * FRom SZL010
Where ZL_PEDIDO = '411689' and ZL_ITEMPV = '01'
And ZL_STATUS In ('P')
And D_E_L_E_T_ = ''

--Etiquetas
Select * FRom SZE010
Where ZE_PEDIDO = '411689' and ZE_ITEM = '01'
And ZE_STATUS = 'P'
And D_E_L_E_T_ = ''









--NF Entarda
Select * From SF1010
Where F1_DOC = '000010027' and F1_FORNECE = 'V0076D'
And D_E_L_E_T_ = ''


--NF Entrada Itens 
Select  D1_NFORI, D1_SERIORI,D1_ITEMORI,* From SD1010
Where D1_DOC = '000010027' and D1_FORNECE = 'V0076D'
And D_E_L_E_T_ = ''

-- Livro Fiscal Itens 
Select FT_ITEMORI,FT_SERORI,FT_NFORI, * From SFT010
Where FT_NFISCAL In ('000010027','000392893') and FT_CLIEFOR = 'V0076D'
And D_E_L_E_T_ = ''

-- Livro Fiscal
Select  * From SF3010
Where F3_NFISCAL In ('000010027','000392893') and F3_CLIEFOR = 'V0076D'
And D_E_L_E_T_ = ''


-- NF Saida 
Select * From SF2010
Where F2_DOC = '000392893' and F2_CLIENTE = 'V0076D'
And D_E_L_E_T_ = ''

--NF Entrada Itens 
Select  D2_PEDIDO,D2_NFORI, D2_SERIORI,D2_ITEMORI,* From SD2010
Where D2_DOC = '000392893' and D2_CLIENTE = 'V0076D'
And D_E_L_E_T_ = ''


--PV Itens 
Select * From SC5010
Where C5_NUM = '414787'
And D_E_L_E_T_ = ''

--PV Itens 
Select C6_NFORI, C6_SERIORI,C6_ITEMORI, * From SC6010
Where C6_NUM = '414787'
And D_E_L_E_T_ = ''

--PV Itens  Lib.
Select * From SC9010
Where C9_PEDIDO = '414787'
And D_E_L_E_T_ = ''


-- Documentos Referenciados
Select * FRom CDD010
Where CDD_DOC In ('00001027','000392893') and CDD_CLIFOR = 'V0076D'
And D_E_L_E_T_ = ''


-- Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL = '01' and B6_PRODUTO = 'ME02000028' 
And B6_CLIFOR = 'V00A88'  --and B6_DOC = '000392340'
And B6_IDENT In ('SvVY5P')
--And B6_SALDO > 0
And D_E_L_E_T_ = ''

-- NF Saida Itens 
Select D2_NUMSEQ,D2_IDENTB6,D2_NFORI,* From SD2010
Where D2_DOC In ('000393178 ')
And D2_COD = 'ME02000028' 
And D_E_L_E_T_ = ''

-- NF Saida Itens 
Select D1_NUMSEQ,D1_IDENTB6,D1_NFORI,* From SD1010
Where D1_DOC In ('000059562')
And D1_COD = 'ME02000028' 
And D_E_L_E_T_ = ''

--SZL - Pesagens
Select * From SZL010
Where ZL_NUM In ('389864','389844')
And D_E_L_E_T_ = ''
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ    


--Ind.
Select C9_BLEST,C9_ITEMREM,R_E_C_N_O_,* From SC9010
Where C9_FILIAL = '01' and C9_PEDIDO In ('415791') and D_E_L_E_T_ =''
And C9_PRODUTO = '1340704401'  
--C9_BLEST - '' Liberado - 1 Bloqueado por Credito - 2 Bloqueado por Estoque - 09 Credito Rejeitado - 10 Faturado 



--And C6_PRODUTO = '1340704401' 

                                                                                 



Select B1_MTZMATP, * From SB1010

--Pedido de compras
Select Distinct A2_CGC,C7_FORNECE,A2_NOME,C7_PRODUTO,C7_DESCRI,C7_QUANT,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_QTDACLA,C7_PRECO,
C7_NUM,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV,B1_TIPO,
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

	Inner Join SA2010 SA2 
	On A2_COD = C7_FORNECE
	And SA2.D_E_L_E_T_= ''	


Where C7_FILIAL = '01' and C7_NUM In ('018512') 
And C7_ITEM = '0006'
--and C7_FORNECE In ('V00AA1') and C7_ENCER = '' and C7_RESIDUO = '' 
and SC7.D_E_L_E_T_ = ''
--and (C7_QUANT-C7_QUJE-C7_QTDACLA) > 0


--SZE -> Tabela de Bobinas
Select ZE_STATUS,* From SZE010
Where ZE_FILIAL In ('01') and ZE_NUMBOB In ('1608029','2276035') 
And D_E_L_E_T_ = ''
--And ZE_STATUS Not in  ('F','C')
--I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf.         

--SZL > Controle de Pesagem
Select ZL_UNMOV,* From SZL010
Where ZL_FILIAL In ('01') and ZL_NUM In ('384832','384833') 
and D_E_L_E_T_ ='' 
Order By ZL_PEDIDO
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ      






 --PV
 Select C5_NOTA,* From SC5010
 Where C5_CLIENTE = '042232'
 And D_E_L_E_T_ = ''




 -- Vendas Produtos cm metragm diferente do PV mair > ou menor
Select C6_FILIAL,C6_NUM,C6_PRODUTO,C6_ITEM,
		C6_QTDVEN,C6_QTDENT,(C6_QTDVEN-C6_QTDENT) As PV_Sado,
		ZE_FILIAL,ZE_PEDIDO,ZE_PEDIDO,ZE_ITEM,
		C6_QTDVEN,C6_METRAGE,C6_LANCES,
		ZL_METROS, ZL_QTLANCE,ZL_LANCE,
		ZL_NUMBOB,ZE_STATUS,C5_CONDPAG,E4_DESCRI,C5_VEND1,A3_NOME,

		Case 
			When ZL_METROS < C6_METRAGE
			Then '<<<<<<<'

			When ZL_METROS > C6_METRAGE
			Then '>>>>>>>'

			When ZL_METROS = C6_METRAGE
			Then 'VVVVVVV'

			Else 'xxxxxxx'
			End As Status_,

* From SC5010 SC5 With(Nolock) --PV Cab

	Inner Join SC6010 SC6 -- PV itens 
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And SC6.D_E_L_E_T_ = ''
	

	Left Join SZL010 SZL --Pesagem
	On ZL_FILIAL = C6_FILIAL
	And ZL_PEDIDO = C6_NUM
	And ZL_ITEMPV = C6_ITEM
	And SZL.D_E_L_E_T_ = ''

	Left Join SZE010 SZE -- Etiquetas
	On ZE_FILIAL = ZL_FILIAL
	And ZE_NUMBOB = ZL_NUMBOB
	And SZE.D_E_L_E_T_ = ''

	Left Join SE4010 SE4
	ON E4_CODIGO = C5_CONDPAG
	And SE4.D_E_L_E_T_ = ''

	Left Join SA3010 SA3
	ON A3_COD = C5_VEND1
	And SA3.D_E_L_E_T_ = ''
		
Where C5_FILIAL = '01' And C5_NUM = ('419672')
--And ((ZL_METROS < C6_METRAGE) or (ZL_METROS > C6_METRAGE))
--And ZE_STATUS = 'P' And ZL_STATUS In ('P')
--And C5_NOTA Not In ('XXXXXX') -- Nao Eliminado Residuo 
--And C5_NOTA = ('') -- PV em Aberto
--And C6_QTDVEN <= C6_ENTREG
--And ZE_STATUS = 'I'
And SC5.D_E_L_E_T_ = ''
Order By 1,2,4

--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa    

--ZL - Pesagem 
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ  

-- Campos
Select * From SX3010
Where X3_ARQUIVO In ('SB1','SD1','SD2','SFT') and 
X3_CAMPO In ('B1_PPIS','B1_PCOFINS','D1_ALQIMP5','D1_ALQIMP6','D2_ALQIMP5','D2_ALQIMP6','FT_ALIQPIS','FT_ALIQCOF')
And D_E_L_E_T_ = ''

Select * From SX3010
Where X3_ARQUIVO In ('SF3','SF1','SFT','SD1') 
And (X3_TIPO = 'N' and  X3_DECIMAL = '4')
And D_E_L_E_T_ = ''
Order By X3_DECIMAL




--Livros Fiscais Itens 
Select FT_ALIQPIS, FT_ALIQCOF,* From SFT010
Where (Len(FT_ALIQPIS) > 5 or Len(FT_ALIQCOF) > 5 )
And D_E_L_E_T_ = ''

--NF Entrada 
Select D1_ALQIMP5, D1_ALQIMP6,D1_ALQCOF,D1_ALQPIS,* From SD1010 SD1

	Inner Join SF1010 SF1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA 
	And SF1.D_E_L_E_T_ = ''


Where D1_COD = 'SV05000020' and D1_FORNECE = 'VOPACJ' 
And (Len(D1_ALQIMP5) > 5 or Len(D1_ALQIMP6) > 5 )  or (D1_ALQIMP5 = '5.70' or D1_ALQIMP6 = '1.24')
And D1_EMISSAO >= '20240301'
And SD1.D_E_L_E_T_ = ''


--NF - Saida 
Select D2_ALQIMP5, D2_ALQIMP6,* From SD2010
Where (Len(D2_ALQIMP5) > 4 or Len(D2_ALQIMP6) > 4 ) or (D2_ALQIMP5 = '5.70' or D2_ALQIMP6 = '1.24')
And D_E_L_E_T_ = ''

-- Excecao Fiscal
Select * From SF7010
Where F7_GRTRIB = '007'
And D_E_L_E_T_ = ''

-- Parametros 
Select X6_FIL, X6_VAR, X6_DESCRIC,X6_DESC1, X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_RNDCOF', 'MV_RNDPIS', 'MV_RNDPS2', 'MV_RNDCF2', 'MV_RNDPS3','MV_RNDCF3','MV_DECALIQ')
And D_E_L_E_T_ = ''
Order By 2


--Ordens de produção 
-- Abertura de OS para Estorno NF 
SELECT C2_DATRF, *
--UPDATE SC2010 SET C2_DATRF = ''
from SC2010
WHERE C2_FILIAL = '01'
AND C2_NUM + C2_ITEM + C2_SEQUEN IN (
'08659401001'   
)
AND D_E_L_E_T_ = ''




Select * From SB9010
Where B9_COD = 'SC01000001'
And B9_FILIAL = '02'
--and B9_LOCAL = '01'
And B9_DATA >= '20240101'
AND D_E_L_E_T_ = ''

Select 

	Case 
		When D3_CUSTO1 > '0' and D3_QUANT > '0'
		Then (D3_CUSTO1/D3_QUANT) 
	Else '0'
	End As CM,


D3_ESTORNO,* 
From SD3010
Where D3_COD = 'SC01000001'
And D3_FILIAL = '02'
And D3_ESTORNO = ''
--And (D3_CUSTO1 = '0' or D3_QUANT = '0')
And D3_EMISSAO Between '20240201' and '20240229'
AND D_E_L_E_T_ = ''
Order By R_E_C_N_O_


Select B2_CMFIM1, 

	
	Case 
		When B2_QATU > '0' and B2_VATU1 > '0'
		Then (B2_VATU1/B2_QATU) 
	Else '0'
	End As CM,

	--Case 
		--When B2_VFIM1 > '0' and B2_QFIM > '0'
		--Then (B2_VFIM1/B2_QFIM)
	--Else '0'
	--End As CM2,

* From SB2010
Where (B2_QATU > '0' and B2_VATU1 > '0')
And B2_COD = 'SC01000001' and B2_FILIAL = '02'
AND D_E_L_E_T_ = ''
Order By B2_FILIAL,B2_COD







-- Terceiros Est
Select R_E_C_N_O_,D_E_L_E_T_,B6_SALDO,B6_IDENT,* From SB6010
Where B6_PRODUTO = 'AI02000709' --and B6_SALDO > 0
--and B6_DTDIGIT Between '20240201' and '20240229'
And B6_IDENT In ('9EGTLN')
AND D_E_L_E_T_ = ''
Order By 4
--SwIINN
--SvVY5P
--SwI4IH

-- NF Entrada Itens 
Select D1_IDENTB6,D1_DOC,D1_NFORI,D1_ITEMORI,* From SD1010
Where D1_FILIAL In ('02') and D1_DOC = '000152420'
AND D_E_L_E_T_ = ''

-- NF Entrada 
Select  * From SF1010
Where F1_FILIAL In ('02') and F1_DOC = '000152420'
AND D_E_L_E_T_ = ''


-- TES
Select * From SF4010
Where F4_CODIGO = '144'
AND D_E_L_E_T_ = ''

-- NF Saida Itens 
Select D2_IDENTB6,D2_DOC,D2_NFORI,D2_ITEMORI,D2_CLIENTE,D2_EMISSAO,* From SD2010
Where D2_FILIAL In ('02') and D2_DOC = '000152420'
AND D_E_L_E_T_ = ''


-- Pesagem 
Select ZL_UNMOV,* From SZL010
Where ZL_FILIAL = '01'
And ZL_NUM In ('394363','394369','394374')
AND D_E_L_E_T_ = ''

-- NF Saida 
Select F2_CHVNFE,* From SF2010
Where F2_DOC = '000399278'
AND D_E_L_E_T_ = ''

-- NF Saida 
Select * From SD2010
Where D2_DOC = '000399278'
AND D_E_L_E_T_ = ''





--PV 
Select * From SC5010
Where C5_NUM = '403159'
And D_E_L_E_T_ =' '

--PV Itens 
Select * From SC6010
Where C6_NUM = '403159'
And D_E_L_E_T_ =' '

--Clientes 
Select * From SA1010
Where A1_COD = '004329'
And D_E_L_E_T_ =' '

-- Vendedores 
Select * From SA3010
Where A3_COD = '159091'
And D_E_L_E_T_ =' '

--NF
Select * From SF2010
Where F2_DOC = '000378888'
and D_E_L_E_T_ =''

--NF Itens 
Select * From SD2010
Where D2_DOC = '000378888'
and D_E_L_E_T_ =''


-- NF Entrada 
Select * From SF1010
Where F1_FILIAL = '03' and F1_FORNECE = 'V009R4'
And F1_DOC = '000234664'
and D_E_L_E_T_ =''


-- NF Entrada 
Select * From SD1010
Where D1_FILIAL = '03' and D1_FORNECE = 'V009R4'
And D1_DOC = '000234644'
and D_E_L_E_T_ =''



-- Livro Fiscal Cab.
Select F3_NFISCAL,* From SF3010
Where F3_FILIAL = '03' and F3_CLIEFOR = 'V009R4'
And F3_NFISCAL = '000234664'
and D_E_L_E_T_ =''


-- Livro Fiscal Itens
Select FT_NFISCAL,* From SFT010
Where FT_FILIAL = '03' and FT_CLIEFOR = 'V009R4'
And FT_NFISCAL = '000234664'
and D_E_L_E_T_ =''




-- PV Itens 
Select C6_COMIS1,* From SC6010
Where C6_FILIAL = '02' and C6_NUM = '110307'
And D_E_L_E_T_ = ''

--PV 
Select C5_COMIS1,C5_DOCPORT,C5_VEND1,* From SC5010
Where C5_FILIAL = '02' and C5_NUM = '110307'
And D_E_L_E_T_ = ''


-- Orçamentos
Select   * From ZP4010
Where ZP4_CODIGO = '375409'
And D_E_L_E_T_ = ''

-- ZP5 - Orcamento Cab. *******
Select ZP5_COMFIX,
ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010
Where ZP5_NUM = '375409' and  D_E_L_E_T_ =''
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado          

-- ZP6 - Orcamento Itens 
Select ZP6_COMSUG,ZP6_COMAPR,* From ZP6010
Where ZP6_NUM = '375409'
And D_E_L_E_T_ =' '

-- Vendedores 
Select A3_COMIS,* From SA3010
Where A3_COD = '159029'
And D_E_L_E_T_ =' '

-- Comissao de Vendas 
Select * From SE3010
Where E3_VEND = '159029' And E3_FILIAL = '02'
And E3_PEDIDO = '110307'
And D_E_L_E_T_ = ' '

-- Carta de descontos
Select ZY_COMIS,* From SZY010
Where  D_E_L_E_T_ =' '

-- SCK - Itens de Orcamento
Select CK_COMIS1,* From SCK010
Where CK_FILIAL = '02' and CK_NUM = '110307'
And  D_E_L_E_T_ =' '

--Orçamentos 
Select * From SCJ010
Where CJ_FILIAL = '02' and CJ_NUM = '110307'
And  D_E_L_E_T_ =' '

--Tabela de Preços
Select * From DA0010

-- NF Saida 
Select * From SX6010
Where X6_VAR = 'MV_DECALIQ '

--NF Saida 
Select (F2_ICMAUTO+F2_VALMERC) As Calc,F2_VALMERC,F2_VALBRUT,F2_ICMAUTO,* From SF2010
Where F2_DOC = '000400215'
And  D_E_L_E_T_ ='*'
--F2_ICMAUTO	Vl.Icm Frete	Valor do ICMs Frete

--NF Saida Itens 
Select D2_VALBRUT,D2_TOTAL,D2_ICMFRET,* From SD2010
Where D2_DOC = '000400215'
And  D_E_L_E_T_ ='*'
--D2_ICMFRET	Icms Frete	Icms Frete







-- Pedido de Vendas Itens
Select C6_FILIAL,C6_NUM,R_E_C_N_O_,C6_XNEGOC,C6_ZZPVORI, C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_QTDLIB,C6_SEMANA,R_E_C_N_O_, * From SC6010
Where C6_FILIAL = '01' and C6_NUM In ('419672')  And C6_ITEM Between ('01') and ('99')
and D_E_L_E_T_ =''





-- PV - Liberados 
Select C9_BLCRED,C9_BLEST,C9_ITEMREM,R_E_C_N_O_,* From SC9010
Where C9_FILIAL = '01' and C9_PEDIDO In ('419672') 
--And C9_ITEM In ('22','25')
and D_E_L_E_T_ =''
--And C9_BLEST = ''
--And C9_PRODUTO = '1340704401'  


-- 03- Verificar Saldos , Empenhos e Endereços
--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL = '02' and BF_PRODUTO In ('1150502401') 
And BF_LOCALIZ In ('M01000','R00100')
and BF_QUANT > 0 and BF_EMPENHO > 0
--and BF_LOCALIZ In ('B00110','B00050','B00070')
 And D_E_L_E_T_ =''


 
 --Log Movtos Pedidos de Vendas  
Select  ZZI_CODEVE,ZZI_EVENTO,ZZI_FILIAL,ZZI_PEDIDO,*
From ZZI010
Where ZZI_FILIAL In ('01') and ZZI_PEDIDO In ('419672')
--and ZZI_DATA >= '20230110' and ZZI_CODEVE In ('15','04','10')
And D_E_L_E_T_ = '' 
Order By 4,1


--LOG DAS ORDENS DE SEPARACAO   
Select ZZR_SITUAC,* From ZZR010
Where ZZR_FILIAL = '01' and ZZR_PEDIDO = '419672'
and D_E_L_E_T_ =''  



 --Clientes
 Select * From SA1010
 Where A1_COD = '042232' or A1_CGC = '42588340000125'
 And D_E_L_E_T_ = ''



 -- Contas a receber 
Select E1_IDCNAB,E1_LOTE,E1_SALDO,E1_VALOR,E1_VALLIQ,E1_BAIXA,E1_HIST,* From SE1010
Where E1_BAIXA Between '20240412' and '20240412'
And D_E_L_E_T_ = ''
Order By E1_PARCELA

--Conta a Receber Aux.
Select FK1_ARCNAB,FK1_LOTE,* From FK1010
Where FK1_DATA Between '20240412' and '20240412'
And D_E_L_E_T_ = ''


--Limpado Tabela refernte ao Arquivo em Anexo.
--FI0 - Cabec Log Processamento CNAB
Select FI0_LASTLN,* From FI0010 
Where FI0_DTPRC  Between '20240412' and '20240412'
And D_E_L_E_T_ =''

--Depois Reprocessados e Arquivos Gerados em 
--FI1 - Detalhe do Log Processamento
Select * From FI1010 
Where FI1_IDARQ  In ('A811623656','A364694598','A962909693','A192941500','A 26278855')
And D_E_L_E_T_ =''



-- Contas a Pagar x Detalhe do Log Processamento CNAB
Select * From FI1010 FI1
	Left Join SE1010 SE1
	On FI1_IDTIT = E1_IDCNAB
	Where FI1_IDARQ  In ('A811623656','A364694598','A962909693','A192941500','A 26278855')
And FI1.D_E_L_E_T_ =''

-- Mov. Bancaria
Select E5_OK,E5_ARQCNAB,E5_BENEF,E5_CLIFOR,E5_NUMERO,E5_PARCELA,E5_DTDIGIT,E5_HISTOR,* From SE5010
Where E5_LOTE In ('ZZZZ072F','ZZZZ072J','ZZZZ072G','ZZZZ072H','ZZZZ072I')
And E5_ARQCNAB <> ''
And D_E_L_E_T_ = ''
Order By E5_VALOR


-- Mov. Bancaria Aux.
Select * From FK5010
Where FK5_LOTE In  ('ZZZZ072F','ZZZZ072J','ZZZZ072G','ZZZZ072H','ZZZZ072I')
--And FK5_DATA >= '20240409'
And D_E_L_E_T_ = ''

--Naturezas Financeiras 
Select * From SED010
Where ED_CODIGO Like ('%NAT%')

--Saldos 
Select * From SE8010
Where E8_BANCO = '033' and E8_AGENCIA = '3582' and E8_CONTA = '130652142'
And E8_DTSALAT >= '20240409'
And D_E_L_E_T_ = ''

--Cliente s
Select * From SA1010
Where A1_CGC In ('27579257000104','00140149000176','43261440000105')
And D_E_L_E_T_ = ''


-- NF Entrada 
Select D1_COD,D1_QUANT,B2_QATU,D3_QUANT,B2_LOCAL,B1_DESC,B1_TIPO,D1_DESC,F1_DOC,F1_FORNECE,A2_NOME,F4_CODIGO,F4_TEXTO,F4_ESTOQUE
From SF1010 SF1


	Inner Join SD1010 SD1 -- NF Entrada Itens 
	On D1_FILIAL = F1_FILIAL
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = D1_LOJA
	and SD1.D_E_L_E_T_ =''
	
	Inner Join SF4010 SF4 -- TES
	On D1_TES = F4_CODIGO
	and SF4.D_E_L_E_T_ =''

	Inner Join SA2010 SA2 --Fornecedor 
	On F1_FORNECE = A2_COD
	And F1_LOJA = A2_LOJA
	And SA2.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 --Produtos
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SB2010 SB2 -- Estoque 
	On B2_COD = B1_COD
	And B2_FILIAL = F1_FILIAL
	And SB2.D_E_L_E_T_ = ''

	Left Join SD3010 SD3
	On D3_FILIAL = D1_FILIAL 
	And D3_COD = D1_COD
	And D3_DOC = F1_DOC
	
Where F1_FORNECE = '000135'-- and F1_DOC = '132'
and SF1.D_E_L_E_T_ =''




-- NF Ent Cab.
Select F1_IRRF,F1_VALIRF,F1_VALPIS,F1_VALCOFI,F1_VALIMP5,F1_VALIMP6,F1_BASIMP5,F1_BASIMP6,F1_BASPIS,F1_BASCOFI, F1_CHVNFE,
* From SF1010
Where F1_DOC In ('000001641','000016838','23394','000040414','000013192')
and F1_FORNECE In ('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
And D_E_L_E_T_ = ''


-- NF Ent Itens 
Select D1_FILIAL,D1_DOC,D1_COD,D1_EMISSAO,D1_FORNECE,
D1_VALIMP5,D1_VALIMP6,D1_BASIMP5,D1_BASIMP6,D1_ALQIMP5,D1_ALQIMP6,
D1_BASEIRR,D1_ALIQIRR,D1_VALIRR,D1_TES, 
D1_BASEPIS,D1_BASECOF,D1_VALPIS,D1_VALCOF,D1_ALQCOF,D1_ALQPIS,
* From SD1010
Where D1_DOC In ('000001641','000016838','23394','000040414','000013192') 
and D1_FORNECE In ('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
And D1_COD = 'AI03000050'
And D_E_L_E_T_ = ''
Order By 4

-- Livro Fiscal Cab.
Select * From SF3010
Where F3_NFISCAL In ('000001641','000016838','23394','000040414','000013192') 
and F3_CLIEFOR In ('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
--or F3_CHVNFE = '35240550222363000140550010000168381320081065'
And D_E_L_E_T_ = ''

-- Livro Fiscal Cab.
Select FT_BASEPIS,FT_BASECOF,FT_ALIQPIS,FT_ALIQCOF,FT_VALPIS,FT_VALCOF,* From SFT010
Where FT_NFISCAL In ('000001641','000016838','23394','000040414','000013192') 
and FT_CLIEFOR In ('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
And FT_PRODUTO = 'AI03000050'
--FT_CHVNFE = '35240550222363000140550010000168381320081065'
And D_E_L_E_T_ = ''

-- Contas a pagaer 
Select E2_TIPO,* From SE2010
Where E2_NUM In ('000001641','000016838','23394','000040414','000013192') 
And E2_FORNECE In ('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
--and E2_TITPAI <> ''
And D_E_L_E_T_ = ''


Select CT2_SEQUEN,* From  CT2010 CT2 With(Nolock) -- Lanc. Contabeis
Where SubString(CT2_ITEMC,2,6) In('V00AQI','000136','V00ADW','V00ADW','VOOCG2')
--And SubString(CT2_ITEMC,8,2) = F1_LOJA
And SubString(CT2_KEY,3,9) In (
								(REPLICATE('0', 9 - LEN('000001641')) + RTrim('000001641')),
								(REPLICATE('0', 9 - LEN('000016838')) + RTrim('000016838')),
								(REPLICATE('0', 9 - LEN('23394')) + RTrim('23394')),
								(REPLICATE('0', 9 - LEN('000040414')) + RTrim('000040414')),
								(REPLICATE('0', 9 - LEN('000013192')) + RTrim('000013192'))
								)
And CT2.D_E_L_E_T_ = ''

Select * FRom CTK010 CTK With(Nolock) -- Contra Prova Contabel
Where CTK_SEQUEN In ('0030768922','0030537685','0030432243','0030913185')		
And CTK.D_E_L_E_T_ = ''

Select * From  CV3010 CV3 With(Nolock) --CV3 - Rastreamento Lancamento
Where CV3_SEQUEN In ('0030768922','0030537685','0030432243','0030913185')
And CV3.D_E_L_E_T_ = ''

-- LP
Select CT5_VLR01,* From CT5010
Where CT5_LANPAD = 'Z01'-- and CT5_SEQUEN In ('001','002')
--CT5_HIST Like  ('%AI%')
--or CT5_DESC Like ('%PIS%') or CT5_DESC Like ('%COFINS%')
And D_E_L_E_T_ = ''

-- Produto 
Select B1_PPIS,B1_PCOFINS,* From SB1010
Where B1_COD = 'AI03000050'
And D_E_L_E_T_ = ''
--PRODUTO
--Perc. PIS (B1_PPIS) = Informe a alíquota
--Perc. COFINS (B1_PCOFINS) =  Informe a alíquota
--Para o cálculo do PIS COFINS apuração o sistema verifica primeiro as alíquotas informadas na exceção fiscal, 
--após produto, caso não tenha alíquota, serão verificados os parâmetros MV_TXPIS e MV_TXCOFIN.


-- TES 
Select F4_PISCOF,F4_PISCRED,F4_TPREG,F4_CSTPIS,F4_CSTCOF,F4_LFICM,* From SF4010
Where F4_CODIGO = '438'
And D_E_L_E_T_ = ''
--PIS/ COFINS (F4_PISCOF) = Ambos
--Cred.PIS/COF (F4_PISCRED) = Credita
--Tp Reg (F4_TPREG) = Cumulativo ou Não Cumulativo
--Sit. Trib. PIS (F4_CSTPIS) = 50 a 66
--Sit. Trib. COF (F4_CSTCOF) = 50 a 66
--L. Fisc. ICMS (F4_LFICM) ; L. Fiscal IPI (F4_LFIPI) ou L. Fiscal ISS (F4_LFISS) 
--= Preenchimento diferente de NÃO - Deve ser configurado o campo de um dos livros fiscais com opção diferente de NÃO,
--para geração dos valores de PIS COFINS nas tabelas SF3 e SFT.

-- Fornecedor 
Select * From SA2010
Where A2_COD = '000136'

-- NF Entarda itens 
Select D1_EMISSAO,* From SD1010
Where D1_COD = 'AI03000050'
And D_E_L_E_T_ = ''


Select * From SA2010
Where A2_COD = 'VOPCX9'

Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,* From SX6010
Where X6_DESCRIC Like ('%NFS%') or 
X6_DESC1 Like ('%NFS%') or 
X6_DESC2 Like ('%NFS%') 
And D_E_L_E_T_ = ''
Order By 2

-- Contas a pagar 
Select E2_SALDO,E2_BAIXA,* From SE2010
Where E2_NUM = '132' --and E2_LOJA = '01'
--And E2_VENCTO = '20231229' and E2_VALOR = '50205.32'
And E2_EMISSAO >= '20240401'
AND D_E_L_E_T_ = ''

--PC
Select C7_TIPCOM,* From SC7010
Where C7_NUM = '019372' and C7_FILIAL = '01'
AND D_E_L_E_T_ = ''

-- SC
Select C1_GRPRD,* From SC1010
Where  D_E_L_E_T_ = ''
--SV05
--SV05000179       
--SERVICO DE FRETE INTERNACIONAL                    

--Tipos de compras 
Select * From DHK010
Where  D_E_L_E_T_ = ''

--Aprovação
Select * From SCR010
Where CR_NUM In ('019372','019374')  
and CR_TIPO In ('PC') 
And CR_FILIAL = '01'
And D_E_L_E_T_ = ''
Order By CR_NUM

----Aprovação Itens
Select * From DBM010
Where D_E_L_E_T_ = ''

-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_APRSCEC','MV_APRPCEC') 


--Aprovadores 
Select * From SAK010

--SV05000176              
--100101 - Diretoria
--511020002           
--000002

-- Produtos 
Select B1_TIPO,* From SB1010
Where B1_COD = 'SV05000176'
And D_E_L_E_T_ = ''

Select * From SX5010
Where X5_TABELA In ('42','02')
And D_E_L_E_T_ = ''
Order By X5_FILIAL,X5_TABELA

Select * From SX5010
Where X5_TABELA =  'Z6' 

--NF Entrada 
Select F1_FILIAL,F1_STATUS,F1_PLACA,F1_CHVNFE,F1_TRANSP,F1_VEICUL1,F1_VEICUL2,F1_VEICUL3,F1_SERMDF,F1_NUMMDF,
* From SF1010
Where F1_FILIAL = '01' and F1_DOC In ('000400747','000400748')
And D_E_L_E_T_ = ''

-- Fornecedores 
Select * From SA2010
Where A2_COD = 'VOOFK9'
And D_E_L_E_T_ = ''

--NF Entrada Itens 
Select 
* From SD1010
Where D1_FILIAL = '01' and D1_DOC In ('000400747','000400748')
And D_E_L_E_T_ = ''

-- TES 
Select * From SF4010
Where F4_CODIGO = '311'
And D_E_L_E_T_ = ''

-- Estoque 
Select * From SB2010
Where B2_FILIAL = '01' and B2_COD = '2110002000'
And D_E_L_E_T_ = ''

-- Moviemtnos Internos 
Select * From SD3010
Where D3_FILIAL = '01' and D3_COD = '2110002000'
And D3_EMISSAO >= '20240501'
And D3_NUMSEQ In ('SwYVFR','SwYVFT')
And D_E_L_E_T_ = ''





-- Livro Fiscal Cab.
Select F3_NFISCAL,F3_CHVNFE,F3_OBSERV, * From SF3010
Where F3_FILIAL = '01' and F3_CHVNFE In ('35240438401544000138550010000022771200002713') 
and D_E_L_E_T_ =''

-- Livro Fiscal Itens
Select FT_NFISCAL,FT_CHVNFE,FT_OBSERV, * From SFT010
Where FT_FILIAL = '01' and FT_CHVNFE In ('35240438401544000138550010000022771200002713') 
and D_E_L_E_T_ =''

--NF Entrada 
Select (F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO) AS Chave,
* From SF1010
Where F1_FORNECE = 'VOP635' And F1_DOC = '000002277'
and D_E_L_E_T_ =''

--NF Entrada Itens 
Select * From SD1010
Where D1_FORNECE = 'VOP635' And D1_DOC = '000002277'
and D_E_L_E_T_ =''


--Fornecedores 
Select * From SA2010
Where A2_NOME Like ('%J.M MAT%')
and D_E_L_E_T_ =''

-- Lançamentos contabeis
Select SubString(CT2_ITEMC,2,6)as FORNECE,SubString(CT2_ITEMC,8,2) as LOJA,
CT2_KEY,CT2_HIST,SubString(CT2_KEY,3,11) As Doc,
Len(SubString(CT2_KEY,3,9)) As Doc_Qtde_Digit,CT2_SEQUEN,
CT2_MANUAL,CT2_ORIGEM,CT2_ROTINA,
* From CT2010 CT2 With(Nolock)
Where CT2_DATA Between '20240401' and '20240430'
And SubString(CT2_ITEMC,2,6) = 'VOP635'
And SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(000002277)) + RTrim(000002277)
And CT2.D_E_L_E_T_ = ''
--CT2_MANUAL
--Campo indicativo se este lancamento contabil foi gerado por outro modulo (2)ou foi digitado no Sigactb (1).

-- Lanc. Contabeis
Select CTK_ORIGEM,CTK_CONTAB,CTK_ROTINA,
* From CTK010 With(Nolock) 
Where  CTK_SEQUEN In ('0030913439','0030902792')
And D_E_L_E_T_ = ''

--CV3 - Rastreamento Lancamento
Select * From  CV3010 CV3 With(Nolock) 
Where CV3_SEQUEN In ('0030913439','0030902792')
And CV3.D_E_L_E_T_ = ''

-- Logs 
Select TTAT_FIELD,* From SF1010_TTAT_LOG
Where --TTAT_FIELD = 'F1_STATUS'
TTAT_UNQ Like ('%VOP635%')
--or TTAT_UNQ Like ('%2277%')

-- Logs 
Select TTAT_FIELD,* From SD1010_TTAT_LOG
Where --TTAT_FIELD = 'F1_STATUS'
TTAT_UNQ Like ('%VOP635%')
--or TTAT_UNQ Like ('%2277%')


-- NF Saida Cab.
Select F2_DOC,F2_TIPO,F2_ESPECIE,*
From SF2010
Where F2_DOC  = '000401845'
And D_E_L_E_T_ = ''

-- NF Saida Itens 
Select D2_DOC,D2_NFORI,D2_TIPO,*
From SD2010
Where D2_DOC  = '000401845'
And D_E_L_E_T_ = ''

-- NF Entrada Cab.
Select F1_DOC,F1_TIPO,F1_ESPECIE,*
From SF1010
Where F1_DOC  = '000417034'
And D_E_L_E_T_ = ''

-- NF Entrada Itens
Select 12_DOC,D1_NFORI,D1_TIPO,*
From SD1010
Where D1_DOC  = '000417034'
And D_E_L_E_T_ = ''


-- Lançamentos contabeis
Select SubString(CT2_ITEMC,2,6)as FORNECE,SubString(CT2_ITEMC,8,2) as LOJA,
SubString(CT2_KEY,15,6) As KEY_FORNEC,
CT2_KEY,CT2_HIST,SubString(CT2_KEY,3,11) As Doc,
Len(SubString(CT2_KEY,3,9)) As Doc_Qtde_Digit,CT2_SEQUEN,
CT2_MANUAL,CT2_ORIGEM,CT2_ROTINA,
* From CT2010 CT2 With(Nolock)
Where CT2_DATA Between '20240401' and '20240430'
And SubString(CT2_ITEMC,2,6) = 'VOPCS5'
Or SubString(CT2_KEY,15,5) = 'VOPCS5'
Or (SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(000401845)) + RTrim(000401845)) 
And CT2.D_E_L_E_T_ = ''
--CT2_MANUAL
--Campo indicativo se este lancamento contabil foi gerado por outro modulo (2)ou foi digitado no Sigactb (1).

-- Lanc. Contabeis
Select CTK_ORIGEM,CTK_CONTAB,CTK_ROTINA,
* From CTK010 With(Nolock) 
Where  CTK_SEQUEN In ('0030919511')
And D_E_L_E_T_ = ''

--CV3 - Rastreamento Lancamento
Select * From  CV3010 CV3 With(Nolock) 
Where CV3_SEQUEN In ('0030919511')
And CV3.D_E_L_E_T_ = ''





-- Verbas x LP (SRV x CT5)
Select RV_COD,RV_DESC,RV_LCTOP,CT5_LANPAD,CT5_DESC,CT5_CREDIT,CT5_DEBITO,
* From SRV010 SRV

	Left Join CT5010 CT5
	On CT5_LANPAD = RV_LCTOP
	And CT5.D_E_L_E_T_ = ''
	
Where SRV.D_E_L_E_T_ = ''
Order By 1



 -- Rasterar Bobinas Empenhadas
--01 - Rasterar Numero de Bobina 
--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,ZE_STATUS,ZE_CONDIC,ZE_SITUACA,ZE_SEQOS,* From SZE010
Where ZE_NUMBOB = '2318074'
and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa     



Select * From SX2010
Where X2_CHAVE = 'ZZV'



-- PV Itens 
Select * From SC5010
Where C5_FILIAL = '01'and C5_NUM In ('421253')
And D_E_L_E_T_ = ' '



-- Etiquetas de Bobinas
Select ZE_RESERVA,ZE_CTRLE,* From SZE010
Where ZE_FILIAL = '02' and ZE_PEDIDO In ('110822') 
and D_E_L_E_T_ = ''

-- PV Liberados 
Select * From SC9010
Where C9_FILIAL = '01' and C9_PEDIDO In ('421253')
And D_E_L_E_T_ = ' '

--SDC - Composicao do Empenho
Select * From SDC010
Where DC_FILIAL = '02' and DC_PEDIDO = '110822'
And D_E_L_E_T_ =' '

-- Pesagem 
Select * From SZL010
Where ZL_FILIAL = '02'and ZL_PEDIDO In ('110822')
And D_E_L_E_T_ =' '

Select * From BI_VW_PRODUTOS


-- Manifesto NF
Select
	Case 
		When C00_CHVNFE = '' Then 'Manifesto não Processado'
		When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
		When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
		Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
		When C00_CODEVE = '1' Then 'Envio de Evento não realizado'
		When C00_CODEVE = '2' Then 'Envio de Evento (Aguardando processamento)'
		When C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
		When C00_CODEVE = '4' Then 'Evento rejeitado (Verifique o monitor para saber os motivos)'
		Else 'Verificar '
	End as STATUS_EVENTO,
	
	Case 
		When C00_SITDOC = '1' Then 'Uso autorizado da NFe'
		When C00_SITDOC = '2' Then 'Uso denegado'
		When C00_SITDOC = '3' Then 'NFe cancelada'
		Else 'Verificar '
	End as STATUS_SITUACAO_DOCUMENTO,

* From C00010
Where C00_DTREC >= '20240101'
And C00_CHVNFE In ('35240751254159000173550010011413041109030530')
And D_E_L_E_T_ =' '
Order By C00_DTREC

/*O C00_CODEVE (Status do Evento), pode ter os seguintes conteúdos:
1 = Envio de Evento não realizado
2 = Envio de Evento realizado (Aguardando processamento)
3 = Evento vinculado com sucesso
4 = Evento rejeitado (Verifique o monitor para saber os motivos)

Já o C00_SITDOC (Situação do Documento), pode ter os seguintes conteúdos:
1 = Uso autorizado da NFe
2 = Uso denegado
3 = NFe cancelada*/


-- SF1 - NF Entrada - Indicador 
Select Distinct F1_DOC,F1_FORNECE, F1_FILIAL,Isnull(F1_ORIGEM,'') As F1_ORIGEM,F1_ESPECIE, X5_DESCRI,F1_OBSTRF,
F1_PESOL,F1_PLIQUI,F1_PBRUTO,F1_CHVNFE,
	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,
	
* From SF1010 SF1

	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

Where F1_CHVNFE In ('35240571799001000196550000000047811000103045','35240547799028000102550010000369091905047712',
'35240547718695000105550010000010071606053657','35240546348140000156550010000265761157283879','35240547978428000177550010006500771907184726')
and F1_FILIAL In ('02') 
and SF1.D_E_L_E_T_ =''
-- And  F1_OBSTRF =  ''
--and F1_ORIGEM NOT IN('AtuDocFr','cbcInTrC')
Group By F1_DOC,F1_FORNECE,F1_FILIAL,F1_ORIGEM,F1_ESPECIE,X5_DESCRI,F1_OBSTRF,F1_PESOL,F1_PLIQUI,F1_PBRUTO,F1_CHVNFE
Order By 1,3 Desc



-- NF Entrada Itens - Retenção IRRF
Select Distinct D1_DOC,D1_FILIAL,D1_FORNECE,D1_LOJA,A2_NOME,
F1_PESOL,F1_PLIQUI,F1_PBRUTO,
* From SD1010 SD1
	
		Inner Join SF1010 SF1
		On F1_FILIAL = D1_FILIAL
		And F1_DOC = D1_DOC
		And F1_LOJA = D1_LOJA
		And F1_FORNECE = D1_FORNECE
		And F1_LOJA = D1_LOJA
		And SF1.D_E_L_E_T_ =''

		Inner Join SA2010 SA2
		On A2_COD = D1_FORNECE
		And A2_LOJA = D1_LOJA
		And SA2.D_E_L_E_T_ =''

Where F1_CHVNFE In ('35240571799001000196550000000047811000103045','35240547799028000102550010000369091905047712',
'35240547718695000105550010000010071606053657','35240546348140000156550010000265761157283879','35240547978428000177550010006500771907184726')
and F1_FILIAL In ('02') 
And SD1.D_E_L_E_T_ =''
Order By 1


-- Nota Fiscal Eletrônica
SELECT 
    STATUS,
    STATUSCANC,
    STATUSMAIL,
    DOC_CHV,
    LOTE,
    CHARINDEX('<placa>', (ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), ''))) AS [PLACA_COL],
    -- Correção do uso do SUBSTRING
    SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), ''), CHARINDEX('<placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), '')) + LEN('<placa>'), 7) AS [EXTRAIDA_PLACA],
    SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), ''), CHARINDEX('<RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), '')) + LEN('<RENAVAM>'), 11) AS [EXTRAIDA_RENAVAM],
	ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), '') AS [XML_ERP],
    ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_SIG])), '') AS [XML_SIG],
    ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_TSS])), '') AS [XML_TSS],
    *
FROM 
    SPED050
WHERE 
    NFE_ID LIKE '5000000000%' 
    AND DATE_NFE >= '20240501' 
    AND D_E_L_E_T_ = '';

-- C00 - Manifesto de Cargas
Select 
	ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '') AS [CC0_XMLMDF],
	SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<placa>'), 7) AS [EXTRAIDA_PLACA],
	SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<RENAVAM>'), 11) AS [EXTRAIDA_RENAVAM],
* From CC0010
Where 
	D_E_L_E_T_ = '';


-- NF Saida Cab. 
Select F2_FILIAL,F2_DOC,A2_COD,A2_NOME,A2_CGC,COMP_CLI.M0_CGC,A1_CGC,COMP_FOR.M0_CGC,F2_ESPECIE,SX5.X5_DESCRI,F2_TIPO,D2_COD,D2_DESCRI,
		D2_TES,F4_TEXTO,D2_COD CODIGO,B1_DESC PROD_DESC,B1_TIPO,SX5_TP.X5_DESCRI,D2_XOPER,

	Case 
		When COMP_CLI.M0_CGC= A2_CGC 
		Then 'VALIDADO'
		Else 'ERROR'
	End as VALID_CLI,

	Case 
		When COMP_FOR.M0_CGC= A1_CGC 
		Then 'VALIDADO'
		Else 'ERROR'
	End as VALID_FOR,

	Case 
		When F2_TIPO = 'N' Then 'NF Normal'
		When F2_TIPO = 'C' Then 'Compl. Preco'
		When F2_TIPO = 'D' Then 'Devolucao'
		When F2_TIPO = 'I' Then ' NF Compl. ICMS'
		When F2_TIPO = 'P' Then 'NF Compl. IPI'
		When F2_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

* From SF2010 SF2

	Left Join SD2010 SD2 -- NF Sadia Itens
	On D2_FILIAL = F2_FILIAL
	And D2_CLIENTE = F2_CLIENTE
	And D2_LOJA = F2_LOJA  
	And D2_DOC = F2_DOC
	And SD2.D_E_L_E_T_ = ''

	Left Join SA1010 SA1 -- Clientes 
	On A1_COD = F2_CLIENTE
	And A1_LOJA = F2_LOJA

	Left Join SA2010 SA2 -- Fornecedores 
	On A2_COD = F2_CLIENTE
	And A2_LOJA = F2_LOJA

	Inner Join SX5010 SX5
	On X5_FILIAL = F2_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F2_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI -- Filiais 
	On COMP_CLI.M0_CGC = A2_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1
	On B1_COD = D2_COD
	And SB1. D_E_L_E_T_ = ''

	Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F2_FILIAL
	
	Inner Join SF4010 SF4 --TES
	On F4_CODIGO = D2_TES
	And SF4.D_E_L_E_T_ =''

Where 
	F2_CHVNFE = '50240502544042000208550010001545531663064696'
	and SF2.D_E_L_E_T_ =''


-- NF Entrada Cab. 
Select F1_DTLANC,F1_ORIGEM,F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO = 0 
					And E2_BAIXA <> ''
					And SE2.D_E_L_E_T_ = ''),0),
	
	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When DS_CHAVENF <> '' 
	Then 'PRE_NOTA'
	Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,
	
	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C7_RESIDUO  = 'S' and D1_PEDIDO <> ''
	Then 'Finalizado' 
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Aberto'
	End RESIDUO,

	Case 
	When C7_ENCER = 'E' and D1_PEDIDO <> ''
	Then 'Encerrado'
	When  D1_PEDIDO = ''
	Then 'Sem PC'
	Else 'Não Encerrado'
	End Encerrado,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS



From SF1010 SF1 With(Nolock)

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Left Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	Left Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Left Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F1_FILIAL

	Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
	On DS_CHAVENF = F1_CHVNFE
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And SDT.D_E_L_E_T_ = ''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00.D_E_L_E_T_ = ''

	LEFT Join SC7010 SC7 With(Nolock) -- PC
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	Left Join SC8010 SC8 With(Nolock) -- Cotacao
	On C8_FILIAL = C7_FILIAL 
	And C8_NUMPED = C7_NUM 
	And C8_ITEMPED = C7_ITEM
	And SC8.D_E_L_E_T_ = ''

	Left Join SC1010 SC1 With(Nolock) -- SC
	On C1_FILIAL = C7_FILIAL 
	And C1_PEDIDO = C7_NUM
	And C1_ITEMPED = C7_ITEM 
	And SC1.D_E_L_E_T_ = ''

	Left Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And B2_QATU > 0
	And SB2.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_FILIAL = F1_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''
	
Where F1_CHVNFE In ('50240502544042000208550010001545531663064696')
And F1_FILIAL = '01'
and SF1.D_E_L_E_T_ =''



--User Expedicao
Select * From SYS_USR
Where USR_DEPTO Like ('%Expedicao%')
And USR_MSBLQL = '2'
and D_E_L_E_T_ =''
Select * From SE2010

-- Genericas 
Select * From SX5010
Where X5_TABELA In ('AT','AU')
and D_E_L_E_T_ =''
Order By X5_TABELA

Select * From ZZU010

Select * From SX2010
Where X2_CHAVE = 'ZZU'


Select * From SD2010
Where D2_DOC = '000396329'

Select * From SF4010
Where F4_CODIGO = '600'


Select * From SD2010
Where D2_DOC Between '000399800' and  '000399803'


-- NF Saida Cab.
Select F2_CHVNFE,F2_TRANSP,F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,F2_SERMDF,F2_NUMMDF,*
From SF2010 SF2

	Inner Join SD2010 SD2
	On F2_FILIAL = D2_FILIAL
	And F2_CLIENTE = D2_CLIENTE
	And F2_LOJA = D2_LOJA
	And F2_DOC = D2_DOC
	And F2_SERIE = D2_SERIE
	And SD2.D_E_L_E_T_ = ''

Where F2_NUMMDF <> ''
And SF2.D_E_L_E_T_ = ''
Order By 1

Select C00_CODEVE,* From C00010

Select * From SX3010
Where X3_ARQUIVO = 'CC0'
And D_E_L_E_T_ = ''

Select * From SX3010
Where X3_ARQUIVO = 'SC6'


--PV Lib
Select * From SC9010
Where C9_FILIAL = '01' and C9_PEDIDO = '421676'
And D_E_L_E_T_ = ''

--Etiquetas 
Select * From SZE010
Where ZE_FILIAL = '01' and  ZE_PEDIDO = '421676'
And D_E_L_E_T_ = ''

-- Pesagem 
Select * From SZL010
Where ZL_FILIAL = '01' and ZL_PEDIDO = '421676'
And D_E_L_E_T_ = ''

--Empenhos 
Select * From SDC010
Where DC_FILIAL = '01'and DC_PEDIDO = '421676'
And D_E_L_E_T_ = ''

--LOG DAS ORDENS DE SEPARACAO   
Select * From ZZR010
Where ZZR_FILIAL = '01' and ZZR_PEDIDO = '421676'
And D_E_L_E_T_ = ''

-- Estoque Endereços
Select * From SBF010
Where BF_FILIAL = '01' and BF_LOCALIZ In ('B00560','B00370')
And BF_PRODUTO In ('1141804401','141504401')
And  BF_QUANT > 0
And D_E_L_E_T_ = ''

                                                                                            


--PIS e COFINS com Valores Zerados e Alicotas > 0
-- NF Saida Itens
Select D2_ALQIMP5,D2_ALQIMP6,D2_BASIMP5,D2_BASIMP6,D2_VALIMP5,D2_VALIMP6,
		D2_TES,D2_COD,* From SD2010
Where D2_ALQIMP5 = '0' and D2_ALQIMP6 = '0'
And D2_VALIMP5 = 0 And D2_VALIMP6 = 0
And D2_EMISSAO >= '20240101'
And D_E_L_E_T_ = ''

--NF Saida
Select F2_BASIMP5,F2_BASIMP6,F2_VALIMP5,F2_VALIMP6,
		F2_VALCOFI,F2_VALPIS,F2_BASPIS,F2_BASCOFI,
* From SF2010
Where F2_BASIMP5 = '0' and F2_BASIMP6 = '0'
And F2_VALIMP5 = '0' and F2_VALIMP6 = '0'
And F2_EMISSAO >= '20240101'
And D_E_L_E_T_ = ''


--Pesagem 
Select ZL_UNMOV,* From SZL010
Where ZL_FILIAL = '01' and ZL_NUM In ('409274','409277','409278','409280')
--And ZL_UNMOV In ('3059684','3059693','3059702','3059709')
And D_E_L_E_T_ = ''

Select C00_STATUS,C00_CODEVE,C00_SITDOC,

Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '1' Then 'Envio de Evento não realizado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '2' Then 'Envio de Evento realizado (Aguardando processamento)'
	When  C00_CHVNFE <> '' and C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
	When  C00_CHVNFE <> '' and C00_CODEVE = '4' Then 'vento rejeitado (Verifique o monitor para saber os motivos)'
	Else 'Verifivcar'
	End As Status_Evento,

	Case 
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '1' Then 'Uso autorizado da NFe'
	When  C00_CHVNFE <> '' and C00_SITDOC = '2' Then 'Uso denegado'
	When  C00_CHVNFE <> '' and C00_SITDOC = '3' Then 'NFe cancelada'
	Else 'Verifivcar'
	End As Status_SITUACAO_COC,


* From C00010
Where C00_CHVNFE In ('35240604108518000102550020005076481892140748','35240600566196000186550010000604521126895388')
And D_E_L_E_T_ = ''

Select F2_TRANSP,* From SF2010
Where F2_EMISSAO >= '20240901' and F2_FILIAL = '02'
And F2_TRANSP <> ''
And D_E_L_E_T_ = ''
Order By 1

-- NF Entrada 
Select F1_PLIQUI,F1_PBRUTO,F1_VALBRUT,F1_VALMERC,F1_VOLUME1,F1_STATUS,F1_VEICUL1,
* From SF1010 With(Nolock)
Where F1_FILIAL = '02' and F1_DOC In ('000507648','000060452')
And D_E_L_E_T_ = ''

-- NF Entrada Itens
Select D1_TOTAL,* From SD1010
Where D1_FILIAL = '02' and D1_DOC In ('000507648','000060452')
And D_E_L_E_T_ = ''


-- NF Pre Entrada 
Select DS_TOTAL,DS_VALMERC,DS_VOLUME1,DS_PLIQUI,DS_PBRUTO,
* From SDS010 With(Nolock)
Where DS_FILIAL = '02' and DS_DOC In ('000507648','000060452')
And D_E_L_E_T_ = ''

-- NF Pre Entrada Itens 
Select DT_TOTAL,* From SDT010
Where DT_FILIAL = '02' and DT_DOC In ('000507648','000060452')
And D_E_L_E_T_ = ''



-- NF Entrada 
Select F1_PLIQUI,F1_PBRUTO,F1_VALBRUT,F1_STATUS,* From SF1010
Where F1_VALBRUT = '0' and F1_STATUS = '' and F1_EMISSAO >= '20240601'
And D_E_L_E_T_ = ''


--Estoque 
Select * From SB2010
Where B2_FILIAL = '02' and B2_COD = '1150804401' and B2_QATU > 0
And D_E_L_E_T_ = ''

-- Estoque Empenhos
Select * From SDC010
Where DC_FILIAL = '02' and DC_PEDIDO = '020231'
--And DC_LOCALIZ = 'R00100'
And D_E_L_E_T_ = ''

-- Estoque por Endereços 
Select * From SBF010
Where BF_FILIAL = '02' and BF_PRODUTO = '1100804201'
And BF_QUANT > 0
And D_E_L_E_T_ = ''

-- Pesagem 
Select * From SZL010
Where ZL_FILIAL = '01' and ZL_NUM = '410191'
And D_E_L_E_T_ = ''

--NF Entrada Itens 
Select * From SD1010
Where D1_FILIAL = '02' and D1_COD = '1150804401'
And D1_FORNECE = '000048'
--And D1_FORNECE = '100'
And D_E_L_E_T_ = ''


--LP
Select * From CT5010
Where (CT5_VLR01 Like ('%SD1%')
And CT5_VLR01 Like ('%SV%'))
Or (CT5_VLR01 Like ('%017%'))
And D_E_L_E_T_ = ''
--CT5_LANPAD = '650' And CT5_SEQUEN = '135'
--IF(SB1->B1_TIPO<>"MP".AND.SF4->F4_CF$"1352/2352/1932/2932".AND.SF4->F4_CODIGO$"017/034/056/061/165/174",SD1->D1_VALICM,0)                                                                               

--TES
Select * From SF4010
Where F4_CODIGO In ('600')
And D_E_L_E_T_ = ''


-- Livro Fiscal Cab.
Select F3_NFISCAL,F3_CHVNFE,F3_OBSERV, * From SF3010
Where F3_FILIAL = '01' and F3_CHVNFE In ('35240534327498000547570090000103161075040868') 
and D_E_L_E_T_ =''

-- Livro Fiscal Itens
Select FT_NFISCAL,FT_CHVNFE,FT_OBSERV, * From SFT010
Where FT_FILIAL = '01' and FT_CHVNFE In ('35240534327498000547570090000103161075040868') 
and D_E_L_E_T_ =''

-- Fornecedores 
Select * From SA2010 With(Nolock)
Where A2_COD In ('V009G5','V009T7','V00A09','VOOB21','VOOFE4','VOOFE4','VOOYD6','VOOYD6','VOOYD6','VOOYD6','VOOZEG',
'VOOZUO','VOP002','VOPAWY','VOPAX5','VOPCJK','VOPCZV')
And D_E_L_E_T_ = '' 


--Lançamento Contabil 
Select CT2_HIST,(SubString(CT2_ITEMC,2,6)) AS FORNECE,
(SubString(CT2_KEY,15,6)) as FORNECE_KEY, CT2_KEY,
* From CT2010 With(Nolock)
Where 
	(SubString(CT2_KEY,15,6) = 'V009G5'
	Or SubString(CT2_KEY,15,6) = 'V009T7'
	Or SubString(CT2_KEY,15,6) = 'V00A09'
	Or SubString(CT2_KEY,15,6) = 'VOOB21'
	Or SubString(CT2_KEY,215,6) = 'VOOFE4'
	Or SubString(CT2_KEY,15,6) = 'VOOYD6'
	Or SubString(CT2_KEY,15,6) = 'VOOZEG'
	Or SubString(CT2_KEY,15,6) = 'VOOZUO'
	Or SubString(CT2_KEY,15,6) = 'VOP002'
	Or SubString(CT2_KEY,15,6) = 'VOPAWY'
	Or SubString(CT2_KEY,15,6) = 'VOPAX5'
	Or SubString(CT2_KEY,15,6) = 'VOPCJK'
	Or SubString(CT2_KEY,15,6) = 'VOPCZV')
And CT2_HIST Like ('%ICMS%') --or CT2_HIST Like ('%FRETE%'))
And CT2_DATA >= '20240501'
And D_E_L_E_T_ = '' 
Order By CT2_DATA


--Rastreamento Contabel
Select CTK_HIST,* From CTK010 With(Nolock)
Where 
	(SubString(CTK_KEY,15,6) = 'V009G5'
	Or SubString(CTK_KEY,15,6) = 'V009T7'
	Or SubString(CTK_KEY,15,6) = 'V00A09'
	Or SubString(CTK_KEY,15,6) = 'VOOB21'
	Or SubString(CTK_KEY,15,6) = 'VOOFE4'
	Or SubString(CTK_KEY,15,6) = 'VOOYD6'
	Or SubString(CTK_KEY,15,6) = 'VOOZEG'
	Or SubString(CTK_KEY,15,6) = 'VOOZUO'
	Or SubString(CTK_KEY,15,6) = 'VOP002'
	Or SubString(CTK_KEY,15,6) = 'VOPAWY'
	Or SubString(CTK_KEY,15,6) = 'VOPAX5'
	Or SubString(CTK_KEY,15,6) = 'VOPCJK'
	Or SubString(CTK_KEY,15,6) = 'VOPCZV')
And CTK_HIST Like ('%ICMS%') --or CTK_HIST Like ('%FRETE%')
And CTK_DATA >= '20240501'
And D_E_L_E_T_ = '' 
Order By CTK_DATA 

--Rastreamento Contabel
Select CV3_HIST,* From CV3010 With(Nolock)
Where 
	(SubString(CV3_KEY,15,6) = 'V009G5'
	Or SubString(CV3_KEY,15,6) = 'V009T7'
	Or SubString(CV3_KEY,15,6) = 'V00A09'
	Or SubString(CV3_KEY,15,6) = 'VOOB21'
	Or SubString(CV3_KEY,15,6) = 'VOOFE4'
	Or SubString(CV3_KEY,15,6) = 'VOOYD6'
	Or SubString(CV3_KEY,15,6) = 'VOOZEG'
	Or SubString(CV3_KEY,15,6) = 'VOOZUO'
	Or SubString(CV3_KEY,15,6) = 'VOP002'
	Or SubString(CV3_KEY,15,6) = 'VOPAWY'
	Or SubString(CV3_KEY,15,6) = 'VOPAX5'
	Or SubString(CV3_KEY,15,6) = 'VOPCJK'
	Or SubString(CV3_KEY,15,6) = 'VOPCZV')
And CV3_HIST Like ('%ICMS%')-- Or CV3_HIST Like ('%FRETE%')
And CV3_DTSEQ >= '20240501'
And D_E_L_E_T_ = '' 
Order By CV3_DTSEQ


-- NF Entrada Itens 
Select Distinct D1_TP,D1_TES,D1_CF
From SD1010 SD1
Where D1_FILIAL = '01'--And D1_ESPECIE = 'CTE' 
And D1_FORNECE In ('V009G5','V009T7','V00A09','VOOB21','VOOFE4','VOOYD6','VOOZEG',
'VOOZUO','VOP002','VOPAWY','VOPAX5','VOPCJK','VOPCZV')
And D1_DTDIGIT Between '20240501' and '20240531'
And SD1.D_E_L_E_T_ = ''
Order By 1

--NF Entarda 
Select F1_VALBRUT,F1_VALMERC,(F1_VALBRUT-F1_VALMERC) As DIF,
* From SF1010
Where F1_EMISSAO >= '20240501'
And F1_VALBRUT <> F1_VALMERC
And D_E_L_E_T_ = ''

-- TES inteligente 
SELECT ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), FM_ZREGRA)),'') AS ZREGRA,
FM_ZORDEM,FM_TS,
* FROM SFM010
WHERE FM_TS In ('612','527')
And FM_TIPO In ('01')
And FM_FILIAL = ''
AND D_E_L_E_T_ = ''
ORDER BY 2

-- Clientes 
Select A1_TIPO,A1_CONTRIB,A1_CALCSUF,A1_SIMPNAC,* From SA1010
Where A1_CGC = '29628340000143'
And D_E_L_E_T_ = ''

--NF Saida Itens 
Select * From SF2010
Where F2_DOC = '000403810'
AND D_E_L_E_T_ = ''



--NF Saida Itens 
Select D2_TES,D2_IDENTB6,D2_NFORI,* From SD2010
Where D2_DOC = '000403810'
AND D_E_L_E_T_ = ''

--TES
Select * From SF4010
Where F4_CODIGO In ('549','539','551')
AND D_E_L_E_T_ = ''

--Estoque 3 
Select B6_IDENT,B6_SALDO,* From SB6010
Where B6_IDENT In ('Sx2G6Y','Sx33HF','Sx2YK4')
AND D_E_L_E_T_ = ''






-- PV 
Select C5_ENTREG,DatePart(DW,C5_ENTREG ) As Dia_SEMANA ,* From SC5010
Where C5_NUM In ('422806','111693')
And C5_EMISSAO >= '20240101'
and D_E_L_E_T_ ='' 

-- PV Itens
Select C6_XNEGOC,C6_ENTREG,C6_DATCPL,DatePart(DW,C6_ENTREG) As Dia_SEMANA,* From SC6010
Where C6_NUM In ('422806','111693')
And C6_DATCPL >= '20240101'
and D_E_L_E_T_ =''
Order By C6_FILIAL,C6_NUM,C6_ITEM

-- PV Liberados 
Select C9_DATENT,C9_DATALIB,DatePart(DW,C9_DATENT ) As Dia_SEMANA,* From SC9010
Where C9_PEDIDO In ('422806','1116963')
and D_E_L_E_T_ ='' 
Order By C9_FILIAL,C9_PEDIDO,C9_ITEM




 --CONTROLE NEGOCIO VENDAS       
Select * From ZZV010
Where ZZV_FILPV In ('01','02') and ZZV_PEDIDO In ('422806','111693')
And D_E_L_E_T_ = ''
Order by ZZV_STATUS
--ZZV_STATUS
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO



--C6_XNEGOC
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO


-- 02 - Verificar Empenho 
 --SDC - Composicao do Empenho
 -- Verificar Produtos e Qtde e Filial e PV = ZE_CTRLE e Sattus <> ('F','C')
 -- Endereço DC_LOCALIZ = BF_LOCALIZ
Select * From SDC010
Where DC_FILIAL In ('01','02') and DC_PEDIDO In ('422806','111693')
and DC_QUANT > 0
And DC_DTLIB >= ('20240101')
and D_E_L_E_T_ ='' 

-- 03- Verificar Saldos , Empenhos e Endereços
--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL In ('01','02') 
and BF_PRODUTO In ('1141404401','1141704401','1141304401','1150604401','1150606401')       
and BF_QUANT > 0 
and BF_LOCALIZ In  ('B00400','B00300','B00300','R00100','R00100')
And D_E_L_E_T_ ='' 




-- TES Inteligente 
SELECT ISNULL(CAST(CAST(FM_ZREGRA AS VARBINARY(MAX)) AS VARCHAR(MAX)), '') AS FM_ZREGRA,
       ISNULL(CAST(CAST(FM_JSBUILD AS VARBINARY(MAX)) AS VARCHAR(MAX)), '') AS FM_JSBUILD,
       *
FROM SFM010
WHERE ISNULL(CAST(CAST(FM_ZREGRA AS VARBINARY(MAX)) AS VARCHAR(MAX)), '') LIKE ('%B1_TIPO%')
  AND D_E_L_E_T_ = ''
Order By FM_TIPO, FM_ZORDEM




Select E1_FILIAL,E1_CLIENTE,E1_NOMCLI,SUM(E1_SALDO) SALDO From SE1010
Where E1_BAIXA = '' and E1_SALDO > '0'
And E1_SITUACA In ('F','6')
And D_E_L_E_T_ ='' 
Group By E1_FILIAL, E1_CLIENTE,E1_NOMCLI
Order By 1,2

-- Situação Cobrança
Select * From FRV010
Where FRV_PROTES = '1'
And D_E_L_E_T_ ='' 

--NF Entrada 
Select F1_STATUS,* From SF1010
Where F1_DOC = '000082405'
And F1_EMISSAO > = '20240101'
And D_E_L_E_T_ ='' 

Select * From SA5010
Where A5_FORNECE = '000130'
And A5_PRODUTO In ('PE4016A','PE4011A')
And D_E_L_E_T_ ='' 


-- SB1 - Produtos 
Select * From SB1010
Where B1_COD In ('1120802201','1131104401')
And D_E_L_E_T_ ='' 

-- SB2 - Estoques
Select * From SB2010
Where B2_COD In ('1120802201','1131104401')
And B2_QATU > 0
And B2_FILIAL = '02'
And D_E_L_E_T_ ='' 

-- SBF - Estoques por Endereços
Select * From SBF010
Where BF_PRODUTO In ('1120802201','1131104401')
And BF_QUANT > 0
And BF_FILIAL = '02'
And D_E_L_E_T_ ='' 

-- SDB - Movimentos de Distribuicao
Select * From SDB010
Where DB_PRODUTO In ('1120802201','1131104401')
And DB_QUANT > 0
And DB_FILIAL = '02'
And DB_LOCAL = '01'
And DB_TM <= '499'
And DB_DOC Like ('ACERT_SLD')
And D_E_L_E_T_ ='' 


-- SB9 - Saldos Iniciais 
Select * From SB9010
Where B9_COD In ('1120802201','1131104401')
And B9_QINI > 0
And B9_DATA Between '20191130' and '20241201'
And B9_LOCAL = '01'
And B9_FILIAL = '02'
And D_E_L_E_T_ ='' 
Order By B9_DATA,B9_LOCAL

-- NF Saida Itens 
Select * From SD2010
Where D2_COD In ('1120802201','1131104401')
And D2_EMISSAO >=  '20191201'
And D2_FILIAL = '02'
And D_E_L_E_T_ ='' 
Order By D2_EMISSAO

--Mov. Internos 
Select * From SD3010
Where D3_COD In ('1120802201','1131104401')
And D3_QUANT = 100
And D3_TM <= '499'
And D3_ESTORNO = ''
And D3_EMISSAO >= '20171018'
And D_E_L_E_T_ ='' 
Order By D3_EMISSAO

-- Clintes Grupos de Clientes 
Select Distinct A1_GRPVEN From   SA1010
Where D_E_L_E_T_ ='' 
Order By A1_GRPVEN

--Grupos de Cliente s
Select * From ACY010
Where D_E_L_E_T_ ='' 

--SC Defletor Ar Condicionaod 
Select * From SC1010
Where C1_NUM = '152591'
And D_E_L_E_T_ ='' 

-- NF Entrada - Soma Manifesto
Select 
	FORMAT((Count(D1_COD)),'#,0.0000', 'pt-BR') As NF_Qtde_Itens,
	FORMAT((SUM(D1_TOTAL)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Itens,
	FORMAT((COUNT(Distinct F1_DOC)),'#,0.0000', 'pt-BR') As NF_Qtde,
	FORMAT((SUM(Distinct F1_VALBRUT)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Bruto,
	FORMAT((Sum(Distinct F1_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Valor_Mercadoria,
	FORMAT((COUNT(Distinct F1_NUMMDF)),'#,0.0000', 'pt-BR') As Manifesto_Qtde,
	FORMAT((Sum(F1_PLIQUI)),'#,0.0000', 'pt-BR') As NF_Peso_Liquido,
	FORMAT((Sum(F1_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Peso_Bruto
	 
From SF1010 As SF1

	Inner Join SD1010 SD1 -- NF Entrada Itens
		On D1_FILIAL = F1_FILIAL
		And D1_FORNECE = F1_FORNECE
		And D1_LOJA = F1_LOJA
		And D1_DOC = F1_DOC
		And D1_SERIE = F1_SERIE
		And SD1.D_E_L_E_T_ ='' 
			   
	Inner Join CC0010 CC0_SF1
		On CC0_SF1.CC0_NUMMDF = F1_NUMMDF
		And CC0_SF1.CC0_SERMDF = F1_SERMDF
		And (CC0_SF1.CC0_VEICUL = F1_VEICUL1
				Or CC0_SF1.CC0_VEICUL = F1_VEICUL2
				Or CC0_SF1.CC0_VEICUL = F1_VEICUL3
				Or CC0_SF1.CC0_VEICUL = F1_PLACA)
		And CC0_SF1.D_E_L_E_T_ = ''

Where F1_SERMDF <> '' And F1_NUMMDF <> ''
And SF1.D_E_L_E_T_ ='' 

Union All

-- NF Saida - Soma Manifesto
Select 
	FORMAT((Count(D2_COD)),'#,0.0000', 'pt-BR') As NF_Qtde_Itens,
	FORMAT((SUM(D2_TOTAL)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Itens,
	FORMAT((COUNT(Distinct F2_DOC)),'#,0.0000', 'pt-BR') As NF_Qtde,
	FORMAT((SUM(Distinct F2_VALBRUT)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Bruto,
	FORMAT((SUM(Distinct F2_VALMERC)),'#,0.0000', 'pt-BR') As NF_Valor_Mercadoria,
	FORMAT((COUNT(Distinct F2_NUMMDF)),'#,0.0000', 'pt-BR') As Manifesto_Qtde,
	FORMAT((Sum(Distinct F2_PLIQUI)),'#,0.0000', 'pt-BR') As NF_Peso_Liquido,
	FORMAT((Sum(Distinct F2_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Peso_Bruto
From SF2010 As SF2 With(Nolock)

	Inner Join SD2010 SD2 With(Nolock) -- NF Saida Itens 
		On D2_FILIAL = F2_FILIAL
		And D2_CLIENTE = F2_CLIENTE
		And D2_LOJA = F2_LOJA
		And D2_DOC = F2_DOC
		And D2_SERIE = F2_SERIE
		And SD2.D_E_L_E_T_ ='' 
		
	Inner Join CC0010 CC0_SF2 With(Nolock) --Manifesto
		On CC0_SF2.CC0_NUMMDF = F2_NUMMDF
		And CC0_SF2.CC0_SERMDF = F2_SERMDF
		And (CC0_SF2.CC0_VEICUL = F2_VEICUL1
				Or CC0_SF2.CC0_VEICUL = F2_VEICUL2
				Or CC0_SF2.CC0_VEICUL = F2_VEICUL3)
		And CC0_SF2.D_E_L_E_T_ = ''

					   
Where F2_SERMDF <> '' And F2_NUMMDF <> ''
And SF2.D_E_L_E_T_ ='' 





 --PV DRC
 Select C5_DRC,* From SC5010
 --Campos 
 Select * From SX3010
 Where X3_CAMPO = 'C5_DRC'


 --Estoques 
 Select B2_RESERVA,B2_QEMP,B2_QEMPSA,* From SB2010
 Where B2_COD = '1150206401' and B2_FILIAL= '01'
 And B2_QATU > 0
 And D_E_L_E_T_ = ''


 --Composição do Empenho         
 Select * From SDC010
 Where DC_PRODUTO = '1150206401' And DC_FILIAL = '01' --and DC_PEDIDO In ('424126','423784','423203')
 And D_E_L_E_T_ ='' 

 --Saldos por Endereço           
 Select * From SBF010
 Where BF_FILIAL = '01' and BF_PRODUTO = '1150206401'
 And BF_LOCALIZ = 'M02000'
  And D_E_L_E_T_ ='' 

  --RESERVAS PORTAL COBRECOM      
  Select * From ZP4010
  Where ZP4_CODPRO = '1150206401' And ZP4_LOCALI = 'M02000'
  And ZP4_FILIAL = '01' And ZP4_CODIGO In ('023029','023075')
  And D_E_L_E_T_ = ''
------ZP4- Status - 1=Pendente;2=Atendida;3=Expirada;4=Cancelada     

--Carta de Descontos            
Select * From SZY010

--Tabela de preços 
Select * From DA0010
--Tabela de preços Itens
Select * From DA1010


--Campos 
Select * From SX2010
Where X2_CHAVE In ('DA0','DA1','ZZE')

--Contador NFs
Select F1_ESPECIE,F1_TIPO,Count(F1_ESPECIE) From SF1010
Where F1_EMISSAO Between '20240105' and '20240531'
And D_E_L_E_T_ ='' 
Group By F1_ESPECIE,F1_TIPO


--Rastreamento Contabil - Novo Conciliador 

-- Contabil 
Select CT2_MSUIDT,* From CT2010
Where CONVERT(VARCHAR(36), CT2_MSUIDT) <> ''
And D_E_L_E_T_ = '' 

-- Contas a pagar 
Select E2_MSUIDT,* From SE2010
Where CONVERT(VARCHAR(36), E2_MSUIDT) <> ''
And D_E_L_E_T_ = '' 

-- NF Entrada Cab.
Select F1_MSUIDT,* From SF1010
Where CONVERT(VARCHAR(36), F1_MSUIDT) <> ''
And D_E_L_E_T_ ='' 

--Mov. Bancaria 
Select E5_MSUIDT,* From SE5010
Where CONVERT(VARCHAR(36), E5_MSUIDT) <> ''
And D_E_L_E_T_ ='' 

--Pesagem 
Select * From SZE010
Where ZE_NUMBOB = '2331036'
And D_E_L_E_T_ ='' 

--Etiquetas
Select * From SZL010
Where ZL_NUMBOB = '2331036'
And D_E_L_E_T_ ='' 

--Retrabalho
Select * FRom ZZE010
Where ZZE_NUMBOB = '2331036'
And D_E_L_E_T_ ='' 



--Testes *************************************************

-- Tipos de dados
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'SF1010'


-- NF Entrada Cab.
Select Convert(F1_MSUIDT As VarChar(Max)),* From SF1010
--Where Isnull(F1_MSUIDT,'') <> ''
And D_E_L_E_T_ ='' 

SELECT 
    F1_MSUIDT,
    CAST(F1_MSUIDT AS VARCHAR(36)) AS F1_MSUIDT_String
FROM 
    SF1010
WHERE 
    CAST(F1_MSUIDT AS VARCHAR(36)) <> ''
    AND D_E_L_E_T_ = ''


	SELECT 
    F1_MSUIDT,
    CONVERT(VARCHAR(36), F1_MSUIDT) AS F1_MSUIDT_String
FROM 
    SF1010
WHERE 
    CONVERT(VARCHAR(36), F1_MSUIDT) <> ''
    AND D_E_L_E_T_ = ''
--***************************************************************************



--NF Entrada 
Select * From SF1010
Where F1_CHVNFE = '35240668893775000177550010000636781000437406'
And D_E_L_E_T_ ='' 


-- Produtos 
Select B1_COD,B1_TIPO,B1_DESC,B1_UM,B1_GRUPO,* From SB1010
Where B1_COD = 'SV05000040'
And D_E_L_E_T_ ='' 

--Tipos de Produtos 
Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE = 'SV' and X5_FILIAL = '01'
And D_E_L_E_T_ ='' 



-- Grupos de produtos 
Select * From SBM010
Where BM_GRUPO = 'SV05'

-- Unidade de medida
Select * From SAH010
Where AH_UNIMED = 'SE'
And D_E_L_E_T_ ='' 

--Contas a pagar 
Select * From SE2010
Where E2_NUM = '062024'
And D_E_L_E_T_ ='' 

--Contas a Pagar              
Select E2_NUMCX,ZM_NUMCX,ZM_NUMERO,E2_NUM,ZM_PARCELA,E2_PARCELA,ZM_PREFIXO,E2_PREFIXO,ZM_TIPO,E2_TIPO,ZM_FORNEC,E2_FORNECE,
ZM_VALOR,E2_VALOR,E2_VALLIQ,E2_VLCRUZ, Round((ZM_VALOR-E2_VALOR),2) As DIF_,Round((E2_VALLIQ-E2_VALOR),2) AS DIF_LIQUI,
E2_JUROS,E2_ACRESC,E2_DECRESC,E2_ORIGEM,

X5_DESCRI,
ZM_VENCTO,E2_VENCTO,E2_BAIXA, DATEDIFF (Day,E2_VENCTO,E2_BAIXA) AS DIF_DIAS,
	Case 
	When Round((ZM_VALOR-E2_VALOR),2) = Round(E2_JUROS,2) Or 
		 Round((ZM_VALOR-E2_VALOR),2) = Round(E2_ACRESC,2)
	Then 'DIF_JUROS_ACRESC'
	When Round((ZM_VALOR-E2_VALOR),2) = Round((E2_JUROS+E2_ACRESC),2) Then 'DIF_SOMA_JUROS_ACRESC'
	Else 'Analisar'
	End As Analise,

* From SE2010 SE2 -- Contas a pagar 
	
	--Caixa
	Left Join SZM010 SZM
	On ZM_FILIAL = E2_FILIAL
	And ZM_FORNEC = E2_FORNECE
	And ZM_LOJA = E2_LOJA
	And ZM_NUMERO = E2_NUM
	And ZM_PREFIXO = E2_PREFIXO
	And ZM_PARCELA = E2_PARCELA
	And ZM_TIPO = E2_TIPO
	And SE2.D_E_L_E_T_ = ''

	--Genericas
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = ZM_FILIAL
	And ZM_TIPO = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''
	
Where E2_NUM In ('062024')
and SZM.D_E_L_E_T_ = ''
--ZM_DATA >= '20230901'  And (ZM_VALOR-E2_VALOR) > 1
Order By 25,26 Desc


--PV
Select C5_ZSTATUS,* From SC5010
Where C5_NUM = '424582'
And D_E_L_E_T_ = ''

--PV Itens 
Select * From SC6010
Where C6_NUM = '424582'
And D_E_L_E_T_ = ''

--PV Liberados 
Select C9_BLCRED,* From SC9010
Where C9_PEDIDO = '424582'
And D_E_L_E_T_ = ''

-- ZZR - Logs das ordens de separação 
Select ZZR_OS,* From ZZR010
Where ZZR_PEDIDO = '424582'
And D_E_L_E_T_ = ''

--Ordens de carga
Select * From ZZ9010

-- SZE Etiquetas 
Select * From SZE010
Where ZE_PEDIDO = '424582'
And D_E_L_E_T_ = ''

-- Pesagem
Select * From SZL010
Where ZL_PEDIDO = '424582'
And D_E_L_E_T_ = ''

-- Estoque por endereços 
Select * From SBF010

-- Empenhos or endereço 
Select * From SDC010
Where DC_PEDIDO = '424582'
And D_E_L_E_T_ = ''

--Produtos 
Select * From SB1010
Where B1_COD = 'Q1150504401'
And D_E_L_E_T_ = ''

-- Generica Tipo Produto 
Select * From SX5010 SX5_TP With(Nolock) 
Where  SX5_TP.X5_TABELA = '02'
And SX5_TP.X5_CHAVE = 'PI'
And SX5_TP.D_E_L_E_T_ = ''









-- Eventos EventViewer
Select ISNULL(CAST(CAST(XH_MESSAGE AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From SXH
Where D_E_L_E_T_ = ' '




Select 
'//'+'QTDE'+'-'+
	(Convert(varchar,Count( B1_TIPO)))+
	'/'+
	Ltrim(Rtrim(B1_TIPO))+
	'-'+
	Ltrim(Rtrim(X5_DESCRI))+
	 '/'+
	 Ltrim(Rtrim(BM_GRUPO))+
	 '-'+
	 Ltrim(Rtrim(BM_DESC))+
	 '/'+
'//' 
											
From SF1010 SF1 With(Nolock)
												
Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
On F1_FILIAL = D1_FILIAL
And F1_DOC = D1_DOC
And F1_LOJA = D1_LOJA
And F1_FORNECE = D1_FORNECE
And F1_LOJA = D1_LOJA
And SD1.D_E_L_E_T_ = ''

Inner Join SB1010 SB1 With(Nolock) -- Produtos
On D1_COD = B1_COD
And SD1.D_E_L_E_T_ = ''

Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
On X5_TABELA = '02' 
And X5_CHAVE = B1_TIPO
And SX5.D_E_L_E_T_ = ''

Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
On BM_GRUPO = B1_GRUPO
And SBM.D_E_L_E_T_ = ''

Where F1_EMISSAO >= '20240601'
Group By B1_TIPO,X5_DESCRI,BM_GRUPO,BM_DESC

Select F1_OBSTRF,F1_TIPO,* From SF1010
Where F1_OBSTRF <> '' and D_E_L_E_T_ = ''

Select * From SZL010
Where ZL_FILIAL = '01' And ZL_NUM = '416781'
and D_E_L_E_T_ = ''

Select * From SZN010




-- ZP5 - Orcamento Cab. *******

Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,

ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,

ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,

* From ZP5010

Where ZP5_DATA >= '20240701' and  D_E_L_E_T_ =''
And ZP5_STATUS In ('A','B','C')
Or ZP5_NUM = '387771'

--ZP5_STATUS 

--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado     

-- Parameros 
Select * From SX6010
Where X6_VAR = 'MV_NT23004'
and D_E_L_E_T_ = ''

-- Livro Fiscal Cab.
Select F3_NFISCAL,* From SF3010
Where F3_FILIAL = '01' and F3_NFISCAL = '000406029' --and D2_COD Like '%1150702401%'
and D_E_L_E_T_ =''


-- Livro Fiscal Itens
Select FT_NFISCAL,* From SFT010
Where FT_FILIAL = '01' and FT_NFISCAL = '000406029' 
and D_E_L_E_T_ =''

--CD2 - Livro Digital de impostos - SPED
Select *From CD2010
Where CD2_FILIAL = '01' and CD2_DOC = '000406029'
and D_E_L_E_T_ =''

-- Parametros 
Select * From SX6010
Where D_E_L_E_T_ =''

--XX7 - "Itens do Catalogo de personalizacoes"
Select * From XX7010
Where D_E_L_E_T_ =''


-- Portal - usuários 
Select * From ZP1010
Where ZP1_CODIGO = '000265'
And D_E_L_E_T_ =''

 -- ZP5 - Orcamento Cab. *******
Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010
Where ZP5_NUM In ('395086') and  D_E_L_E_T_ =''
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado ;9= Aguardando Processamento         

-- ZP6 - Orcamento Itens 
Select * From ZP6010
Where ZP6_NUM In ('395086')
And D_E_L_E_T_ =' '





-- Logs portal Vendas
SELECT 
    ISNULL(CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)), '') AS MSG,
    * 
FROM ZP2010
WHERE 
    CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)) LIKE '%395086%' 
	--And CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)) Like '%Administrador%'
    AND D_E_L_E_T_ = ''
	And ZP2_DATA >= '20240807'

	--Parametros 
Select * From SX6010
Where X6_VAR = 'ZZ_VLPADPT'
AND D_E_L_E_T_ = ''

--REVISOES ORCAMENTOS           
Select 
 ISNULL(CAST(CAST(ZPE_JSON AS VARBINARY(MAX)) AS VARCHAR(MAX)), '') AS MSG,
* From ZPE010
Where ZPE_NUM = '395086'
AND D_E_L_E_T_ = ''



-- ZP3 - Orcamento Msg *******
Select ISNULL(CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP3010
Where CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)) Like '%395086%'
And D_E_L_E_T_ =' '


--DOCUMENTOS ORCAMENTOS         
Select * From ZPA010
Where ZPA_NUM In ('382568')
--or ZPA_NUMDOC In ('107982','108060')
And D_E_L_E_T_ = ''

-- PV Cab.
Select C5_DOCPORT,A1_NOME,* From SC5010 SC5
	Inner Join SA1010 SA1
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C5_FILIAL In ('01','02') and C5_DOCPORT In ('428614')
And SC5.D_E_L_E_T_ = ''
-- C5_DOCPORT - Numero Orcamento Portal 


-- Clientes 
Select * From SA1010
Where A1_COD In ('045583')
and D_E_L_E_T_ = ''

-- LP
Select CT5_ITEMD,* From CT5010
Where CT5_ITEMD <> ''
And CT5_LANPAD = '610'
and D_E_L_E_T_ = ''
Order By CT5_LANPAD

-- NF Itens 
Select F2_TIPO,F4_CODIGO,F4_TEXTO,F4_CF,D2_TOTAL,D2_VALICM,D2_VALIMP6,D2_VALIMP5,D2_VALIPI,
* From SF2010 SF2

	Inner Join SD2010 SD2 
		On F2_FILIAL = D2_FILIAL
		And F2_CLIENTE = D2_CLIENTE
		And F2_LOJA = D2_LOJA
		And F2_DOC = D2_DOC 
		And F2_SERIE = D2_SERIE
		And SD2.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4
		On D2_TES = F4_CODIGO
		And SF4.D_E_L_E_T_ = ''

Where F2_TIPO = 'D'
And F4_CF In ('5410','5411','5412','5413','5553','5412','5413','5555')
And F2_EMISSAO Between '20240701' and '20240731'
And SF2.D_E_L_E_T_ = ''

-- Contab.
Select CT2_ROTINA,R_E_C_N_O_,* From CT2010
Where D_E_L_E_T_ = '*' and CT2_VALOR In ('5242','89','3819.42','1800')
And CT2_DATA >= '20240601'
Order By 1

--Importação Chile
--Sem QRCode
--1310904556
--Com QRCode 1270504583 / 1270404583


-- Produtos
Select B1_COD, B1_DESC,B1_FAMILIA, * From SB1010
Where B1_COD In ('1310904556','1270504583','1270404583')  
and D_E_L_E_T_ = ''

-- Produtos Complemento
Select * From SB5010
Where B5_COD In ('1310904556','1270504583','1270404583')
and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD In ('1310904556','1270504583','1270404583')
And D_E_L_E_T_ = ''


-- Genericas - Tipos de produtos 
Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE = 'PA'
 and D_E_L_E_T_ =''

 -- Nome Produto 
 Select * From SZ1010
 Where Z1_COD In ('127','131') and D_E_L_E_T_ =''  

  -- Bitola
 Select * From SZ2010
 Where  D_E_L_E_T_ ='' and Z2_COD = '05'
 Order By Z2_XPORTAL


   -- Cores
 Select * From SZ3010
 Where  D_E_L_E_T_ =''
 And Z3_COD = '01'


 -- Classe
Select * From SX5010
Where X5_TABELA = 'Z1' 
 and D_E_L_E_T_ =''

   -- Especialidade
 Select * From SZ4010
 Where  D_E_L_E_T_ =''



 --LANCES X ACONDICIONAMENTO     
 Select * From ZZZ010
 Where ZZZ_BITOLA <> ('') and ZZZ_ACOND In ('B') and ZZZ_PROD In ('115')
  and D_E_L_E_T_ =''

-- Portal -- 
--SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 
WHERE Z2_COD IN( '08','04','05')

--Produtos Descriçao
Select * From SZ7010


-- SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 WHERE Z2_COD IN( '08','04','05')

--LANCES X ACONDICIONAMENTO     
Select * From ZZZ010

--SZJ
Select * From SZJ010
Where ZJ_PRODUTO In ('1310904556','1270504583','1270404583')
and D_E_L_E_T_ =''




--NF Itens 
Select Distinct D1_COD,B1_DESC,D1_TP,X5_DESCRI,F1_DOC,F1_SERIE,E2_NUM,E4_COND,
DATEPART(MONTH, D1_EMISSAO) As MES,DATEPART(YEAR, D1_EMISSAO) As Ano,
DATEPART(MONTH, SE2.E2_VENCTO) As MES_Fin,DATEPART(YEAR, SE2.E2_VENCTO) As Ano_Fin,
E2_VALOR As Valor_Titulo, Sum(Distinct E2_VALOR) As Valor_Titulo_Soma,
SUM(D1_TOTAL) As Total_Itens, F1_VALBRUT As Val_NF


From SD1010 SD1

	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ =''

	Inner Join SX5010 SX5
	On X5_TABELA = '02' 
	And X5_CHAVE = B1_TIPO
	And SX5.D_E_L_E_T_ = ''

	Inner Join SF1010 SF1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''	
	
	Left Join SE2010 SE2
	On SE2.E2_FILIAL = F1_FILIAL
	And SE2.E2_FORNECE = F1_FORNECE
	And SE2.E2_LOJA = F1_LOJA
	And SE2.E2_NUM = F1_DOC 
	And SE2.E2_TIPO = 'NF'
	And SE2.D_E_L_E_T_ =''	

	Inner Join SE4010 SE4
	On E4_CODIGO = F1_COND
	And SE4.D_E_L_E_T_ =''	
	
Where D1_CC = '100112'
And F1_DOC = '000000175' and F1_SERIE = '0'
And SD1.D_E_L_E_T_ = ''
Group By D1_COD,B1_DESC,D1_TP,X5_DESCRI,
F1_DOC,F1_SERIE,E2_NUM,E4_COND,
DATEPART(MONTH, D1_EMISSAO),DATEPART(YEAR, D1_EMISSAO),
DATEPART(MONTH, SE2.E2_VENCTO),DATEPART(YEAR, SE2.E2_VENCTO),
F1_VALBRUT,E2_VALOR
Order By 5,6

--NF Entrada 
Select Distinct E2_NUM,F1_DOC,Sum(E2_VALOR) As VAL_TIT,SUM(Distinct F1_VALBRUT) As VAL_NF,
D1_COD, SUM(Distinct D1_TOTAL) VAL_ITEM,
DATEPART(MONTH, D1_EMISSAO) As MES,DATEPART(YEAR, D1_EMISSAO) As Ano,
DATEPART(MONTH, SE2.E2_VENCTO) As MES_Fin,DATEPART(YEAR, SE2.E2_VENCTO) As Ano_Fin

From SF1010 SF1

	Left Join SE2010 SE2
	On SE2.E2_FILIAL = F1_FILIAL
	And SE2.E2_FORNECE = F1_FORNECE
	And SE2.E2_LOJA = F1_LOJA
	And SE2.E2_NUM = F1_DOC 
	And SE2.E2_TIPO = 'NF'
	And SE2.D_E_L_E_T_ =''	

	Inner Join SD1010 SD1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''	

Where F1_DOC = '000000175' and F1_SERIE = '0' And F1_FORNECE = 'VOOZOK' 
And SF1.D_E_L_E_T_ =''	
Group By E2_NUM,F1_DOC,F1_VALBRUT,D1_COD,
DATEPART(MONTH, D1_EMISSAO),DATEPART(YEAR, D1_EMISSAO),
DATEPART(MONTH, SE2.E2_VENCTO),DATEPART(YEAR, SE2.E2_VENCTO)

--Parametros 
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_ATFSOLD','MV_ALTLCTO','MV_PRELAN')
And D_E_L_E_T_ =''	


-- EDI CTE 
Select 
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_OBS)),'') AS [OBS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_EDIMSG)),'') AS [MGS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_ZZMSG)),'') AS [ZZMGS],
GXG_EDISIT, GXG_DTIMP,GXG_CTE,

	Case 
	When GXG_EDISIT = '1'  Then 'Importado'
	When GXG_EDISIT = '2'  Then 'Importado com Erro'
	When GXG_EDISIT = '3'  Then 'Rejeitado'
	When GXG_EDISIT = '4'  Then 'Processado'
	When GXG_EDISIT = '5'  Then 'Erro Impeditivo'
	Else 'ANALISAR'
	End AS Status_EDI,

* From GXG010
Where GXG_FILIAL In ('01','02','03') and GXG_DTEMIS >= '20240101'
And GXG_EDISIT In ('2','3','5')
And GXG_CTE In ('35240645830855000773570010000000111004800245','35240645830855000773570010000000081004800592')
And D_E_L_E_T_ = ''
Order By 4,5

--NF Saida
Select MAX(F2_DOC) From SF2010
Where F2_FILIAL = '01' And F2_DOC Like ('%0003998%')
And D_E_L_E_T_ = ''

-- Genericas 
Select * From SX5010
Where X5_FILIAL = '01' And (X5_FILIAL = '01' And X5_TABELA = '01' and X5_CHAVE = '1')
Or (X5_FILIAL = '01' And X5_TABELA = '00' and X5_CHAVE = '01')
And D_E_L_E_T_ = ''

---Novo  Conciliador Cntabil CTBA940
--QLB - Conciliador Backoffice - Chaves 
Select * From QLB010
Where  QLB_CODCFG Like ('10%') and D_E_L_E_T_ = ''
--QLC - Cabeçalho da Conciliação  
Select * From QLC010
Where D_E_L_E_T_ = ''
--QLD - Itens da Conciliação  
Select * From QLD010
Where D_E_L_E_T_ = ''
--QLM - Controle de Acesso
Select * From QLM010
Where D_E_L_E_T_ = ''

SELECT *


--Data width error - Field: D2_CUSTO1 Value: 17455467816658.000000 on GRAVACUSD2(SIGACUSA.PRX) 25/09/2023
--UPDATE SB2010 SET B2_VATU1 = 0, B2_CM1 = 0
--UPDATE SB2010 SET B2_VATU2 = 0, B2_CM2 = 0, B2_VATU3 = 0, B2_CM3 = 0,B2_VATU4 = 0, B2_CM4 = 0, B2_VATU5 = 0, B2_CM5 = 0
FROM SB2010
WHERE B2_FILIAL  = '02'
AND B2_LOCAL = '01'
AND D_E_L_E_T_ = ''



-- Alçadas Aprovação 
Select CR_STATUS,
		Case 
			When CR_STATUS = '01'
			Then 'Pendente em níveis anteriores - azul'
			When CR_STATUS = '02'
			Then 'Pendente - vermelho'
			When CR_STATUS = '03'
			Then 'Aprovado - verde'
			When CR_STATUS = '04'
			Then 'Bloqueado - preto'
			When CR_STATUS = '05'
			Then 'Aprovado/rejeitado pelo nível - cinza'
			When CR_STATUS = '06'
			Then 'Rejeitado - x vermelho '
			When CR_STATUS = '06'
			Then 'Documento Rejeitado ou Bloqueado por outro usuário. - amarelo'
			Else 'XXXXXX'
			End As Status,
* From SCR010
Where CR_FILIAL = '01' and CR_TIPO <> '' and CR_NUM In ('019474')
And D_E_L_E_T_ = ''
Order By CR_USER
--CR_STATUS='01' - Pendente em níveis anteriores - azul
--CR_STATUS='02' - Pendente - vermelho
--CR_STATUS='03' - Aprovado - verde
--CR_STATUS='04' - Bloqueado - preto
--CR_STATUS='05' - Aprovado/rejeitado pelo nível - cinza
--CR_STATUS='06' - Rejeitado - x vermelho                                                                                                                        
--CR_STATUS='07' - Documento Rejeitado ou Bloqueado por outro usuário. - amarelo

-- Alçadas Aprovação Itens 
Select * From DBM010
Where DBM_FILIAL = '01' and DBM_TIPO <> 'PC' and DBM_NUM In ('019474')
And D_E_L_E_T_ = ''
Order By DBM_USER
--DBM_APROV - 1=Aprovado;2=Pendente;3=Rejeitado



-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_APRPCEC','MV_APRSCEC','MV_ALTPDOC')
And D_E_L_E_T_ = ''

-- Grupos de Aprovação 
Select * From SAL010
Where D_E_L_E_T_ = ''

-- Aprovadores 
Select * From SAK010
Where D_E_L_E_T_ = ''

-- Perfil de aprovadores
Select * From DHL010

--Tipos de Compras x Aprovador
Select * From DHM010
Where D_E_L_E_T_ = ''

-- Entidades Contabeis x Grupo Aprovadores 
Select * From DBL010
Where D_E_L_E_T_ = ''

-- Grupos de Aprovação  
Select AL_FILIAL,AL_COD,AL_DESC,
AK_COD,AK_NOME,DHL_COD,DHL_LIMMIN,DHL_LIMMAX,
* From SAL010 SAL -- Grupos de Aprovadores
	
	Inner Join SAK010 SAK -- Aprovadores
	On AK_FILIAL = AL_FILIAL
	And AK_COD = AL_APROV
	And SAK.D_E_L_E_T_ = ''

	Inner Join DHL010 DHL -- Perfil de aprovadores 
	On DHL_FILIAL = AK_FILIAL
	And DHL_COD = AL_PERFIL
	And DHL.D_E_L_E_T_ = ''

Where AL_FILIAL = '01' and AL_COD In ('000001','000002','000003','000004','000005')
And AK_COD Not In ('000009')
And SAL.D_E_L_E_T_ =''



-- Grupos de aprovação x Centro de Custos 
Select Distinct DBL_FILIAL,DBL_GRUPO,AL_COD,AL_DESC,CTT_CUSTO,CTT_DESC01
From DBL010 DBL

	Inner Join SAL010 SAL -- Grupos de aprodores 
	On AL_FILIAL = DBL_FILIAL
	And DBL_GRUPO = AL_COD
	And SAL.D_E_L_E_T_ = ''

	Inner Join CTT010 CTT -- CC
	On DBL_CC = CTT_CUSTO
	And CTT.D_E_L_E_T_ = ''

Where DBL.D_E_L_E_T_ =''
Order By 2


--Parametros 
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,* From  SX6010
Where X6_VAR In (
'MV_ATFDPDI',
'MV_ATFMCCM',
'MV_ATFMDMX',
'MV_ATFMOED',
'MV_TIPDEPR',
'MV_ULTDEPR',
'MV_VALCORR',
'MV_ATFRSLD',
'MV_BLQINVE'
)
And D_E_L_E_T_ =''

--Contas a pagar CC
Select E2_CCUSTO,* From SE2010
Where E2_CCUSTO <> ''





--CONTROLE NEGOCIO VENDAS       
Select * FRom ZZV010
Where ZZV_ID In ('004890', 
					'005999', 
					'006241', 
					'006235', 
					'006237', 
					'006238', 
					'006247')
And D_E_L_E_T_ = ''
-- ZZV_STATUS - C6_XNEGOC
--1 - Falta iniciar atendimento ZZV_STATUS
--2 - Em negociacao
--3 - Agendamento futuro
--4 - Falta aprovacao supervisao
--5 - Falta alterar pedido
--6 - Rejeitado cobrecom
--7 - NAO ESTA EM NEGOCIACAO

-- PV 
Select C6_NUM,C6_XNEGOC,(C6_QTDVEN-C6_QTDENT) As Saldo,C6_NOTA,* From SC6010
Where C6_NUM In ('335376',
				'416298',
				'426360',
				'426191',
				'426191',
				'426292',
				'426523')
And C6_XNEGOC <> ''
And C6_NOTA <> ''
--And (C6_QTDVEN-C6_QTDENT) > 0 
And D_E_L_E_T_ = ''




-- Parametros
Select * From SX6010
Where X6_VAR = 'MV_MULNATP'
And D_E_L_E_T_ =' '

-- Contas a pagar 
Select E2_MULTNAT,E2_NATUREZ, * From SE2010
Where E2_MULTNAT = '1'
And D_E_L_E_T_ =' '
Order By E2_FILIAL,E2_NUM
--E2-NATUREZ
--Codigo da natureza. Utilizado para identificar a procedencia dos titulos, permitindo a consolidacao por este item e o controle orcamentario.
--E2_MULTNAT
--1=Sim;2=Nao
--Help de Campo: Indica se o titulo tera seu valor distribuido entre varias naturezas, sem a necessidade de incluir mais de um tituloquando o

-- Natureza Financeira
Select * From SED010
Where D_E_L_E_T_ =' '

-- SEV - Mutiplas Naturezas por titulo 
Select EV_NATUREZ,EV_RATEICC, * From SEV010
Where D_E_L_E_T_ =' '
Order By EV_FILIAL,EV_NUM
--EV_RATEICC
--1=Sim;2=Nao
--Help de Campo: Informa a utilizacao ou nao de distribuicao por centro de custo dos valores da natureza na distribuicao por multiplas naturezas. 
--1 = Sim - Utiliza a distribuicao por centro de custo 2 = Nao - Nao utiliza a distribuicao por centro de custo

-- Ordens de separação 
Select ZZR_SITUAC,ZZR_DOC,* From ZZR010
Where ZZR_PEDIDO = '425284'
And D_E_L_E_T_ =' '

-- ZZF -- Controle sobre Retrabalho
Select * From ZZF010
Where ZZF_ZZEID In ('050027','050028','056107','063406')
And D_E_L_E_T_ =' '
--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat  
-- ZZF_ZZEID = Retrabalho
--ZZF_ZZEID = ZZEID

--SDC - Composicao do Empenho
Select D_E_L_E_T_,* From SDC010
Where 
DC_PEDIDO In ('050027','050028','056107','063406')
--And DC_LOCALIZ In ('R00100')
And D_E_L_E_T_ =' '
And DC_ORIGEM = 'ZZF'


-- CTRL RETRABALHO PROATIVA      
Select ZZE_STATUS,ZZE_SITUAC,* From ZZE010
Where ZZE_ID In ('023010','050028','056107','063406')
And D_E_L_E_T_ = ''
--ZZE_SITUAC 1=Encerrado;2=Em Aberto                                                                                                     
--ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO   
--ZZF_ZZEID = ZZEID


-- Saldo Inicial 
Select B9_CM1, Round((B9_VINI1/B9_CM1),2) as CM_CALC,
* From SB9010
Where B9_COD In ('2010000000','PE4017A')
And B9_DATA Between '20240101' And '20241231'
And B9_QINI > 0
And D_E_L_E_T_ = ''
Order By B9_DATA,B9_FILIAL,B9_LOCAL

-- Estoque 3 
Select B6_QUANT,B6_PRUNIT,B6_CUSTO1, Round((B6_CUSTO1/B6_QUANT),2) As CM_CALC,
* From SB6010
Where B6_DOC = '000396870'
And B6_EMISSAO Between ('20240101') and ('20241231')
And D_E_L_E_T_ = ''
Order By 4 Desc

---PC
Select C7_FORNECE,* From SC7010
Where C7_NUM = '019617'
And D_E_L_E_T_ = ''

-- Fornece
Select A2_CGC,* From SA2010
Where A2_COD In ('VOP648','VOPAZB')
And D_E_L_E_T_ = ''

-- Paramtros 
Select X6_VAR,X6_TIPO,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_CHVNFE','MV_DCHVNFE','MV_CHVESPE')
And D_E_L_E_T_ = ''


--User
Select * From SYS_USR
Where USR_CODIGO  Like ('%gabriel%')
And D_E_L_E_T_ = ''

Select * From SC2010
Where C2_EMISSAO >= '20240301'
And D_E_L_E_T_ = ''







-- NF Saida Itens
Select Round((D2_TOTAL/D2_QUANT),4) As CALC, 
Round((D2_CUSTO1/D2_QUANT),4) AS CM_CALC,
D2_CUSTO1,
* From SD2010 With (Nolock)
Where D2_COD = '2010000000'
And D2_EMISSAO Between '20240601' and '20240630'
--And D2_DOC In ('000405199','000156284')
And D_E_L_E_T_ = ''
Order By CM_CALC

-- NF Entrada Itens
Select Round((D1_TOTAL/D1_QUANT),4)As CALC, 
Round((D1_CUSTO/D1_QUANT),4) AS CM_CALC,
D1_CUSTO,
* From SD1010
Where D1_COD = '2010000000'
And D1_EMISSAO Between '20240601' and '20240630'
And D1_DOC In ('000405199','000156284')
And D_E_L_E_T_ = ''
Order By CM_CALC

--Movimentos Internos 
Select (D3_CUSTO1/D3_QUANT) AS CM_CALC,
D3_CUSTO1,
* From SD3010 With(Nolock)
Where D3_COD = '2010000000'
And D3_EMISSAO Between '20240601' and '20240630'
And D3_QUANT > 0 
And D3_CUSTO1 > 0
And D3_ESTORNO <> 'S'
--And D3_DOC = '000405199'
And D_E_L_E_T_ = ''
Order By CM_CALC

--Movimentos Internos 
Select 
* From SD3010 With(Nolock)
Where D3_COD = '2010000000'
And (D3_QUANT = 0 Or D3_CUSTO1 = 0)
And D3_ESTORNO <> 'S'
And D3_EMISSAO Between '20240601' and '20240630'
And D_E_L_E_T_ = ''

-- Estoque 3 
Select 
Round((B6_CUSTO1/B6_QUANT),4) AS CM_CALC,
B6_CUSTO1,B6_PRUNIT,
* From SB6010
Where B6_PRODUTO = '2010000000'
And B6_EMISSAO Between '20240601' and '20240630'
And D_E_L_E_T_ = ''
--And B6_DOC In ('000405199','000156284')
Order By CM_CALC

-- B9 Saldos Iniciais 
Select 
--Round((B9_VINI1/B9_QINI),4) AS REAL_CALC,
--B9_CM1,B9_VINI1,B9_CM1,
* From SB9010
Where B9_COD = '2010000000'
And B9_DATA Between '20240501' and '20240531'
--And B9_QINI > 0 
--And B9_VINI1 < 0
And D_E_L_E_T_ = ''
Order By REAL_CALC


-- Portal - Cab. Orcamento 
Select ZP5_STATUS,
ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010
Where ZP5_NUM In ('392739') --or ZP5_CLIENT = '028171'
And D_E_L_E_T_ = ''
/* Status dos Orçamentos
#define QUOTATION_STATUS_REVISION                   "0"
#define QUOTATION_STATUS_UNDER_MAINTENANCE          "1"
#define QUOTATION_STATUS_WAITING_APPROVAL           "2"
#define QUOTATION_STATUS_APPROVINGLY                "3"
#define QUOTATION_STATUS_WAITING_CONFIRM            "4"
#define QUOTATION_STATUS_CONFIRMED                  "5"
#define QUOTATION_STATUS_NOT_APPROVED               "6"
#define QUOTATION_STATUS_CANCELED                   "7"
#define QUOTATION_STATUS_WAITING_TECNICAL_APPROVAL  "8"
#define QUOTATION_STATUS_WAITING_PROCESSING         "9"
#define QUOTATION_STATUS_PROCESSING                 "A"
#define QUOTATION_STATUS_ERROR_PROCESSING           "B"
#define QUOTATION_STATUS_TECNICAL_REJECT            "C"*/

-- Logs portal Vendas ********
Select ISNULL(CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP2010
Where ZP2_CODIGO = '00392739'

-- ZP3 - Orcamento Msg *******
Select ISNULL(CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP3010
Where ZP3_NUMORC In ('392739')
And D_E_L_E_T_ =' '

-- ZP6 - Orcamento Itens 
Select * From ZP6010
Where ZP6_NUM = '392739'
And D_E_L_E_T_ =' '

--DOCUMENTOS ORCAMENTOS         
Select * From ZPA010
Where ZPA_NUM In ('392739')
--or ZPA_NUMDOC In ('107982','108060')
And D_E_L_E_T_ = ''

-- PV Cab.
Select C5_DOCPORT,A1_NOME,* From SC5010 SC5
	Inner Join SA1010 SA1
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C5_FILIAL In ('01','02') and C5_DOCPORT In ('392739')
And SC5.D_E_L_E_T_ = ''
-- C5_DOCPORT - Numero Orcamento Portal 

--PV Lib
Select * From SC6010 SC6
Where C6_FILIAL = '02' 
And C6_NUM In ('113624','113612')
And D_E_L_E_T_ = ''
Order By C6_NUM

--PV Lib
Select * From SC9010 SC9
Where C9_FILIAL = '02' 
And C9_PEDIDO In ('113624','113612')
And D_E_L_E_T_ = ''






-- PV Cab.
Select C5_DOCPORT,A1_NOME,* From SC5010 SC5
	Inner Join SA1010 SA1
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C5_FILIAL In ('02') and C5_NUM In ('113218')
And SC5.D_E_L_E_T_ = ''
-- C5_DOCPORT - Numero Orcamento Portal 

--PV Lib
Select (C6_QTDVEN-C6_QTDENT) As SALDO,C6_NOTA,
* From SC6010 SC6
Where C6_FILIAL = '02' 
And C6_NUM In ('113218')
And D_E_L_E_T_ = ''
Order By SALDO

--PV Lib
Select C9_NFISCAL, C9_QTDLIB,
* From SC9010 SC9
Where C9_FILIAL = '02' 
And C9_PEDIDO In ('113218')
And D_E_L_E_T_ = ''

Select D1_QUANT,D1_VUNIT,D1_TOTAL,D1_CUSTO,

	Case
		When D1_CUSTO > 0 And D1_QUANT > 0
		Then (D1_CUSTO/D1_QUANT) 
		Else 0
		End As Calc,
* From SD1010
Where  D_E_L_E_T_ = ''

-- Produtos ICMS 
Select B1_PICM,* From SB1010
Where B1_COD = 'PF1820A'
And D_E_L_E_T_ = ''

--Parametros ICMS
Select X6_FIL,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_VAR,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_ICMPAD','MV_ESTICM','MV_NORTE','MV_GTPICM') 
And D_E_L_E_T_ = ''
--cUfOrig





-- PV Liberados
Select C9_PEDIDO,* From SC9010
Where C9_PEDIDO In ('428679')					
And C9_PRODUTO In ('1111504401')
And D_E_L_E_T_ = ''
Order By 1,C9_ITEM

-- PV - Itens 
Select C6_QTDEMP,C6_ZZPVORI,C6_FILIAL,C6_NOTA,C6_NUM,C6_QTDVEN,C6_QTDENT, (C6_QTDVEN-C6_QTDENT) As Saldo,* From SC6010
Where C6_NUM In ('428679'					)
And C6_PRODUTO In ('1111504401')
and D_E_L_E_T_ =''

--PV
Select C5_DOCPORT,* From SC5010
Where C5_NUM In ('428615')
and D_E_L_E_T_ =''


 -- Rasterar Bobinas Empenhadas
--01 - Rasterar Numero de Bobina 
--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,ZE_STATUS,ZE_CONDIC,ZE_SITUACA,ZE_SEQOS,* From SZE010
Where ZE_FILIAL In ('01','02','03') 
And ZE_NUMBOB = '2339848'
--and ZE_CTRLE In ('023010','023011') 
and D_E_L_E_T_ ='' 
and ZE_STATUS Not in  ('F','C')
--And ZE_PEDIDO In ('114101','428054')
	
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa     



-- 04 - Rastrar Controle de Vendas 
--ZE_CTRLE = ZZV_ID
-- Verificar Vendedor Responsavel = ZZV_SUPER = SA3 Vendedores 
--ZZV_SUPER = A3_COD
--CONTROLE NEGOCIO VENDAS       
Select ZZV_SUPER,* From ZZV010
Where ZZV_ID In ('006356','006357') 
and D_E_L_E_T_ = ''


--SDC - Composicao do Empenho
Select D_E_L_E_T_,* From SDC010
Where DC_ORIGEM = 'ZP4'
--And DC_PRODUTO  In ('1150309401')
And DC_PEDIDO In ('023029','023075')
And D_E_L_E_T_ = ''

--SBF - Saldos por Endereco
Select * From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO In ('1150309401')
and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ ='' and BF_LOCALIZ In ('R00200','R00100')         

Select * From SC6010
Where C6_CLI = '012063'
And C6_PRODUTO = '1150309401'

--RESERVAS PORTAL COBRECOM      
Select * From ZP4010
Where ZP4_CODIGO In ('023010','023011')
--Or  ZP4_STATUS In ('1')
And D_E_L_E_T_ = ''
--And ZP4_CODPRO = '1540504401'
--And ZP4_DATA >= '20240701'
Order By ZP4_STATUS
--ZP4_STATUS - 1=Pendente;2=Atendida;3=Expirada;4=Cancelada   


-- ZP5 Cab. Orçamento 
Select * From ZP5010
Where ZP5_NUM In ('394378')
And D_E_L_E_T_ = ''
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado 

-- ZP6 - Orcamento Itens 
Select ZP6_NUMRES,* From ZP6010 ZP6
	
		Inner Join ZP9010 ZP9
		On ZP6_NUM = ZP9_NUM
		And ZP6_ITEM = ZP9_ITEM
		And ZP9.D_E_L_E_T_ = ''

Where ZP6_NUM In ('394378')
And ZP9_CODPRO  In ('1111504401')
And ZP6.D_E_L_E_T_ =' '

--Orçamento
Select * FRom ZP9010
Where ZP9_NUM In ('394378')
And ZP9_CODPRO In ('1111504401')
And D_E_L_E_T_ =' '





-- Solicitação ao Armazem 
Select * From SCP010


-- Pre requisiçoes 
Select * From SCQ010

Select * FRom SX6010
Where X6_VAR = 'MV_NGSSPRE'

 -- Pesagem -- Status 
Select ZL_STATUS,ZL_COMENTS,
	Case 
	When ZL_STATUS = 'A' Then 'A PROCESSAR'
	When ZL_STATUS = 'E' Then 'ERRO'
	When ZL_STATUS = 'Q' Then 'BLOQUEIO CQ'
	When ZL_STATUS = 'P' Then 'PROCESSADO'
	Else 'ANALISAR'
	End as OBS_,
* From SZL010
Where ZL_NUM In ('430976') 
Or ZL_STATUS  In ('A','E')  
And ZL_DATA >= '20240701'
And ZL_NUM In ('347357','347757','352536','352538','352539')
And D_E_L_E_T_ =' '
Order by 1
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ        

--Testes CT2 Key
Select SubString(CT2_KEY,15,6) As F1_FORNEC,
	   SubString(CT2_KEY,21,2) As  F1_LOJA,
	   SubString(CT2_KEY,23,10) As PRODUTO,
* From CT2010
Where 
--CT2_ROTINA = 'MATA103'
CT2_DATA Between '20240701' and '20240731'
And CT2_SEQUEN = '0030935398'
And D_E_L_E_T_ = ''




-- NF Entrada
Select * From SF1010
Where F1_EMISSAO Between '20240701' and '20240731'
And F1_FILIAL In ('01','02','03')
And F1_FORNECE = 'V0091S' and F1_DOC = '000112066'

-- NF Entrada 
Select F1_INSS,F1_BASEINS,* From SF1010
Where F1_DOC In ('00000270','00000275')
And F1_EMISSAO Between '20240701' and '20240731'
And F1_FORNECE In ('VOP070')
And D_E_L_E_T_ = ''
--Valor INSS - F1_INSS
--Base de INSS - F1_BASEINS


-- NF Entrada Itens 
Select D1_BASEINS,D1_ALIQINS,D1_VALINS,* From SD1010
Where D1_DOC In ('00000270','00000275')
And D1_EMISSAO Between '20240701' and '20240731'
And D1_FORNECE In ('VOP070')
And D_E_L_E_T_ = ''
--Alq. INSS - D1_ALIQINS
--Vlr. do INSS - D1_VALINS
--Base de INSS - D1_BASEINS


--Fornecedores 
Select A2_CGC,A2_RECINSS,* From SA2010
Where A2_COD = 'VOP070'
And D_E_L_E_T_ = ''

--Produtos
Select B1_INSS,B1_REDINSS,* From SB1010
Where B1_COD In ('SV05000054','SV05000148')
And D_E_L_E_T_ = ''
--Calcula INSS (B1_INSS) = SIM
--%Red. INSS (B1_REDINSS) este campo é para Redução da BASE do INSS. Informe o percentual a ser considerado 
--em relação a base de cálculo. Ex: Se for informado 60%, a base de cálculo ficará com 60% de seu valor original.

--Contas a pagar 
Select E2_NATUREZ,E2_BASEINS,E2_INSS,E2_VRETINS,* From SE2010
Where E2_FILIAL = '02'
And E2_NUM In ('00000270','00000275')
And E2_EMISSAO >= '20240701'
And D_E_L_E_T_ = ''
Order BY E2_NUM,E2_FORNECE
--Base INSS - E2_BASEINS
--Valor do INSS - E2_INSS
--Vlr. Ret. INSS - E2_VRETINS

-- Natureas 
Select ED_CALCINS,ED_PERCINS,ED_DEDINSS,* From SED010
Where ED_CODIGO = 'D1107'
And D_E_L_E_T_ = ''
--Calcula INSS (ED_CALCINS)= SIM
--Porc. INSS (ED_PERCINS)= 11% ou alíquota necessária
--Ded.INSS (ED_DEDINSS): Informe "1" (Sim)para que o valor do INSS seja deduzido do valor do título quando 
--houver retenção desta contribuição. Informe "2" (Não) em caso contrário.


-- Livro Fiscal Cab.
Select F3_NFISCAL,F3_CHVNFE,F3_DESCRET,F3_OBSERV,* From SF3010
Where F3_FILIAL = '02' 
and F3_CLIEFOR = 'VOP070'
and F3_NFISCAL In ('00000270','00000275')
and D_E_L_E_T_ =''


-- Livro Fiscal Itens
Select FT_NFISCAL,FT_CHVNFE,FT_OBSERV,FT_ALIQINS,FT_VALINS,FT_BASEINS,* From SFT010
Where FT_FILIAL = '02' 
and FT_CLIEFOR = 'VOP070'
and FT_NFISCAL In ('00000270','00000275')
and D_E_L_E_T_ =''
--Alq. INSS - FT_ALIQINS
--Valor INSS - FT_VALINS
--Base INSS - FT_BASEINS


--TES 
Select F4_ISS,F4_LFISS,* From SF4010
Where F4_CODIGO = '039'
And D_E_L_E_T_ = ''
--Para calcular o ISS, e não tributar:
--Calcula ISS(F4_ISS) = Não
--L.Fiscal.ISS(F4_LFISS) = Outros

--Parametos 
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_ACMINSS')
And D_E_L_E_T_ = ''



SELECT 
    B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,*,
	SUBSTRING(B1_COD, 8, 1) AS CLASSE
FROM 
    SB1010 SB1
WHERE
    B1_FILIAL = ''
    AND B1_COD LIKE '1850%'
    AND B1_ESPECIA = '01'
    AND B1_XPORTAL IN ('S', 'E')
    AND B1_MSBLQL <> '1'
    AND SB1.D_E_L_E_T_ = ''
ORDER BY 
    B1_CLASENC DESC

--Motivos Rejeição 
Select * From SX5010
Where (X5_TABELA = '00' and X5_CHAVE = 'ZS' ) or (X5_TABELA = 'ZS')
AND D_E_L_E_T_ = ''
--And R_E_C_N_O_ Between ('105915') and ('105928')
Order By X5_FILIAL,X5_CHAVE

Select * From SX6010
Where X6_VAR = 'MV_ZZB1F4E'
And D_E_L_E_T_ = ''

Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE In ('AI','MO','MC')
And D_E_L_E_T_ = '' And X5_FILIAL = ''









/*ORDENS de Serviços */
SELECT *
FROM ZZR010
WHERE ZZR_FILIAL = '02'
And ZZR_NROBOB = '2339848'
AND D_E_L_E_T_ = ''
--Alterar Campo Situação para 2 - Montado
--1=Em Montagem;2=Montado;3=Carregado;4=Expedido;9=Cancelado      


/*ORDEM DE CARGA */
SELECT *
FROM ZZ9010
WHERE ZZ9_FILIAL = '02'
AND ZZ9_ORDSEP Like '%11267801%'
And D_E_L_E_T_ = ''


--PV Renegociação
Select C6_XNEGOC,C6_ZZPVORI,C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_QTDLIB,C6_SEMANA,R_E_C_N_O_, * From SC6010
Where C6_FILIAL = '01' and C6_NUM In ('429466')  
and D_E_L_E_T_ =''
And C6_XNEGOC <> '' 
--C6_XNEGOC
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO




-- Negociação
Select ZZV_ID,ZZV_FILIAL,
(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [ZZV_OBSF])),'')) As [ZZV_OBSF],
ZZV_NUMBOB,ZZV_RESP,ZZV_NOMEC,ZZV_OBS01,ZZV_STATUS,ZZV_ACOND,ZZV_LANCES,ZZV_METRAG,ZZV_ACONAL,ZZV_LANCEA,ZZV_METRAL,ZZV_ACEITE,ZZV_PROALT,

	Case 
		When ZZV_STATUS = '1' Then 'Falta Iniciar atendimento'
		When ZZV_STATUS = '2' Then 'Em negociacao'
		When ZZV_STATUS = '3' Then 'Agendamento futuro'
		When ZZV_STATUS = '4' Then 'Falta aprovacao supervisao'
		When ZZV_STATUS = '5' Then 'Falta alterar pedido'
		When ZZV_STATUS = '6' Then 'Rejeitado cobrecom'
		When ZZV_STATUS = '7' Then 'Pedido Alterado'
		When ZZV_STATUS = '' Then 'NAO ESTA EM NEGOCIACAO'
		End as ZZV_STATUS_DESC,

* From ZZV010
Where ZZV_ID In ('006356','006357')
--Or (ZZV_FILPV = '02' and ZZV_PEDIDO = '113074')
and D_E_L_E_T_ = ''
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO



 -- Rasterar Bobinas Empenhadas
--01 - Rasterar Numero de Bobina 
--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,ZE_STATUS,ZE_CONDIC,ZE_SITUACA,ZE_SEQOS,* From SZE010
Where ZE_FILIAL In ('01','02','03') 
and ZE_CTRLE In ('006356','006357','SEQ0000')
--Or ZE_NUMBOB In ('SEQ0001','SEQ0019','SEQ0002','2327907','SEQ0005'))
and D_E_L_E_T_ ='' 
and ZE_STATUS Not in  ('F','C')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa     



--SZL > Controle de Pesagem
Select ZL_STATUS,* From SZL010  With(Nolock)
Where ZL_FILIAL In ('01','02') and ZL_NUMBOB In ('2339848 ') and D_E_L_E_T_ ='' 
--and ZL_PEDIDO = ''
And ZL_STATUS Not In ('C')
Order By ZL_PEDIDO
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ   


-- Contas a pagar
Select E2_NUMBOR,* From SE2010
Where E2_NUM In ('100824')
And E2_VALOR In ('840.25','5221.75')
And D_E_L_E_T_ = ''


--SEA (Borderô), 
Select * From SEA010
Where EA_NUMBOR In ('915700','914354')
--Or EA_NUM In ('100824')
And D_E_L_E_T_ =''


-- NF Saida
Select F2_TIPO,F2_ESPECIE,F2_CHVNFE,* From SF2010
Where F2_DOC In ('000159453','000159454','000159455','000159456','000159457')
And F2_EMISSAO >= '20240801'
And D_E_L_E_T_ =''



-- NF Entrada Itens 
WITH LatestProduct AS (
    SELECT 
        D1_COD,
        D1_VUNIT,
        D1_EMISSAO,
		D1_TP,
        ROW_NUMBER() OVER(PARTITION BY D1_COD ORDER BY D1_EMISSAO DESC) AS RowNum
    FROM 
        SD1010
    WHERE 
        D_E_L_E_T_ = ''
		And D1_TP Not In ('SV','PA')
)
SELECT 
    D1_COD,
    D1_VUNIT,
    D1_EMISSAO,
	D1_TP
FROM 
    LatestProduct
WHERE 
    RowNum = 1
ORDER BY 
    D1_COD;



-- ZZ9 --Ordens de Carga
Select * From ZZ9010
Where ZZ9_DOC = '000159178'
And D_E_L_E_T_ = ''

-- ZZR --LOG DAS ORDENS DE SEPARACAO  
Select * From ZZR010
Where ZZR_PEDIDO = '113074' and ZZR_ITEMPV = '21'
And D_E_L_E_T_ = ''

-- SC6 - PV Itens 
Select C6_XNEGOC,* From SC6010
Where C6_NUM = '113074' and C6_ITEM = '21'
And D_E_L_E_T_ = ''
--C6_XNEGOC
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO




-- SC6 - PV Itens
Select C6_NUM,C6_ITEM,C6_XNEGOC,C6_ZZPVORI,* From SC6010
Where 
((C6_FILIAL = '02' And C6_NUM = '113074' and (C6_ITEM = '23'))
Or (C6_FILIAL = '02' And C6_NUM = '109465' and (C6_ITEM = '09'))
Or (C6_FILIAL = '02' And C6_NUM = '112412' and (C6_ITEM = '03'))
Or (C6_FILIAL = '02' And C6_NUM = '112586' and (C6_ITEM = '05')))
And D_E_L_E_T_ = ''
Order By 1,2


-- SC6 - PV Itens Ind.
Select C6_NUM,C6_ITEM,C6_XNEGOC,C6_ZZPVORI,* From SC6010
Where 
((C6_FILIAL = '01' And C6_NUM = '417220' and (C6_ITEM = '04'))
Or (C6_FILIAL = '01' And C6_NUM = '424708' and (C6_ITEM = '02'))
Or (C6_FILIAL = '01' And C6_NUM = '425308' and (C6_ITEM = '11'))
Or (C6_FILIAL = '01' And C6_NUM = '426319' and (C6_ITEM = '01')))
And D_E_L_E_T_ = ''
Order By 1,2

-- SC9 - PV Itens Liberados Ind.
Select * From SC9010
Where 
((C9_FILIAL = '01' And C9_PEDIDO = '417220' and (C9_ITEM = '04' or C9_ITEMREM = '04'))
Or (C9_FILIAL = '01' and C9_PEDIDO = '424708' and (C9_ITEM = '02' or C9_ITEMREM = '02'))
Or (C9_FILIAL = '01' and C9_PEDIDO = '425308' and (C9_ITEM = '11' or C9_ITEMREM = '11'))
Or (C9_FILIAL = '01' and C9_PEDIDO = '426319' and (C9_ITEM = '01' or C9_ITEMREM = '01')))
And D_E_L_E_T_ = ''
Order By C9_PEDIDO,C9_ITEM

-- SC9 - PV Itens Liberados 
Select * From SC9010
Where 
((C9_FILIAL = '02' And C9_PEDIDO = '113074' and (C9_ITEM = '23' or C9_ITEMREM = '23'))
Or (C9_FILIAL = '02' and C9_PEDIDO = '109465' and (C9_ITEM = '09' or C9_ITEMREM = '09'))
Or (C9_FILIAL = '02' and C9_PEDIDO = '112412' and (C9_ITEM = '03' or C9_ITEMREM = '03'))
Or (C9_FILIAL = '02' and C9_PEDIDO = '112586' and (C9_ITEM = '05' or C9_ITEMREM = '05')))
And D_E_L_E_T_ = ''
Order By C9_PEDIDO,C9_ITEM










-- SD2 -- NF Saida Itens
Select * From SD2010
Where D2_PEDIDO = '113074' and D2_ITEMPV = '21'
And D_E_L_E_T_ = ''

-- Script para analise de itens divergente entre OS e Faturamento de Renegociação 
Select SubString(C6_PRODUTO,1,10) As C6_PRODUTO,SubString(C9_PRODUTO,1,10) As C9_PRODUTO,
--SubString(ZZR_PRODUT,1,10) As ZZR_PRODUTO,SubString(D2_COD,1,10) As ZZR_PRODUTO,
C6_DESCRI,C9_DESCRI,
--ZZR_DESCRI,D2_DESCRI,
C6_QTDVEN,C6_QTDENT,C9_QTDLIB,C9_BLEST,
--ZZR_QUAN,D2_QUANT,C6_XNEGOC,

	Case 
		When C6_PRODUTO <> C9_PRODUTO 
			--or C6_PRODUTO <> ZZR_PRODUT
			--or C6_PRODUTO <> D2_COD
		Then '#######'
		Else 'VVVVVVV'
		End as Status,

* From SC6010 SC6
	
	/*Inner Join ZZR010 ZZR
	On ZZR_FILIAL = C6_FILIAL 
	And ZZR_PEDIDO = C6_NUM
	And ZZR_ITEMPV = C6_ITEM
	And ZZR.D_E_L_E_T_ = '' */

	Inner Join SC9010 SC9
	On C9_FILIAL = C6_FILIAL 
	And C9_PEDIDO = C6_NUM
	And (C9_ITEM = C6_ITEM or  C9_ITEMREM = C6_ITEM)
	And SC9.D_E_L_E_T_ = ''

	/*Inner Join SD2010 SD2
	On D2_FILIAL = C6_FILIAL 
	And D2_PEDIDO = C6_NUM
	And D2_ITEMPV = C6_ITEM
	And SD2.D_E_L_E_T_ = ''*/

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	--And C5_NOTA Not In ('XXXXXX')
	--And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

Where C5_EMISSAO >= '20240101' 
--and C6_NUM  = '113074'
--And C6_ITEM In ('21')
And	(SubString(C6_PRODUTO,1,10) <> SubString(C9_PRODUTO,1,10)) 
			--or SubString(C6_PRODUTO,1,10) <> SubString(ZZR_PRODUT,1,10)
			--or SubString(C6_PRODUTO,1,10) <> SubString(D2_COD,1,10))
And C6_XNEGOC <> ''
And SC6.D_E_L_E_T_ = ''

 --SDC - Composicao do Empenho
Select * From SDC010
Where DC_FILIAL In ('02') 
--And DC_ORIGEM In('SC6') 
And DC_PEDIDO = '113074'
And D_E_L_E_T_ = '' 

--SBF - Saldos por Endereco
Select * From SBF010
Where BF_FILIAL = '02' and BF_PRODUTO In ('1111204401','1141204401','1091604201','1541104401')       
and BF_QUANT > 0 --and BF_EMPENHO > 0
And D_E_L_E_T_ ='' and BF_LOCALIZ In ('R00100','R00028','B00244')         

Select C6_X_NACIM,C6_CLASFIS From SC6010
Where C6_PRODUTO = '2010000000'
And D_E_L_E_T_ =''
--Nac.Import.?             
--Situacao Tributaria      

--Campos 
Select * From SX3010
Where X3_CAMPO In ('C6_X_NACIM','C6_CLASFIS','')
And D_E_L_E_T_ =''


--Fornecedores 
Select A2_ZZITEM,* From SA2010 With(NoLock)
Where D_E_L_E_T_ = ''
And A2_COD Like ('%VOPDI%')

--Item Contábil                 
Select * From CTD010 --With(NoLock)
Where  CTD_ITEM Like ('%FVOPDI%')
And D_E_L_E_T_ = ''








--PV 
Select * From SC5010
Where C5_NUM = '427765'
And D_E_L_E_T_ = ''

-- NF Saida 
Select  * From SF2010
Where F2_CLIENTE = '015257' and F2_LOJA = '02'
And F2_DOC In ('000409342','000409664','000410041','000410253','000410925','000411062')
And D_E_L_E_T_ = ''

-- NF Saida Itens 
Select  Distinct D2_DOC From SD2010
Where D2_CLIENTE = '015257' and D2_LOJA = '02'
And D2_PEDIDO = '427765'
And D_E_L_E_T_ = ''



SELECT  MAX(FK1_SEQ) AS [SEQ]  FROM FK7010 FK7  INNER JOIN FK1010 FK1 ON FK7.FK7_IDDOC = FK1.FK1_IDDOC AND FK7.D_E_L_E_T_ = FK1.D_E_L_E_T_ WHERE FK7.FK7_CHAVE  = '01|1  |000407154|B  |NF |035061|01'  AND FK1.FK1_TPDOC = 'CP' AND FK7.D_E_L_E_T_ = ''


SELECT  * FROM FK7010 FK7  
WHERE FK7.FK7_CHAVE  = '01|1  |000407154|B  |NF |035061|01'   AND FK7.D_E_L_E_T_ = ''

Select * From FK1010
Where FK1_IDDOC = 'F64D93B7CE424F1184A1801844E35029'
And D_E_L_E_T_ = ''

-- Analisar Reserva no Portal 
-- Reservas Portal 
Select * From ZP4010
Where ZP4_FILIAL In ('01') and ZP4_CODIGO In ('022948')
And D_E_L_E_T_ = '' 
----ZP4- Status - 1=Pendente;2=Atendida;3=Expirada;4=Cancelada     

-- Procurar ZP4_CODIGO = DC_PEDIDO 
-- DC_ORIGEM = ZP4
-- Apagar linha na DC - não fazer nada na ZP4
-- Haverá desbalanceamento das tabelas EDCxSBF
-- Rodar Ajustes de Balanceamento de Tabelas SDCxSBF
--SDC - Composicao do Empenho
-- Endereço DC_LOCALIZ = BF_LOCALIZ
Select * From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO In ('1150802401') and DC_QUANT > 0
and D_E_L_E_T_ ='' And  DC_ORIGEM In ('ZP4')
Order By DC_QUANT


--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO In ('1150802401') and BF_QUANT > 0 --and BF_EMPENHO > 0
And D_E_L_E_T_ ='' 
And BF_LOCALIZ In ('M00300')





----CTRL SEPARACAO PROATIVA      
Select ZZE_SITUAC,ZZE_STATUS,* From ZZE010
Where ZZE_FILIAL = '01' and ZZE_PRODUT In ('1141804401')
And ZZE_DTINI >= '20240501'
And ZZE_NUMBOB In ('2319731','2341205')
And D_E_L_E_T_ = ''
--ZZE_SITUAC 1=Encerrado;2=Em Aberto                                                                                                     
--ZZE_STATUS 1=AGUARD. SEPARACAO;2=AGUARD.ORD.SERVICO;3=EM RETRABALHO;4=BAIXADO;5=ENCERRADO;6=EM CQ;7=PARCIAL;8=ENCER CQ;9=CANCELADO        
                            


--CTRL SEPARACAO PROATIVA       
Select * From ZZF010
Where ZZF_FILIAL In ('01','02') and ZZF_PRODUT = '1141804401'
And ZZF_DTINC >= '20240501'
And ZZF_NUMBOB In ('2319731','2341205')
--and ZZF_ZZEID In ('005981','006126','006135','006285','006311')
--or ZZF_ZZEID = '062152'
And D_E_L_E_T_ = ''
--2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat 



--ENTRADAS PARA RETRABALHO      
Select * From ZZU010
Where ZZU_FILIAL In ('01') and ZZU_PRODUT = '1141804401'
And ZZU_DTREC >= '20240501'
--And ZZU_ZZEID In ('006198')
And D_E_L_E_T_ = ''
--ZZU_STATUS
--1=não separado;2=separado     

-- SZE -- Etiquetas de Bobinas
Select ZE_FILIAL,ZE_PEDIDO,ZE_PRODUTO,ZE_ITEM,ZE_DESCPRO,* From SZE010
Where ZE_PRODUTO = '1141804401' and ZE_FILIAL = '01' 
And ZE_NUMBOB In ('2319731','2341205')
And ZE_DATA >= '20240501'
and D_E_L_E_T_ = ''

-- SZL -- Pesagem -- Status 
Select ZL_FILIAL,ZL_PEDIDO,ZL_PRODUTO,ZL_ITEMPV,ZL_DESC,* From SZL010
Where ZL_PRODUTO = '1141804401' and ZL_FILIAL = '01' and 
ZL_DATA >= '20240501' and ZL_METROS >= '1013'
And ZL_NUMBOB In ('2319731','2341205')
and D_E_L_E_T_ = ''
-- ZL_TIPO - P=Producao;D=Prod.+1500Kg;R=Retrabalho;T=Troca Etiqueta;S=Sucata;F=Troca Filial;U=Prod.Unimov
-- ZL_STATUS - A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ   





--Genéricas
-- Motivos de rejeição Credito 
Select * From SX5010
Where (X5_CHAVE = '00' and X5_CHAVE = 'ZS')
Or (X5_TABELA = 'ZS')
And D_E_L_E_T_ = ''
Order By X5_FILIAL,X5_TABELA,X5_CHAVE


--Genéricas
-- Motivos de rejeição Credito 
Select COUNT(X5_CHAVE) From SX5010
Where (X5_TABELA = 'ZS')
And D_E_L_E_T_ = ''
--Order By X5_FILIAL,X5_TABELA,X5_CHAVE
Group By X5_FILIAL




--Pedido de compras
Select C7_FORNECE,C7_QUANT,A2_NOME,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_ENCER,C7_RESIDUO,C7_QTDACLA,C7_NUM,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As Saldo,
* From SC7010 SC7

	Inner Join SA2010 SA2
	On A2_COD = C7_FORNECE
	And A2_LOJA = C7_LOJA 
	And SA2.D_E_L_E_T_ = ''

Where C7_FILIAL = '01' 
and C7_NUM In ('023091','021834') 
And C7_FORNECE = 'V00329'
And C7_PRODUTO In ('ME02000002','ME02000003')
And C7_RESIDUO = ''
And C7_ENCER = ''
and SC7.D_E_L_E_T_ =''




-- Amarracao ProdutoxFornecedor 
Select A5_UMNFE,* From SA5010
Where A5_FORNECE In ('V00329') and (A5_PRODUTO In ('ME02000002') Or A5_CODPRF In (31141))
and D_E_L_E_T_ = ''

-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD In ('ME02000002')  and D_E_L_E_T_ = ''
--35240147978428000177550010004380231904054315

--Fornecedor 
Select A2_CGC,* From SA2010
Where A2_COD In  ('V00329')
and D_E_L_E_T_ = ''
Order By 1

-- Marktplace 
Select * From CPX010
Where CPX_CODIGO  In ('V00329') or CPX_CODFOR In ('V00329')
and D_E_L_E_T_ = ''

--  - NF -        47978428000177   VOP228	01 SALES DISTRIBUIDORA LTDA                
-- Marketplace -  10290557000168   V009ZR   01 SALES EQUIP.E PROD.HIG.PROF.LTDA        

----SDS - Cabecalho importacao XML NF-e
Select DS_CHAVENF,* From SDS010
Where DS_CHAVENF = '35240847799028000102550010000376961698191109'
And D_E_L_E_T_ = ''

--SDT - Itens importacao XML NF-e
Select DT_DOC,* From SDT010
Where DT_FILIAL = '01' and DT_DOC In ('000341411') and D_E_L_E_T_ = ''
And DT_FORNEC In ('000001')

-- Manifesto 
Select C00_STATUS,* From C00010
Where C00_CHVNFE = '35240847799028000102550010000376961698191109'
Order By 1


-- NF Entrada Cb.
Select F1_GF,* From SF1010
Where F1_CHVNFE In ('35240847799028000102550010000376961698191109') 
and D_E_L_E_T_ = ''
Order By F1_EMISSAO

-- NF Entrada Itens
Select D1_PEDIDO,D1_ITEMPC, * From SD1010
Where D1_FORNECE In ('V00329') and D1_DOC = '000037696'
and D_E_L_E_T_ = ''
Order By D1_EMISSAO

-- TES
Select F4_DEVPARC,* From SF4010
Where F4_DEVPARC  = '1'
And D_E_L_E_T_ = ''
Order By F4_CODIGO



--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
NFE_ID,STATUS,STATUSCANC,DOC_CHV,
* From SPED050
Where NFE_ID In ('1  000160401','1  000160402') 
and DATE_NFE >= '20230101' 
and D_E_L_E_T_ = ''

/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
--[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/

Select * From ATA

--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where NFE_ID In ('1  000160401','1  000160402')
and DTREC_SEFR >= '20240701' 
and D_E_L_E_T_ = ''
--or LOTE In ('000000000093238','000000000039330','000000000093245','000000000039377')
Order By NFE_ID

--Lotes de Nota Fiscal Eletrônica
Select 
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_LOTE)),'') AS [XML_LOTE],
* From SPED052
Where LOTE In ('000000000093238','000000000039330','000000000093245','000000000039377')
And DATE_LOTE >= '20240101'
and D_E_L_E_T_ = ''



-- NF Entrada Cab.
Select F1_FILIAL,* From SF1010
Where F1_DOC  In ('000160505','000160113')
And F1_EMISSAO >= '20240101'
And D_E_L_E_T_ =''

-- NF Entrada Itens 
Select D1_FILIAL,D1_DOC,D1_ITEMORI,D1_NFORI,* From SD1010
Where D1_DOC In ('000160505','000160113')
And D1_EMISSAO >= '20240101'
And D_E_L_E_T_ =''


-- NF Entrada Cab. 
Select Distinct F1_DOC,F1_VALBRUT,X5_DESCRI,F1_ESPECIE,F1_TIPO,

	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,
	--N = NF Normal C = Compl. Preco D = Devolucao I = NF Compl. ICMS P = NF Compl. IPI B = NF Beneficiamento
* From SF1010 SF1

	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''
	
Where F1_FILIAL = '02' and F1_DOC In ('000160505') 
And F1_EMISSAO >= '20240101'
and SF1.D_E_L_E_T_ =''


-- NF Saida Cab. 
Select F2_DOC,A2_COD,A2_NOME,A2_CGC,COMP_CLI.M0_CGC,A1_CGC,COMP_FOR.M0_CGC,F2_ESPECIE,X5_DESCRI,F2_TIPO,D2_COD,D2_DESCRI,
	
	Case When COMP_CLI.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

	Case 
	When F2_TIPO = 'N' Then 'NF Normal'
	When F2_TIPO = 'C' Then 'Compl. Preco'
	When F2_TIPO = 'D' Then 'Devolucao'
	When F2_TIPO = 'I' Then ' NF Compl. ICMS'
	When F2_TIPO = 'P' Then 'NF Compl. IPI'
	When F2_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

*From SF2010 SF2

	Left Join SA1010 SA1 -- Clientes 
	On A1_COD = F2_CLIENTE
	And A1_LOJA = F2_LOJA

	Left Join SA2010 SA2 -- Fornecedores 
	On A2_COD = F2_CLIENTE
	And A2_LOJA = F2_LOJA

	Inner Join SX5010 SX5
	On X5_FILIAL = F2_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F2_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI -- Filiais 
	On COMP_CLI.M0_CGC = A2_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD2010 SD2 -- NF Sadia Itens
	On D2_FILIAL = F2_FILIAL
	And D2_CLIENTE = F2_CLIENTE
	And D2_LOJA = F2_LOJA  
	And D2_DOC = F2_DOC
	And SD2.D_E_L_E_T_ = ''

Where F2_FILIAL = '02' and F2_DOC in ('000160401','000160402')
and SF2.D_E_L_E_T_ =''


--Livro Fiscal 
Select F3_OBSERV,F3_DESCRET,F3_CHVNFE,* From SF3010
Where F3_NFISCAL in ('000160401','000160402')
And F3_ENTRADA >= '20240101'
And D_E_L_E_T_ = ''

--Livro Fiscal Itens 
Select FT_OBSERV,FT_CHVNFE,* From SFT010
Where FT_NFISCAL in ('000160401','000160402')
And FT_ENTRADA >= '20240101'
And D_E_L_E_T_ = ''


-- EDI CTE
Select * From GXH010
Where GXH_DANFE In ('35240813445356000180570020000011781000377571')


--Fornecedores 
Select A2_CGC,* From SA2010
Where A2_CGC Like '%13445356000180%'
and D_E_L_E_T_ ='' 

--Transportadora s
Select A4_CGC,* From SA4010
Where A4_CGC Like '%13445356000180%'
and D_E_L_E_T_ ='' 

Select 

-- 02 - Verificar Empenho 
 --SDC - Composicao do Empenho
 -- Verificar Produtos e Qtde e Filial e PV = ZE_CTRLE e Sattus <> ('F','C')
 -- Endereço DC_LOCALIZ = BF_LOCALIZ
Select DC_PEDIDO,DC_ITEM,* From SDC010
Where DC_FILIAL = '01' 
and DC_QUANT > 0
and DC_PRODUTO = '1530504423'
--And DC_PEDIDO In ('023029','023075')
and D_E_L_E_T_ =''  
Order By 1,2


-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD = 'PE4016A'  and D_E_L_E_T_ = ''

-- Produtos Complemento
Select * From SB5010
Where B5_COD = 'MC09000022'  and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD = 'MC09000022'  and D_E_L_E_T_ = ''

-- Orçamentos
Select   * From ZP4010
Where ZP4_CODIGO = '023475'
------ZP4- Status - 1=Pendente;2=Atendida;3=Expirada;4=Cancelada     


--CT2 Lanc. Contabeis 
Select * From CT2010
Where CT2_HIST Like ('%MOV.INTERNA%')
And CT2_DATA Between '20240701' and '20240731'
and D_E_L_E_T_ =''

--CTK Contra Prova CTB
Select * From CTK010
Where CTK_HIST Like ('%MOV.INTERNA%')
And CTK_DATA Between '20240701' and '20240731'
and D_E_L_E_T_ =''


--CV3 Rastreamento Cont.
Select * From CV3010
Where CV3_HIST Like ('%MOV.INTERNA%')
And CV3_DTSEQ Between '20240701' and '20240731'
and D_E_L_E_T_ =''


-- Mov. Internos 
Select * From SD3010
Where --D3_HIST Like ('%MOV.INTERNA%')
D3_EMISSAO Between '20240701' and '20240731'
And D3_TIPO In ('MP','OI')
And D3_CF In ('RE0')
And D3_ESTORNO = ''
And D_E_L_E_T_ =''
--And R_E_C_N_O_ = '26376986' 

-- Genericos - Tipos de Saldos
Select * From SX5010
Where (X5_TABELA = '00' and X5_CHAVE = 'SL') or (X5_TABELA = 'SL')
and D_E_L_E_T_ =''

Select * From SZL010

 -- Pesagem -- Status 
Select ZL_FILIAL,ZL_NUM,ZL_STATUS,--,Count(ZL_STATUS)As STATUS_,
	Case 
	When ZL_STATUS = 'A' Then 'A PROCESSAR'
	When ZL_STATUS = 'E' Then 'ERRO'
	When ZL_STATUS = 'Q' Then 'BLOQUEIO CQ'
	When ZL_STATUS = 'P' Then 'PROCESSADO'
	When ZL_STATUS = 'C' Then 'CANCELADA'
	Else 'ANALISAR'
	End as OBS_,
*
From SZL010
Where ZL_STATUS In ('A','E','C','P')
And ZL_NUM In ('439437','622717')
And ZL_DATA >= '20240802'
And ZL_FILIAL In ('01','02')
And D_E_L_E_T_ =' '
--Group By ZL_FILIAL,ZL_STATUS,ZL_NUM
--Order By 1,2

-- Mov Internos 
Select D3_ZZUNMOV,* From SD3010
Where D3_FILIAL = '01' and D3_COD = '1111104401'
And D3_EMISSAO >= '20240822' and D3_ESTORNO = ''
--And D3_DOC Like ('%574959%')
and D3_ZZUNMOV = '3154068'
--And D3_QUANT= '200'
And D_E_L_E_T_ =' '

-- Estoques 
Select * From SB2010
Where B2_COD = '1111104401'
And B2_FILIAL = '01'
And B2_QATU > 0
And B2_LOCAL = '20'
And D_E_L_E_T_ =' '

-- Estoques 
Select * From SBF010
Where BF_PRODUTO = '1111104401'
And BF_FILIAL = '01'
And BF_QUANT > 0
And BF_LOCAL = '20'
And D_E_L_E_T_ =' '


-- Contas a Receber 
Select E1_FILIAL, E1_CLIENTE, E1_NOMCLI, E1_NUM,E1_TIPO,X5_DESCRI,
E1_VENCTO,E1_BAIXA,E1_SALDO,E1_VALOR,E1_VALLIQ,
*
From SE1010 SE1

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E1_FILIAL
	And X5_CHAVE = E1_TIPO
	And SX5.D_E_L_E_T_ = ''
		
Where E1_FILIAL In ('01','02','03') And E1_NUM In ('000403493')
--And E1_CLIENTE = '011128'
and SE1.D_E_L_E_T_ ='' 
Order By 5

-- SE5 - Mov. Bancaria
Select SE5.D_E_L_E_T_,X5_DESCRI,E5_NUMERO,* From SE5010 SE5

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E5_FILIAL
	And X5_CHAVE = E5_TIPO
	And SX5.D_E_L_E_T_ = ''

Where E5_FILIAL In ('01') and E5_NUMERO In ('000403493' )
--And E5_VALOR In ('10614.1')
And E5_CLIENTE = '006481'
and SE5.D_E_L_E_T_ = ''
Order By SE5.R_E_C_N_O_

--Campos
Select * From SX3010
Where X3_CAMPO In ('C1_CC','C7_CC')

-- Fornecedores 
Select * From SA2010
Where A2_CGC = '13445356000180'
and D_E_L_E_T_ ='' 

-- Transportadora 
Select * From SA4010
Where A4_CGC = '13445356000180'
and D_E_L_E_T_ ='' 

--NF Entrada 
Select * From SF1010
Where F1_CHVNFE = '35240813445356000180570020000011781000377571'
and D_E_L_E_T_ ='' 


-- GU3 - EMITENTES DE TRANSPORTE
Select * From GU3010
Where GU3_CDEMIT = '13445356000180'
and D_E_L_E_T_ ='' 

-- Log Rejeição Credito 
Select * From ZZI010
Where ZZI_FILIAL = '02' and ZZI_PEDIDO = '115137'
and D_E_L_E_T_ ='' 

-- PV itens 
Select C6_BLQ,* From SC6010
Where C6_FILIAL = '02' and C6_NUM = '115137'
and D_E_L_E_T_ ='' 

-- PV itens Lib.
Select * From SC9010
Where C9_FILIAL = '02' and C9_PEDIDO = '115137'
and D_E_L_E_T_ ='' 


-- Contas a pagar 
Select E1_CLIENTE,E1_NUM,E1_BAIXA,E1_VALLIQ,E1_SALDO,E1_BAIXA,E1_STATUS,E1_VALOR,E1_NUMBCO,E1_CLIENTE,* From SE1010
Where E1_NUM  = '000402048' 
--And E1_SITUACA = 'F'
And D_E_L_E_T_ ='' 


-- Mov. Bancaria 
Select E5_NUMERO,E5_HISTOR,E5_TIPODOC,E5_MOTBX,E5_SEQ,E5_ORIGEM,E5_ARQCNAB,E5_PREFIXO,* From SE5010
Where E5_NUMERO = '000402048'
--And E5_DATA >= '20230907'
And D_E_L_E_T_ =''


-- Contabil 
Select CT2_MANUAL,CT2_ROTINA,CT2_LP,CT2_SEQHIS,CT2_VALOR,CT2_HIST,* From CT2010
Where CT2_HIST Like ('%000402048%')
Order By 6

--LP 
Select CT5_VLR01,* From CT5010
Where CT5_LANPAD = '521' and CT5_SEQUEN = '001'
And D_E_L_E_T_ =''


-- PC
Select C7_ZDET,C7_EMISSAO,C7_FILIAL,C7_NUM,C7_ITEM,* From SC7010
Where C7_ZDET Not In ('')
--C7_NUM = '024250'
And D_E_L_E_T_ =''
Order By 2 Desc,3,4,5 Asc

Select C7_NUMCOT,C7_ZDET,
C7_EMISSAO,C7_FILIAL,C7_NUM,C7_ITEM,
C8_NUM,C8_ITEM,
* From SC7010 SC7

	Left Join SC8010 SC8
	On C7_FILIAL = C8_FILIAL
	And C7_NUM = C8_NUMPED
	And C7_ITEM = C8_ITEMPED
	And SC8.D_E_L_E_T_ =''

Where SC7.D_E_L_E_T_ =''
Order By 3 Desc,4,5,6 Asc


--Contas a pagar 
Select E1_ZZBOR1,E1_ZZBC2,E1_SALDO,E1_NUMBOR,* From SE1010
Where E1_SALDO > '0'
And E1_ZZBOR1 <> ''
And E1_ZZBC2 = '000'
AND D_E_L_E_T_=''
order By E1_CLIENTE

-- Parametro 
Select * From SX6010
Where X6_VAR = 'MV_ZZBORD1'
AND D_E_L_E_T_=''


--PV Itens 
Select 
C6_FILIAL,C6_NUM,C6_ITEM,C6_QTDEMP,
SUBSTRING(C6_ZZPVORI,1,6) As PV_IND,
Substring(C6_ZZPVORI,7,2) As PV_IND_ITEM,
Substring(C6_PRODUTO,1,10) As PROD_,
C6_ZZPVORI,	
* From SC6010 SC6
Where C6_FILIAL = '02'And C6_NUM = '112703'
AND D_E_L_E_T_=''

-- PV Itens 
Select 
C6_FILIAL,C6_NUM,C6_ITEM,C6_QTDEMP,
SUBSTRING(C6_ZZPVORI,1,6) As PV_IND,
Substring(C6_ZZPVORI,7,2) As PV_IND_ITEM,
Substring(C6_PRODUTO,1,10) As PROD_,
C6_ZZPVORI,	
* From SC6010 SC6
Where C6_FILIAL = '01'And C6_NUM = '425342'
AND D_E_L_E_T_=''


-- Grupo de ativos 
Select 1,* From SNG010
Where D_E_L_E_T_=''
Order By NG_FILIAL, NG_GRUPO

--CTT
Select  Distinct 
SubString(CTT_CUSTO,1,1) AS LOCAL_SINT,
SubString(CTT_CUSTO,4,3) AS LOCAL_DET,CTT_DESC01  From CTT010
Where Len(CTT_CUSTO) = '6'
AND D_E_L_E_T_=''
And CTT_BLOQ = '2'
And SubString(CTT_CUSTO,1,1) Not In ('4')
Order By 1




-- Bancos 
Select * From SA6010
Where A6_COD = '001'
AND D_E_L_E_T_ = ''


--Comunicacao Remota
Select EE_INSTPRI,EE_INSTSEC,* From SEE010
Where EE_CODIGO = '001'
AND D_E_L_E_T_ = ''

-- SEB - Ocorrencias da Transm Bancaria
Select * From SEB010
Where EB_BANCO = '001'
And EB_TIPO In ('R','D')
AND D_E_L_E_T_ = ''
Order By  EB_REFBAN
--EB_REFBAN	Ocorr Banco	Codigo Ocorrencia Banco
--EB_TIPO	Tipo	Envio ou Retorno --E=Envio;R=Retorno;P=Contas a Pagar;D=DDA
--EB_OCORR	Ocorr Sist.	Codigo Ocorrencia Sistema	
--EB_DESCRI	Descricao	Descricao da Ocorrencia

-- Genericas - Ocorrencias CNAB
Select * From SX5010
Where (X5_TABELA = '00' and X5_CHAVE = '10' and X5_FILIAL = '01')
Or (X5_TABELA = '10'  and X5_FILIAL = '01')
AND D_E_L_E_T_ = ''

-- SEB - Ocorrencias da Transm Bancaria
Select 

EB_OCORR = (Select Top 1 X5_CHAVE From SX5010 SX5 -- Genericas -OCORRENCIAS CNAB                                       
				Where EB_FILIAL = ''
				And X5_TABELA = '10'
				And SubString(X5_CHAVE,1,2) = EB_OCORR
				--And LEN(X5_CHAVE) = 2
				And EB_TIPO In ('R')
				And SX5.D_E_L_E_T_ = ''),

* From SEB010 SEB
				
Where EB_BANCO = '001'
And EB_TIPO In ('R','D')
And EB_REFBAN  = '06'
AND SEB.D_E_L_E_T_ = ''
Order By  1,2




-- Contas a pagar 
Select E1_STATUS,E1_IDCNAB,* From SE1010
Where E1_NUM = '000144051'
AND D_E_L_E_T_ = ''
--E1_STATUS = Status do titulo. A = Aberto B = Baixado R = Reliquidado

-- Bordero 
Select * From SEA010

-- Mov. Bancaria 
Select * From SE5010
Where E5_BANCO = '001' 
--And E5_NUMERO = '000144051'
--and E5_AGENCIA = '3582' 
And E5_LOTE = 'ZZZZ07FW'
--And E5_ARQCNAB = ''
And D_E_L_E_T_ = ''
Order By E5_DATA


--FI0 - Cabec Log Processamento CNAB
Select FI0_LOTE,* From FI0010 FI0

	Left Join FI1010 FI1 -- Detalhe do Log Processamento
	On FI1_FILIAL = FI0_FILIAL 
	And FI1_IDARQ = FI0_IDARQ
	And FI1.D_E_L_E_T_ = ''
	
Where FI0_BCO = '001'
And FI0_LOTE = 'ZZZZ07FW'
--And FI0_IDARQ = '0001609433'
AND FI0.D_E_L_E_T_ = ''




--FI0 - Cabec Log Processamento CNAB
Select FI0_LOTE,* From FI0010 FI0
Where FI0_BCO = '001'
And FI0_LOTE = 'ZZZZ07FW'
--And FI0_IDARQ = '0001609433'
AND FI0.D_E_L_E_T_ = ''


--FI1 - FI1 - Detalhe do Log Processamento
Select * From FI1010
Where FI1_IDARQ = 'A694097871'
And FI1_IDTIT = '0001734158'
AND D_E_L_E_T_ = ''


--Situação Cobrança - FINA022
Select * From FRV010
Where D_E_L_E_T_ = ''

-- Contas a pagar 
Select Distinct E1_SITUACA,Count(E1_SITUACA) From SE1010
Group By E1_SITUACA







--NF Saida Itens 
Select D2_DOC,* From SD2010 With(Nolock)
Where D2_FILIAL = '03'
And D2_DOC = '000007142'
And D_E_L_E_T_ = ''

--NF Saida 
Select F2_DOC,F2_CDROMA,* From SF2010 --With(Nolock)
Where F2_FILIAL = '03'
And F2_CDROMA <= 'F2_CDROMA'
And D_E_L_E_T_ = ''

-- LOG DAS ORDENS DE SEPARACAO   
Select * From ZZR010 With (Nolock)
Where ZZR_PEDIDO = '005373'
And ZZR_FILIAL = '03'
And ZZR_DOC = ''
And D_E_L_E_T_ = ''
Order By ZZR_ITEMPV

-- Comp. Emepenho With (Nolock)
Select * From SDC010 With (Nolock)
Where DC_PEDIDO = '005373'
And DC_FILIAL = '03'
And D_E_L_E_T_ = ''
Order By DC_ITEM

-- PV Itens 
Select C9_ITEMREM,C9_AGREG,R_E_C_N_O_,* From SC9010  With (Nolock)
Where C9_PEDIDO In ('005373')
And C9_FILIAL = '03'
--And C9_SEQOS = '04'
And D_E_L_E_T_ = ''
Order By 3

-- PV Itens 
Select * From SC6010 With(Nolock)
Where C6_NUM In ('005373')
And C6_FILIAL = '03'
And D_E_L_E_T_ = ''



--NF Saida 
Select F2_CDROMA,* From SF2010 With(Nolock)
Where F2_CDROMA <> ''
And F2_FILIAL = '03'
And D_E_L_E_T_ = ''

--Produtos
Select * From SB2010 With(Nolock)
Where B2_COD In ('1150504401','1150706401','1151004401''1100904201','1150703401','SC01000002')
And B2_FILIAL = '01'
And B2_LOCAL = '20'
And D_E_L_E_T_ = ''


 --SBF -> Controla o saldo no acondicionamento
Select * From SBF010
Where BF_FILIAL In ('01') and BF_PRODUTO In ('1150504401','1150706401','1151004401''1100904201','1150703401','SC01000002')
And BF_LOCALIZ = 'PROD_PCF'
and D_E_L_E_T_ =''