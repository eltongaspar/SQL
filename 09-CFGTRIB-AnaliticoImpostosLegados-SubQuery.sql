/*#####################################################################
#
# ANÁLISE DETALHADA DE TRIBUTAÇÃO
# LIVRO FISCAL (SFT) X CONFIGURADOR DE TRIBUTOS (CD2)
#
# Objetivo:
# Validar os tributos gravados no Livro Fiscal (SFT)
# e comparar com os tributos calculados pelo
# Configurador de Tributos (CD2).
#
# Caso analisado:
#
# Nota Fiscal : 000106746
# Série        : 002
# Tipo Mov.    : Saída
#
# Aplicações:
#
# ✓ Auditoria Tributária
# ✓ Validação do CDT
# ✓ Conferência de CST
# ✓ Conferência de Alíquotas
# ✓ Homologação de Regras
# ✓ Diagnóstico de Tributação
# ✓ Reforma Tributária (IBS/CBS)
#
#####################################################################*/


/*====================================================================
1 - CONSULTA DO LIVRO FISCAL (SFT)
======================================================================

Objetivo:
Visualizar todos os dados fiscais gravados para a NF.

Principais informações consultadas:

- CFOP
- TES
- NCM
- CST ICMS
- CST PIS
- CST COFINS
- CST ISS
- CST IPI
- CSOSN
- Alíquotas
- DIFAL
- Chave da NF-e

Tabela:
SFT010 (Livro Fiscal)

====================================================================*/

SELECT

    /* Identificação da Nota Fiscal */
    FT_FILIAL,
    FT_NFISCAL,
    FT_SERIE,
    FT_CLIEFOR,
    FT_LOJA,

    /* Dados Fiscais */
    FT_CFOP,
    FT_TES,
    FT_TIPOMOV,
    FT_ITEM,

    /* ICMS */
    FT_ALIQICM,
    FT_CLASFIS,
    FT_CSOSN,
    FT_DIFAL,

    /* IPI */
    FT_ALIQIPI,
    FT_CTIPI,

    /* NCM */
    FT_POSIPI,

    /* PIS / COFINS */
    FT_ALIQPIS,
    FT_ALIQCOF,
    FT_CSTPIS,
    FT_CSTCOF,

    /* ISS */
    FT_ISSST,
    FT_CSTISS,
    FT_CFPS,

    /* Retenções */
    FT_ARETPIS,
    FT_ARETCOF,

    /* NF-e */
    FT_CHVNFE,

    /* Demais campos da tabela */
    *

FROM SFT010

WHERE FT_TIPOMOV = 'S'
  AND FT_NFISCAL = '000106746'
  AND FT_SERIE   = '002'
  AND D_E_L_E_T_ = ''

ORDER BY R_E_C_N_O_ DESC;



/*====================================================================
2 - CONSULTA DOS IMPOSTOS CALCULADOS PELO CDT
======================================================================

Objetivo:
Listar todos os tributos gerados pelo Configurador
de Tributos para a Nota Fiscal.

Tabela:
CD2010

Campos principais:

CD2_IMP    = Código do imposto
CD2_ORIGEM = Origem da regra tributária
CD2_CST    = CST calculado
CD2_BC     = Base de cálculo
CD2_ALIQ   = Alíquota aplicada
CD2_VLTRIB = Valor calculado
CD2_ADIF   = Alíquota DIFAL

====================================================================*/

SELECT

    CD2_ITEM,
    CD2_IMP,
    CD2_ORIGEM,
    CD2_CST,
    CD2_BC,
    CD2_ALIQ,
    CD2_VLTRIB,
    CD2_ADIF,

    /* Todos os campos do cálculo tributário */
    *

FROM CD2010

WHERE CD2_DOC   = '000106746'
  AND CD2_SERIE = '002'
  AND D_E_L_E_T_ = ''

ORDER BY CD2_ITEM;


/*====================================================================
3 - CONCILIAÇÃO SFT X CD2
======================================================================

Objetivo:
Apresentar lado a lado:

Livro Fiscal (SFT)
versus
Configuração Tributária (CD2)

Resultado:

Permite validar:

✓ CST gerado
✓ Alíquota calculada
✓ Regra aplicada
✓ Diferenças entre cadastro e cálculo

====================================================================*/

