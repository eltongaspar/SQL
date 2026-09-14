/*#####################################################################
#
# ANÁLISE FISCAL - IMPOSTOS LEGADOS
# AGRUPAMENTO TRIBUTÁRIO POR NCM
#
# Objetivo:
# Realizar análise fiscal consolidada por NCM (Nomenclatura
# Comum do Mercosul), identificando os cenários tributários
# utilizados nas operações de saída.
#
# A consulta permite avaliar:
#
# - NCM utilizado
# - Código de serviço vinculado ao produto
# - Origem da mercadoria
# - CST ICMS
# - CST IPI
# - CST PIS
# - CST COFINS
# - CST ISS
# - Alíquotas utilizadas
# - Quantidade de notas fiscais
# - Quantidade de itens
# - Faixa de CFOP
# - Faixa de TES
# - Valor contábil movimentado
#
# Tabelas utilizadas:
#
# SD2010 = Itens da Nota Fiscal de Saída
# SFT010 = Livro Fiscal
# SB1010 = Cadastro de Produtos
#
# Aplicações:
#
# ✓ Auditoria Fiscal
# ✓ SPED Fiscal
# ✓ SPED Contribuições
# ✓ Mapeamento Tributário
# ✓ Revisão de NCM
# ✓ Revisão de CST
# ✓ Reforma Tributária (IBS/CBS)
#
#####################################################################*/

SELECT

    /* Ranking dos NCMs por valor movimentado */
    ROW_NUMBER() OVER (
        ORDER BY SUM(SFT.FT_VALCONT) DESC
    ) AS LINHA,

    /* NCM do produto */
    SB1.B1_POSIPI AS NCM,

    /* Código de serviço utilizado pelo produto */
    SB1.B1_CODISS AS COD_SERVICO,

    /* Quantidade total de itens encontrados */
    COUNT(*) AS QTDE_ITENS,

    /* Quantidade de notas fiscais distintas */
    COUNT(
        DISTINCT RTRIM(SFT.FT_FILIAL)
        + RTRIM(SFT.FT_SERIE)
        + RTRIM(SFT.FT_NFISCAL)
    ) AS QTDE_NF,

    /* Valor contábil total das operações */
    SUM(SFT.FT_VALCONT) AS VALOR_CONTABIL,

    /* Origem da mercadoria (primeiro dígito do CST ICMS) */
    SUBSTRING(SFT.FT_CLASFIS,1,1) AS ORIGEM_PRODUTO,

    /* Descrição da origem do produto */
    CASE SUBSTRING(SFT.FT_CLASFIS,1,1)

        WHEN '0' THEN 'Nacional'
        WHEN '1' THEN 'Importação Direta'
        WHEN '2' THEN 'Importação Mercado Interno'
        WHEN '3' THEN 'Nacional Conteúdo Importado <= 40%'
        WHEN '4' THEN 'Nacional PPB'
        WHEN '5' THEN 'Nacional Conteúdo Importado > 40% <= 70%'
        WHEN '6' THEN 'Importação Direta sem Similar Nacional'
        WHEN '7' THEN 'Importação Mercado Interno sem Similar Nacional'
        WHEN '8' THEN 'Nacional Conteúdo Importado > 70%'
        ELSE 'Não Informado'

    END AS DESC_ORIGEM,

    /* Últimos 2 dígitos do CST ICMS */
    SUBSTRING(SFT.FT_CLASFIS,2,2) AS CST_ICMS,

    /* CST dos demais tributos */
    SFT.FT_CTIPI  AS CST_IPI,
    SFT.FT_CSTPIS AS CST_PIS,
    SFT.FT_CSTCOF AS CST_COFINS,
    SFT.FT_CSTISS AS CST_ISS,

    /* Alíquotas efetivamente utilizadas */
    SFT.FT_ALIQICM AS ALIQ_ICMS,
    SFT.FT_ALIQIPI AS ALIQ_IPI,
    SFT.FT_ALIQPIS AS ALIQ_PIS,
    SFT.FT_ALIQCOF AS ALIQ_COFINS,
    SFT.FT_ALIQCSL AS ALIQ_CSLL,
    SFT.FT_ALIQINS AS ALIQ_INSS,
    SFT.FT_ALIQIRR AS ALIQ_IRRF,
    SD2.D2_ALIQISS AS ALIQ_ISS,

    /* Quantidade de CFOP utilizados para o NCM */
    COUNT(DISTINCT SFT.FT_CFOP) AS QTDE_CFOP,

    /* Menor CFOP encontrado */
    MIN(SFT.FT_CFOP) AS MENOR_CFOP,

    /* Maior CFOP encontrado */
    MAX(SFT.FT_CFOP) AS MAIOR_CFOP,

    /* Quantidade de TES encontrados */
    COUNT(DISTINCT SFT.FT_TES) AS QTDE_TES,

    /* Menor TES encontrado */
    MIN(SFT.FT_TES) AS MENOR_TES,

    /* Maior TES encontrado */
    MAX(SFT.FT_TES) AS MAIOR_TES

