
/*Categoria Ativo Fixo

SN1 CADASTRO DE ATIVO IMOBILIZADO

SN2 DESCRICOES ESTENDIDAS

SN3 CADASTRO DE SALDOS E VALORES

SN4 MOVIMENTACOES DO ATIVO FIXO

SN5 ARQUIVOS DE SALDOS

SN6 SALDOS POR CONTA E ITEM

SN7 CADASTRO DE SIMULACAO VENDAS

SN8 CADASTRO DE INVENTARIO

SN9 CADASTRO DE ACOES

SNA SALDOS POR CTA, ITEM E CL VLR*/


/*MANUTEN��O
ST3	BLOQUEIO DE RECURSOS
ST4	SERVI�OS DE MANUTEN��O
ST5	TAREFAS DA MANUTEN��O
ST6	FAM�LIA DE BENS
ST7	FABRICANTE DE BEM
ST8	OCORR�NCIAS
ST9	BEM
STA	PROBLEMAS COM ORDENS SERVI�O
STB	DETALHES DO BEM
STC	ESTRUTURA
STD	AREA DE MANUTEN��O
STE	TIPO DE MANUTEN��O
STF	MANUTEN��O
STG	DETALHES DE MANUTEN��O
STH	ETAPAS DA MANUTEN��O
STI	PLANO DE MANUTEN��O
STJ	ORDENS DE SERVI�O DE MANUT.
STK	BLOQUEIO DE FUNCION�RIO
STL	DETALHES DA ORDEM DE SERVI�O
STM	DEPENDENCIAS DA MANUTEN��O
STN	OCORR�NCIAS RETORNO MANUTEN��O
STO	PLANO DE ACOMPANHAMENTO
STP	ORDENS SERVI�O ACOMPANHAMENTO
STQ	ETAPAS EXECUTADAS
STR	DESGASTE POR PRODU��O
STS	HIST�RICO DE MANUTEN��O
STT	HIST�RICO DE DETALHES DE MANUT
STU	HIST�RICO DE OCORR�NCIAS
STV	HIST�RICO DE PROBLEMAS
STW	HIST�RICO DE ACOMPANHAMENTO
STX	HIST�RICO DE ETAPAS EXECUTADAS
STY	HIST�RICO DE RETORNO PRODU��O
STZ	MOVIMENTA��O DE BENS*/


--Hist�rico de ordens de servi�os
/*Original													C�pia
STA - Problemas com Ordens de Servi�o)				STV - Hist�rico de Problemas
STJ - Ordens de Servi�o								STS - Hist�rico de Manuten��o
STL - Insumos da Ordem de Servi�o					STT - Hist�rico de Detalhes da Manuten��o
STN - Ocorr�ncias Retorno Manuten��o				STU - Hist�rico de Ocorr�ncias
STQ - Etapas Executadas								STX - Hist�rico de Etapas Executadas
TPL - Motivos de Atraso da O.S.						TQ6 - Hist�rico Motivos Atraso O.S 
TPQ - Op��es Respostas das Etapas)					TPX - Hist�rico de Op��es Respostas da O.S*/




--Projeto Ativo Fixo 
--/*Categoria Ativo Fixo
--SN0 - Dados Auxiliares ATF
Select * From SN0010
Where  D_E_L_E_T_ = ''

--SN1 CADASTRO DE ATIVO IMOBILIZADO
Select * From SN1010
Where  N1_CBASE Like ('AI%')
And D_E_L_E_T_ = ''

--SN2 DESCRICOES ESTENDIDAS
Select * From SN2010
Where  D_E_L_E_T_ = ''


--SN3 CADASTRO DE SALDOS E VALORES
Select N3_CCDEPR,N3_CDEPREC,* From SN3010
Where  N3_CBASE Like ('%AI%')
And D_E_L_E_T_ = ''


--SN4 MOVIMENTACOES DO ATIVO FIXO
Select N4_ORIGEM,N4_LP,N4_LA,* From SN4010
Where N4_CBASE Like ('%AI%') --or N4_DATA >= '20240701'
And N4_CBASE Not Like ('%NFE%')
--And N4_OCORR IN ('09','') 
And N4_LP = '833'
And N4_FILIAL = '02'
And D_E_L_E_T_ = '';
--N4_OCORR - Tipo de movimenta��o. 
/*1 Baixa (tamb�m utilizada na rotina de Transfer�ncia de Ativos - ATFA060)
2 Substitui��o
3 Transfer�ncia de
4 Transfer�ncia para
5 Implanta��o
6 Deprecia��o
7 Corre��o
8 Corre��o da deprecia��o
9 Amplia��o
10 Deprecia��o Acelerada
11 Deprecia��o Inc. Negativa
12 Deprecia��o Inc. Positiva
13 Invent�rio
15 Baixa por aquisi��o de transfer�ncia
16 Aquisi��o por transfer�ncia
18 Deprecia��o acumulada da corre��o monet�ria mensal
20 Deprecia��o Gerencial */

