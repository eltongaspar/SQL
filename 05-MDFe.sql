--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
NFE_ID,STATUS,STATUSCANC,DOC_CHV,
* From SPED050
Where NFE_ID In ('1  000160401','1  000160402','500000000254','500000000363') 
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
or LOTE In ('000000000093238','000000000039330','000000000093245','000000000039377')
Order By NFE_ID

--Lotes de Nota Fiscal Eletrônica
Select 
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_LOTE)),'') AS [XML_LOTE],
* From SPED052
Where LOTE In ('000000000093238','000000000039330','000000000093245','000000000039377')
And DATE_LOTE >= '20240101'
and D_E_L_E_T_ = ''




-- NF Entrada Cab.
Select F1_FILIAL,F1_STATUS,F1_PLACA,F1_CHVNFE,F1_TRANSP,F1_VEICUL1,F1_VEICUL2,F1_VEICUL3,F1_SERMDF,F1_NUMMDF,
F1_PESOL,F1_PLIQUI,F1_PBRUTO,F1_CHVNFE,F1_TIPO,
* From SF1010
Where F1_STATUS In ('A','')
And F1_NUMMDF = '000000127'
--And F1_CHVNFE In ('14240429815600000190550010000750121287194564','24240401299396000182550010000038181778756690')
And F1_CHVNFE <>    ''
And F1_EMISSAO >= '20240101'
And D_E_L_E_T_ = ''
Order By 1,10
--F1_PESOL	Peso Liquido	Peso Liquido
--F1_PLIQUI	Peso Liquido	Peso Liquido da N.F.	
--F1_PBRUTO	Peso Bruto	Peso Bruto da N.F.



-- NF Entrada Cab.
Select F1_FILIAL,F1_STATUS,F1_PLACA,F1_CHVNFE,F1_TRANSP,F1_VEICUL1,F1_VEICUL2,F1_VEICUL3,F1_SERMDF,F1_NUMMDF,
F1_PESOL,F1_PLIQUI,F1_PBRUTO,F1_TIPO,
* From SF1010 SF1

	Inner Join SD1010 SD1
	On F1_FILIAL = D1_FILIAL
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And F1_DOC = D1_DOC
	And F1_SERIE = D1_SERIE
	And SD1.D_E_L_E_T_ = ''

Where F1_STATUS In ('A','')
And F1_NUMMDF <> ''
--And F1_CHVNFE = '26240311623188002194550010001714881001714890'
And F1_EMISSAO >= '20240101'
And SF1.D_E_L_E_T_ = ''
Order By 1,10



-- Pre nota
SELECT *
FROM SDT010 SDT WITH(NOLOCK)
INNER JOIN SDS010 SDS WITH(NOLOCK) ON DT_FILIAL = DS_FILIAL
									AND DT_DOC = DS_DOC
									AND DT_SERIE = DS_SERIE
									AND DT_FORNEC = DS_FORNEC
									AND DT_LOJA = DS_LOJA
									AND SDT.D_E_L_E_T_ = SDS.D_E_L_E_T_
WHERE DT_FILIAL In ('01','02','03')
AND SDT.D_E_L_E_T_ = ''
AND DS_CHAVENF In ('35240547718695000105550010000009961426771122','35240504625461000100550010000721481019113908',
'35240561410841000161550040001094421538143186')



--Veiulos 
--UPDATE DA3010 SET DA3_FILIAL  = ''
Select DA3_TPROD,SX5.X5_DESCRI,DA3_TIPVEI,DUT_DESCRI,DA3_MARVEI,SX52.X5_DESCRI,DA3_CORVEI,SX53.X5_DESCRI,DA3_TIPTRA,
DA3_TPROD,SX54.X5_DESCRI,DA3_TPCAR,SX55.X5_DESCRI,
		Case 
		When DA3_TIPTRA = '1' Then 'Rodoviario'
		When DA3_TIPTRA = '2' Then 'Aerio'
		When DA3_TIPTRA = '3' Then 'Fluvial'
		When DA3_TIPTRA = '4' Then 'Especial'
		When DA3_TIPTRA = '5' Then 'Rodoviario Internacional'
		When DA3_TIPTRA = '6' Then 'Multmodal'
	End as CATEGORIA_VEICULO,

