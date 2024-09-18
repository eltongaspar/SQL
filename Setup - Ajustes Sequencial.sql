-- Setup 
-- Para quedas de energia ou perdas de sequencial de numeração 
-- Executar Querys e analisar sequencial 

--TI - TI - Perda de Numero Sequencial - Quedas de Energia ou desligamento inesperado Servidor ou Quedas Inesperadas
--Script para ajustes e analise de  perdas de sequenciais em quedas dos servidores 
-- Quedas inesperadas 
-- Desligamento inesperado 
-- Quedas de energia 



/*ORDEM DE CARGA - EXISTENTES DEVEM SER FINABLQ E SEMCARGA*/
-- Entrae em Estoques 04 - CBCProjetos - Ctrl Cargas
-- Filiais 01/02/03
SELECT MAX(ZZ9_ORDCAR)
FROM ZZ9010
WHERE ZZ9_FILIAL = '02'
AND ZZ9_ORDCAR NOT LIKE 'SEM%'
AND ZZ9_ORDCAR NOT LIKE 'FIN%'
AND	D_E_L_E_T_ = ''

/*ALTERAR AS QUE FORAM GERADAS INCORRETAMENTE*/
/*ORDEM DE CARGA - EXISTENTES DEVEM SER FINABLQ E SEMCARGA*/
SELECT *
--UPDATE ZZ9010 SET ZZ9_ORDCAR = '00015184'
FROM ZZ9010
WHERE ZZ9_FILIAL In('01','02','03')
AND ZZ9_ORDCAR LIKE 'SEM%'
AND ZZ9_ORDCAR LIKE 'FIN%'
AND ZZ9_ORDCAR = 'SEMCARGB'
AND	D_E_L_E_T_ = ''


/*ORDENS AGLUTINADAS COMECAM COM OS*/
-- Entra em Estoques 04 / CBC WMS / Gerenciamento WMS
-- Somente Matriz 01
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
-- Entar em PCP 10 / Atualizações / Movimentações / Oredens de Produção 
-- Filiais 01/02 
SELECT MAX(C2_NUM)
FROM SC2010
WHERE C2_FILIAL = '02'
AND C2_NUM LIKE '0%'
AND C2_EMISSAO >= '20231201' --DATA ANTES DO RESET DO LICENSE (ULTIMO DIA COM A SEQ CORRETO)
AND D_E_L_E_T_ = ''


-- Clientes
-- Entrar em Cadastros de clientes e Alterar no CFG 
Select  Max(A1_COD) FROM SA1010
Where A1_COD Like ('04%') and D_E_L_E_T_ = ''
Order By 1


Select * From SA1010
Order By A1_COD