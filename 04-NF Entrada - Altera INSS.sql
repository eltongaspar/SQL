-- INSS - NF de Entrada

--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, F1_INSS, F1_BASEINS, F1_VALINA, F1_BASEINA,  * From SF1010
Where F1_FILIAL = 'DB01' and F1_DOC ='000050076' and D_E_L_E_T_=''

--F1_INSS	Valor INSS	Valor do INSS
--F1_BASEINS	Base de INSS	Base de calculo do INSS
--F1_VALINA	Vlr INSS Ad	Valor do INSS Condicoes E
--F1_BASEINA	Base INSS Ad	Base do INSS Condicoes Es


--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC,D1_BASEINS, D1_ALIQINS,D1_VALINS,   * From SD1010
Where D1_FILIAL ='DB01' and D1_DOC = '000050076' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20220101'


--D1_BASEINS	Base de INSS	Base de calculo do INSS	N
--D1_ALIQINS	Aliq. INSS	Aliquota de INSS	
--D1_VALINS	Vlr. do INSS	Valor do INSS


--SF3 - Livros Fiscais
SELECT F3_PERCINP, F3_VALINP, F3_BASEINP,  * FROM SF3010 
WHERE F3_FILIAL='DB01' AND F3_NFISCAL IN ('000050076')
-- LIMPA INSS
--Não encontrado INSS 
-- Outros Campos INSS - F3_PERCINP F3_VALINP F3_BASEINP

--SFT - Livro Fiscal por Item de NF
SELECT FT_BASEINS, FT_ALIQINS, FT_VALINS, * FROM SFT010 
WHERE FT_FILIAL='DB01' AND FT_NFISCAL IN ('000050076')  

-- LIMPA INSS
-- FT_BASEINS   Base INSS	Base de INSS 
--FT_ALIQINS	Aliq. INSS	Aliquota de INSS
--FT_VALINS     Valor INSS	Valor do INSS
-- Outros impostos 
--FT_VALINP	Val.INSS.Pt	Valor do INSS Patronal	
--FT_PERCINP	Perc.INSS.Pt	Percent. do INSS Patronal
--FT_BASEINP	Bas.INSS.Pt	Base do INSS Patronal

--SE1 - Contas a Receber
SELECT  E1_INSS, E1_BASEINS, * FROM SE1010 
WHERE E1_FILORIG='DB01' AND E1_NUM IN ('000050076')  
-- LIMPA INSS
-- E1_INSS E1_BASEINSS
--Outros
--E1_PRINSS

-- SE2 - Contas a Pagar
SELECT D_E_L_E_T_,E2_FILIAL, E2_TIPO,E2_NUM,E2_VALOR,E2_INSS,E2_PARCINS,E2_INSSRET,E2_PRINSS,E2_RETINS,E2_VRETINS,E2_PRETINS,E2_BASEINS,E2_CODINS,  * FROM SE2010 
WHERE E2_FILORIG='DB01' AND E2_NUM IN ('000050076')   
---APAGAR
-- Apagar titulo

--E2_INSS	INSS	Valor do INSS
--E2_PARCINS	Parc. INSS	Parcela do INSS
--E2_INSSRET	INSS Retido	INSS Retido
--E2_PRINSS	Prov INSS	Provisao de - INSS	
--E2_RETINS	Ret. INSS	Codigo de Retencao INSS
--E2_VRETINS	Vlr Ret INSS	Valor Retido INSS
--E2_PRETINS	Pend.Rt.INSS	Pendente Retencao - INSS
--E2_BASEINS	Base INSS	Base INSS
--E2_CODINS	Cod Ret INSS	Cod Retencao INSS