* From DA3010 DA3
	
	Left Join SX5010 SX5 -- Tipos de Rodado
	On X5_FILIAL = ''
	And X5_TABELA = 'MU'
	And DA3_TPROD = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''

	Left Join DUT010 DUT -- Tipos Veiculos
	On DUT_FILIAL = ''
	And DA3_TIPVEI = DUT_TIPVEI
	And DUT.D_E_L_E_T_ = ''

	Left Join SX5010 SX52 -- Marca Veiculo
	On SX52.X5_FILIAL = ''
	And SX52.X5_TABELA = 'M6'
	And DUT_TIPCAR = SX52.X5_CHAVE
	And SX52.D_E_L_E_T_ = ''

	Left Join SX5010 SX53 -- Cores de veiculos
	On SX53.X5_FILIAL = ''
	And SX53.X5_TABELA = 'M7'
	And DUT_TIPCAR = SX53.X5_CHAVE
	And SX53.D_E_L_E_T_ = ''

	Left Join SX5010 SX54 -- Tipos de Rodado
	On SX54.X5_FILIAL = ''
	And SX54.X5_TABELA = 'MU'
	And DA3_TPROD = SX54.X5_CHAVE
	And SX54.D_E_L_E_T_ = ''

	Left Join SX5010 SX55 -- Tipos de Rodado
	On SX55.X5_FILIAL = ''
	And SX55.X5_TABELA = 'MV'
	And DA3_TPCAR = SX55.X5_CHAVE
	And SX55.D_E_L_E_T_ = ''
		
Where DA3.D_E_L_E_T_ = ''
Order By DA3_PLACA

--Tipos Veiculos 
Select DUT_TIPROD,SX5.X5_DESCRI,DUT_TIPCAR,SX52.X5_DESCRI,DUT_CATVEI,

	Case 
		When DUT_CATVEI = '1' Then 'Comum'
		When DUT_CATVEI = '2' Then 'Cavalo'
		When DUT_CATVEI = '3' Then 'Carreta'
		When DUT_CATVEI = '4' Then 'Especial'
		When DUT_CATVEI = '5' Then 'Utilitario'
		When DUT_CATVEI = '6' Then 'Composição'
	End as CATEGORIA_VEICULO,



* From DUT010 DUT --Tipos Veiculos 

	Left Join SX5010 SX5 -- Tipos de Rodado
	On X5_FILIAL = ''
	And X5_TABELA = 'MU'
	And DUT_TIPROD = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''

	Left Join SX5010 SX52 -- Tipos de Rodado
	On SX52.X5_FILIAL = ''
	And SX52.X5_TABELA = 'MV'
	And DUT_TIPCAR = SX52.X5_CHAVE
	And SX52.D_E_L_E_T_ = ''

Where DUT.D_E_L_E_T_ = ''
--DUT_CATVEI
--1=Comum;2=Cavalo;3=Carreta;4=Especial;5=Utilitario;6=Composicao
		

--Veiulos 
--UPDATE DA3010 SET DA3_FILIAL  = ''
Select DA3_TPROD,DA3_TIPVEI,* From DA3010 DA3
Where DA3.D_E_L_E_T_ = ''
Order By DA3_PLACA


--Motoritas
Select * From DA4010
--UPDATE DA4010 SET DA4_FILIAL  = ''
Where D_E_L_E_T_ = ''

-- Tipos veiculos 
Select * From DUT010
Where D_E_L_E_T_ = ''
--DUT_CATVEI
--1=Comum;2=Cavalo;3=Carreta;4=Especial;5=Utilitario;6=Composicao

