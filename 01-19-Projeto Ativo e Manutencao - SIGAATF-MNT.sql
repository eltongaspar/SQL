
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


/*MANUTENÇÃO
ST3	BLOQUEIO DE RECURSOS
ST4	SERVIÇOS DE MANUTENÇÃO
ST5	TAREFAS DA MANUTENÇÃO
ST6	FAMÍLIA DE BENS
ST7	FABRICANTE DE BEM
ST8	OCORRÊNCIAS
ST9	BEM
STA	PROBLEMAS COM ORDENS SERVIÇO
STB	DETALHES DO BEM
STC	ESTRUTURA
STD	AREA DE MANUTENÇÃO
STE	TIPO DE MANUTENÇÃO
STF	MANUTENÇÃO
STG	DETALHES DE MANUTENÇÃO
STH	ETAPAS DA MANUTENÇÃO
STI	PLANO DE MANUTENÇÃO
STJ	ORDENS DE SERVIÇO DE MANUT.
STK	BLOQUEIO DE FUNCIONÁRIO
STL	DETALHES DA ORDEM DE SERVIÇO
STM	DEPENDENCIAS DA MANUTENÇÃO
STN	OCORRÊNCIAS RETORNO MANUTENÇÃO
STO	PLANO DE ACOMPANHAMENTO
STP	ORDENS SERVIÇO ACOMPANHAMENTO
STQ	ETAPAS EXECUTADAS
STR	DESGASTE POR PRODUÇÃO
STS	HISTÓRICO DE MANUTENÇÃO
STT	HISTÓRICO DE DETALHES DE MANUT
STU	HISTÓRICO DE OCORRÊNCIAS
STV	HISTÓRICO DE PROBLEMAS
STW	HISTÓRICO DE ACOMPANHAMENTO
STX	HISTÓRICO DE ETAPAS EXECUTADAS
STY	HISTÓRICO DE RETORNO PRODUÇÃO
STZ	MOVIMENTAÇÃO DE BENS*/


--Histórico de ordens de serviços
/*Original													Cópia
STA - Problemas com Ordens de Serviço)				STV - Histórico de Problemas
STJ - Ordens de Serviço								STS - Histórico de Manutenção
STL - Insumos da Ordem de Serviço					STT - Histórico de Detalhes da Manutenção
STN - Ocorrências Retorno Manutenção				STU - Histórico de Ocorrências
STQ - Etapas Executadas								STX - Histórico de Etapas Executadas
TPL - Motivos de Atraso da O.S.						TQ6 - Histórico Motivos Atraso O.S 
TPQ - Opções Respostas das Etapas)					TPX - Histórico de Opções Respostas da O.S*/




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
--N4_OCORR - Tipo de movimentação. 
/*1 Baixa (também utilizada na rotina de Transferência de Ativos - ATFA060)
2 Substituição
3 Transferência de
4 Transferência para
5 Implantação
6 Depreciação
7 Correção
8 Correção da depreciação
9 Ampliação
10 Depreciação Acelerada
11 Depreciação Inc. Negativa
12 Depreciação Inc. Positiva
13 Inventário
15 Baixa por aquisição de transferência
16 Aquisição por transferência
18 Depreciação acumulada da correção monetária mensal
20 Depreciação Gerencial */

--N4_MOTIVO
--Motivo da movimentação. 01 - venda; 02 - Extravio; 03 - Roubo; 04 - Doação; 05 - Avaria; 06 - Obsolência; 07 - Su- cateamento; 08 - Outros.	
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




--MANUTENÇÃO
--ST3	BLOQUEIO DE RECURSOS
Select * From ST3010
Where  D_E_L_E_T_ = ''

--ST4	SERVIÇOS DE MANUTENÇÃO
Select * From ST4010
Where  D_E_L_E_T_ = ''

--ST5	TAREFAS DA MANUTENÇÃO
Select * From ST5010
Where  D_E_L_E_T_ = ''

--ST6	FAMÍLIA DE BENS
Select * From ST6010
Where  D_E_L_E_T_ = ''

--ST7	FABRICANTE DE BEM
Select * From ST7010
Where  D_E_L_E_T_ = ''

