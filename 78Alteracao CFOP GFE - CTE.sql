--- AJUSTE GFE - ENTRADA ERRADA CHAMADO LUCILENE DIA 05.12....PROTHEUS COLOCANDO CFOP 2352 PARA DENTRO DO ESTADO

--Livro Fiscal
SELECT * FROM SF3010 
WHERE F3_FILIAL='BA11' AND F3_NFISCAL IN ('000076731') AND D_E_L_E_T_='' AND F3_CFO='2352' AND F3_ENTRADA>='20210701'
--UPDATE SF3010 SET F3_CFO='1352' WHERE F3_FILIAL='AC01' AND F3_NFISCAL IN ('000068032','000068033') AND D_E_L_E_T_='' AND F3_CFO='2352' AND F3_ENTRADA>='20200701'

--Livro Fiscal Itens
SELECT * FROM SFT010 
WHERE FT_FILIAL='BA11' AND FT_NFISCAL IN ('000076731') AND D_E_L_E_T_='' AND FT_CFOP='2352' AND FT_ENTRADA>='20210701'
--UPDATE SFT010 SET  FT_CFOP='1352' WHERE FT_FILIAL='AC01' AND FT_NFISCAL IN ('000068032','000068033') AND D_E_L_E_T_='' AND FT_CFOP='2352' AND FT_ENTRADA>='20200701'

-- NF Entrada Itens
SELECT * FROM SD1010 
WHERE D1_FILIAL='BA11' AND D1_DOC IN ('000076731') AND D_E_L_E_T_='' AND D1_CF='2352' AND D1_EMISSAO >='20210701'
--UPDATE SD1010 SET D1_CF='1352' WHERE D1_FILIAL='AC01' AND D1_DOC IN ('000068032','000068033') AND D_E_L_E_T_='' AND D1_CF='2352' AND D1_EMISSAO >='20200701'