-- Genericas - Tipo Rodado - Tipos de Rodados 
Select * From SX5010
Where ((X5_TABELA = '00' and X5_CHAVE = 'MU')
Or  X5_TABELA = 'MU') And X5_FILIAL = ''
And D_E_L_E_T_ = ''


-- Genericas - Tipo Rodado - Tipo de Carroceria - (e-Ct)                            
Select * From SX5010
Where ((X5_TABELA = '00' and X5_CHAVE = 'MV')
Or  X5_TABELA = 'MV') And X5_FILIAL = ''
And D_E_L_E_T_ = ''

-- Genericas - Marca de veículos                                                   
Select * From SX5010
Where ((X5_TABELA = '00' and X5_CHAVE = 'M6')
Or  X5_TABELA = 'M6') And X5_FILIAL = ''
And D_E_L_E_T_ = ''

-- Genericas - Cores de veículos                                                                                         
Select * From SX5010
Where ((X5_TABELA = '00' and X5_CHAVE = 'M7')
Or  X5_TABELA = 'M7') And X5_FILIAL = ''
And D_E_L_E_T_ = ''


-- Genericas - Tipo Rodado - CADASTRO DE SEGMENTOS DE VEICULOS                
Select * From SX5010
Where ((X5_TABELA = '00' and X5_CHAVE = 'LC')
Or  X5_TABELA = 'LC') And X5_FILIAL = ''
And D_E_L_E_T_ = ''

-- ST6 Familias de Bens
Select * From ST6010
Where D_E_L_E_T_ = ''

-- DC1 - Unitizados Sintetico 
Select * From DC1010

--DAC - Grupo de Veiculos 
Select * From DAC010

--CC0 – Manifesto Documentos Fiscais
Select CC0_VEICUL,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), CC0_XMLMDF)),'') AS [CC0_XMLMDF],
	
	Case 
		When CC0_STATUS = '1' Then 'Transmitido'
		When CC0_STATUS = '2' Then 'Não Transmitido'
		When CC0_STATUS = '3' Then 'Autorizado'
		When CC0_STATUS = '4' Then 'Não Autorizado'
		When CC0_STATUS = '5' Then 'Cancelado'
		When CC0_STATUS = '6' Then 'Encerrado'
	End as CC0_STATUS,


	Case
		When CC0_STATEV = '1' Then 'Evento não Realizado'
		When CC0_STATEV = '2' Then 'Evento Realizado'
		When CC0_STATEV = '3' Then 'Evento Vinculado'
		When CC0_STATEV = '4' Then 'Evento não Vinculado'
	End as CC0_STATEV,

	CC0_MSGRET,CC0_MSGRET,

	Case
		When CC0_TPNF = '1' Then 'NF Entrada'
		When CC0_TPNF = '2' Then 'NF Saida'
		When CC0_TPNF = '3' Then 'Outros'
	End as CC0_TPNF,

* From CC0010
Where CC0_NUMMDF = '000000254'
And D_E_L_E_T_ = ''
And CC0_DTEMIS >= '20240501'
Order by CC0_FILIAL,CC0_NUMMDF

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



-- NF Saida Cab.
Select F2_CHVNFE,F2_TRANSP,F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,F2_SERMDF,F2_NUMMDF,*
From SF2010 SF2
Where F2_DOC In ('000157037','000157038','000157039','000157040')
And F2_FILIAL = '02'
---And F2_EMISSAO >= '20240901'
--And F2_TRANSP = ''
And D_E_L_E_T_ = ''
Order By 1


-- NF Saida Cab.
Select F2_CHVNFE,F2_TRANSP,F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,F2_SERMDF,F2_NUMMDF,F2_DTENTR,*
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

Select D1_CF,* From SD1010
Where D1_CF <> ''


