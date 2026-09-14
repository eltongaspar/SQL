/*#####################################################################
#
# ANÁLISE FISCAL DE IMPOSTOS LEGADOS
# COMPARATIVO SFT x CD2 x SD2 x SF4
#
# Objetivo:
# Comparar as informações tributárias existentes entre:
#
# SFT010 = Livro Fiscal
# CD2010 = Configurador de Tributos
# SD2010 = Itens da NF de Saída
# SF4010 = Cadastro TES
# SX5010 = Cadastro CFOP
# SYS_COMPANY = Empresas e Filiais
#
# A consulta permite validar:
#
# ✓ CFOP
# ✓ TES
# ✓ CST ICMS
# ✓ CST IPI
# ✓ CST PIS
# ✓ CST COFINS
# ✓ CST ISS
# ✓ CSOSN
# ✓ NCM
# ✓ Alíquotas
# ✓ DIFAL
# ✓ ICMS Complementar
# ✓ ICMS Solidário
# ✓ CBS
# ✓ IBS
# ✓ Parametrização do TES
#
# Fluxo da validação:
#
# SD2 (Item da NF)
#      ↓
# SF4 (TES)
#      ↓
# CD2 (Configurador de Tributos)
#      ↓
# SFT (Livro Fiscal)
#
# Filtro atual:
#
# Nota Fiscal : 000106746
# Série        : 002
#
#####################################################################*/


SELECT

    /* Ranking dos registros retornados */
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS LINHA,

    /*=========================================================
      EMPRESA / FILIAL
    =========================================================*/

    '01' AS COD_EMPRESA,
    'COMPANHIA DISTR.DE GAS DO RIO DE JANEIRO' AS EMPRESA,

    FT_FILIAL,
    SC.M0_FILIAL AS NOME_FILIAL,

    /*=========================================================
      IDENTIFICAÇÃO DO DOCUMENTO
    =========================================================*/

    FT_NFISCAL,
    FT_SERIE,
    FT_ITEM,

    FT_CLIEFOR,
    FT_LOJA,

    FT_CHVNFE,

    /*=========================================================
      DADOS FISCAIS DA OPERAÇÃO
    =========================================================*/

    FT_CFOP,
    CFOP.X5_DESCRI AS DESC_CFOP,

    FT_TIPOMOV,
    FT_CFPS,
    FT_TES,
    FT_POSIPI,

    /*=========================================================
      PARAMETRIZAÇÃO TES (SF4)
    =========================================================*/

    F4_CF,
    F4_TEXTO,
    F4_FINALID,

    /*=========================================================
      ITEM DA NOTA (SD2)
    =========================================================*/

    D2_TES,
    D2_CF,

    /*=========================================================
      ORIGEM DA MERCADORIA
    =========================================================*/

    CASE SUBSTRING(SFT.FT_CLASFIS, 1, 1)
        WHEN '0' THEN 'Nacional'
        WHEN '1' THEN 'Estrangeira - Importacao Direta'
        WHEN '2' THEN 'Estrangeira - Adquirida Mercado Interno'
        WHEN '3' THEN 'Nacional - Conteudo Importacao Superior 40%'
        WHEN '4' THEN 'Nacional - Processo Produtivo Basico'
        WHEN '5' THEN 'Nacional - Conteudo Importacao Menor ou Igual 40%'
        WHEN '6' THEN 'Estrangeira - Importacao Direta Sem Similar'
        WHEN '7' THEN 'Estrangeira - Mercado Interno Sem Similar'
        WHEN '8' THEN 'Nacional - Conteudo Importacao Superior 70%'
        ELSE 'Nao Identificada'
    END AS DESC_ORIGEM_PRODUTO,

    /*=========================================================
      PIS
    =========================================================*/

    FT_ALIQPIS,
    MAX(CASE WHEN CD2.CD2_IMP = 'PS2'
             THEN CD2.CD2_ALIQ END) AS CD2_PIS_ALIQ,

    D2_ALQPIS,

    F4_PISCOF,
    FT_ARETPIS,

    FT_CSTPIS,

    MAX(CASE WHEN CD2.CD2_IMP = 'PS2'
             THEN CD2.CD2_CST END) AS CD2_PIS_CST,

    F4_CSTPIS,
    F4_BASEPIS,

    /*=========================================================
      COFINS
    =========================================================*/

    FT_ALIQCOF,

    MAX(CASE WHEN CD2.CD2_IMP = 'CF2'
             THEN CD2.CD2_ALIQ END) AS CD2_COF_ALIQ,

    D2_ALQCOF,

    FT_ARETCOF,

    FT_CSTCOF,

    MAX(CASE WHEN CD2.CD2_IMP = 'CF2'
             THEN CD2.CD2_CST END) AS CD2_COF_CST,

    F4_CSTCOF,
    F4_BASECOF,

    /*=========================================================
      ICMS
    =========================================================*/

    FT_ALIQICM,

    MAX(CASE WHEN CD2.CD2_IMP = 'ICM'
             THEN CD2.CD2_ALIQ END) AS CD2_ICM_ALIQ,

    F4_ICM,
    D2_PICM,

    FT_CLASFIS,

    MAX(CASE WHEN CD2.CD2_IMP = 'ICM'
             THEN CD2.CD2_CST END) AS CD2_ICM_CST,

    F4_SITTRIB,
    D2_SITTRIB,

    /*=========================================================
      ICMS COMPLEMENTAR / DIFAL
    =========================================================*/

    FT_DIFAL,

    MAX(CASE WHEN CD2.CD2_IMP = 'CMP'
             THEN CD2.CD2_ALIQ END) AS CD2_CMP_ALIQ,

    MAX(CASE WHEN CD2.CD2_IMP = 'SOL'
             THEN CD2.CD2_ALIQ END) AS CD2_SOL_ALIQ,

    MAX(CASE WHEN CD2.CD2_IMP = 'CMP'
             THEN CD2.CD2_CST END) AS CD2_CMP_CST,

    MAX(CASE WHEN CD2.CD2_IMP = 'SOL'
             THEN CD2.CD2_CST END) AS CD2_SOL_CST,

    F4_BASEICM,
    F4_COMPL,
    F4_BSICMST,
    F4_PICMDIF,
    F4_DIFAL,

    D2_ICMSRET,
    D2_ALIQSOL,
    D2_ALIQCMP,
    D2_DIFAL,
    D2_PDORI,
    D2_PDDES,

    /*=========================================================
      IPI
    =========================================================*/

    FT_ALIQIPI,

    MAX(CASE WHEN CD2.CD2_IMP = 'IPI'
             THEN CD2.CD2_ALIQ END) AS CD2_IPI_ALIQ,

    D2_IPI,
    F4_IPI,

    FT_CTIPI,

    MAX(CASE WHEN CD2.CD2_IMP = 'IPI'
             THEN CD2.CD2_CST END) AS CD2_IPI_CST,

    F4_CTIPI,
    F4_BASEIPI,

    /*=========================================================
      ISS
    =========================================================*/

    FT_ISSST,

    MAX(CASE WHEN CD2.CD2_IMP = 'ISS'
             THEN CD2.CD2_ALIQ END) AS CD2_ISS_ALIQ,

    F4_ISS,
    D2_ALIQISS,

    FT_CSOSN,
    F4_CSOSN,

    FT_CSTISS,

    MAX(CASE WHEN CD2.CD2_IMP = 'ISS'
             THEN CD2.CD2_CST END) AS CD2_ISS_CST,

    F4_CSTISS,
    D2_CODISS,

    F4_BASEISS,
    F4_RETISS,

    /*=========================================================
      REFORMA TRIBUTÁRIA
    =========================================================*/

    MAX(CASE WHEN CD2.CD2_IMP = 'CBSFED'
             THEN CD2.CD2_ALIQ END) AS CD2_CBSFED_ALIQ,

    MAX(CASE WHEN CD2.CD2_IMP = 'IBSEST'
             THEN CD2.CD2_ALIQ END) AS CD2_IBSEST_ALIQ,

    MAX(CASE WHEN CD2.CD2_IMP = 'CBSFED'
             THEN CD2.CD2_CST END) AS CD2_CBSFED_CST,

    MAX(CASE WHEN CD2.CD2_IMP = 'IBSEST'
             THEN CD2.CD2_CST END) AS CD2_IBSEST_CST,

    /*=========================================================
      CONFIGURAÇÕES DO TES
    =========================================================*/

    F4_LFICM,
    F4_LFIPI,
    F4_DESTACA,
    F4_INCIDE,
    F4_INCSOL,
    F4_DESPIPI,
    F4_TPIPI,
    F4_STDESC

