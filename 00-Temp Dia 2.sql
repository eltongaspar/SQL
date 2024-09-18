--Consulta Chave nas NFe de entrada.
--Desabilitar por Filial.
--MV_CHVNFE
--Informa se havera consulta da NFE/CTE no portal da SEFAZ .T.
 --= Sim; .F. = Nao.
 SELECT * FROM SX6010 WHERE X6_VAR='MV_CHVNFE'	and X6_FIL = 'FK01'

 --NF Entrada Cab. SF1
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC,F1_CHVNFE, * From SF1010
Where F1_FILIAL = 'BA11' and F1_DOC ='000018339' and D_E_L_E_T_=''

--NF Entrada Itens SD1
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC, * From SD1010
Where D1_FILIAL ='BA11' and D1_DOC ='000018339' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20220101'


--CD2 - Livro digital de Impostos-SPED
Select * From CD2010
Where CD2_FILIAL = 'BA11' and CD2_DOC In ('000018334') and D_E_L_E_T_=''


--EIC - Cadastros de vias

--SYQ - Vias de Transporte
Select * From SYQ010
Where YQ_VIA = '02' and D_E_L_E_T_ =''

--SYR - Taxas de Frete
Select * From SYR010
Where YR_VIA = '02' and YR_ORIGEM In ('TOR') and YR_DESTINO In ('GRU')
and D_E_L_E_T_ =''

--SY9 - Portos/Aeroportos - Origem e Destino
Select * From SY9010
Where Y9_COD In ('00097','41068') and D_E_L_E_T_ =''

--SYA - Paises - Pais Origem 
Select * From SYA010
Where YA_DESCR Like ('%TOR%') or YA_CODGI = '149' and D_E_L_E_T_ =''

--ELO - Cod.Pais Orig.Item Com.ISO3166
Select * From ELO010
Where ELO_DESC Like ('%TOR%') and D_E_L_E_T_ =''




-- Empresas 
Select * From SYS_COMPANY
Where M0_CGC = '37105649000187'

--Consulta Cadastros - Transferencias Automaticas
Select ZB_FILORIG, ZB_FILDEST, ZB_TESDEST, * From SZB010
Where D_E_L_E_T_ = '' and ZB_PRODUTO = '0200500099' and ZB_FILORIG = 'FL01' and ZB_FILDEST = 'BA06'



--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, * From SF2010
Where F2_FILIAL = 'AE01' and F2_DOC In ('000013069') and D_E_L_E_T_=''

--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_TES,D2_CCUSTO,D2_DOC,D2_PEDIDO,D2_PREEMB, * From SD2010
Where D2_FILIAL ='FJ01' and D2_DOC In ('000013069')  and D_E_L_E_T_=''
--and D2_COD = '0660010488'

-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL In ('AE01') and B6_PRODUTO in ('0660012278') and B6_SALDO > 0

Select B6_FILIAL,B6_PRODUTO, Sum(B6_SALDO) TOTAL From SB6010
Where B6_FILIAL In ('AE01') and B6_PRODUTO in ('0660012278') and B6_SALDO > 0
Group By B6_FILIAL, B6_PRODUTO



Select X6_DESCRIC,X6_DESC1,X6_DESC2,* From SX6010
Where X6_VAR In ('MV_RESTSOL','MV_APROVSC','MV_RESTPED')





--Acontece o erro pois não existe um lançamento no financeiro deste processo.

--Localizar na tabela de Despesas de Exportação (EET) o pedido e apagar o numero do documento do financeiro e a data de emissão.

--AJUSTE DENTRO DO DESPESAS NACIONAIS, DENTRO DO EMBARQUE

SELECT * FROM EET010 WHERE EET_PEDIDO='23/005-B-RB'  AND D_E_L_E_T_='' AND EET_FINNUM='200012314'

--UPDATE EET010 SET EET_FINNUM='', EET_ZZDTEM='' WHERE EET_PEDIDO='23/005-B-RB'  AND D_E_L_E_T_='' AND EET_FINNUM='200012314'










-- SPED050 - Nota Fiscal Eletrônica
Select * From SPED050
Where NFE_ID = '2  000006502' -- com dois espaçes entre Serie + Num NFe
and D_E_L_E_T_ =''
-- SPED054 - Lotes X Nota Fiscal Eletrônica
Select * From SPED054
Where NFE_ID = '2  000006502' and D_E_L_E_T_ =''

--Lotes de Nota Fiscal Eletrônica
Select * From SPED052
Where LOTE = '000000000013689' and D_E_L_E_T_ =''



--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC,F2_HAWB,F2_CHVNFE, * From SF2010
Where F2_FILIAL = 'BA14' and F2_DOC In ('000000071') and D_E_L_E_T_=''

--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_TES,D2_CCUSTO,D2_DOC,D2_PEDIDO,D2_PREEMB, * From SD2010
Where D2_FILIAL ='BA02' and D2_DOC In ('000006502')  and D_E_L_E_T_=''



--NF Entrada Cab.
Select F1_ISS,F1_RECISS, F1_INCISS, F1_DTCPISS, * From SF1010
Where F1_FILIAL = 'BA14' and F1_DOC = '000000071' and D_E_L_E_T_='' and F1_EMISSAO >= '20221201'

--SF1 - NF Entrada Cabeçalho 
--F1_ISS- Valor do ISS ***
--F1_RECISS - Recolhe ISS ? 1-Sim/2-Não
--F1_INCISS - Munic. de Incid. do ISS
--F1_DTCPISS - Desc. Data Competencia

--NF Entrada Itens
Select D1_NFORI,D1_DOC,D1_BASEISS,D1_ALIQISS,D1_VALISS,D1_CODISS,D1_ABATISS,   * From SD1010
Where D1_FILIAL ='BA14' and D1_DOC ='000000071' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20221201'

--SD1 - NF Entrada Itens 
--D1_BASEISS - Base de calculo do ISS ***
--D1_ALIQISS - Aliquota de ISS ***
--D1_VALISS - Valor do ISS ***
--D1 _CODISS - Codigo de Servico do ISS
--D1_ABATISS - Valor abatimento / ISS