-- NF Saida - Data Entrega - Portaria Baixa NF - Saida de NFs
-- cbcPortMain
-- Prenchido Campo F2_DTENTR
Select F2_DTENTR,F2_SERMDF,F2_NUMMDF,F2_TRANSP,F2_VEICUL1,F2_VEICUL2,F2_VEICUL3,* From SF2010
Where F2_FILIAL In ('01','02','03')
And F2_DOC In ('000154126','000006639')
And F2_EMISSAO > '20240101'
And D_E_L_E_T_ = ''



-- MDFe x NF Entrada / Saida
SELECT		
		CC0.CC0_FILIAL			 AS [FILIAL],  
		CC0.CC0_SERMDF           AS [SERMDF],
		CC0.CC0_NUMMDF           AS [NUMMDF], 
		ISNULL(SF1.F1_DOC,'')    AS [NF_F1], 
		ISNULL(SF1.F1_SERIE,'')  AS [SERIE_F1], 
		ISNULL(SF1.F1_CHVNFE,'') AS [CHVNFE_F1],	
		ISNULL(SF2.F2_DOC,'')    AS [NF_F2], 
		ISNULL(SF2.F2_SERIE,'')  AS [SERIE_F2],		
		ISNULL(SF2.F2_CHVNFE,'') AS [CHVNFE_F2],

		Case 
			When CC0_STATUS = '1' Then 'Transmitido'
			When CC0_STATUS = '2' Then 'Não Transmitido'
			When CC0_STATUS = '3' Then 'Autorizado'
			When CC0_STATUS = '4' Then 'Não Autorizado'
			When CC0_STATUS = '5' Then 'Cancelado'
			When CC0_STATUS = '6' Then 'Encerrado'
		End as CC0_STATUS,


		Case
			When CC0_STATEV = '1' Then 'Evento não Realizado'
			When CC0_STATEV = '2' Then 'Evento Realizado'
			When CC0_STATEV = '3' Then 'Evento Vinculado'
			When CC0_STATEV = '4' Then 'Evento não Vinculado'
		End as CC0_STATEV,

		Case
			When CC0_TPNF = '1' Then 'NF Entrada'
			When CC0_TPNF = '2' Then 'NF Saida'
			When CC0_TPNF = '3' Then 'Outros'
		End as CC0_TPNF,

		CC0_MSGRET,CC0_MSGRET,* 


FROM CC0010 CC0
		LEFT JOIN SF1010 SF1
		ON (CC0.CC0_FILIAL = SF1.F1_FILIAL
		Or	CC0.CC0_VEICUL = F1_VEICUL1)
		AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
		AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
		AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_

		LEFT JOIN SF2010 SF2
		ON  CC0.CC0_FILIAL = SF2.F2_FILIAL
		AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
		AND CC0.CC0_SERMDF = SF2.F2_SERMDF
		AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_

WHERE CC0.CC0_FILIAL In ('01','02','03')
--AND (SF2.F2_CHVNFE = '' OR SF1.F1_CHVNFE = '')
And CC0_NUMMDF = '000000069'
And CC0_DTEMIS >= '20240501'
AND CC0.D_E_L_E_T_ = ''
Order By 3


-- MDFe x NF Saida 
SELECT		
		CC0.CC0_FILIAL			 AS [FILIAL],  
		CC0.CC0_SERMDF           AS [SERMDF],
		CC0.CC0_NUMMDF           AS [NUMMDF], 
		ISNULL(SF2.F2_DOC,'')    AS [NF_F2], 
		ISNULL(SF2.F2_SERIE,'')  AS [SERIE_F2],		
		ISNULL(SF2.F2_CHVNFE,'') AS [CHVNFE_F2],

		Case 
			When CC0_STATUS = '1' Then 'Transmitido'
			When CC0_STATUS = '2' Then 'Não Transmitido'
			When CC0_STATUS = '3' Then 'Autorizado'
			When CC0_STATUS = '4' Then 'Não Autorizado'
			When CC0_STATUS = '5' Then 'Cancelado'
			When CC0_STATUS = '6' Then 'Encerrado'
		End as CC0_STATUS,


		Case
			When CC0_STATEV = '1' Then 'Evento não Realizado'
			When CC0_STATEV = '2' Then 'Evento Realizado'
			When CC0_STATEV = '3' Then 'Evento Vinculado'
			When CC0_STATEV = '4' Then 'Evento não Vinculado'
		End as CC0_STATEV,

		Case
			When CC0_TPNF = '1' Then 'NF Entrada'
			When CC0_TPNF = '2' Then 'NF Saida'
			When CC0_TPNF = '3' Then 'Outros'
		End as CC0_TPNF,

		CC0_MSGRET,CC0_MSGRET,* 


