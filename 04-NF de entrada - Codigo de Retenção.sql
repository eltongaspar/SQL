--O valor do código de retenção é preenchido na tabela SE2, campo E2_CODRET.

--SE2 - Contas a Pagar
SELECT E2_IRRF, E2_VRETIRF, E2_BASEIRF, E2_CODRET, * FROM SE2010 
WHERE E2_NUM='000085723' AND E2_FILORIG='BA11' AND E2_CODRET='3280' and D_E_L_E_T_ =''
--UPDATE SE2010 SET E2_CODRET='3280' WHERE E2_NUM='000085723' AND E2_FILORIG='BA11' AND E2_CODRET='3208'


-- Consular Livros Fiscais NF Cabeçalho e NF Itens
-- SFT - Livro Fiscal por Item de NF
Select FT_BASEIRR, FT_ALIQIRR, FT_VALIRR, * From SFT010
Where FT_FILIAL = 'BA11'and  FT_NFISCAL = '000085723' and D_E_L_E_T_=''

-- NF de Entrada - cabeçalho
Select F1_IRRF, F1_VALIRF, * From SF1010
Where F1_FILIAL = 'BA11' and F1_DOC = '000085723' and D_E_L_E_T_ ='' and D_E_L_E_T_ = ''

-- NF de Entrada - itens 
Select D1_BASEIRR, D1_ALIQIRR, D1_VALIRR, * From SD1010 
Where D1_FILIAL = 'BA11' and D1_DOC = '000085723' and D_E_L_E_T_ = '' and D_E_L_E_T_ = ''