/*SE2 - Contas a pagar 
E2_SALDO - Saldo a Receber
E2_VALOR - Valor do Titulo
E2_BAIXA - Data de Baixa do Titulo
E2_ISS - Valor do ISS
E2_PARCISS - Parcela do ISS
E2_VRETISS - Valor Retido - ISS
E2_VENCISS - Vencimento ISS
E2_VBASISS - Valor Acumulado Servicos
E2_MDRTISS - Modo de Retencao de ISS
E2_FRETISS - Forma de retencao do ISS	
E2_TRETISS - Retencao do ISS
E2_BASEISS - Base ISS	
E2_PRISS - Provisao de - ISS
E2_BTRISS - Bitributacao do ISS CPOM
E2_VRETBIS - Vlr. Retencao ISS Bitrib.*/






--SE5 - Movimentação Bancária 
--E5_VRETISS - Valor Retido ISS
--E5_PRISS - Provisao de - ISS







-- Consulta Clientes
--SELECT * FROM SA1010 WHERE A1_COD='000582'

--Consulta Fornecedores
--SELECT * FROM SA2010 WHERE A2_COD in ('000582','002769 ') and D_E_L_E_T_ = ''

--Consulta Fornecedores CNPJ/CPF
--SELECT * FROM SA2010 WHERE A2_CGC = '07535284000160' and D_E_L_E_T_ = ''


--SD3 - Movimentacoes Internas
Select * From SD3010
Where D3_FILIAL = 'BA02'and D3_COD = '0110010317' and D3_QUANT > 0and D3_LOTECTL = '12211054' and D3_ESTORNO = '' and D_E_L_E_T_ =''

Select Sum(D3_QUANT) ENTRADA From SD3010
Where D3_FILIAL = 'BA02'and D3_COD = '0110010317' and D3_QUANT > 0and D3_LOTECTL = '12211054' and D3_ESTORNO = '' and D_E_L_E_T_ =''
And D3_TM <= 499

Select Sum(D3_QUANT) SAIDA From SD3010
Where D3_FILIAL = 'BA02'and D3_COD = '0110010317' and D3_QUANT > 0and D3_LOTECTL = '12211054' and D3_ESTORNO = '' and D_E_L_E_T_ =''
And D3_TM >= 500


--SD5 - Requisicoes por Lote
Select * From SD5010
Where D5_FILIAL = 'BA02' and D5_PRODUTO = '0110010317' and D5_LOTECTL = '12211054' and D5_ESTORNO = '' and D_E_L_E_T_ =''

Select Sum(D5_QUANT) ENTRADA From SD5010
Where D5_FILIAL = 'BA02' and D5_PRODUTO = '0110010317' and D5_LOTECTL = '12211054' and D5_ESTORNO = '' and D_E_L_E_T_ =''
and D5_ORIGLAN <= 499

Select Sum(D5_QUANT) SAIDA From SD5010
Where D5_FILIAL = 'BA02' and D5_PRODUTO = '0110010317' and D5_LOTECTL = '12211054' and D5_ESTORNO = '' and D_E_L_E_T_ =''
and D5_ORIGLAN >=500

--SD4 - Requisicoes Empenhadas
--SD4010 SET D4_QUANT=D4_QTDEORI
SELECT * FROM SD4010 
WHERE D4_FILIAL = 'BA02' and D4_COD = '0110010317' and D4_QUANT > 0 And D_E_L_E_T_ ='' And D4_LOTECTL = '12211054'

SELECT Sum(D4_QUANT) Emepnho FROM SD4010 
WHERE D4_FILIAL = 'BA02' and D4_COD = '0110010317' and D4_QUANT > 0 And D_E_L_E_T_ ='' And D4_LOTECTL = '12211054'



SELECT
    ROW_NUMBER() OVER(ORDER BY B1_COD ASC) AS LINHA,
    B1_COD,
    B1_DESC
FROM
    SB1010 SB1
WHERE
    B1_FILIAL = ' '
    AND B1_MSBLQL != '1'
    AND SB1.D_E_L_E_T_ = ' '

Select * From SB1010

sp_who

Select * From SPI010
Where PI_FILIAL = 'BA01' and PI_MAT = '000562'

-- Consulta Verbas (RH)
Select * From SRV010
Where RV_FILIAL = 'BA' and RV_COD = '350'

Select * From SRL010


-- Criação de perídos para calculos RH

-- Tabela Periodos (RH)
Select * From RCF010
Where RCF_FILIAL = 'BA15'

-- Tabela Periodo de Calculo (RH)
Select * From RCH010
Where RCH_FILIAL = 'BA15'

-- Cadastros de Periodos (RH)
Select * From RFQ010
Where RFQ_FILIAL = 'BA15'

-- Parametros 
Select * From SX6010
Where X6_FIL = 'BA15' and X6_VAR In ('MV_PAPONTA')

--SP9 - EVENTOS
Select * From SP9010
Where P9_FILIAL = 'BA15'

--SP4 - TIPO DE HORA EXTRA
Select * From SP4010
Where P4_FILIAL = 'BA15'

--SR6 - TURNO
Select * From SR6010
Where R6_FILIAL = 'BA15'

--SPJ - HORARIO PADRAO
Select * From SPJ010
Where PJ_FILIAL = 'BA15'




--RFB - Cabecalho de Pre-Leitura (Arquivos Relogio ponto)
Select * From RFB010
Where RFB_FILIAL ='BA04' and  RFB_DTHRG >= '2301010000' and D_E_L_E_T_=''




--EXP - Capa da Invoice
SELECT EXP_TOTPED,* FROM EXP010 
WHERE EXP_FILIAL In  ('BA03') and EXP_PREEMB In ('035619')
Order By EXP_FILIAL, EXP_PREEMB


--SE1 - Contas a Receber
SELECT E1_FILORIG, E1_VALOR, E1_SALDO, E1_ZZPREEM,E1_CCUSTO, * FROM SE1010
WHERE E1_FILORIG In ('BA03') and  E1_ZZPREEM In ('23/005-RB ') and E1_BAIXA='' AND D_E_L_E_T_=''
Order By 1,4


--EEQ - Valor das Parcelas do Embarque
SELECT EEQ_VL, EEQ_FINNUM, * FROM EEQ010
WHERE EEQ_FILIAL In ('BA03') and  EEQ_PREEMB In('23/005-RB ') AND D_E_L_E_T_='' 
Order By EEQ_FILIAL, EEQ_PREEMB

--EET - Despesas de Exportacao
Select * From EET010
Where EET_FILIAL = 'BA03' and EET_PEDIDO  In('23/005-RB') AND D_E_L_E_T_='' 