FROM CC0010 CC0

		LEFT JOIN SF2010 SF2
		ON  CC0.CC0_FILIAL = SF2.F2_FILIAL
		AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
		AND CC0.CC0_SERMDF = SF2.F2_SERMDF
		AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_

WHERE CC0.CC0_FILIAL In ('01','02','03')
--AND (SF2.F2_CHVNFE = '' OR SF1.F1_CHVNFE = '')
And CC0_NUMMDF = '000000069'
And CC0_DTEMIS >= '20240501'
AND CC0.D_E_L_E_T_ = ''
Order By 3


-- MDFe x NF Entrad
SELECT		
		CC0.CC0_FILIAL			 AS [FILIAL],  
		CC0.CC0_SERMDF           AS [SERMDF],
		CC0.CC0_NUMMDF           AS [NUMMDF], 
		ISNULL(SF1.F1_DOC,'')    AS [NF_F1], 
		ISNULL(SF1.F1_SERIE,'')  AS [SERIE_F1], 
		ISNULL(SF1.F1_CHVNFE,'') AS [CHVNFE_F1],	

		Case 
			When CC0_STATUS = '1' Then 'Transmitido'
			When CC0_STATUS = '2' Then 'Não Transmitido'
			When CC0_STATUS = '3' Then 'Autorizado'
			When CC0_STATUS = '4' Then 'Não Autorizado'
			When CC0_STATUS = '5' Then 'Cancelado'
			When CC0_STATUS = '6' Then 'Encerrado'
		End as CC0_STATUS,


		Case
			When CC0_STATEV = '1' Then 'Evento não Realizado'
			When CC0_STATEV = '2' Then 'Evento Realizado'
			When CC0_STATEV = '3' Then 'Evento Vinculado'
			When CC0_STATEV = '4' Then 'Evento não Vinculado'
		End as CC0_STATEV,

		Case
			When CC0_TPNF = '1' Then 'NF Entrada'
			When CC0_TPNF = '2' Then 'NF Saida'
			When CC0_TPNF = '3' Then 'Outros'
		End as CC0_TPNF,

		CC0_MSGRET,CC0_MSGRET,* 


FROM CC0010 CC0
		LEFT JOIN SF1010 SF1
		ON (CC0.CC0_FILIAL = SF1.F1_FILIAL
		Or	CC0.CC0_VEICUL = F1_VEICUL1)
		AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
		AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
		AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_

WHERE CC0.CC0_FILIAL In ('01','02','03')
--AND (SF2.F2_CHVNFE = '' OR SF1.F1_CHVNFE = '')
And CC0_NUMMDF = '000000069'
And CC0_DTEMIS >= '20240501'
AND CC0.D_E_L_E_T_ = ''
Order By 3




-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_BLOQ103'
And D_E_L_E_T_ = ''

-- Veiculos 
Select * From DA3010
Where D_E_L_E_T_ = ''

-- Criar Chave na Tabela 01 com Chave 500 (Série)

-- Genéricas
Select X5_CHAVE,* From SX5010
Where X5_TABELA = '01' and X5_CHAVE = '500'
And D_E_L_E_T_ = ''



-- Cria Parâmetro personalizado 
-- Parâmetros 
Select * From SX6010
Where X6_VAR =  ('ZZ_SERIMDF')



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
	
