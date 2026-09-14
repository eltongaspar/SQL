/*#####################################################################
#
# CONFIGURADOR DE TRIBUTOS (CDT)
# SCRIPT DE ANÁLISE E AUDITORIA DE IMPOSTOS
#
# Objetivo:
# Conjunto de consultas para auditoria e validação das regras
# fiscais geradas pelo Configurador de Tributos (CDT).
#
# Permite analisar:
#
# ✓ Quantidade de regras fiscais
# ✓ Quantidade de regras financeiras
# ✓ Amarração Fornecedor x Produto
# ✓ Integridade entre SFT e CD2
# ✓ Duplicidades na CD2
# ✓ Registros sem geração tributária
# ✓ Resumo fiscal por CFOP e CST
# ✓ Resumo dos impostos calculados pelo CDT
#
# Tabelas envolvidas:
#
# F2B010 = Regras Fiscais
# FKK010 = Regras Financeiras
# SA5010 = Fornecedor x Produto
# SFT010 = Livro Fiscal
# CD2010 = Configurador de Tributos
#
# Aplicações:
#
# - Implantação CDT
# - Auditoria Tributária
# - Revisão de Parametrização
# - Suporte Fiscal
# - Validação Pós-Migração
# - Diagnóstico de Divergências
#
#####################################################################*/


/*====================================================================
1 - QUANTIDADE DE REGRAS DO CONFIGURADOR DE TRIBUTOS
======================================================================

Objetivo:
Levantar a quantidade total de regras cadastradas no ambiente.

F2B010 = Regras fiscais
FKK010 = Regras financeiras

Resultado esperado:
Uma linha contendo o total de regras de cada módulo.

====================================================================*/

SELECT
    F2B.REGRAS_FISCAIS,
    FKK.REGRAS_FINANCEIRAS
FROM
(
    SELECT COUNT(*) AS REGRAS_FISCAIS
    FROM F2B010
    WHERE D_E_L_E_T_ = ''
) F2B
CROSS JOIN
(
    SELECT COUNT(*) AS REGRAS_FINANCEIRAS
    FROM FKK010
    WHERE D_E_L_E_T_ = ''
) FKK;


/*====================================================================
2 - AMARRAÇÃO FORNECEDOR X PRODUTO
======================================================================

Objetivo:
Validar se existe vínculo entre fornecedor e produto.

Tabela:
SA5010

Campos:
A5_FORNECE = Fornecedor
A5_CODPRF  = Produto do fornecedor

Aplicação:
- Conferência de compras
- Formação tributária
- Integrações fornecedor x produto

====================================================================*/

SELECT *
FROM SA5010
WHERE A5_FORNECE = 28182508
  AND A5_CODPRF  = 14034
  AND D_E_L_E_T_ = '';


/*====================================================================
3 - COMPARATIVO ENTRE LIVRO FISCAL (SFT) E CDT (CD2)
======================================================================

Objetivo:
Comparar o volume de registros processados entre:

SFT010 = Livro Fiscal
CD2010 = Configurador de Tributos

A quantidade deve ser compatível após a geração dos impostos.

====================================================================*/

SELECT
    COUNT(*) AS QTD_SFT
FROM SFT010
WHERE D_E_L_E_T_ = ''
  AND FT_TES > '500';


SELECT
    COUNT(*) AS QTD_CD2
FROM CD2010
WHERE D_E_L_E_T_ = ''
  AND CD2_TPMOV = 'S';


/*====================================================================
4 - QUANTIDADE DE CHAVES ÚNICAS GERADAS NA CD2
======================================================================

Objetivo:
Verificar quantidade efetiva de combinações processadas
pelo Configurador de Tributos.

Chave considerada:
Filial + Documento + Série + Cliente + Loja + Produto

====================================================================*/

SELECT
    COUNT(
        DISTINCT CONCAT(
            CD2_FILIAL,'|',
            CD2_DOC,'|',
            CD2_SERIE,'|',
            CD2_CODCLI,'|',
            CD2_LOJCLI,'|',
            CD2_CODPRO
        )
    ) AS QTD_CHAVES_CD2
FROM CD2010
WHERE D_E_L_E_T_ = ''
  AND CD2_TPMOV = 'S';


/*====================================================================
5 - IDENTIFICAÇÃO DE DUPLICIDADES NA CD2
======================================================================

Objetivo:
Encontrar documentos que possuem mais de um registro
para a mesma chave de tributação.

Aplicação:
- Diagnóstico CDT
- Reprocessamentos
- Duplicidades tributárias

====================================================================*/

