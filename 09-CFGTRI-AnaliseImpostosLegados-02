/*#####################################################################
#
# ANÁLISE FISCAL - IMPOSTOS LEGADOS (VERSÃO 2)
#
# Objetivo:
# Mapear os cenários tributários existentes nas operações de
# saída, agrupando por:
#
# - CFOP
# - Origem do Produto
# - CST ICMS
# - CST PIS
# - CST COFINS
# - Alíquotas
#
# Adicionalmente apresenta indicadores de:
#
# - Quantidade de clientes
# - Quantidade de produtos
# - Quantidade de NCMs
# - Unidades de medida utilizadas
# - Quantidade movimentada
# - Valor contábil total
#
# Tabelas utilizadas:
#
# SFT010 = Livro Fiscal (base principal)
# SX5010 = Cadastro de CFOP
# SD2010 = Itens das Notas de Saída
# SB1010 = Cadastro de Produtos
#
# Aplicação:
#
# ✓ Auditoria Fiscal
# ✓ Revisão Tributária
# ✓ Análise de Cadastro
# ✓ Mapeamento para Reforma Tributária
# ✓ SPED Fiscal
# ✓ SPED Contribuições
#
#####################################################################*/

SELECT

    /* Ranking dos agrupamentos com maior ocorrência */
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS LINHA,

    /* CFOP da operação */
    SFT.FT_CFOP,

    /* Descrição do CFOP */
    CFOP.X5_DESCRI AS DESC_CFOP,

    /* Código CST completo gravado no Livro Fiscal */
    SFT.FT_CLASFIS AS CST_ICMS,

    /* Primeiro caractere do CST = Origem da Mercadoria */
    SUBSTRING(SFT.FT_CLASFIS,1,1) AS ORIGEM_PRODUTO,

    /* Tradução da origem da mercadoria */
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

    /* Últimos dois dígitos = Tributação do ICMS */
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

    /* Alíquota ICMS */
    SFT.FT_ALIQICM,

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

    /* Alíquota IPI */
    SFT.FT_ALIQIPI,

    /* Quantidade de registros fiscais encontrados */
    COUNT(*) AS QTD_REGISTROS,

    /* Quantidade de clientes distintos */
    COUNT(
        DISTINCT CONCAT(
            ISNULL(SFT.FT_CLIEFOR,''),
            ISNULL(SFT.FT_LOJA,'')
        )
    ) AS QTD_CLIENTES,

    /* Quantidade de produtos distintos */
    COUNT(DISTINCT SB1.B1_COD) AS QTD_PRODUTOS,

    /* Quantidade de NCMs distintos */
    COUNT(DISTINCT SB1.B1_POSIPI) AS QTD_NCMS,

    /* Quantidade de unidades de medida utilizadas */
    COUNT(DISTINCT SD2.D2_UM) AS QTD_UNIDADES_MEDIDA,

    /* Quantidade de segundas unidades utilizadas */
    COUNT(DISTINCT SD2.D2_SEGUM) AS QTD_SEGUNDA_UNIDADE,

    /* Quantidade total movimentada */
    SUM(SFT.FT_QUANT) AS QTDE_TOTAL,

    /* Valor contábil total do agrupamento */
    SUM(SFT.FT_VALCONT) AS VALOR_TOTAL

FROM SFT010 SFT

/* Busca descrição do CFOP na SX5 */
LEFT JOIN SX5010 CFOP
       ON CFOP.D_E_L_E_T_ = ''
      AND CFOP.X5_TABELA = '13'
      AND CFOP.X5_CHAVE  = SFT.FT_CFOP

/* Relaciona com o item da nota fiscal */
LEFT JOIN SD2010 SD2
       ON SD2.D_E_L_E_T_ = ''
      AND SD2.D2_DOC     = SFT.FT_NFISCAL
      AND SD2.D2_SERIE   = SFT.FT_SERIE
      AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR
      AND SD2.D2_LOJA    = SFT.FT_LOJA
      AND SD2.D2_COD     = SFT.FT_PRODUTO

/* Busca informações cadastrais do produto */
LEFT JOIN SB1010 SB1
       ON SB1.D_E_L_E_T_ = ''
      AND SB1.B1_COD = SD2.D2_COD

WHERE

      /* Apenas registros válidos */
      SFT.D_E_L_E_T_ = ''

      /* Somente operações de saída */
  AND SFT.FT_TES > '500'

      /* Período de análise */
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


/*#####################################################################
#
# CONSULTA AUXILIAR - EMPRESAS E FILIAIS DO AMBIENTE
#
# Objetivo:
# Identificar as empresas e filiais cadastradas para apoio
# em auditorias e validações fiscais.
#
# Campos principais:
#
# M0_CODIGO = Código da Empresa
# M0_CODFIL = Código da Filial
#
#####################################################################*/

SELECT *
FROM SYS_COMPANY;

/*
Utilizações:

✓ Identificar empresas existentes no ambiente
✓ Identificar filiais cadastradas
✓ Validar compartilhamento de dados
✓ Filtrar consultas fiscais por empresa/filial
✓ Conferir ambiente antes de auditorias

Exemplo:

Empresa: M0_CODIGO
Filial : M0_CODFIL
*/