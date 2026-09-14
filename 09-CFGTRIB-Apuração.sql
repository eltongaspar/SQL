/*==============================================================
 APURAÇÃO IBS/CBS - DOCUMENTOS DE SAÍDA

 Objetivo:
 Validar os tributos gerados nas notas fiscais de saída,
 relacionando os registros da nota (SD2) com as tabelas
 de apuração da Reforma Tributária (F2D, CJ3 e F2B).

 Tabelas:
 SD2010 = Itens da Nota Fiscal de Saída
 F2D010 = Tributos calculados por documento/item
 CJ3010 = Detalhamento do cálculo tributário
 F2B010 = Cadastro das Regras Tributárias

 Data de análise:
 14/11/2025

 Observação:
 A coluna BASE_IBSCBS calcula a base líquida:
 Valor Total - ICMS - PIS - COFINS
==============================================================*/

SELECT
    -- Identificação da NF
    D2_FILIAL,
    D2_DOC,
    D2_SERIE,

    -- Valores da operação
    D2_VALBRUT,
    D2_TOTAL,

    -- Tributos destacados
    D2_VALICM,
    D2_VALIMP5,   -- PIS
    D2_VALIMP6,   -- COFINS
    D2_VALIPI,

    -- Base estimada para IBS/CBS
    D2_TOTAL
        - D2_VALICM
        - D2_VALIMP5
        - D2_VALIMP6 AS BASE_IBSCBS,

    -- Resultado do cálculo tributário
    B.F2D_TRIB,
    F2D_BASE,
    F2D_ALIQ,
    F2D_VALOR,

    -- Detalhamento da composição do tributo
    C.CJ3_VLTRIB,
    CJ3_CST,
    CJ3_TRIB,
    CJ3_CCT,

    -- Descrição da regra tributária
    D.F2B_DESC

FROM SD2010 A

LEFT JOIN F2D010 B
    ON B.D_E_L_E_T_ = ''
   AND F2D_FILIAL = D2_FILIAL
   AND F2D_IDREL = D2_IDTRIB

LEFT JOIN CJ3010 C
    ON C.D_E_L_E_T_ = ''
   AND F2D_FILIAL = CJ3_FILIAL
   AND CJ3_IDF2D = F2D_ID

LEFT JOIN F2B010 D
    ON D.D_E_L_E_T_ = ''
   AND F2B_FILIAL = D2_FILIAL
   AND F2D_TRIB = F2B_REGRA
   AND F2B_ALTERA = '2'

WHERE D2_EMISSAO = '20251114';

/*==============================================================
 APURAÇÃO IBS/CBS - DOCUMENTOS DE ENTRADA

 Objetivo:
 Validar os tributos calculados nas notas fiscais de entrada,
 permitindo comparar a tributação aplicada às compras
 com as regras cadastradas no sistema.

 Tabelas:
 SD1010 = Itens da Nota Fiscal de Entrada
 F2D010 = Tributos calculados
 CJ3010 = Memória de cálculo tributária
 F2B010 = Cadastro das Regras Tributárias
==============================================================*/

SELECT

    -- Identificação da nota
    D1_FILIAL,
    D1_DOC,
    D1_SERIE,

    -- Valores da operação
    D1_TOTAL,
    D1_TOTAL,

    -- Tributos destacados
    D1_VALICM,
    D1_VALIMP5,   -- PIS
    D1_VALIMP6,   -- COFINS
    D1_VALIPI,

    -- Base estimada IBS/CBS
    D1_TOTAL
        - D1_VALICM
        - D1_VALIMP5
        - D1_VALIMP6 AS BASE_IBSCBS,

    -- Resultado da apuração
    B.F2D_TRIB,
    F2D_BASE,
    F2D_ALIQ,
    F2D_VALOR,

    -- Detalhamento do cálculo
    C.CJ3_VLTRIB,
    CJ3_CST,
    CJ3_TRIB,
    CJ3_CCT,

    -- Regra tributária aplicada
    D.F2B_DESC

FROM SD1010 A

LEFT JOIN F2D010 B
    ON B.D_E_L_E_T_ = ''
   AND F2D_FILIAL = D1_FILIAL
   AND F2D_IDREL = D1_IDTRIB

LEFT JOIN CJ3010 C
    ON C.D_E_L_E_T_ = ''
   AND F2D_FILIAL = D1_FILIAL
   AND CJ3_IDF2D = F2D_ID

LEFT JOIN F2B010 D
    ON D.D_E_L_E_T_ = ''
   AND F2B_FILIAL = D1_FILIAL
   AND F2D_TRIB = F2B_REGRA
   AND F2B_ALTERA = '2'

WHERE D1_EMISSAO = '20251114';

/*==============================================================
 RESUMO DOS TRIBUTOS IBS/CBS APURADOS

 Objetivo:
 Apresentar um resumo consolidado dos valores gerados
 por regra tributária em determinado período/data.

 Utilização:
 - Conferência da apuração da Reforma Tributária.
 - Comparação com os valores da nota fiscal.
 - Auditoria das regras cadastradas.

 Data analisada:
 20/12/2025
==============================================================*/

SELECT

    -- Código da regra tributária aplicada
    F2D_TRIB,

    -- Soma total apurada para a regra
    SUM(F2D_VALOR) AS F2D_VALOR,

    -- Descrição resumida da regra
    SUBSTRING(D.F2B_DESC,1,6) AS F2B_DESC

FROM SD2010 A

LEFT JOIN F2D010 B
    ON B.D_E_L_E_T_ = ''
   AND F2D_FILIAL = D2_FILIAL
   AND F2D_IDREL = D2_IDTRIB

LEFT JOIN CJ3010 C
    ON C.D_E_L_E_T_ = ''
   AND F2D_FILIAL = CJ3_FILIAL
   AND CJ3_IDF2D = F2D_ID

LEFT JOIN F2B010 D
    ON D.D_E_L_E_T_ = ''
   AND F2B_FILIAL = D2_FILIAL
   AND F2D_TRIB = F2B_REGRA
   AND F2B_ALTERA = '2'

WHERE D2_EMISSAO = '20251220'

GROUP BY
    F2D_TRIB,
    SUBSTRING(D.F2B_DESC,1,6);

/*
Resultado esperado:
- Código da regra tributária (F2D_TRIB)
- Descrição resumida da regra
- Valor total calculado para IBS/CBS

Aplicação:
Conferência rápida da tributação apurada após o
processamento das notas fiscais de saída.
*/