--EE9 - Itens Embarque
Select * FRom EE9010
Where EE9_FILIAL = 'BA03' and EE9_PREEMB In ('23/005-RB') and D_E_L_E_T_ =''











-- Easy Export Control

--EE9 - Itens Embarque
SELECT EE9_VLFRET, * FROM EE9010 
WHERE EE9_PREEMB = ('23/053-RB') 

-- EE7 Capa Exportacao
Select * From EE7010
Where EE7_FILIAL = 'BA03' and EE7_PEDIDO = '035619'

--EE8 Itens do Pedido de Exportação
Select * From EE8010
Where EE8_FILIAL = 'BA03' and EE8_PEDIDO = '035619'


-- Condicao de pagamento Modulo 29 - Easy Export
--SY6 - Condicoes de Pagamento
Select Y6_CODERP, Y6_SIGSE4,Y6_DESC_P,Y6_DESC_I,* From SY6010
Where Y6_COD = '00022' and D_E_L_E_T_ ='' 


--SE4 - Condiçoes de pagamento 
Select * From SE4010
Where E4_CODIGO = '060' and D_E_L_E_T_ =''

--EE2 - Multi-Idiomas
Select * From EE2010
Where EE2_TEXTO In ('000036','354864') and D_E_L_E_T_ = ''

--SYP - Descricoes dos Campos Memo
Select * From SYP010
Where YP_CHAVE In ('000036','354864') And YP_CAMPO Like ('%Y6_DESC%') and YP_FILIAL = '' and D_E_L_E_T_ =''


--SX5 - Tabelas 
Select * From SX5010
Where X5_FILIAL = 'BA03' and X5_TABELA = '21' And D_E_L_E_T_ =''







--EEC Capa do Embarque de Exportação
Select * From EEC010
Where EEC_FILIAL = 'BA03' and EEC_PREEMB = '23/053-RB'


--EET - Despesas de Exportacao
Select EET_FINNUM,* From EET010
Where EET_FILIAL = 'BA03' and EET_PEDIDO = '23/053-RB' and D_E_L_E_T_ ='' 
--and EET_FINNUM = '200004362' and D_E_L_E_T_ =''

--EEB - Agentes de um Pedido
Select * From EEB010
Where EEB_FILIAL = 'BA03' and EEB_PEDIDO = '23/053-RB' and D_E_L_E_T_ =''


-- EXL - TITULO PROVISORIO (sem data de embarque)
SELECT * FROM EXL010 WHERE EXL_PREEMB Like '23/053-RB' and D_E_L_E_T_ =''


--TITULO DEFINITIVO (com dt embarque)
SELECT EEQ_FINNUM, * FROM EEQ010 
WHERE EEQ_PREEMB='23/053-RB' and D_E_L_E_T_ =''

--SC5 - Pedidos de Venda
Select C5_ZZREFIM, * From SC5010
Where C5_FILIAL ='BA03'and  C5_NUM In ('035619') and D_E_L_E_T_=''

--SC6 - Itens dos Pedidos de Venda
Select C6_ZZREFIM,* From SC6010
Where C6_FILIAL ='BA03'and  C6_NUM In ('035619') and D_E_L_E_T_=''

--SC9 - Pedidos Liberados
SELECT C9_LOTECTL, * FROM SC9010 
WHERE C9_FILIAL='BA03' AND C9_PEDIDO In ('035619') AND D_E_L_E_T_=''


--SE2 - Contas a Pagar
SELECT E2_HIST,* FROM SE2010 
WHERE E2_HIST Like ('%23/053-RB') and D_E_L_E_T_ =''


--EXP - Capa da Invoice
SELECT * FROM EXP010 WHERE EXP_PREEMB='23/053-RB'
--UPDATE EXP010 SET EXP_FRPREV='3976', EXP_TOTPED='80024' WHERE EXP_PREEMB='22/085-SG'

--EXR - Detalhes das Invoices
SELECT * FROM EXR010 WHERE EXR_PREEMB='23/053-RB' 
--UPDATE EXR010 SET EXR_PRCTOT='40012', EXR_VLFRET='1988' WHERE EXR_PREEMB='22/085-SG' 

Select * From SYS_USR
Where USR_CODIGO Like '%daniela%'


--QAA - Usuarios
Select * From QAA010
Where QAA_FILIAL = 'AE01' and QAA_APELID = 'daniela.oliveira'


--FIL - C/C Fornecedores
Select * From FIL010
Where FIL_FORNEC In ('000867') And D_E_L_E_T_ = ''

--F72 - Chaves Pix Fornecedores
Select * From F72010






--SB8 - Saldos por Lote
Select SUM (B8_EMPENHO), B8_LOTECTL  From SB8010
Where B8_FILIAL = 'BA03' and B8_PRODUTO In  ('1090060144') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_LOTECTL


Select * From SYS_COMPANY
Where M0_CODFIL = 'BA16'




--Fornecedores
Select * From SA2010
Where A2_COD = '019685' and D_E_L_E_T_ =''



--Livro Fiscal SF3
Select F3_EMISSAO, F3_CHVNFE,F3_CFO, * From SF3010
Where F3_FILIAL ='BA15' and F3_NFISCAL In ('044558075','044453792') and D_E_L_E_T_=''

--Livro Fiscal Itens SFT
Select FT_EMISSAO, FT_CHVNFE,FT_CFOP, * From SFT010
Where FT_FILIAL ='BA15' and FT_NFISCAL In ('044558075','044453792') and D_E_L_E_T_=''



-- Cadastro de Produtos
Select B1_RASTRO,* From SB1010
Where B1_COD In ('0880010477','0880010087') and D_E_L_E_T_=''

---- Saldo Fisico e Financeiro (Estoque)
Select ROW_NUMBER() OVER(ORDER BY B2_COD ASC) AS LINHA,B2_QEMP,B2_QEMPSA ,B2_QATU,B2_RESERVA, * From SB2010
Where B2_COD In ('0880010477','0880010087') and D_E_L_E_T_ = '' and B2_FILIAL = 'BA15'


--Livro Fiscal SF3
Select F3_EMISSAO,* From SF3010
Where F3_FILIAL ='CA01' and F3_NFISCAL ='000000294' and D_E_L_E_T_=''

--Livro Fiscal Itens SFT
Select FT_EMISSAO, * From SFT010
Where FT_FILIAL ='CA01' and FT_NFISCAL ='000000294' and D_E_L_E_T_=''

