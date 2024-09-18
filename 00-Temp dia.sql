--CTT - Centro de Custo
--Voltar lançamento exluido
--1 - achar lançamento por Filial, Data e Valor e localizar o CT2_SEQUEN
Select CT2_SEQUEN,CT2_HIST, CT2_VALOR, CT2_ZZDOC, * From CT2010
Where CT2_FILORI  = 'BA03' and CT2_DATA = '20220412' and D_E_L_E_T_='' and CT2_VALOR In ('111587.99','0') and CT2_ZZDOC In ('000049973','')
and CT2_SEQUEN = '0001147349'
--and CT2_DEBITO <> '' 

-- 2 - pelo CT2_SEQUEN ahar as qtde de linhas excluidas e voltar o lancamento 
Select CT2_HIST, CT2_SEQUEN, CT2_VALOR, * From CT2010
Where CT2_FILORI = 'BA03' and CT2_DATA = '20220412' and D_E_L_E_T_='' and CT2_SEQUEN In('0001147349')




Declare @FILIAL Char(4), @NUMPC Char(6), @NUMCOT Char(6), @NUMSC Char(6)
SET @FILIAL = 'BA02' 
SET @NUMPC = '008984'
SET @NUMCOT = '006670'
SET @NUMSC = '007531'

-- NF de Entrada - itens
-- Veficar se PC não teve movimentações Fiscais de Entrada
Select D1_TES, D1_PEDIDO,D_E_L_E_T_, * From SD1010 
Where D1_FILIAL = @FILIAL and D1_PEDIDO In (@NUMPC) and D_E_L_E_T_='' 

Select Sum (D1_QUANT) AS Total From SD1010 
Where D1_FILIAL = @FILIAL and D1_PEDIDO in (@NUMPC) and D_E_L_E_T_='' 

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


-- Consulta Clientes
--SELECT * FROM SA1010 WHERE A1_COD='000582'

--Consulta Fornecedores
--SELECT * FROM SA2010 WHERE A2_COD in ('000582','002769 ') and D_E_L_E_T_ = ''

--Consulta Fornecedores CNPJ/CPF
--SELECT * FROM SA2010 WHERE A2_CGC = '07535284000160' and D_E_L_E_T_ = ''

-- TES - Troca de TES
--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_PODER3,* From SF4010
Where F4_CODIGO in ('006') and D_E_L_E_T_=''

-- Unidade de medida 
Select * From SAH010
Where AH_UNIMED In ('PC','L')


-- Cadastro de Produtos
Select B1_RASTRO,* From SB1010
Where B1_COD In ('0200500001','0200500002') and D_E_L_E_T_=''

               
--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, * From SF2010
Where F2_FILIAL = 'BA11' and F2_DOC >='000002872' and D_E_L_E_T_=''


--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_TES, * From SD2010
Where D2_FILIAL ='BA11' and D2_DOC >='000002872'  and D_E_L_E_T_=''

               
--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, * From SF1010
Where F1_FILIAL = 'BA09' and F1_DOC ='000009061' and D_E_L_E_T_=''

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC, * From SD1010
Where D1_FILIAL ='BA09' and D1_DOC ='000009061' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20220101'

--Livro Fiscal 
Select F3_EMISSAO,* From SF3010
Where F3_FILIAL ='AE01' and F3_NFISCAL ='000029921' and D_E_L_E_T_=''

--Livro Fiscal Itens
Select FT_EMISSAO, * From SFT010
Where FT_FILIAL ='AE01' and FT_NFISCAL ='000029921' and D_E_L_E_T_=''

-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP,B2_QEMPSA ,B2_QATU, * From SB2010
Where B2_COD In ('0905110001','0905210001') and D_E_L_E_T_ = '' and B2_FILIAL = 'AE01'


--SB8 - Saldos por Lote
Select SUM (B8_SALDO), B8_LOTECTL  From SB8010
Where B8_FILIAL = 'AC01' and B8_PRODUTO In  ('0100170001') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_LOTECTL

Select *  From SB8010
Where B8_FILIAL = 'AC01' and B8_PRODUTO In  ('0100170001') and D_E_L_E_T_='' and B8_SALDO > '0'
and B8_LOTECTL = '5220074'



--SC5 - Pedidos de Venda
Select * From SC5010
Where C5_FILIAL ='BA03'and  C5_NUM ='029772' and D_E_L_E_T_=''

--SC6 - Itens dos Pedidos de Venda
Select * From SC6010
Where C6_FILIAL ='BA03'and  C6_NUM ='029772' and D_E_L_E_T_=''

--SC9 - Pedidos Liberados
SELECT C9_LOTECTL, * FROM SC9010 
WHERE C9_FILIAL='BA03' AND C9_PEDIDO In ('029791') AND D_E_L_E_T_=''


--SE1 - Contas a Receber
Select E1_LA,E1_VALOR, E1_HIST, * From SE1010
Where E1_FILORIG= 'BA11' and E1_NUM In ('000001553') and D_E_L_E_T_ = ''