SELECT TOP 100

    CD2_FILIAL,
    CD2_DOC,
    CD2_SERIE,
    CD2_CODCLI,
    CD2_LOJCLI,
    CD2_CODPRO,

    COUNT(*) AS QTDE

FROM CD2010

WHERE D_E_L_E_T_ = ''
  AND CD2_TPMOV = 'S'

GROUP BY

    CD2_FILIAL,
    CD2_DOC,
    CD2_SERIE,
    CD2_CODCLI,
    CD2_LOJCLI,
    CD2_CODPRO

HAVING COUNT(*) > 1

ORDER BY QTDE DESC;


/*====================================================================
6 - REGISTROS DO LIVRO FISCAL SEM GERAÇÃO NO CDT
======================================================================

Objetivo:
Localizar operações que existem no Livro Fiscal
mas não possuem geração correspondente na CD2.

Resultado esperado:
Idealmente o retorno deve ser ZERO.

Se houver registros:
- Falha de processamento
- Parametrização incorreta
- Exclusão de registros
- Processamento incompleto

====================================================================*/

SELECT
    COUNT(*) AS SFT_SEM_CD2

FROM SFT010 SFT

WHERE SFT.D_E_L_E_T_ = ''
  AND SFT.FT_TES > '500'

  AND NOT EXISTS (

        SELECT 1

        FROM CD2010 CD2

        WHERE CD2.D_E_L_E_T_ = ''
          AND CD2.CD2_TPMOV = 'S'

          AND CD2.CD2_FILIAL = SFT.FT_FILIAL
          AND CD2.CD2_DOC    = SFT.FT_NFISCAL
          AND CD2.CD2_SERIE  = SFT.FT_SERIE
          AND CD2.CD2_CODCLI = SFT.FT_CLIEFOR
          AND CD2.CD2_LOJCLI = SFT.FT_LOJA
          AND CD2.CD2_CODPRO = SFT.FT_PRODUTO
);


/*====================================================================
7 - RESUMO FISCAL POR FILIAL / CFOP / CST
======================================================================

Objetivo:
Consolidar informações do Livro Fiscal por:

- Filial
- CFOP
- CST ICMS

Permite comparar posteriormente com os registros
tributários gerados na CD2.

====================================================================*/

SELECT

    FT_FILIAL,
    FT_CFOP,
    FT_CLASFIS,

    SUM(FT_QUANT)   AS QTDE,
    SUM(FT_VALCONT) AS VALOR

FROM SFT010

WHERE D_E_L_E_T_ = ''
  AND FT_TES > '500'

GROUP BY

    FT_FILIAL,
    FT_CFOP,
    FT_CLASFIS;


/*====================================================================
8 - RESUMO DOS IMPOSTOS GERADOS PELO CDT
======================================================================

Objetivo:
Identificar os impostos calculados pelo configurador.

Campos principais:

CD2_IMP     = Imposto
CD2_QTRIB   = Quantidade Tributável
CD2_VLTRIB  = Valor do Tributo

Aplicação:

✓ Conferência dos cálculos
✓ Auditoria tributária
✓ Comparação com Livro Fiscal
✓ Validação Reforma Tributária
✓ Validação IBS/CBS

====================================================================*/

SELECT

    CD2_FILIAL,

    CD2_IMP,

    COUNT(*) AS QTD_REGISTROS,

    SUM(CD2_QTRIB) AS QTDE_TRIBUTADA,

    SUM(CD2_VLTRIB) AS VALOR_IMPOSTO

FROM CD2010

WHERE D_E_L_E_T_ = ''
  AND CD2_TPMOV = 'S'

GROUP BY

    CD2_FILIAL,
    CD2_IMP;


/*====================================================================
CHECKLIST DE AUDITORIA CDT
======================================================================

[ ] Quantidade de regras fiscais carregadas

[ ] Quantidade de regras financeiras carregadas

[ ] Amarrações fornecedor x produto conferidas

[ ] Quantidade SFT compatível com CD2

[ ] Sem duplicidades na CD2

[ ] Sem registros SFT sem geração tributária

[ ] CFOPs analisados

[ ] CSTs analisados

[ ] Valores tributários conciliados

[ ] Impostos gerados conforme parametrização

======================================================================*/