Where F1_CHVNFE In ('50240502544042000208550010001532751487206884','50240502544042000208550010001532761478102661',
'50240502544042000208550010001532771249607835')
--And F1_FILIAL = '01'
-- 35240547718695000105550010000009961426771122
--35240504625461000100550010000721481019113908
--35240561410841000161550040001094421538143186
and SF1.D_E_L_E_T_ =''





SELECT CC0.CC0_FILIAL    AS [FILIAL_CC0],
	CC0.CC0_SERMDF           AS [SERMDF], 	 
	CC0.CC0_NUMMDF           AS [NUMMDF], 	 
	ISNULL(SF1.F1_FILIAL,'') AS [FILIAL_F1], 
	ISNULL(SF1.F1_DOC,'')    AS [NF_F1],  	 
	ISNULL(SF1.F1_SERIE,'')  AS [SERIE_F1], 
	ISNULL(SF1.F1_CHVNFE,'') AS [CHVNFE_F1], 
	ISNULL(SF2.F2_FILIAL,'') AS [FILIAL_F2], 
	ISNULL(SF2.F2_DOC,'')    AS [NF_F2], 
	ISNULL(SF2.F2_SERIE,'')  AS [SERIE_F2], 
	ISNULL(SF2.F2_CHVNFE,'') AS [CHVNFE_F2] 
	FROM CC0010 CC0 
	LEFT JOIN SF1010 SF1 
	ON  CC0.CC0_NUMMDF = SF1.F1_NUMMDF 
	AND CC0.CC0_SERMDF = SF1.F1_SERMDF 
	AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
	--AND SF1.F1_CHVNFE = '35240547718695000105550010000009961426771122' 
	LEFT JOIN SF2010 SF2 
	ON  CC0.CC0_NUMMDF = SF2.F2_NUMMDF 
	AND CC0.CC0_SERMDF = SF2.F2_SERMDF      
	AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_  
	--AND SF2.F2_CHVNFE = '35240547718695000105550010000009961426771122'  
	WHERE CC0.CC0_FILIAL IN ('01','02','03')
	AND ((SF2.F2_NUMMDF <> '' AND SF2.F2_SERMDF <> '') 
	OR (SF1.F1_NUMMDF <> '' AND SF1.F1_SERMDF <> ''))
	And CC0_NUMMDF = '000000042'
	AND CC0.D_E_L_E_T_ = ''


	-- Nota Fiscal Eletrônica
SELECT 
    STATUS,
    STATUSCANC,
    STATUSMAIL,
    DOC_CHV,
    LOTE,
    CHARINDEX('<placa>', (ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), ''))) AS [PLACA_COL],
    -- Correção do uso do SUBSTRING
    SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), ''), CHARINDEX('<infDoc>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [XML_ERP])), '')) + LEN('<infDoc>'), 7) AS [EXTRAIDA_PLACA],
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
	SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<seg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<seg>'), 3) AS [SEG],
	SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<infResp>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<infResp>'), 3) AS [SEG_RESP_INFO],
	SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<respSeg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<respSeg>'), 3) AS [SEG_RESP],
* From CC0010
Where 
	D_E_L_E_T_ = '';




	-- C00 - Manifesto de Cargas 
SELECT 
    ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '') AS [CC0_XMLMDF],
    CASE 
        WHEN CHARINDEX('<seg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<seg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<seg>'), 3)
        ELSE 'N/A'
    END AS [SEG],
    CASE 
        WHEN CHARINDEX('<infResp>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<infResp>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<infResp>'), 3)
        ELSE 'N/A'
    END AS [SEG_RESP_INFO],
    CASE 
        WHEN CHARINDEX('<respSeg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN SUBSTRING(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), CHARINDEX('<respSeg>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<respSeg>'), 3)
        ELSE 'N/A'
    END AS [SEG_RESP],
    *
FROM CC0010
WHERE D_E_L_E_T_ = '';







-- C00 - Manifesto de Cargas 
SELECT 
    ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '') AS [CC0_XMLMDF],
    CASE 
        WHEN CHARINDEX('<RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN 
            SUBSTRING(
                ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), 
                CHARINDEX('<RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<RENAVAM>'), 
                CHARINDEX('</RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) - 
                (CHARINDEX('<RENAVAM>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<RENAVAM>'))
            )
        ELSE 'N/A'
    END AS [RENAVAM],
    CASE 
        WHEN CHARINDEX('<placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN 
            SUBSTRING(
                ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), 
                CHARINDEX('<placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<placa>'), 
                CHARINDEX('</placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) - 
                (CHARINDEX('<placa>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<placa>'))
            )
        ELSE 'N/A'
    END AS [PLACA],
    CASE 
        WHEN CHARINDEX('<cMDF>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) > 0 
        THEN 
            SUBSTRING(
                ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), ''), 
                CHARINDEX('<cMDF>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<cMDF>'), 
                CHARINDEX('</cMDF>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) - 
                (CHARINDEX('<cMDF>', ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [CC0_XMLMDF])), '')) + LEN('<cMDF>'))
            )
        ELSE 'N/A'
    END AS [cMDF],


    *