--SE2 - Contas a Pagar
Select E2_LA, E2_SALDO, E2_VALOR,E2_VLCRUZ,E2_BASECOF,E2_BASEPIS,E2_BASECSL,E2_BASEINS,E2_BASEIRF,E2_BASEISS, * From SE2010
Where E2_FILORIG= 'BA01' and E2_NUM In ('FUNPINUS') and D_E_L_E_T_ = '' 
and E2_FORNECE = '009032' and E2_PARCELA = '010'


--SE5 - Movimentacao Bancaria
Select E5_LA, E5_DATA,E5_DTDIGIT, E5_DTDISPO, E5_VALOR, E5_HISTOR,E5_NUMERO, * From SE5010
Where E5_FILORIG ='BA11'  and E5_NUMERO In ('00149') and D_E_L_E_T_ = ''
--and E5_FORNECE = '000964' and D_E_L_E_T_ =''




--FK5 - Movimentos Bancarios - Auxiliares
Select * From FK5010
Where FK5_FILORI In ('BA09','BA10') and FK5_NUMCH In ('004948','004838','004855','004870','004914') and FK5_DATA >= '20220501'

-- FO0 - Cabeçalho da simulação 
Select * From FO0010
Where FO0_FILIAL = 'BA01' and D_E_L_E_T_='' and FO0_PROCES ='000000000000182'

--FO1 - Titulos Negociados
Select * From FO1010
Where FO1_FILIAL = 'BA01' and D_E_L_E_T_='' and FO1_PROCES ='000000000000182'

--FO2 - Titulos Gerados
Select * From FO2010
Where FO2_FILIAL = 'BA01' and D_E_L_E_T_='' and FO2_PROCES = '000000000000182'

-- FK1 - Baixas a Receber
Select * From FK1010
Where FK1_FILORI = 'BA11' and FK1_DOC = '000001553' and D_E_L_E_T_= ''









--SRD - Historico de Movimentos
Select * From SRD010
Where RD_FILIAL = 'BA02' and RD_MAT = '000217' and RD_DATARQ >= '202201' and RD_PD = '676'


--RFB - Cabecalho de Pre-Leitura (Arquivos Relogio ponto)
Select * From RFB010
Where RFB_FILIAL ='BA09' and D_E_L_E_T_='' --and  RFB_DTHRG >= '2203150000' and D_E_L_E_T_=''
Order By RFB_DTHRG



-- SRR - Itens de Ferias e Rescisoes
Select * From SRR010
Where RR_FILIAL = 'BA02' and RR_MAT in ('000217') and RR_PERIODO >= '202201'

--SRA - Funcionarios
Select * From SRA010
Where RA_CIC = '30792146840'


--RD0 - Pessoas/Participantes
Select * From RD0010
Where RD0_LOGIN = '30792146840'

--SRD - Historico de Movimentos
Select * From SRD010
Where RD_FILIAL In ('FF01') and RD_MAT In ('001277','001262') and RD_DATARQ = '202202' and RD_PD = '676'

-- Iner Join SRAxRD0 
Select RD0.RD0_LOGIN, SRA.RA_CIC, * From SRA010 SRA
Inner Join RD0010 RD0 With (NOLOCK)
ON RA_CIC = RD0.RD0_LOGIN
Where  SRA.D_E_L_E_T_ = '' and RD0.D_E_L_E_T_ ='' and SRA.RA_CIC <> '' and RD0.RD0_LOGIN <> ''

--SRV - Verbas
Select COUNT (RV_COD) Total_G47  From SRV010
Where RV_COD = 'G47'





-- Parametro Etiquetas
SELECT * FROM SX6010 WHERE X6_VAR='ZZ_ETQCOMB'




-- QP7 - Ensaios Mensuraveis Produtos
Select * From QP7010
Where QP7_FILIAL = 'BA03' and QP7_PRODUT ='0100040006' and D_E_L_E_T_=''

--SG2 - Roteiro de Operacoes
Select * From SG2010
Where G2_FILIAL ='BA03' and G2_PRODUTO ='0100040006' and D_E_L_E_T_=''


--TNF - EPI Entregues Funcionarios
Select * From TNF010
wHERE TNF_DTENTR > '20220401'

--SH6 - Movimentacao da Producao
Select * From SH6010
Where H6_FILIAL = 'BA01' and H6_DATAINI >= '20220101' and H6_DATAFIN = '20220331' and D_E_L_E_T_=''

Select D2_COD From SD2010
Where D2_FILIAL = 'BA01' and D2_EMISSAO >= '20220101'
Group By D2_COD






--Outros 

--GXG - EDI - Documento de Frete
Select * From GXG010
--GXH - EDI - DOC CARGA DO DOC FRETE
Select * From GXH010


--AMARRAÇÃO NF ORIG X NF IMP/FRE
Select * From SF8010
Where F8_TRANSP = '185005'

-- Transportadoras
Select * From SA4010
Where A4_NOME Like '6M%'




--Selct para Laudo 

--Pesquisa Lote
--Movimentações Internas        
SELECT * FROM SD3010 WHERE D3_LOTECTL='722869'

--Identificar produto
--Identificadores de produtos
SELECT BZ_ZZCDREF, * FROM SBZ010 WHERE BZ_COD='0900160006'