--N4_MOTIVO
--Motivo da movimenta��o. 01 - venda; 02 - Extravio; 03 - Roubo; 04 - Doa��o; 05 - Avaria; 06 - Obsol�ncia; 07 - Su- cateamento; 08 - Outros.	
--Motivos Genericas 
Select * From SX5010
Where X5_TABELA = '16'
And D_E_L_E_T_= ''

--SN5 ARQUIVOS DE SALDOS
Select * From SN5010
Where  D_E_L_E_T_ = ''


--SN6 SALDOS POR CONTA E ITEM
Select * From SN6010
Where  D_E_L_E_T_ = ''

--SN7 CADASTRO DE SIMULACAO VENDAS
Select * From SN7010
Where  D_E_L_E_T_ = ''

--SN8 CADASTRO DE INVENTARIO
Select * From SN8010
Where  D_E_L_E_T_ = ''

--SN9 CADASTRO DE ACOES
Select * From SN9010
Where  D_E_L_E_T_ = ''

--SNA SALDOS POR CTA, ITEM E CL VLR*/
Select * From SNA010
Where  D_E_L_E_T_ = ''

Select * From SNL010




--MANUTEN��O
--ST3	BLOQUEIO DE RECURSOS
Select * From ST3010
Where  D_E_L_E_T_ = ''

--ST4	SERVI�OS DE MANUTEN��O
Select * From ST4010
Where  D_E_L_E_T_ = ''

--ST5	TAREFAS DA MANUTEN��O
Select * From ST5010
Where  D_E_L_E_T_ = ''

--ST6	FAM�LIA DE BENS
Select * From ST6010
Where  D_E_L_E_T_ = ''

--ST7	FABRICANTE DE BEM
Select * From ST7010
Where  D_E_L_E_T_ = ''

--ST8	OCORR�NCIAS
Select * From ST8010
Where  D_E_L_E_T_ = ''

--ST9	BEM
Select * From ST9010
Where  D_E_L_E_T_ = ''

--STA	PROBLEMAS COM ORDENS SERVI�O
Select * From STA010
Where  D_E_L_E_T_ = ''

--STB	DETALHES DO BEM
Select * From STB010
Where  D_E_L_E_T_ = ''

--STC	ESTRUTURA
Select * From STC010
Where  D_E_L_E_T_ = ''

--STD	AREA DE MANUTEN��O
Select * From STD010
Where  D_E_L_E_T_ = ''

--STE	TIPO DE MANUTEN��O
Select * From STE010
Where  D_E_L_E_T_ = ''

--STF	MANUTEN��O
Select * From STF010
Where  D_E_L_E_T_ = ''

--STG	DETALHES DE MANUTEN��O
Select * From STG010
Where  D_E_L_E_T_ = ''

--STH	ETAPAS DA MANUTEN��O
Select * From STH010
Where  D_E_L_E_T_ = ''

--STI	PLANO DE MANUTEN��O
Select * From STI010
Where  D_E_L_E_T_ = ''

--STJ	ORDENS DE SERVI�O DE MANUT.
Select * From STJ010
Where  D_E_L_E_T_ = ''

