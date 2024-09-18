-- Data 
Declare @DATAINI Date
Set @DATAINI = '20230324'

-- Contadopr de NF - Saida
Select F2_FILIAL,Count (F2_DOC) AS NF_SAIDA_QTDE_TOTAL From SF2010
Where F2_EMISSAO >= @DATAINI and D_E_L_E_T_=''
Group By F2_FILIAL
Order By 1

Select Count (F2_DOC) AS NF_SAIDA_QTDE_TOTAL_GERAL From SF2010
Where F2_EMISSAO >= @DATAINI and D_E_L_E_T_=''

--Soma NF Saida 
Select F2_FILIAL,Sum (F2_VALBRUT) AS NF_SAIDA_VLR_TOTAL From SF2010
Where F2_EMISSAO >= @DATAINI and D_E_L_E_T_=''
Group By F2_FILIAL
Order By 1

Select Sum (F2_VALBRUT) AS NF_SAIDA_VLR_TOTAL_GERAL From SF2010
Where F2_EMISSAO >= @DATAINI and D_E_L_E_T_=''


-- Contador de NF - Entrada
Select F1_FILIAL,Count (F1_DOC) AS NF_ENT_QTDE_TOTAL From SF1010 With (NoLock)
Where F1_EMISSAO >= @DATAINI and D_E_L_E_T_=''
Group By F1_FILIAL
Order By 1

Select Count (F1_DOC) AS NF_ENT_QTDE_TOTAL From SF1010 With (NoLock)
Where F1_EMISSAO >= @DATAINI and D_E_L_E_T_='' 

--Soma NF Entrada
Select F1_FILIAL,Sum (F1_VALBRUT) AS NF_ENT_TOTAL From SF1010 With (NoLock)
Where F1_EMISSAO >= @DATAINI and D_E_L_E_T_=''
Group By F1_FILIAL
Order By 1

Select Sum (F1_VALBRUT) AS NF_ENT_TOTAL From SF1010 With (NoLock)
Where F1_EMISSAO >= @DATAINI and D_E_L_E_T_=''

--Consulta Tabela NF Entrada Conexão NFe
--ZC1 - Cabecalho XML                 
Select ZC1_DTCRIA, ZC1_HRCRIA, ZC1_CGCEMI, ZC1_EMIT, ZC1_DOC, * From ZC1010 With (NoLock)
Where ZC1_DTCRIA >= @DATAINI and ZC1_HRCRIA >= '00:00:00' and D_E_L_E_T_=''
Order By 1,2 Desc

-- Contador NF Enrada  por Filial 
Select ZC1_FILIAL, Count (ZC1_DOC) NF_ENT_QTDE_CNFe From ZC1010 With (NoLock)
Where ZC1_DTCRIA >= @DATAINI and ZC1_HRCRIA >= '00:00:00' and D_E_L_E_T_=''
Group By ZC1_FILIAL

--Contador NF Entrada Geral  
Select Count (ZC1_DOC) NF_ENT_QTDE_CNFe  From ZC1010 With (NoLock)
Where ZC1_DTCRIA >= @DATAINI and ZC1_HRCRIA >= '00:00:00' and D_E_L_E_T_=''


-- Somador NF Enrada  por Filial 
Select ZC1_FILIAL, SUM (ZC1_TOTVAL) TNF_ENT_TOTAL_CNFe  From ZC1010 With (NoLock)
Where ZC1_DTCRIA >= @DATAINI and ZC1_HRCRIA >= '00:00:00' and D_E_L_E_T_=''
Group By ZC1_FILIAL

--Somador NF Entrada Geral  
Select SUM (ZC1_TOTVAL) NF_ENT_VLR_CNFe  From ZC1010 With (NoLock)
Where ZC1_DTCRIA >= @DATAINI and ZC1_HRCRIA >= '00:00:00' and D_E_L_E_T_=''


                                                 
--Processamento de NF TSS
--Select * From TSSTR1



SELECT 'SAIDA' AS TIPO,F2_FILIAL, F2_DOC, F2_CHVNFE, F2_EST FROM SF2010 (NOLOCK) WHERE F2_EMISSAO='20221128' AND D_E_L_E_T_=''
UNION ALL
SELECT 'ENTRADA' AS TIPO,F1_FILIAL, F1_DOC, F1_CHVNFE, F1_EST FROM SF1010 (NOLOCK) WHERE F1_EMISSAO='20221128' AND D_E_L_E_T_='' AND F1_FORMUL='S'
ORDER BY 1,2,3