FROM SD2010 SD2

/* ==========================================================
   Relacionamento com Livro Fiscal

   Objetivo:
   Recuperar a tributação efetivamente gravada no Livro Fiscal
   correspondente ao item da Nota Fiscal.
========================================================== */
INNER JOIN SFT010 SFT
    ON SFT.FT_FILIAL  = SD2.D2_FILIAL
   AND SFT.FT_NFISCAL = SD2.D2_DOC
   AND SFT.FT_SERIE   = SD2.D2_SERIE
   AND SFT.FT_CLIEFOR = SD2.D2_CLIENTE
   AND SFT.FT_LOJA    = SD2.D2_LOJA
   AND SFT.FT_ITEM    = SD2.D2_ITEM

/* ==========================================================
   Cadastro do Produto

   Objetivo:
   Obter NCM e Código de Serviço cadastrados no produto.
========================================================== */
INNER JOIN SB1010 SB1
    ON SB1.B1_COD = SD2.D2_COD
   AND SB1.D_E_L_E_T_ = ''

WHERE

    /* Apenas registros ativos */
    SD2.D_E_L_E_T_ = ''
    AND SFT.D_E_L_E_T_ = ''

    /* Apenas operações de saída */
    AND SFT.FT_TES > '500'

    /* Período analisado */
    AND SFT.FT_EMISSAO >= '20250101'

GROUP BY

    /* Agrupamento tributário */
    SB1.B1_POSIPI,
    SB1.B1_CODISS,
    SUBSTRING(SFT.FT_CLASFIS,1,1),
    SUBSTRING(SFT.FT_CLASFIS,2,2),

    SFT.FT_CTIPI,
    SFT.FT_CSTPIS,
    SFT.FT_CSTCOF,
    SFT.FT_CSTISS,

    SFT.FT_ALIQICM,
    SFT.FT_ALIQIPI,
    SFT.FT_ALIQPIS,
    SFT.FT_ALIQCOF,
    SFT.FT_ALIQCSL,
    SFT.FT_ALIQINS,
    SFT.FT_ALIQIRR,

    SD2.D2_ALIQISS

ORDER BY

    /* Maior valor contábil primeiro */
    VALOR_CONTABIL DESC;


/***********************************************************************
ANÁLISE DOS RESULTADOS

A consulta permite identificar:

✓ Quais NCMs possuem maior faturamento

✓ Quais CSTs estão vinculados a cada NCM

✓ Quais alíquotas de ICMS, IPI, PIS e COFINS
  são utilizadas por classificação fiscal

✓ NCMs com múltiplos CFOPs

✓ NCMs com múltiplos TES

✓ Produtos classificados como serviço
  (B1_CODISS preenchido)

✓ Possíveis divergências fiscais de cadastro

✓ Impacto tributário por classificação fiscal

INDICADORES IMPORTANTES

QTDE_ITENS
    Quantidade total de itens vendidos.

QTDE_NF
    Quantidade de documentos fiscais.

VALOR_CONTABIL
    Valor total movimentado pelo NCM.

QTDE_CFOP
    Quantidade de CFOPs associados ao NCM.

QTDE_TES
    Quantidade de TES utilizados para o NCM.

QTDES elevadas de CFOP ou TES para um mesmo
NCM podem indicar necessidade de revisão da
parametrização tributária.

***********************************************************************/