--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC,F1_ESPECIE, * From SF1010
Where F1_FILIAL = 'EC01' and F1_DOC In ('000035802') and D_E_L_E_T_=''--and F1_EMISSAO >= '20230101'

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC,D1_ZZNFRUR, * From SD1010
Where D1_FILIAL ='EC01' and D1_DOC In ('000035802') and D_E_L_E_T_ ='' --and D1_EMISSAO >= '20230101'



--Parametros
Select * From SX6010
Where X6_VAR = 'MV_TAFVLRE'

--Empresas
Select * From SYS_COMPANY
Where M0_CODFIL In ('ED01','ED20')




-- Clientes 
Select * From SA1010
Where A1_COD = '003498' and D_E_L_E_T_ =''


               
SELECT F2_ZZUFPLA,* FROM SF2010 WHERE F2_FILIAL='BA02' AND F2_DOC IN ('000006674','000006693')




--CTT - Centro de Custo
--Voltar lançamento exluido
--1 - achar lançamento por Filial, Data e Valor e localizar o CT2_SEQUEN
Select CT2_SEQUEN,CT2_HIST, CT2_VALOR, CT2_ZZDOC, * From CT2010
Where CT2_FILORI  = 'EC01' and CT2_DATA = '20230316' and D_E_L_E_T_='*' and CT2_LOTE In ('RENDAP') 


-- 2 - pelo CT2_SEQUEN ahar as qtde de linhas excluidas e voltar o lancamento 
Select CT2_HIST, CT2_SEQUEN, CT2_VALOR, * From CT2010
Where CT2_FILORI = 'EC01' and CT2_DATA = '20230316' and D_E_L_E_T_='*' and CT2_SEQUEN In('0001354452')

Select * From SRR010

Select * From SX6010
Where X6_VAR = 'MV_ORGCFG' 

Select * From SR8010
Where R8_FILIAL = 'BA01' and R8_MAT = '000562'


SELECT DISTINCT C1_CC, CTT_DESC01, C1_PRODUTO FROM SC1010
INNER JOIN CTT010 ON CTT_CUSTO=C1_CC AND CTT_FILIAL=C1_FILIAL
WHERE C1_FILIAL='BA01' AND C1_SOLICIT LIKE 'gabriel.natan' AND C1_EMISSAO>='20230101'


Select * From SYS_USR
Where USR_NOME Like '%Emerson%'




--Parametros 
Select * From SX6010
Where X6_FIL = 'BA01' and X6_VAR In ('ZZ_ENVWFPV','ZZ_WFPVEM1','ZZ_WFPVEM2','ZZ_WFCFOAM','ZZ_WFPVEM3') 

--Parametros 
Select * From SX6010
Where X6_VAR In ('ZZ_WFCFOAM') 


-- Tabelas
Select * From SX2010
Where X2_CHAVE = 'SZ3'

-- Parametros 
-- ICMS por estados
-- Aliquota de ICMS de cada estado. Informar a sigla Aliquota de ICMS de cada estado. Informar a sigla 
-- e em seguida a aliquota, para calculo de ICMS com-plementar.                                        
Select * From SX6010
Where X6_VAR Like '%MV_ESTICM%'

-- Pedido de Compras
SELECT C7_OBS, C7_DATPRF,C7_CC,C7_CONTA,C7_COND, C7_TPFRETE,* FROM SC7010 WHERE C7_FILIAL='AA01' AND C7_NUM='003851'

-- Historico de alteração de Pedido de compras
SELECT CY_VERSAO,CY_OBS, CY_DATPRF,CY_CC,CY_CONTA,CY_COND, CY_TPFRETE,* FROM SCY010 WHERE CY_FILIAL='AA01' AND CY_NUM='003851' AND CY_ITEM='0013'



Select * From SYS_USR
Where USR_NOME Like ('%Felipe%')

--TNF - EPI Entregues Funcionarios
Select * From TNF010
Where TNF_FILIAL = 'AE01' and D_E_L_E_T_ = '' and TNF_MAT = '000223'
Order By TNF_DTENTR


--GWN - ROMANEIOS DE CARGA
Select * From GWN010
Where GWN_FILIAL = 'BA11' and GWN_NRROM = '00002590' and D_E_L_E_T_= ''

-- GWN_SIT - Opcoes do ComboBox: 1=Digitado;2=Emitido;3=Liberado;4=Encerrado

--PC 
Select C7_RESIDUO, C7_ENCER, * From SC7010
Where C7_FILIAL = 'DB0' and C7_NUM = '002809' and D_E_L_E_T_ =''

Select * From NT3010





-- SC 
Select C1_NOMAPRO,* From SC1010
Where C1_FILIAL = 'FA01' and C1_SOLICIT = 'stela.franco' and D_E_L_E_T_ ='' and C1_EMISSAO >= '20230301'
and C1_NUM = '001438' 

-- SR - Aprovação
Select * From SCR010
Where CR_FILIAL = 'FA01' and CR_TIPO = 'SC' and CR_EMISSAO >= '20230101' and D_E_L_E_T_ = ''
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.

-- SC - Inner Join 
Select C1_NOMAPRO,* From SC1010 SC1

	Inner Join SCR010 SCR With(NoLock)
	On C1_FILIAL = CR_FILIAL
	And C1_NUM = CR_NUM
	And CR_TIPO = 'SC'
	And SCR.D_E_L_E_T_ =''

Where C1_FILIAL = 'FA01' and C1_SOLICIT = 'stela.franco' and SC1.D_E_L_E_T_ ='' and C1_EMISSAO >= '20230301'




--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC,F1_ESPECIE, * From SF1010
Where F1_FILIAL = 'BA02' and F1_DOC In ('000006706') and D_E_L_E_T_=''and F1_EMISSAO >= '20230101'

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC,D1_ZZNFRUR,D1_LOCAL,D1_PEDIDO, * From SD1010
Where D1_FILIAL ='BA02' and D1_DOC In ('000006706') and D_E_L_E_T_ ='' and D1_EMISSAO >= '20230101'

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC,D1_ZZNFRUR,D1_LOCAL, * From SD1010
Where D1_COD ='0210050255' and D_E_L_E_T_ = ''


-- Alteração Fornecedor  PC de Importação
-- Pedido de Compras
SELECT C7_FORNECE, C7_LOJA, D_E_L_E_T_,* FROM SC7010 WHERE  C7_FILIAL='BA02' AND C7_NUM  IN ('009213')
--UPDATE SC7010 SET C7_FORNECE='002330' WHERE  C7_FILIAL='BA02' AND C7_NUM  IN ('009213')