--ST8	OCORRÊNCIAS
Select * From ST8010
Where  D_E_L_E_T_ = ''

--ST9	BEM
Select * From ST9010
Where  D_E_L_E_T_ = ''

--STA	PROBLEMAS COM ORDENS SERVIÇO
Select * From STA010
Where  D_E_L_E_T_ = ''

--STB	DETALHES DO BEM
Select * From STB010
Where  D_E_L_E_T_ = ''

--STC	ESTRUTURA
Select * From STC010
Where  D_E_L_E_T_ = ''

--STD	AREA DE MANUTENÇÃO
Select * From STD010
Where  D_E_L_E_T_ = ''

--STE	TIPO DE MANUTENÇÃO
Select * From STE010
Where  D_E_L_E_T_ = ''

--STF	MANUTENÇÃO
Select * From STF010
Where  D_E_L_E_T_ = ''

--STG	DETALHES DE MANUTENÇÃO
Select * From STG010
Where  D_E_L_E_T_ = ''

--STH	ETAPAS DA MANUTENÇÃO
Select * From STH010
Where  D_E_L_E_T_ = ''

--STI	PLANO DE MANUTENÇÃO
Select * From STI010
Where  D_E_L_E_T_ = ''

--STJ	ORDENS DE SERVIÇO DE MANUT.
Select * From STJ010
Where  D_E_L_E_T_ = ''

--STK	BLOQUEIO DE FUNCIONÁRIO
Select * From STK010
Where  D_E_L_E_T_ = ''

--STL	DETALHES DA ORDEM DE SERVIÇO
Select * From STL010
Where  D_E_L_E_T_ = ''

--STM	DEPENDENCIAS DA MANUTENÇÃO
Select * From STM010
Where  D_E_L_E_T_ = ''

--STN	OCORRÊNCIAS RETORNO MANUTENÇÃO
Select * From STN010
Where  D_E_L_E_T_ = ''

--STO	PLANO DE ACOMPANHAMENTO
Select * From STO010
Where  D_E_L_E_T_ = ''

--STP	ORDENS SERVIÇO ACOMPANHAMENTO
Select * From STP010
Where  D_E_L_E_T_ = ''

--STQ	ETAPAS EXECUTADAS
Select * From STQ010
Where  D_E_L_E_T_ = ''

--STR	DESGASTE POR PRODUÇÃO
Select * From STR010
Where  D_E_L_E_T_ = ''

--STS	HISTÓRICO DE MANUTENÇÃO
Select * From STS010
Where  D_E_L_E_T_ = ''

--STT	HISTÓRICO DE DETALHES DE MANUT
Select * From STT010
Where  D_E_L_E_T_ = ''

--STU	HISTÓRICO DE OCORRÊNCIAS
Select * From STU010
Where  D_E_L_E_T_ = ''

--STV	HISTÓRICO DE PROBLEMAS
Select * From STV010
Where  D_E_L_E_T_ = ''

--STW	HISTÓRICO DE ACOMPANHAMENTO
Select * From STW010
Where  D_E_L_E_T_ = ''

--STX	HISTÓRICO DE ETAPAS EXECUTADAS
Select * From STX010
Where  D_E_L_E_T_ = ''

--STY	HISTÓRICO DE RETORNO PRODUÇÃO
Select * From STY010
Where  D_E_L_E_T_ = ''

--STZ	MOVIMENTAÇÃO DE BENS
Select * From STZ010
Where  D_E_L_E_T_ = ''



--Histórico de ordens de serviços
--Original													
--STA - Problemas com Ordens de Serviço)	
Select * From STA010
Where  D_E_L_E_T_ = ''

--STJ - Ordens de Serviço	
Select * From STJ010
Where  D_E_L_E_T_ = ''

--STL - Insumos da Ordem de Serviço	
Select * From STL010
Where  D_E_L_E_T_ = ''

--STN - Ocorrências Retorno Manutenção	
Select * From STN010
Where  D_E_L_E_T_ = ''

--STQ - Etapas Executadas
Select * From STQ010
Where  D_E_L_E_T_ = ''

