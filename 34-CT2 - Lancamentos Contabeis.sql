--CT2 - Lancamentos Contabeis
Select CT2_DOC, CT2_LINHA, CT2_VALOR, CT2_HIST, * From CT2010
Where CT2_FILIAL = 'BA03' and CT2_LOTE = '008820' and CT2_DATA > '20211221' and CT2_DOC = '000042' and D_E_L_E_T_ = ''

--Where CT2_FILIAL = 'BA03' and CT2_LOTE = '008820' and CT2_DATA = '20211222' and CT2_HIST LIKE '%000047143%' and D_E_L_E_T_ = ''

--Order By CT2_LINHA