-- SW2 - SW2 - Capa de Purchase Order
SELECT * FROM SW2010 WHERE W2_FILIAL='BA02' AND W2_PO_SIGA='009213'
--UPDATE SW2010 SET W2_FORN='002330' WHERE W2_FILIAL='BA02' AND W2_PO_SIGA='009213'

--SW3 - SW3 - Itens de Purchase Order
SELECT * FROM SW3010 WHERE W3_FILIAL='BA02' AND W3_PO_NUM='IMP-22/025-SG' AND D_E_L_E_T_=''
--UPDATE SW3010 SET W3_FABR='002330' WHERE W3_FILIAL='BA02' AND W3_PO_NUM='IMP-22/025-SG' AND D_E_L_E_T_=''

--Outras tabelas 
--SW0 -- SW0 - Capa de Solicitacao Importacao
Select * From SW0010

--SW1 -- SW1 - Itens Solicitacao Importacao
Select * From SW1010




-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP, B2_QATU, * From SB2010
Where B2_COD = '0210050255' and D_E_L_E_T_ = '' and B2_FILIAL = 'BA02'


--Tabela SB8 - Saldos por Lote
SELECT * FROM SB8010 
WHERE B8_PRODUTO='0210050255' AND B8_FILIAL='BA02' AND B8_SALDO > 0




-- Requisições Empenhadas - Consulta
Select D4_OP,D4_LOTECTL, D4_DTVALID, * From SD4010
Where D4_FILIAL = 'BA02' and D4_COD in ('0210050255') and D_E_L_E_T_ = '' and D4_QUANT > '0' 


--Movimentações internas
Select D3_LOTECTL,D3_DTVALID, * From SD3010
Where D3_FILIAL = 'BA02' and D3_COD in ('0210050255') and D3_EMISSAO >= '20230301' and D3_ESTORNO = ''
and D3_TM in ('020','999') 

--SD5 - Requisicoes por Lote
Select * FRom SD5010
Where D5_FILIAL = 'BA02' and D5_PRODUTO = '0210050255' and D_E_L_E_T_ =''






--Empresasas 
Select * From SYS_COMPANY
Where M0_CODFIL Like ('%BA%') and M0_ESTENT = 'RS'

Select * From CTT010
Where CTT_FILIAL = 'BA01' and D_E_L_E_T_= '' and CTT_CUSTO Like ('4%')


--EE7 - Processo de Exportacao
Select * From EE7010
Where EE7_DTPEDI

-- EEC - Embarque
Select * From EEC010

--EE8 - Itens Processo de Exportacao
Select * From EE8010


-- Parametros
Select X6_CONTEUD,* From SX6010
Where X6_VAR = 'MV_DATAFIS'

--AJUSTE DENTRO DO DESPESAS NACIONAIS, DENTRO DO EMBARQUE

SELECT * FROM EET010 WHERE EET_PEDIDO='23/025-SG'  AND D_E_L_E_T_='' AND EET_FINNUM='200014082'

--UPDATE EET010 SET EET_FINNUM='', EET_ZZDTEM='' WHERE EET_PEDIDO='21/136-SG'  AND D_E_L_E_T_='' AND EET_FINNUM='200004087'

-- Cabeçalho Consulta por Query   Consulta Dinamica
Select * From ZQ1010

-- Parametro Consulta por Query  - Consulta Dinamica
Select * From ZQ2010

--Usuario Consulta por Query   - Consulta Dinamica  
Select * From ZQ3010
Where ZQ3_CODUSR = '000396'

-- Tabelas
Select * From SX2010
Where X2_CHAVE In ('ZQ1','ZQ2','ZQ3')

Select * From SYS_USR 
Where USR_CODIGO = 'gabriela.fernandes'









-- Parametros
Select * From SX6010
Where X6_VAR In ('MV_ICMPAD','MV_ESTICM') and X6_FIL = 'BA04'

--SN4 - Movimentacoes do Ativo Fixo
Select N4_CCUSTO,N4_CCUSTOT, * From SN4010
Where N4_FILIAL = 'BA03' and N4_CBASE In ('NFE0000TW0','NFE0000TW1','NFE0000U21','NFE0000U22') and D_E_L_E_T_ =''

-- Controle de Meta Produção (Budget) - PCP - Personalizacao
--Tabelas
Select * From SX2010
Where X2_CHAVE In ('ZZO','ZZP','ZZQ','ZZR')

--Cadastro Budget de Gastos Item
Select * From ZZO010

--Cadastro de Certificado FSC   
Select * From ZZP010

--Cadastro Controle Requisito
Select * From ZZQ010

-- Cadastro Controle Requisito It
Select * From ZZR010


--SD3 - Movimentacoes Internas
SELECT D3_COD, D3_LOTECTL, Sum(D3_QUANT) D3_QTDE,D3_TM FROM SD3010 
WHERE D3_FILIAL = 'BA01' AND D3_COD In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D3_EMISSAO Between '20230201' and '20230231' and D3_LOTECTL In ('12220618','12310235')
Group By D3_COD,D3_LOTECTL,D3_TM

SELECT * FROM SD3010 
WHERE D3_FILIAL = 'BA01' AND D3_COD In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D3_EMISSAO Between '20230201' and '20230231' and D3_LOTECTL In ('12220618','12310235')


--SD5 - Requisicoes por Lote
SELECT * FROM SD5010 
WHERE D5_FILIAL = 'BA01' AND D5_PRODUTO In ('0110020020','0110010251')  AND D_E_L_E_T_ = '' and D5_LOTECTL In ('12220618','12310235')






Select * From RD0010


--Conta Contabil 
Select * From CT1010
Where CT1_CONTA = ('1103010001') and D_E_L_E_T_ =''

-- Compradores 
Select * From SY1010
Where Y1_USER = '000836'

--Centro de custos
Select * From CTT010
Where CTT_CUSTO In ('900410','900414') and D_E_L_E_T_ =''

--Grupo de Aprovacao 
Select * From SAL010 
Where AL_FILIAL = 'BA11' and AL_COD In ('000003') and D_E_L_E_T_ =''

--DBL - Entidades Contabeis X Grp Apr
Select * From DBL010
Where DBL_CC In ('900410','900414') and D_E_L_E_T_ =''


--User
Select * From SYS_USR 
Where USR_CODIGO Like ('%danilo%')



