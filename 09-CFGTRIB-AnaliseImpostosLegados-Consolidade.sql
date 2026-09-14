/*#####################################################################
#
# ANÁLISE FISCAL CONSOLIDADA MULTIEMPRESAS
# IMPOSTOS LEGADOS - LIVRO FISCAL (SFT)
#
# Objetivo:
# Consolidar informações tributárias de todas as empresas do
# grupo em uma única consulta, permitindo análise comparativa
# da tributação aplicada nas operações de saída.
#
# Empresas contempladas:
#
# 01 - COMPANHIA DISTR.DE GAS DO RIO DE JANEIRO
# 02 - CEG RIO S/A
# 03 - GAS NATURAL SAO PAULO SUL S.A.
# 04 - GAS NATURAL FENOSA ENGINEERING BRASIL SA
# 05 - GAS NATURAL SERVICOS S/A
#
# Tabelas utilizadas:
#
# SFT0x0 = Livro Fiscal
# SD20x0 = Itens da Nota Fiscal de Saída
# SB10x0 = Cadastro de Produtos
# SX50x0 = Cadastro de CFOP
# SYS_COMPANY = Empresas e Filiais
#
# Objetivos da análise:
#
# ✓ Comparar tributação entre empresas
# ✓ Identificar CFOPs utilizados
# ✓ Identificar CSTs utilizados
# ✓ Mapear alíquotas praticadas
# ✓ Levantar quantidade de clientes
# ✓ Levantar quantidade de produtos
# ✓ Levantar quantidade de NCMs
# ✓ Medir volume faturado
# ✓ Apoiar auditorias fiscais
# ✓ Apoiar projetos de Reforma Tributária
#
#####################################################################*/


/*********************************************************************
CAMPOS ANALISADOS
**********************************************************************

EMPRESA
    Empresa Protheus analisada.

NOME_COMERCIAL
    Razão comercial da empresa.

FT_FILIAL
    Filial da operação.

NOME_FILIAL
    Nome da filial obtido da SYS_COMPANY.

FT_CFOP
    Código Fiscal da Operação.

DESC_CFOP
    Descrição do CFOP.

FT_CLASFIS
    CST ICMS gravado no Livro Fiscal.

FT_ALIQICM
    Alíquota ICMS.

FT_CSTPIS
    CST PIS.

FT_ALIQPIS
    Alíquota PIS.

FT_CSTCOF
    CST COFINS.

FT_ALIQCOF
    Alíquota COFINS.

FT_ALIQIPI
    Alíquota IPI.

QTD_REGISTROS
    Quantidade de lançamentos fiscais.

QTD_CLIENTES
    Quantidade de clientes distintos.

QTD_PRODUTOS
    Quantidade de produtos distintos.

QTD_NCMS
    Quantidade de NCMs distintos.

QTD_UNIDADES_MEDIDA
    Quantidade de unidades de medida utilizadas.

QTD_SEGUNDA_UNIDADE
    Quantidade de segundas unidades utilizadas.

QTDE_TOTAL
    Quantidade física movimentada.

VALOR_TOTAL
    Valor contábil movimentado.

*********************************************************************/


/*********************************************************************
FILTROS UTILIZADOS
**********************************************************************

SFT.D_E_L_E_T_ = ''
    Apenas registros ativos.

FT_TES > '500'
    Considera apenas operações de saída.

FT_EMISSAO >= '20250101'
    Considera movimentações a partir de 01/01/2025.

*********************************************************************/


/*********************************************************************
RELACIONAMENTOS
**********************************************************************

SFT
 ↓
SD2
 ↓
SB1

SFT → Dados fiscais gravados no Livro Fiscal.

SD2 → Dados originais da Nota Fiscal.

SB1 → Informações cadastrais dos produtos e NCM.

SX5 → Descrição dos CFOPs.

SYS_COMPANY → Nome das filiais.

*********************************************************************/


/*********************************************************************
RESULTADOS ESPERADOS
**********************************************************************

A consulta permite identificar:

✓ Qual empresa possui maior volume fiscal.

✓ Quais CFOPs são mais utilizados.

✓ Quais CSTs estão sendo utilizados.

✓ Quais alíquotas estão sendo praticadas.

✓ Distribuição dos NCMs por empresa.

✓ Distribuição de clientes por empresa.

✓ Empresas com maior quantidade de itens fiscais.

✓ Possíveis divergências de parametrização tributária.

✓ Cenários tributários que devem ser avaliados
  para migração ao IBS/CBS.

*********************************************************************/


/*********************************************************************
ANÁLISES RECOMENDADAS APÓS EXECUÇÃO
**********************************************************************

1. Agrupar por EMPRESA
   Identificar diferenças tributárias entre empresas.

2. Agrupar por CFOP
   Verificar consistência operacional.

3. Agrupar por CST ICMS
   Validar parametrizações de ICMS.

4. Agrupar por CST PIS
   Validar SPED Contribuições.

5. Agrupar por CST COFINS
   Validar SPED Contribuições.

6. Analisar NCMs
   Identificar classificações críticas.

7. Comparar alíquotas
   Detectar possíveis inconsistências.

8. Revisar empresas com:
   - Muitos CSTs
   - Muitos CFOPs
   - Muitos NCMs
   - Muitos clientes

*********************************************************************/


/*********************************************************************
OBSERVAÇÃO DE PERFORMANCE
**********************************************************************

A consulta realiza:

- 5 consultas SFT
- 5 consultas SD2
- 5 consultas SB1
- 5 consultas SX5

utilizando UNION ALL.

Em bases grandes recomenda-se:

✓ Criar índices em:
    FT_NFISCAL
    FT_SERIE
    FT_CLIEFOR
    FT_LOJA
    FT_PRODUTO

✓ Executar por período menor quando necessário.

✓ Utilizar filtros por empresa durante auditorias.

*********************************************************************/


/*********************************************************************
CHECKLIST DE AUDITORIA
**********************************************************************

[ ] Todas as empresas retornaram registros

[ ] Todas as filiais estão identificadas

[ ] CFOPs revisados

[ ] CST ICMS revisados

[ ] CST PIS revisados

[ ] CST COFINS revisados

[ ] Alíquotas revisadas

[ ] NCMs revisados

[ ] Clientes revisados

[ ] Produtos revisados

[ ] Indicadores consolidados

[ ] Impacto Reforma Tributária avaliado

*********************************************************************/