--TPL - Motivos de Atraso da O.S.	
Select * From TPL010
Where  D_E_L_E_T_ = ''

--TPQ - Opções Respostas das Etapas)	
Select * From TPQ010
Where  D_E_L_E_T_ = ''

--Cópia
--STV - Histórico de Problemas
Select * From STV010
Where  D_E_L_E_T_ = ''

--STS - Histórico de Manutenção
Select * From STS010
Where  D_E_L_E_T_ = ''

--STT - Histórico de Detalhes da Manutenção
Select * From STT010
Where  D_E_L_E_T_ = ''

--STU - Histórico de Ocorrências
Select * From STU010
Where  D_E_L_E_T_ = ''

--STX - Histórico de Etapas Executadas
Select * From STX010
Where  D_E_L_E_T_ = ''

--TQ6 - Histórico Motivos Atraso O.S 
Select * From TQ6010
Where  D_E_L_E_T_ = ''

--TPX - Histórico de Opções Respostas da O.S
Select * From TPX010
Where  D_E_L_E_T_ = ''

-- Contabil Lançamentos 
Select * From CT2010
Where CT2_ROTINA = 'ATFA050'
And D_E_L_E_T_ = ''

-- LPs
Select * From CT5010
Where CT5_LANPAD = '830'
And D_E_L_E_T_= ''




--Outras tabelas
--FN6 – Baixa de Ativos
Select * From SN6010

--FN7 – Baixas de tipos de ativo
Select * From FN7010

--FN8 – Lote de baixa de ativos
Select * From FN8010

--FN9 – Cabeçalho da Transferência
Select * From FN9010

--FNS – Tipos de Saldo Transferidos
Select * From FNS010


--FNA – Movimentos de Produção
Select * From FNA010

--FNB – Projetos de imobilizado
Select * From FNB010

--FNC – Etapas do projeto
Select * From FNC010

--FND – Itens das etapas do projeto
Select * From FND010

--FNE – Config ctb de projetos atf
Select * From FNE010

--FNF – MOVIMENTOS AVP DO ATIVO FIXO
Select * From FNF010

--FNG – Itens do Grupo de Bens *******
Select * From FNG010 

--FNH – Opera. com controle de aprova. *******
Select * From FNH010

--FNI – Indices cálculo de depreciacao
Select * From FNI010

--FNJ – Item de Etapa X Ativo Execução
Select * From FNJ010

--FNK – Alçadas aprovacao por operacao
Select * From FNK010

--FNL – Itens Alçada Aprov. por operac
Select * From FNL010

--FNM – Movimen. de aprova. por opera.
Select * From FNM010

--FNN – Processo Constitucao Provisao
Select * From FNN010

--FNO – Movtos. Constituição Provisão
Select * From FNO010

--FNP – PROCESSAMENTO APROPRIAÇÃO AVP
Select * From FNP010

--FNQ – Margem Gerencial
Select * FRom FNQ010

--FNR – Ativos Transferidos
Select * From FNR010



--FNT – Taxas de indices depreciacao
Select * From FNT010

--FNU – Controle de Provisão
Select * From FNU010

--FNV – Item da Provisão
Select * From FNV010

--FNW – Movimentos de Provisão
Select * From FNW010

--FNX – Realização da Provisão
Select * From FNX010

--FNY – Ajuste Valor Justo
Select * From FNY010

--FNZ – Itens de Ajuste Valor Justo
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
		
Where CT2_FILIAL = '02'
And CT2_DATA Between '20240101' and '20241231'
And CT2_LP Between '800' and '840'
--And CT2_ROTINA = ('ATFA060')
--and CT2_KEY = '011  000355749   NF'
and CT2.D_E_L_E_T_ =''


-- Lançamentos Contab.
Select CT2_ROTINA,CT2_LP,CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN
From CT2010 CT2 With(Nolock)
Where CT2_FILIAL = '02'
And CT2_DATA Between '20240101' and '20241231'
And CT2_LP Between '800' and '840'
--And CT2_ROTINA = ('ATFA060')
--and CT2_KEY = '011  000355749   NF'
--and CT2.D_E_L_E_T_ =''