--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC,D1_LOTECTL,D1_ZZNFRUR,D1_LOCAL,D1_PEDIDO, * From SD1010
Where D1_FILIAL ='BA24' and D1_DOC In ('000004052') and D_E_L_E_T_ ='' and D1_EMISSAO >= '20230101'


--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC,F1_ESPECIE, * From SF1010
Where F1_FILIAL = 'BA24' and F1_DOC In ('000004052') and D_E_L_E_T_='' and F1_EMISSAO >= '20230101'



--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_PODER3,F4_TEXTO,* From SF4010
Where F4_CODIGO in ('097','322','487') and D_E_L_E_T_=''





--RFE - Pre Leitua
Select * From RFE010
Where RFE_FILIAL = 'BA07' and RFE_DATA >= '20230401' and D_E_L_E_T_ =''
--UPDATE RFE010 SET  D_E_L_E_T_='*', R_E_C_D_E_L_=R_E_C_N_O_ Where RFE_FILIAL = 'BA07' and RFE_DATA >= '20230401' and D_E_L_E_T_ =''

--SP8 - Movimento de Marcacoes
Select * From SP8010
Where P8_FILIAL = 'BA07' and P8_DATA >= '20230404' and D_E_L_E_T_ ='*'
--UPDATE SP8010 SET  D_E_L_E_T_='*' Where P8_FILIAL = 'BA07' and P8_DATA >= '20230404' and D_E_L_E_T_ =''


Select * FRom CDY010
Where CDY_FILIAL = 'BA11' and D_E_L_E_T_ =''

Select * From ZY5010













-- Clientes 
Select * From SA2010
Where A2_COD In ('012129') and D_E_L_E_T_ =''

--User
Select * From SYS_USR 
Where USR_CODIGO Like '%cesar%'


--NF Entrada Itens
SELECT * FROM SD1010 WHERE D1_FILIAL='FK01' AND D1_COD='0550010091' AND D1_DOC='000002434'  and D_E_L_E_T_ =''
--UPDATE SD1010 SET D1_TES='440' WHERE D1_FILIAL='FK01' AND D1_COD='0550010091' AND D1_DOC='000002434'  and D_E_L_E_T_ =''

--NF Entrada Itens
SELECT * FROM SD1010 WHERE D1_FILIAL='FK01' AND D1_COD='0660015740' AND D1_DOC='000011650' and D_E_L_E_T_ =''
--UPDATE SD1010 SET D1_TES='440' WHERE D1_FILIAL='FK01' AND D1_COD='0660015740' AND D1_DOC='000011650' and D_E_L_E_T_ =''



-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL = 'FK01' and B6_PRODUTO in ('0660015740','0550010091') and B6_SALDO > 0

Select Sum (B6_SALDO) Total From SB6010
Where B6_FILIAL = 'FK01' and B6_PRODUTO in ('0660015740','0550010091') and B6_SALDO > 0
Group By B6_PRODUTO




--NF Saida Itens
Select D2_ZZSAIDA,D2_FILIAL,D2_DOC,D2_COD,D2_LOTECTL D2_EMISSAO,D2_NFORI, D2_TES, * From SD2010
Where D2_FILIAL ='BA02' and D2_DOC In ('000006680','000006682','000006782','000008072','000008073')  and D_E_L_E_T_='' and D2_EMISSAO >= '20230101'





--Livro Fiscal SF3
Select F3_EMISSAO,* From SF3010
Where F3_FILIAL ='BA02' and F3_NFISCAL ='000006812' and D_E_L_E_T_='' and F3_EMISSAO >= '20230101'
--UPDATE SF3010 SET F3_CFO 


--Livro Fiscal Itens SFT
Select FT_EMISSAO, * From SFT010
Where FT_FILIAL ='BA02' and FT_NFISCAL ='000006812' and D_E_L_E_T_='' and FT_EMISSAO >= '20230101'
--UPDATE SFT010 SET FT_CFOP 


--NF Saida Cab.
Select F2_FILIAL,F2_EMISSAO, * From SF2010
Where F2_FILIAL = 'BA02' and F2_DOC In ('000006808') and D_E_L_E_T_='' and F2_EMISSAO >= '20230101'
--UPDATE SF2010 SET

--NF Saida Itens
Select D2_ZZSAIDA,D2_FILIAL,D2_DOC,D2_COD,D2_CF,D2_LOTECTL D2_EMISSAO,D2_NFORI, D2_TES, * From SD2010
Where D2_FILIAL ='BA02' and D2_DOC In ('000006808')  and D_E_L_E_T_='' and D2_EMISSAO >= '20230101'




-- Cadastro de Produtos
Select B1_RASTRO,B1_NOTAMIN,B1_TIPOCQ,B1_MSBLQL,* From SB1010
Where B1_COD In ('0110040006') and D_E_L_E_T_ =''

-- Produtos Complemento 
Select * From SB5010
Where B5_FILIAL = 'BA02' and B5_COD = '0110040006' and D_E_L_E_T_ =''

-- Produto Indicador
Select * From SBZ010
Where BZ_FILIAL = 'BA02' and BZ_COD = '0110040006' and D_E_L_E_T_ =''


---- Saldo Fisico e Financeiro (Estoque)
Select ROW_NUMBER() OVER(ORDER BY B2_COD ASC) AS LINHA,B2_QEMP,B2_QEMPSA ,B2_QATU,B2_RESERVA, * From SB2010
Where B2_COD In ('0110040006') and D_E_L_E_T_ = '' and B2_FILIAL = 'BA02'

--SB8 - Saldos por Lote
Select *  From SB8010
Where B8_FILIAL = 'BA02' and B8_PRODUTO In  ('0110040006') and D_E_L_E_T_='' and B8_SALDO > '0'

--SB8 - Saldos por Lote
Select B8_PRODUTO,SUM (B8_SALDO) SALDO, B8_LOTECTL  From SB8010
Where B8_FILIAL = 'BA02' and B8_PRODUTO In  ('0110040006') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO,B8_LOTECTL

--SB8 - Saldos por Lote
Select B8_PRODUTO,SUM (B8_SALDO) SALDO  From SB8010
Where B8_FILIAL = 'BA02' and B8_PRODUTO In  ('0110040006') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO









Declare @FILIAL Char(4), @NUMPC Char(6), @NUMCOT Char(6), @NUMSC Char(6)
SET @FILIAL = 'BA03' 
SET @NUMPC = '021025'
SET @NUMCOT = '005135'
SET @NUMSC = '004960'