FROM CC0010
WHERE D_E_L_E_T_ = '';



WITH XMLData AS (
    SELECT 
        CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), [CC0_XMLMDF])) AS XMLContent,
        D_E_L_E_T_
    FROM CC0010
    WHERE D_E_L_E_T_ = ''
),
SegTagData AS (
    SELECT
        XMLContent,
        CHARINDEX('<seg>', XMLContent) AS StartTag,
        CHARINDEX('</seg>', XMLContent) AS EndTag
    FROM XMLData
    WHERE CHARINDEX('<seg>', XMLContent) > 0
    UNION ALL
    SELECT
        XMLContent,
        CHARINDEX('<seg>', XMLContent, EndTag + LEN('</seg>')) AS StartTag,
        CHARINDEX('</seg>', XMLContent, EndTag + LEN('</seg>')) AS EndTag
    FROM SegTagData
    WHERE CHARINDEX('<seg>', XMLContent, EndTag + LEN('</seg>')) > 0
),
ParsedSegData AS (
    SELECT
        XMLContent,
        SUBSTRING(XMLContent, StartTag, EndTag - StartTag + LEN('</seg>')) AS SegContent
    FROM SegTagData
    WHERE StartTag > 0 AND EndTag > StartTag
),
ExtractedCNPJData AS (
    SELECT
        CASE 
            WHEN CHARINDEX('<respSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS respSeg_CNPJ,
        CASE 
            WHEN CHARINDEX('<infSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS infSeg_CNPJ,
        CASE 
            WHEN CHARINDEX('<nApol>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nApol>', SegContent) + LEN('<nApol>'), 
                    CHARINDEX('</nApol>', SegContent) - CHARINDEX('<nApol>', SegContent) - LEN('<nApol>')
                )
            ELSE 'N/A'
        END AS nApol,
        CASE 
            WHEN CHARINDEX('<nAver>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nAver>', SegContent) + LEN('<nAver>'), 
                    CHARINDEX('</nAver>', SegContent) - CHARINDEX('<nAver>', SegContent) - LEN('<nAver>')
                )
            ELSE 'N/A'
        END AS nAver
    FROM ParsedSegData
)
SELECT respSeg_CNPJ, infSeg_CNPJ, nApol, nAver
FROM ExtractedCNPJData;


-- Select SPED-MDFE
SELECT 
	SF2.F2_FILIAL FILIAL,SF2.F2_SERIE SERIE, SF2.F2_DOC DOC, SF2.F2_EMISSAO EMISSAO, SF2.F2_CHVNFE CHVNFE, SF2.F2_ESPECIE ESPECIE, SF2.F2_CARGA CARGA,  
	SF2.F2_VALBRUT VALBRUT, SF2.F2_PBRUTO PBRUTO, SF2.F2_CLIENTE CLIFOR, SF2.F2_LOJA LOJA, SF2.F2_TIPO TIPO,  SF2.F2_SERMDF SERMDF, SF2.F2_NUMMDF NUMMDF, 
	SF2.F2_VEICUL1 VEICUL1, SF2.F2_VEICUL2 VEICUL2, SF2.F2_VEICUL3 VEICUL3,'S' AS TP_NF, SF2.R_E_C_N_O_ RECNF 
