/*#####################################################################
#
# ANÁLISE FISCAL - IMPOSTOS LEGADOS (VERSÃO 2)
#
# Objetivo:
# Consolidar e analisar a tributação das operações de saída
# registradas no Livro Fiscal (SFT), permitindo identificar
# as combinações tributárias utilizadas por:
#
# - CFOP
# - Origem do Produto
# - CST ICMS
# - CST PIS
# - CST COFINS
# - Alíquotas dos tributos
#
# Além disso, apresentar indicadores operacionais como:
#
# ✓ Quantidade de Clientes
# ✓ Quantidade de Produtos
# ✓ Quantidade de NCMs
# ✓ Quantidade de Unidades de Medida
# ✓ Quantidade Total Movimentada
# ✓ Valor Total Faturado
#
# Tabelas Utilizadas:
#
# SFT010 = Livro Fiscal
# SD2010 = Itens da Nota Fiscal de Saída
# SB1010 = Cadastro de Produtos
# SX5010 = Cadastro de CFOP
#
# Aplicações:
#
# - Auditoria Fiscal
# - Revisão Tributária
# - SPED Fiscal
# - SPED Contribuições
# - Análise de NCM
# - Revisão de TES
# - Mapeamento para IBS/CBS
#
#####################################################################*/

SELECT

    /* Ranking dos agrupamentos com maior quantidade de registros */
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS LINHA,

    /*=========================================================
      CFOP
    =========================================================*/

    SFT.FT_CFOP,

    /* Descrição do CFOP obtida da SX5 */
    CFOP.X5_DESCRI AS DESC_CFOP,

    /*=========================================================
      ICMS
    =========================================================*/

    /* CST completo gravado no Livro Fiscal */
    SFT.FT_CLASFIS AS CST_ICMS,

    /* Primeiro dígito = Origem da Mercadoria */
    SUBSTRING(SFT.FT_CLASFIS,1,1) AS ORIGEM_PRODUTO,

    /* Descrição da Origem da Mercadoria */
    CASE SUBSTRING(SFT.FT_CLASFIS,1,1)
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

    /* Últimos dois dígitos = CST de Tributação do ICMS */
    RIGHT(SFT.FT_CLASFIS,2) AS CST_TRIBUTACAO_ICMS,

    /* Descrição do CST ICMS */
    CASE RIGHT(SFT.FT_CLASFIS,2)
        WHEN '00' THEN 'Tributada Integralmente'
        WHEN '10' THEN 'Tributada e com ICMS ST'
        WHEN '20' THEN 'Com Reducao de Base'
        WHEN '30' THEN 'Isenta ou Nao Tributada com ST'
        WHEN '40' THEN 'Isenta'
        WHEN '41' THEN 'Nao Tributada'
        WHEN '50' THEN 'Suspensao'
        WHEN '51' THEN 'Diferimento'
        WHEN '60' THEN 'ICMS ST Recolhido Anteriormente'
        WHEN '70' THEN 'Reducao de Base e ST'
        WHEN '90' THEN 'Outras'
        ELSE 'Nao Identificado'
    END AS DESC_CST_ICMS,

    /* Alíquota ICMS utilizada */
    SFT.FT_ALIQICM,

    /*=========================================================
      PIS
    =========================================================*/

    /* CST PIS */
    SFT.FT_CSTPIS,

    /* Descrição CST PIS */
    CASE SFT.FT_CSTPIS
        WHEN '01' THEN 'Aliquota Basica'
        WHEN '02' THEN 'Aliquota Diferenciada'
        WHEN '03' THEN 'Tributacao por Quantidade'
        WHEN '04' THEN 'Monofasica'
        WHEN '05' THEN 'Substituicao Tributaria'
        WHEN '06' THEN 'Aliquota Zero'
        WHEN '07' THEN 'Isenta'
        WHEN '08' THEN 'Sem Incidencia'
        WHEN '09' THEN 'Suspensao'
        WHEN '49' THEN 'Outras Operacoes'
        WHEN '99' THEN 'Outras Operacoes'
        ELSE 'Nao Identificado'
    END AS DESC_CST_PIS,

    /* Alíquota PIS */
    SFT.FT_ALIQPIS,

    /*=========================================================
      COFINS
    =========================================================*/

    /* CST COFINS */
    SFT.FT_CSTCOF,

    /* Descrição CST COFINS */
    CASE SFT.FT_CSTCOF
        WHEN '01' THEN 'Aliquota Basica'
        WHEN '02' THEN 'Aliquota Diferenciada'
        WHEN '03' THEN 'Tributacao por Quantidade'
        WHEN '04' THEN 'Monofasica'
        WHEN '05' THEN 'Substituicao Tributaria'
        WHEN '06' THEN 'Aliquota Zero'
        WHEN '07' THEN 'Isenta'
        WHEN '08' THEN 'Sem Incidencia'
        WHEN '09' THEN 'Suspensao'
        WHEN '49' THEN 'Outras Operacoes'
        WHEN '99' THEN 'Outras Operacoes'
        ELSE 'Nao Identificado'
    END AS DESC_CST_COFINS,

    /* Alíquota COFINS */
    SFT.FT_ALIQCOF,

    /*=========================================================
      IPI
    =========================================================*/

    /* Alíquota IPI */
    SFT.FT_ALIQIPI,

    /*=========================================================
      INDICADORES DE VOLUME
    =========================================================*/

    /* Quantidade de registros fiscais */
    COUNT(*) AS QTD_REGISTROS,

    /* Quantidade de Clientes distintos */
    COUNT(
        DISTINCT CONCAT(
            ISNULL(SFT.FT_CLIEFOR,''),
            ISNULL(SFT.FT_LOJA,'')
        )
    ) AS QTD_CLIENTES,

    /* Quantidade de Produtos distintos */
    COUNT(DISTINCT SB1.B1_COD) AS QTD_PRODUTOS,

    /* Quantidade de NCMs distintos */
    COUNT(DISTINCT SB1.B1_POSIPI) AS QTD_NCMS,

    /* Quantidade de Unidades de Medida */
    COUNT(DISTINCT SD2.D2_UM) AS QTD_UNIDADES_MEDIDA,

    /* Quantidade de Segunda Unidade */
    COUNT(DISTINCT SD2.D2_SEGUM) AS QTD_SEGUNDA_UNIDADE,

    /* Quantidade total movimentada */
    SUM(SFT.FT_QUANT) AS QTDE_TOTAL,

    /* Valor contábil total */
    SUM(SFT.FT_VALCONT) AS VALOR_TOTAL

