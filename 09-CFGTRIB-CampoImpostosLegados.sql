/*#####################################################################
#
# DOCUMENTAÇÃO FISCAL E TRIBUTÁRIA - PROTHEUS
#
# Objetivo:
# Identificar os campos responsáveis pela definição da tributação
# em documentos de saída e nos Livros Fiscais.
#
# Tabelas analisadas:
# - SD2   : Itens da Nota Fiscal de Saída
# - SFT   : Itens do Livro Fiscal
# - SF3   : Livro Fiscal
#
# Utilização:
# - Auditoria tributária
# - Validação de TES
# - Conferência de impostos
# - Análise de CST, CFOP e NCM
# - Reforma Tributária (IBS/CBS)
#
#####################################################################*/


/*********************************************************************
* SD2 - ITENS DA NOTA FISCAL DE SAÍDA
**********************************************************************

Campos que determinam o cálculo tributário na emissão da NF.

D2_TES       = TES da operação
D2_CF        = CFOP da operação
D2_IPI       = Alíquota de IPI
D2_PICM      = Alíquota de ICMS
D2_TP        = Tipo do produto
D2_EST       = UF de destino
D2_TIPO      = Tipo da Nota Fiscal
D2_CODISS    = Código do serviço ISS
D2_ICMSRET   = Valor ICMS Solidário

Impostos Gerais:
D2_ALQIMP1   = Alíquota Imposto 1
D2_ALQIMP2   = Alíquota Imposto 2
D2_ALQIMP3   = Alíquota Imposto 3
D2_ALQIMP4   = Alíquota Imposto 4
D2_ALQIMP5   = Alíquota Imposto 5 (PIS)
D2_ALQIMP6   = Alíquota Imposto 6 (COFINS)

ISS:
D2_ALIQISS   = Alíquota ISS
D2_SERVIC    = Código do serviço
D2_CODISS    = Código ISS
D2_ALQCPM    = Alíquota ISS CPM

PIS / COFINS:
D2_ALQPIS    = Alíquota PIS
D2_ALQCOF    = Alíquota COFINS
D2_ALIQPS3   = PIS ST
D2_ALIQCF3   = COFINS ST

ICMS:
D2_SITTRIB   = Situação tributária
D2_ALIQSOL   = ICMS Solidário
D2_ALIQCMP   = ICMS Complementar
D2_DIFAL     = DIFAL
D2_PDORI     = Percentual Origem
D2_PDDES     = Percentual Destino
D2_ALFCPST   = FCP ST

Retenções:
D2_ALIQINS   = INSS
D2_ALQIRRF   = IRRF
D2_ALQCSL    = CSLL

Fundos e Contribuições:
D2_ALQFMP    = FUMIPEQ
D2_ALQFMD    = FAMAD
D2_ALIQFAB   = FABOV
D2_ALQFEEF   = FEEF-RJ
D2_ALIQFET   = FETHAB
D2_ALIQFUN   = FUNRURAL
D2_ALIQPRO   = PROTEGE-GO
D2_ALIFUND   = FUNDESA
D2_ALIIMA    = IMA-MT
D2_ALIFASE   = FASE-MT
D2_ALSENAR   = SENAR

*********************************************************************/