--STK	BLOQUEIO DE FUNCION�RIO
Select * From STK010
Where  D_E_L_E_T_ = ''

--STL	DETALHES DA ORDEM DE SERVI�O
Select * From STL010
Where  D_E_L_E_T_ = ''

--STM	DEPENDENCIAS DA MANUTEN��O
Select * From STM010
Where  D_E_L_E_T_ = ''

--STN	OCORR�NCIAS RETORNO MANUTEN��O
Select * From STN010
Where  D_E_L_E_T_ = ''

--STO	PLANO DE ACOMPANHAMENTO
Select * From STO010
Where  D_E_L_E_T_ = ''

--STP	ORDENS SERVI�O ACOMPANHAMENTO
Select * From STP010
Where  D_E_L_E_T_ = ''

--STQ	ETAPAS EXECUTADAS
Select * From STQ010
Where  D_E_L_E_T_ = ''

--STR	DESGASTE POR PRODU��O
Select * From STR010
Where  D_E_L_E_T_ = ''

--STS	HIST�RICO DE MANUTEN��O
Select * From STS010
Where  D_E_L_E_T_ = ''

--STT	HIST�RICO DE DETALHES DE MANUT
Select * From STT010
Where  D_E_L_E_T_ = ''

--STU	HIST�RICO DE OCORR�NCIAS
Select * From STU010
Where  D_E_L_E_T_ = ''

--STV	HIST�RICO DE PROBLEMAS
Select * From STV010
Where  D_E_L_E_T_ = ''

--STW	HIST�RICO DE ACOMPANHAMENTO
Select * From STW010
Where  D_E_L_E_T_ = ''

--STX	HIST�RICO DE ETAPAS EXECUTADAS
Select * From STX010
Where  D_E_L_E_T_ = ''

--STY	HIST�RICO DE RETORNO PRODU��O
Select * From STY010
Where  D_E_L_E_T_ = ''

--STZ	MOVIMENTA��O DE BENS
Select * From STZ010
Where  D_E_L_E_T_ = ''



--Hist�rico de ordens de servi�os
--Original													
--STA - Problemas com Ordens de Servi�o)	
Select * From STA010
Where  D_E_L_E_T_ = ''

--STJ - Ordens de Servi�o	
Select * From STJ010
Where  D_E_L_E_T_ = ''

--STL - Insumos da Ordem de Servi�o	
Select * From STL010
Where  D_E_L_E_T_ = ''

--STN - Ocorr�ncias Retorno Manuten��o	
Select * From STN010
Where  D_E_L_E_T_ = ''

--STQ - Etapas Executadas
Select * From STQ010
Where  D_E_L_E_T_ = ''

--TPL - Motivos de Atraso da O.S.	
Select * From TPL010
Where  D_E_L_E_T_ = ''

--TPQ - Op��es Respostas das Etapas)	
Select * From TPQ010
Where  D_E_L_E_T_ = ''

--C�pia
--STV - Hist�rico de Problemas
Select * From STV010
Where  D_E_L_E_T_ = ''

--STS - Hist�rico de Manuten��o
Select * From STS010
Where  D_E_L_E_T_ = ''

--STT - Hist�rico de Detalhes da Manuten��o
Select * From STT010
Where  D_E_L_E_T_ = ''

--STU - Hist�rico de Ocorr�ncias
Select * From STU010
Where  D_E_L_E_T_ = ''

--STX - Hist�rico de Etapas Executadas
Select * From STX010
Where  D_E_L_E_T_ = ''

--TQ6 - Hist�rico Motivos Atraso O.S 
Select * From TQ6010
Where  D_E_L_E_T_ = ''

--TPX - Hist�rico de Op��es Respostas da O.S
Select * From TPX010
Where  D_E_L_E_T_ = ''

-- Contabil Lan�amentos 
Select * From CT2010
Where CT2_ROTINA = 'ATFA050'
And D_E_L_E_T_ = ''

-- LPs
Select * From CT5010
Where CT5_LANPAD = '830'
And D_E_L_E_T_= ''