FROM SFT010 SFT

/*=========================================================
  Busca descrição do CFOP
=========================================================*/
LEFT JOIN SX5010 CFOP
       ON CFOP.D_E_L_E_T_ = ''
      AND CFOP.X5_TABELA = '13'
      AND CFOP.X5_CHAVE  = SFT.FT_CFOP

/*=========================================================
  Relaciona Item da Nota Fiscal
=========================================================*/
LEFT JOIN SD2010 SD2
       ON SD2.D_E_L_E_T_ = ''
      AND SD2.D2_DOC     = SFT.FT_NFISCAL
      AND SD2.D2_SERIE   = SFT.FT_SERIE
      AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR
      AND SD2.D2_LOJA    = SFT.FT_LOJA
      AND SD2.D2_COD     = SFT.FT_PRODUTO

/*=========================================================
  Cadastro de Produtos
=========================================================*/
LEFT JOIN SB1010 SB1
       ON SB1.D_E_L_E_T_ = ''
      AND SB1.B1_COD = SD2.D2_COD

WHERE

      /* Apenas registros ativos */
      SFT.D_E_L_E_T_ = ''

      /* Apenas operações de saída */
  AND SFT.FT_TES > '500'

      /* Período analisado */
  AND SFT.FT_EMISSAO >= '20250101'

GROUP BY

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
    QTD_REGISTROS DESC;

/*********************************************************************
RESULTADO ESPERADO

A consulta permite identificar:

✓ Quais CFOPs possuem maior utilização

✓ Quais origens de mercadoria estão sendo utilizadas

✓ Quais CSTs ICMS estão associados às operações

✓ Quais CSTs PIS e COFINS estão sendo utilizados

✓ Quais alíquotas estão sendo praticadas

✓ Quantidade de clientes atendidos

✓ Quantidade de produtos movimentados

✓ Quantidade de NCMs envolvidos

✓ Quantidade total faturada

✓ Possíveis divergências tributárias

ANÁLISES RECOMENDADAS

1. CST ICMS diferentes para o mesmo CFOP
2. Alíquotas diferentes para o mesmo CST
3. NCM com múltiplas tributações
4. CFOP com excesso de CSTs
5. Produtos com tributação inconsistente
6. Preparação para migração IBS/CBS

*********************************************************************/