/*********************************************************************
* SFT - ITENS DO LIVRO FISCAL
**********************************************************************

Tabela responsável por armazenar os valores gravados no Livro Fiscal.

Identificação Fiscal:
FT_CFOP      = CFOP
FT_CODISS    = Código ISS
FT_POSIPI    = NCM
FT_TES       = TES

ICMS:
FT_ALIQICM   = Alíquota ICMS
FT_CLASFIS   = CST ICMS
FT_ALIQSOL   = ICMS Solidário
FT_ALQNDES   = ICMS ST Anterior
FT_PICEFET   = % ICMS Efetivo
FT_RICEFET   = % Redução ICMS Efetivo

IPI:
FT_ALIQIPI   = Alíquota IPI
FT_CTIPI     = CST IPI

PIS / COFINS:
FT_ALIQPIS   = Alíquota PIS
FT_ALIQCOF   = Alíquota COFINS
FT_CSTPIS    = CST PIS
FT_CSTCOF    = CST COFINS
FT_ALIQPS3   = PIS ST
FT_ALIQCF3   = COFINS ST
FT_MALQPIS   = PIS Majorado
FT_MALQCOF   = COFINS Majorado

Retenções:
FT_ARETPIS   = PIS Retido
FT_ARETCOF   = COFINS Retido
FT_ARETCSL   = CSLL Retida
FT_ALIQIRR   = IRRF
FT_ALIQINS   = INSS

ISS:
FT_CSTISS    = CST ISS
FT_ALQCPM    = ISS CPM

Fundos e Contribuições:
FT_ALQFECP   = FECP
FT_ALFCPST   = FCP ST
FT_AFCPANT   = FCP Anterior
FT_ALQFET    = FETHAB
FT_ALQFAB    = FABOV
FT_ALQFAC    = FACS
FT_ALQFUM    = FUMACOP
FT_ALQFMP    = FUMIPEQ
FT_ALQFMD    = FAMAD
FT_ALIQPRO   = PROTEGE-GO
FT_ALIQFUN   = FUNRURAL
FT_ALIFUND   = FUNDESA
FT_ALIIMA    = IMA-MT
FT_ALIFASE   = FASE-MT
FT_ALSENAR   = SENAR

DIFAL:
FT_PDORI     = Percentual Origem
FT_PDDES     = Percentual Destino

*********************************************************************/


/*********************************************************************
* SF3 - LIVRO FISCAL
**********************************************************************

Tabela consolidada utilizada na escrituração fiscal.

Identificação:
F3_CFO       = CFOP
F3_CODISS    = Código ISS
F3_ESPECIE   = Espécie do documento

ICMS:
F3_ALIQICM   = Alíquota ICMS

IPI:
F3_ALIQIPI   = Alíquota IPI

PIS / COFINS:
F3_CSTPIS    = CST PIS
F3_CSTCOF    = CST COFINS
F3_ALIQPS3   = PIS ST
F3_ALIQCF3   = COFINS ST
F3_MALQCOF   = COFINS Majorado

ISS:
F3_CSTISS    = Situação Tributária ISS
F3_ALQCPM    = ISS CPM
F3_TRIBMUN   = Código Tributação Municipal

Contribuições:
F3_ALIQCPB   = CPRB

DIFAL:
F3_BASEDES   = Base Difal Destino

*********************************************************************/


/*********************************************************************
* CONSULTA DOS CAMPOS DE IMPOSTOS - SFT
*********************************************************************/
SELECT
    FT_CFOP,
    FT_POSIPI,
    FT_CLASFIS,
    FT_CTIPI,
    FT_ALIQICM,
    FT_ALIQIPI,
    FT_ALIQPIS,
    FT_ALIQCOF,
    FT_CSTPIS,
    FT_CSTCOF,
    FT_ALIQSOL,
    FT_PDORI,
    FT_PDDES,
    FT_ALFCPST
FROM SFT010
WHERE D_E_L_E_T_ = '';



/*********************************************************************
* CONSULTA DOS CAMPOS DE IMPOSTOS - SD2
*********************************************************************/
SELECT
    D2_TES,
    D2_CF,
    D2_IPI,
    D2_PICM,
    D2_CODISS,
    D2_SITTRIB,
    D2_ALQPIS,
    D2_ALQCOF,
    D2_ALIQPS3,
    D2_ALIQCF3,
    D2_ALIQSOL,
    D2_DIFAL,
    D2_PDORI,
    D2_PDDES,
    D2_ALFCPST
FROM SD2010
WHERE D_E_L_E_T_ = '';



/*********************************************************************
* RELACIONAMENTO DAS TABELAS
**********************************************************************

SD2 → Origem da Venda
 ↓
SFT → Livro Fiscal (detalhado por item)
 ↓
SF3 → Consolidação Fiscal da Escrituração

Validação recomendada:
1. Conferir TES (SD2 x SFT)
2. Conferir CFOP (SD2 x SFT x SF3)
3. Conferir CST ICMS/IPI/PIS/COFINS
4. Conferir Alíquotas
5. Conferir NCM
6. Conferir DIFAL e FCP
7. Conferir tributos estaduais adicionais

*********************************************************************/