FROM SFT010 SFT

/* CDT */
LEFT JOIN CD2010 CD2
    ON SFT.FT_FILIAL  = CD2.CD2_FILIAL
   AND SFT.FT_NFISCAL = CD2.CD2_DOC
   AND SFT.FT_SERIE   = CD2.CD2_SERIE
   AND SFT.FT_ITEM    = CD2.CD2_ITEM
   AND CD2.D_E_L_E_T_ = ''

/* TES */
INNER JOIN SF4010 SF4
    ON SF4.F4_FILIAL = SFT.FT_FILIAL
   AND SF4.F4_CODIGO = SFT.FT_TES
   AND SF4.D_E_L_E_T_ = ''

/* Item da NF */
INNER JOIN SD2010 SD2
    ON SFT.FT_FILIAL  = SD2.D2_FILIAL
   AND SFT.FT_NFISCAL = SD2.D2_DOC
   AND SFT.FT_SERIE   = SD2.D2_SERIE
   AND SFT.FT_CLIEFOR = SD2.D2_CLIENTE
   AND SFT.FT_LOJA    = SD2.D2_LOJA
   AND SFT.FT_ITEM    = SD2.D2_ITEM
   AND SD2.D_E_L_E_T_ = ''

/* Cadastro de CFOP */
LEFT JOIN SX5010 CFOP
    ON CFOP.X5_TABELA = '13'
   AND CFOP.X5_CHAVE  = SFT.FT_CFOP
   AND CFOP.D_E_L_E_T_ = ''

/* Empresa / Filial */
LEFT JOIN SYS_COMPANY SC
    ON SC.M0_CODIGO = '01'
   AND LTRIM(RTRIM(SC.M0_CODFIL))
       = LTRIM(RTRIM(SFT.FT_FILIAL))

WHERE
      SFT.FT_NFISCAL = '000106746'
  AND SFT.FT_SERIE   = '002'
  AND SFT.D_E_L_E_T_ = ''

/* manter GROUP BY original completo */
GROUP BY
    -- campos originais da query
    FT_FILIAL,
    FT_NFISCAL,
    FT_SERIE,
    FT_ITEM,
    FT_CLIEFOR,
    FT_LOJA,
    FT_CFOP,
    FT_TIPOMOV,
    FT_CHVNFE,
    FT_CFPS,
    FT_TES,
    FT_POSIPI,
    SC.M0_FILIAL,
    CFOP.X5_DESCRI,
    F4_CF,
    F4_TEXTO,
    F4_FINALID,
    D2_TES,
    D2_CF
;