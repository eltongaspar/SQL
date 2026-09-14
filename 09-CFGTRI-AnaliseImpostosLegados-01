/*#####################################################################
#
# ANÁLISE FISCAL - IMPOSTOS LEGADOS
#
# Objetivo:
# Analisar a tributação aplicada nas operações fiscais,
# agrupando informações por:
#
# - CFOP
# - CST ICMS
# - CST PIS
# - CST COFINS
# - Alíquotas
#
# Fonte Principal:
# SFT010 (Livro Fiscal)
#
# Tabela Auxiliar:
# SX5010 (Descrição dos CFOPs)
#
# Finalidade:
# - Auditoria fiscal
# - Mapeamento tributário
# - Diagnóstico de parametrizações
# - Identificação de combinações tributárias
# - Apoio a projetos de Reforma Tributária
#
#####################################################################*/

SELECT

    /* Sequência do ranking pela quantidade de registros */
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS LINHA,

    /* CFOP da operação */
    SFT.FT_CFOP,

    /* Descrição do CFOP */
    CFOP.X5_DESCRI AS DESC_CFOP,

    /* CST ICMS gravado no Livro Fiscal */
    SFT.FT_CLASFIS AS CST_ICMS,

    /* Tradução da Situação Tributária do ICMS */
    CASE SFT.FT_CLASFIS
        WHEN '00' THEN 'Tributada Integralmente'
        WHEN '10' THEN 'Tributada e com ICMS ST'
        WHEN '20' THEN 'Com Redução de Base'
        WHEN '30' THEN 'Isenta ou Não Tributada com ST'
        WHEN '40' THEN 'Isenta'
        WHEN '41' THEN 'Não Tributada'
        WHEN '50' THEN 'Suspensão'
        WHEN '51' THEN 'Diferimento'
        WHEN '60' THEN 'ICMS cobrado anteriormente por ST'
        WHEN '70' THEN 'Redução Base e ST'
        WHEN '90' THEN 'Outras'
        ELSE 'Não Identificado'
    END AS DESC_CST_ICMS,

    /* Alíquota de ICMS */
    SFT.FT_ALIQICM,

    /* CST PIS */
    SFT.FT_CSTPIS,

    /* Descrição CST PIS */
    CASE SFT.FT_CSTPIS
        WHEN '01' THEN 'Operação Tributável Alíquota Básica'
        WHEN '02' THEN 'Operação Tributável Alíquota Diferenciada'
        WHEN '03' THEN 'Tributação por Quantidade'
        WHEN '04' THEN 'Monofásica Alíquota Zero'
        WHEN '05' THEN 'Substituição Tributária'
        WHEN '06' THEN 'Alíquota Zero'
        WHEN '07' THEN 'Isenta'
        WHEN '08' THEN 'Sem Incidência'
        WHEN '09' THEN 'Suspensão'
        WHEN '49' THEN 'Outras Operações de Saída'
        WHEN '50' THEN 'Crédito Vinculado Receita Tributada'
        WHEN '51' THEN 'Crédito Vinculado Receita Não Tributada'
        WHEN '52' THEN 'Crédito Vinculado Exportação'
        WHEN '53' THEN 'Crédito Vinculado Receitas Mistas'
        WHEN '54' THEN 'Crédito Presumido'
        WHEN '55' THEN 'Aquisição com ST'
        WHEN '56' THEN 'Crédito Vinculado Receita Monofásica'
        WHEN '60' THEN 'Crédito Presumido ST'
        WHEN '98' THEN 'Outras Entradas'
        WHEN '99' THEN 'Outras Operações'
        ELSE 'Não Identificado'
    END AS DESC_CST_PIS,

    /* Alíquota do PIS */
    SFT.FT_ALIQPIS,

    /* CST COFINS */
    SFT.FT_CSTCOF,

    /* Descrição CST COFINS */
    CASE SFT.FT_CSTCOF
        WHEN '01' THEN 'Operação Tributável Alíquota Básica'
        WHEN '02' THEN 'Operação Tributável Alíquota Diferenciada'
        WHEN '03' THEN 'Tributação por Quantidade'
        WHEN '04' THEN 'Monofásica Alíquota Zero'
        WHEN '05' THEN 'Substituição Tributária'
        WHEN '06' THEN 'Alíquota Zero'
        WHEN '07' THEN 'Isenta'
        WHEN '08' THEN 'Sem Incidência'
        WHEN '09' THEN 'Suspensão'
        WHEN '49' THEN 'Outras Operações de Saída'
        WHEN '50' THEN 'Crédito Vinculado Receita Tributada'
        WHEN '51' THEN 'Crédito Vinculado Receita Não Tributada'
        WHEN '52' THEN 'Crédito Vinculado Exportação'
        WHEN '53' THEN 'Crédito Vinculado Receitas Mistas'
        WHEN '54' THEN 'Crédito Presumido'
        WHEN '55' THEN 'Aquisição com ST'
        WHEN '56' THEN 'Crédito Vinculado Receita Monofásica'
        WHEN '60' THEN 'Crédito Presumido ST'
        WHEN '98' THEN 'Outras Entradas'
        WHEN '99' THEN 'Outras Operações'
        ELSE 'Não Identificado'
    END AS DESC_CST_COFINS,

    /* Alíquota COFINS */
    SFT.FT_ALIQCOF,

    /* Alíquota IPI */
    SFT.FT_ALIQIPI,

    /* Quantidade de lançamentos encontrados */
    COUNT(*) AS QTD_REGISTROS,

    /* Quantidade distinta de clientes */
    COUNT(
        DISTINCT CONCAT(
            ISNULL(SFT.FT_CLIEFOR,''),
            ISNULL(SFT.FT_LOJA,'')
        )
    ) AS QTD_CLIENTES,

    /* Valor contábil total das operações */
    SUM(SFT.FT_VALCONT) AS VALOR_TOTAL

FROM SFT010 SFT

/* Busca descrição do CFOP na SX5 */
LEFT JOIN SX5010 CFOP
       ON CFOP.D_E_L_E_T_ = ''
      AND CFOP.X5_TABELA = '13'
      AND CFOP.X5_CHAVE = SFT.FT_CFOP

WHERE

    /* Apenas registros ativos */
    SFT.D_E_L_E_T_ = ''

    /* Considera operações de saída */
    AND SFT.FT_TES > '500'

    /* Período de análise */
    AND SFT.FT_EMISSAO >= '20250101'

GROUP BY

    /* Agrupamento tributário */
    SFT.FT_CFOP,
    CFOP.X5_DESCRI,
    SFT.FT_CLASFIS,
    SFT.FT_ALIQICM,
    SFT.FT_CSTPIS,
    SFT.FT_ALIQPIS,
    SFT.FT_CSTCOF,
    SFT.FT_ALIQCOF,
    SFT.FT_ALIQIPI

ORDER BY

    /* Maior volume de ocorrências */
    QTD_REGISTROS DESC;


/*********************************************************************
RESULTADO ESPERADO

A consulta permite identificar:

✓ CFOPs mais utilizados
✓ CST ICMS utilizados por operação
✓ CST PIS utilizados por operação
✓ CST COFINS utilizados por operação
✓ Alíquotas praticadas
✓ Quantidade de clientes atendidos
✓ Valor total movimentado
✓ Possíveis divergências tributárias

APLICAÇÃO

- Auditoria Fiscal
- SPED Fiscal
- SPED Contribuições
- EFD-Reinf
- Revisão de TES
- Mapeamento para IBS/CBS
- Diagnóstico de parametrização tributária

*********************************************************************/