SELECT

    /* ==========================================================
       IDENTIFICAÇÃO DO DOCUMENTO
    ========================================================== */

    FT_FILIAL,
    FT_NFISCAL,
    FT_SERIE,
    FT_CLIEFOR,
    FT_LOJA,

    /* ==========================================================
       DADOS FISCAIS
    ========================================================== */

    FT_CFOP,
    FT_TES,
    FT_TIPOMOV,
    FT_ITEM,

    FT_CHVNFE,

    /* ==========================================================
       ICMS
    ========================================================== */

    FT_CLASFIS,
    FT_ALIQICM,
    FT_CSOSN,
    FT_DIFAL,

    /* ==========================================================
       IPI
    ========================================================== */

    FT_CTIPI,
    FT_ALIQIPI,

    /* ==========================================================
       NCM
    ========================================================== */

    FT_POSIPI,

    /* ==========================================================
       PIS / COFINS
    ========================================================== */

    FT_CSTPIS,
    FT_CSTCOF,

    FT_ALIQPIS,
    FT_ALIQCOF,

    FT_ARETPIS,
    FT_ARETCOF,

    /* ==========================================================
       ISS
    ========================================================== */

    FT_CSTISS,
    FT_CFPS,



    /*###########################################################
      ALÍQUOTAS CALCULADAS NO CDT
    ###########################################################*/

    /* PIS */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC    = SFT.FT_NFISCAL
          AND C.CD2_SERIE  = SFT.FT_SERIE
          AND C.CD2_ITEM   = SFT.FT_ITEM
          AND C.CD2_IMP    = 'PS2'
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_PIS_ALIQ,

    /* COFINS */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC    = SFT.FT_NFISCAL
          AND C.CD2_SERIE  = SFT.FT_SERIE
          AND C.CD2_ITEM   = SFT.FT_ITEM
          AND C.CD2_IMP    = 'CF2'
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_COF_ALIQ,

    /* ICMS */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC    = SFT.FT_NFISCAL
          AND C.CD2_SERIE  = SFT.FT_SERIE
          AND C.CD2_ITEM   = SFT.FT_ITEM
          AND C.CD2_IMP    = 'ICM'
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_ICM_ALIQ,

    /* ICMS Complementar */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_IMP = 'CMP'
          AND C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC = SFT.FT_NFISCAL
          AND C.CD2_SERIE = SFT.FT_SERIE
          AND C.CD2_ITEM = SFT.FT_ITEM
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_CMP_ALIQ,

    /* ICMS Solidário */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_IMP = 'SOL'
          AND C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC = SFT.FT_NFISCAL
          AND C.CD2_SERIE = SFT.FT_SERIE
          AND C.CD2_ITEM = SFT.FT_ITEM
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_SOL_ALIQ,

    /* IPI */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_IMP = 'IPI'
          AND C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC = SFT.FT_NFISCAL
          AND C.CD2_SERIE = SFT.FT_SERIE
          AND C.CD2_ITEM = SFT.FT_ITEM
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_IPI_ALIQ,

    /* CBS Federal */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_IMP = 'CBSFED'
          AND C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC = SFT.FT_NFISCAL
          AND C.CD2_SERIE = SFT.FT_SERIE
          AND C.CD2_ITEM = SFT.FT_ITEM
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_CBSFED_ALIQ,

    /* IBS Estadual */
    (
        SELECT TOP 1 C.CD2_ALIQ
        FROM CD2010 C
        WHERE C.CD2_IMP = 'IBSEST'
          AND C.CD2_FILIAL = SFT.FT_FILIAL
          AND C.CD2_DOC = SFT.FT_NFISCAL
          AND C.CD2_SERIE = SFT.FT_SERIE
          AND C.CD2_ITEM = SFT.FT_ITEM
          AND C.D_E_L_E_T_ = ''
    ) AS CD2_IBSEST_ALIQ,



    /*###########################################################
      CST GERADOS PELO CDT
    ###########################################################*/

    /* PIS */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'PS2'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_PIS_CST,

    /* COFINS */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'CF2'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_COF_CST,

    /* ICMS */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'ICM'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_ICM_CST,

    /* ICMS Complementar */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'CMP'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_CMP_CST,

    /* ICMS Solidário */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'SOL'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_SOL_CST,

    /* IPI */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'IPI'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_IPI_CST,

    /* CBS */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'CBSFED'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_CBSFED_CST,

    /* IBS */
    (
        SELECT TOP 1 C.CD2_CST
        FROM CD2010 C
        WHERE C.CD2_IMP = 'IBSEST'
        AND C.CD2_FILIAL = SFT.FT_FILIAL
        AND C.CD2_DOC = SFT.FT_NFISCAL
        AND C.CD2_SERIE = SFT.FT_SERIE
        AND C.CD2_ITEM = SFT.FT_ITEM
        AND C.D_E_L_E_T_ = ''
    ) AS CD2_IBSEST_CST

FROM SFT010 SFT

WHERE SFT.FT_TIPOMOV = 'S'
  AND SFT.FT_NFISCAL = '000106746'
  AND SFT.FT_SERIE   = '002'
  AND SFT.D_E_L_E_T_ = '';



/***********************************************************************
CHECKLIST DE VALIDAÇÃO

✓ CST ICMS SFT x CDT

✓ CST PIS SFT x CDT

✓ CST COFINS SFT x CDT

✓ CST IPI SFT x CDT

✓ Alíquota ICMS SFT x CDT

✓ Alíquota PIS SFT x CDT

✓ Alíquota COFINS SFT x CDT

✓ Alíquota IPI SFT x CDT

✓ Tributos IBS/CBS calculados

✓ Regras geradas pelo CDT

✓ Tributação efetivamente escriturada

Objetivo final:
Garantir que o cálculo realizado pelo Configurador
de Tributos seja exatamente o mesmo gravado
no Livro Fiscal.

***********************************************************************/