FROM SF2010 SF2	

WHERE 
	SF2.F2_ESPECIE = 'SPED' AND SF2.F2_CHVNFE <> ' ' AND SF2.F2_FIMP <> 'D' AND SF2.D_E_L_E_T_ = ' ' AND SF2.F2_EMISSAO >= '20230101' AND SF2.F2_EMISSAO <= '20241231' 
	AND (SF2.F2_VEICUL1 = 'DBM1792 ' OR SF2.F2_VEICUL2 = 'DBM1792 ' OR SF2.F2_VEICUL3 = 'DBM1792 ') AND SF2.F2_SERMDF = ' ' AND SF2.F2_NUMMDF = ' '  
	
	UNION ALL 
SELECT 
	SF1.F1_FILIAL FILIAL,SF1.F1_SERIE SERIE, SF1.F1_DOC DOC, SF1.F1_EMISSAO EMISSAO, SF1.F1_CHVNFE CHVNFE, SF1.F1_ESPECIE ESPECIE,'F1_CARGA' AS CARGA, 
	
	CASE 
		WHEN SF1.F1_VALBRUT > 0 
		THEN SF1.F1_VALBRUT ELSE SUM(SD1.D1_TOTAL) 
		END AS VALBRUT, SF1.F1_PBRUTO PBRUTO, 
		
	SF1.F1_FORNECE CLIFOR, SF1.F1_LOJA LOJA, SF1.F1_TIPO TIPO,  SF1.F1_SERMDF SERMDF, SF1.F1_NUMMDF NUMMDF, SF1.F1_VEICUL1 VEICUL1, SF1.F1_VEICUL2 VEICUL2, 
	SF1.F1_VEICUL3 VEICUL3,'E' AS TP_NF, SF1.R_E_C_N_O_ RECNF 
	FROM SF1010 SF1 
	INNER JOIN 
		SD1010 SD1 
		ON SF1.F1_FILIAL = SD1.D1_FILIAL 
		AND SF1.F1_DOC = SD1.D1_DOC 
		AND SF1.F1_SERIE	= SD1.D1_SERIE 
		AND SF1.F1_FORNECE = SD1.D1_FORNECE 
		AND SF1.F1_LOJA = SD1.D1_LOJA 
		AND SF1.D_E_L_E_T_	= SD1.D_E_L_E_T_ 
	
	WHERE
		SF1.F1_ESPECIE = 'SPED' AND SF1.D_E_L_E_T_ = ' ' AND SF1.F1_CHVNFE <> ' ' AND SF1.F1_EMISSAO >= '20230101' AND SF1.F1_EMISSAO <= '20241231' 
		AND (SF1.F1_VEICUL1 = 'DBM1792 ' OR SF1.F1_VEICUL2 = 'DBM1792 ' OR SF1.F1_VEICUL3 = 'DBM1792 ') AND SF1.F1_SERMDF = ' ' AND SF1.F1_NUMMDF = ' '  
		GROUP BY SF1.F1_FILIAL,  SF1.F1_SERIE,  SF1.F1_DOC,  SF1.F1_EMISSAO,  SF1.F1_CHVNFE,  SF1.F1_ESPECIE, SF1.F1_VALBRUT,  SF1.F1_PBRUTO,  SF1.F1_FORNECE,  
		SF1.F1_LOJA,  SF1.F1_TIPO,   SF1.F1_SERMDF,  SF1.F1_NUMMDF,  SF1.F1_VEICUL1,  SF1.F1_VEICUL2,  SF1.F1_VEICUL3, SF1.R_E_C_N_O_ 