--Outras tabelas
--FN6 � Baixa de Ativos
Select * From SN6010

--FN7 � Baixas de tipos de ativo
Select * From FN7010

--FN8 � Lote de baixa de ativos
Select * From FN8010

--FN9 � Cabe�alho da Transfer�ncia
Select * From FN9010

--FNS � Tipos de Saldo Transferidos
Select * From FNS010


--FNA � Movimentos de Produ��o
Select * From FNA010

--FNB � Projetos de imobilizado
Select * From FNB010

--FNC � Etapas do projeto
Select * From FNC010

--FND � Itens das etapas do projeto
Select * From FND010

--FNE � Config ctb de projetos atf
Select * From FNE010

--FNF � MOVIMENTOS AVP DO ATIVO FIXO
Select * From FNF010

--FNG � Itens do Grupo de Bens *******
Select * From FNG010 

--FNH � Opera. com controle de aprova. *******
Select * From FNH010

--FNI � Indices c�lculo de depreciacao
Select * From FNI010

--FNJ � Item de Etapa X Ativo Execu��o
Select * From FNJ010

--FNK � Al�adas aprovacao por operacao
Select * From FNK010

--FNL � Itens Al�ada Aprov. por operac
Select * From FNL010

--FNM � Movimen. de aprova. por opera.
Select * From FNM010

--FNN � Processo Constitucao Provisao
Select * From FNN010

--FNO � Movtos. Constitui��o Provis�o
Select * From FNO010

--FNP � PROCESSAMENTO APROPRIA��O AVP
Select * From FNP010

--FNQ � Margem Gerencial
Select * FRom FNQ010

--FNR � Ativos Transferidos
Select * From FNR010



--FNT � Taxas de indices depreciacao
Select * From FNT010

--FNU � Controle de Provis�o
Select * From FNU010

--FNV � Item da Provis�o
Select * From FNV010

--FNW � Movimentos de Provis�o
Select * From FNW010

--FNX � Realiza��o da Provis�o
Select * From FNX010

--FNY � Ajuste Valor Justo
Select * From FNY010

--FNZ � Itens de Ajuste Valor Justo
Select * From FNZ010

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_AT60FIL'
And D_E_L_E_T_ = ''

 

-- Multi Natureaza 
-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_MULNATP'
And D_E_L_E_T_ = '';

--Contas a pagar 
Select E2_MULTNAT,* From SE2010
where E2_MULTNAT  = '1'
And D_E_L_E_T_ = '';
--E2_MULTNAT
--1=Sim;2=Nao
--Help de Campo: Indica se o titulo tera seu valor distribuido entre varias naturezas, sem a necessidade de incluir mais de um tituloquando 
--o valor do mesmo for distribuido em varias naturezas.

--SEV - Multiplas Naturezas por Titulo
Select EV_RATEICC ,* From SEV010
Where EV_RATEICC  = '1'
And D_E_L_E_T_ = '';
--EV_RATEICC
--Informa a utilizacao ou nao de distribuicao por centro de custo dos valores da natureza na distribuicao por multiplas naturezas. 
--1 = Sim - Utiliza a distribuicao por centro de custo 2 = Nao - Nao utiliza a distribuicao por centro de custo

-- SED - Natureza Financeira 
Select * From SED010
Where D_E_L_E_T_ = ''


-- Lan�amentos Contab.
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
		
Where CT2_FILIAL = '02'
And CT2_DATA Between '20240101' and '20241231'
And CT2_LP Between '800' and '840'
--And CT2_ROTINA = ('ATFA060')
--and CT2_KEY = '011  000355749   NF'
and CT2.D_E_L_E_T_ =''


-- Lan�amentos Contab.
Select CT2_ROTINA,CT2_LP,CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN
From CT2010 CT2 With(Nolock)
Where CT2_FILIAL = '02'
And CT2_DATA Between '20240101' and '20241231'
And CT2_LP Between '800' and '840'
--And CT2_ROTINA = ('ATFA060')
--and CT2_KEY = '011  000355749   NF'
--and CT2.D_E_L_E_T_ =''