-- NF de Entrada - itens
-- Veficar se PC não teve movimentações Fiscais de Entrada
Select D1_TES, D1_PEDIDO,D_E_L_E_T_, * From SD1010 
Where D1_FILIAL = @FILIAL and D1_PEDIDO In (@NUMPC) and D_E_L_E_T_='' 

Select Sum (D1_QUANT) AS Total From SD1010
Where D1_FILIAL = @FILIAL and D1_PEDIDO In (@NUMPC) and D_E_L_E_T_='' 

-- Pedido Compra
SELECT C7_FILIAL, C7_PRODUTO, C7_NUM, C7_NUMCOT, C7_NUMSC, C7_FORNECE, C7_LOJA, C7_QUJE, C7_CONAPRO, C7_QUANT, C7_RESIDUO, C7_ENCER, * FROM SC7010 
WHERE C7_FILIAL = @FILIAL AND C7_NUM in (@NUMPC) and D_E_L_E_T_ = ''

SELECT Sum (C7_QUANT) AS QUANT, Sum (C7_QUJE) as Entrega   FROM SC7010 
WHERE C7_FILIAL=@FILIAL AND C7_NUM in (@NUMPC) and D_E_L_E_T_ = ''

--Cotações
SELECT C8_FILIAL, C8_PRODUTO, C8_NUMPED,C8_NUM,C8_NUMSC, C8_FORNECE, C8_LOJA, * FROM SC8010 
WHERE C8_FILIAL=@FILIAL AND C8_NUM = @NUMCOT AND D_E_L_E_T_='' and NOT C8_NUMPED = 'XXXXXX' and C8_NUMPED in (@NUMPC)

-- Solicitação de compra
Select C1_FILIAL, C1_PRODUTO, C1_PEDIDO, C1_COTACAO, C1_NUM, C1_FORNECE, C1_LOJA, * From SC1010
Where C1_FILIAL = @FILIAL and C1_NUM = @NUMSC and D_E_L_E_T_ = '' and C1_PEDIDO = @NUMPC

--SCR - Documentos com Alcada
Select * From SCR010
Where CR_FILIAL = @FILIAL and CR_NUM = @NUMPC and D_E_L_E_T_ =''
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.

--DBM - Itens de Doc. com Alçada
Select * From DBM010
Where DBM_FILIAL = @FILIAL and DBM_NUM = @NUMPC and D_E_L_E_T_ =''

--SYS Company
Select * From SYS_COMPANY 
Where M0_CGC = '03342935000144'




--SIGAEST - 04
-- Acompanha Custos 

--Log de Fechamentos
Select * From D3X010

--Fechamento Realizado 
Select * From D3Y010

-- Controle Transacional
Select * From D3W010

--Paramestos 
Select * From SX6010
Where X6_VAR = 'MV_CUSTEXC'

Select * From SX6010
Where X6_VAR = 'MV_CMDBLQV'




--Parametro para cancelamento de NF após 24 h
--MV_SPEDEXC
--Entrar no parametro da sua filial e colocar o numero de horas para o cancelamento da NF.
SELECT * FROM SX6010 
WHERE X6_FIL = 'BA12' and X6_VAR='MV_SPEDEXC'	

--Define a quantidade de dias para transmissão do Cancelamento Extemporâneo.
--MV_CANCEXT
-- Parâmtro para todas empresas Padrão 1 Dias.
Select * From SX6010
Where X6_FIL = 'BA12' and X6_VAR = 'MV_CANCEXT'

-- Parametros
Select * From SX6010
Where X6_VAR = 'MV_DATAFIS'


SELECT * FROM SB2010 WHERE B2_COD='0100100001' AND B2_FILIAL='AE01' and D_E_L_E_T_ =''

--Email de Copia de WF Compras (Processo Completo)
Select * From SX6010
Where X6_VAR = 'ZZ_WFCC'

Select * FRom SRA010
Where RA_NOME Like ('DOUGLAS%') and RA_NOME Like ('%SILVA%')




--RCC - Parametros - RH 
Select * FRom RCC010

--RCB - Configuracao de Parametros
Select * From RCB010

Select * From SYS_USR
Where USR_DTLOGON <= ('20230301')



Select * From SYS_USR
Where USR_DTTENTBLQ >= '20230401' or USR_DATABLQ >= '20230401'



--SE1 - Contas a Receber
Select E1_LA,E1_VALOR, E1_HIST, * From SE1010
Where E1_FILORIG = 'BA15' and E1_HIST In ('190853') and D_E_L_E_T_ = ''

--SE2 - Contas a Pagar
Select E2_FILORIG,E2_SALDO,E2_VALLIQ,E2_BAIXA,E2_EMISSAO, E2_EMIS1, * From SE2010
Where E2_FILORIG = 'BA15' and E2_NUM In ('190853') and D_E_L_E_T_ = ''  and E2_EMISSAO >= '20230101'

--SE5 - Movimentacao Bancaria
Select E5_FILORIG,E5_HISTOR,E5_NUMERO,E5_LA, * From SE5010
Where E5_FILORIG = 'BA15'  and E5_VALOR In ('1580.58') and D_E_L_E_T_ = ''




--CTT - Centro de Custo
--Voltar lançamento exluido
--1 - achar lançamento por Filial, Data e Valor e localizar o CT2_SEQUEN
Select CT2_SEQUEN,CT2_HIST, CT2_VALOR, CT2_ZZDOC, * From CT2010
Where CT2_FILORI  = 'DB01' and CT2_DATA In ('20230320') and D_E_L_E_T_='' and 
CT2_VALOR In ('24367.56','62272.70') 


-- 2 - pelo CT2_SEQUEN ahar as qtde de linhas excluidas e voltar o lancamento 
Select CT2_HIST, CT2_SEQUEN, CT2_VALOR, * From CT2010
Where CT2_FILORI = 'BA02' and D_E_L_E_T_='' and CT2_SEQUEN In('0001243198')
and CT2_VALOR In ('1385','5288','6775','5182','10387','3611','9024')


-- Credito ICMS Lucro Real NF Entrada 
SELECT F1_FILIAL,F1_BASEICM, F1_VALICM, F1_BASIMP5, F1_BASIMP6,F1_DOC FROM SF1010 (NOLOCK)
WHERE (F1_FILIAL LIKE 'BA%' OR F1_FILIAL ='AC01') AND F1_DTDIGIT>='20230501' AND F1_VALICM>0


--C8R – Cadastro de Rubricas
Select * FRom C8R010
--C8U - Codigo Incid. Trib Rubrica IRRPF
Select * FRom C8U010
--C8T - Incid. Trib. Rubrica Previdência Social.
Select * FRom C8T010

-- TAFST1 (Fila ERP )
Select * From TAFST1
Where D_E_L_E_T_ =''
--TAFST2 ( TAF )
Select * From TAFST2
Where D_E_L_E_T_ =''

Select * FRom TAFGERCTL


--NF Saida Cab.
Select F2_FILIAL,F2_EMISSAO,F2_CHVNFE * From SF2010
Where F2_FILIAL ='DB01' and F2_DOC In ('000054671') and D_E_L_E_T_='' and F2_EMISSAO >= '20230101'
--UPDATE SF2010 SET

--NF Saida Itens
Select D2_ZZSAIDA,D2_FILIAL,D2_DOC,D2_COD,D2_CF,D2_LOTECTL D2_EMISSAO,D2_NFORI, D2_TES,D2_CF, * From SD2010
Where D2_FILIAL ='DB01' and D2_DOC In ('000054671')  and D_E_L_E_T_='' and D2_EMISSAO >= '20230101'
--UPDATE SD2010 SET D2_CF = '7102' Where D2_FILIAL ='DB01' and D2_DOC In ('000054671')  and D_E_L_E_T_='' and D2_EMISSAO >= '20230101'

--Livro Fiscal SF3
Select F3_EMISSAO,F3_OBSERV,F3_DESCRET,F3_CHVNFE,* From SF3010
Where F3_FILIAL = 'BA11' and F3_NFISCAL ='000004158' and D_E_L_E_T_='' and F3_EMISSAO >= '20230101'
--UPDATE SF3010 SET F3_CFO = '7102' Where F3_FILIAL = 'DB01' and F3_NFISCAL ='000054671' and D_E_L_E_T_='' and F3_EMISSAO >= '20230101'


--Livro Fiscal Itens SFT
Select FT_EMISSAO,FT_OBSERV,FT_CHVNFE, * From SFT010
Where FT_FILIAL ='BA11' and FT_NFISCAL ='000004158' and D_E_L_E_T_='' and FT_EMISSAO >= '20230101'
--UPDATE SFT010 SET FT_CFOP = '7102'Where FT_FILIAL ='DB01' and FT_NFISCAL ='000054671' and D_E_L_E_T_='' and FT_EMISSAO >= '20230101'





--SB9 - Saldos Iniciais
SELECT * FROM SB9010 WHERE B9_FILIAL = 'CA01' AND B9_COD = '0220010224' AND D_E_L_E_T_ = '' And B9_DATA >= '20230201'
And B9_QINI > 0






--SE2 - Contas a Pagar
Select E2_SALDO, E2_VALOR, E2_VLCRUZ, E2_BASECOF,E2_BASEPIS,E2_BASECSL, E2_BASEISS,E2_BASEIRF,E2_BASEINS, * 
From SE2010
Where E2_FILORIG = 'BA02' and E2_NUM In ('018002788') and D_E_L_E_T_ = '' 

--SE1 - Contas a Receber
SELECT E1_FILORIG, E1_VALOR, E1_SALDO, E1_LA, * FROM SE1010
WHERE E1_FILORIG In ('BA02') and  E1_NUM In ('018002788')  AND D_E_L_E_T_=''
Order By 1,4


--SE5 - Movimentacao Bancaria
Select E5_FILORIG,E5_HISTOR,E5_NUMERO,E5_VRETISS,E5_PRISS, * From SE5010
Where E5_FILORIG ='BA02'  and E5_DATA In ('018002788') and D_E_L_E_T_ = ''




-- Saldo Fisico e Financeiro (Estoque)
Select ROW_NUMBER() OVER(ORDER BY B2_COD ASC) AS LINHA,B2_QEMP,B2_QEMPSA ,B2_QATU,B2_RESERVA, * From SB2010
Where B2_COD In ('0110010251') and D_E_L_E_T_ = '' and B2_FILIAL = 'BA01'

-- Cadastro de Produtos
Select B1_RASTRO,B1_NOTAMIN,B1_TIPOCQ,B1_MSBLQL,* From SB1010
Where B1_COD In ('0110010251') and D_E_L_E_T_ =''

-- Produtos Complemento 
Select * From SB5010
Where B5_FILIAL = 'BA01' and B5_COD = '0110010251' and D_E_L_E_T_ =''

-- Produto Indicador
Select * From SBZ010
Where BZ_FILIAL = 'BA01' and BZ_COD = '0110010251' and D_E_L_E_T_ =''



--SB8 - Saldos por Lote
Select B8_FILIAL,B8_PRODUTO,SUM (B8_SALDO) SALDO, B8_LOTECTL  From SB8010
Where B8_FILIAL = 'BA01' and B8_PRODUTO In  ('0110010251') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By  B8_FILIAL,B8_PRODUTO, B8_LOTECTL

--SB8 - Saldos por Lote
Select *  From SB8010
Where B8_FILIAL = 'BA01' and B8_PRODUTO In  ('0110010251') and D_E_L_E_T_='' and B8_SALDO > '0'

--SB8 - Saldos por Lote
Select SUM (B8_SALDO) SALDO From SB8010
Where B8_FILIAL = 'BA01' and B8_PRODUTO In  ('0110010251') and D_E_L_E_T_='' and B8_SALDO > '0'



--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC,F1_ESPECIE, F1_GF,F1_CHVNFE, * From SF1010
Where F1_FILIAL = 'BA01' and F1_DOC In ('000003613') and D_E_L_E_T_='' and F1_EMISSAO >= '20230101'


--NF Entrada Itens
SELECT * FROM SD1010 WHERE D1_FILIAL= 'BA01' AND D1_DOC In ('000003613') and D_E_L_E_T_ ='' and D1_EMISSAO >= '20230101'
and D1_COD ='0110010251'
--UPDATE SD1010 SET D1_TES='440' 


-- TES - Troca de TES
--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_PODER3,F4_TEXTO,* From SF4010
Where F4_CODIGO in ('329') and D_E_L_E_T_=''

Select * From QEK010
Where QEK_FILIAL = 'BA01' and QEK_NTFISC = '000003613' and D_E_L_E_T_ ='' and QEK_PRODUT = '0110010251'