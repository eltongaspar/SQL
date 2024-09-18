/*--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, F1_ESPECIE, F1_IRRF, F1_VALIRF, * From SF1010
Where F1_FILIAL = 'BA01' and F1_IRRF > '0' and F1_VALIRF > ('0') and D_E_L_E_T_=''

/*
F1_IRRF	Imp. Renda	Imposto de Renda
F1_VALIRF	IRRF Ret	Valor do IRRF Retido
*/

--SE2 - Contas a Pagar
Select E2_VALOR, E2_DIRF, E2_PRETIRF, E2_VRETIRF, E2_DTDIRF, E2_BASEIRF,E2_NUMTIT, * From SE2010
Where E2_FILORIG= 'BA01' and E2_BASEIRF > '0' and E2_VRETIRF > '0' and D_E_L_E_T_ = '' 

/*
E2_IRRF	IRRF	Valor do IRRF
E2_PARCIR	Parc. IRF	Parcela do IRF
E2_NUMTIT	Tit IRRF Off	Nro Titulo IR off line
E2_DIRF	Gera Dirf	Gera Dirf para este tit?
E2_PRETIRF	Pend.Ret IRF	Pendente de Retencao - IR
E2_VRETIRF	Valor Rt. IR	Valor Retido - IRRF
E2_DTDIRF	Dt Ger. Dirf	Data de Geracao da Dirf
E2_BASEIRF	Base IRRF	Base IRRF
*/*/

--NF Entrada Cab.
Select  SF1.F1_FILIAL,SYS_COMPANY.M0_FILIAL,SF1.F1_FORNECE, SF1.F1_LOJA,SA2.A2_CGC, SA2.A2_NOME, SF1.F1_ESPECIE,
SF1.F1_IRRF, SF1.F1_VALIRF,
SE2.E2_VALOR,
SF1.F1_DOC,SE2.E2_NUM,SF1.F1_DUPL, SE2.E2_TITPAI, SF1.F1_ESPECIE, SF1.F1_TIPO, SE2.E2_TIPO,
SF1.F1_COND, SE4.E4_DESCRI,SF1.F1_EMISSAO, SF1.F1_DTLANC, SE2.E2_HIST, SF1.D_E_L_E_T_  From SF1010 SF1

	--SE2 - Contas a Pagar
	Inner Join SE2010 SE2 With (Nolock)
	ON SE2.E2_NUM = SF1.F1_DOC
	And SE2.E2_VALOR = SF1.F1_VALIRF
	And SE2.D_E_L_E_T_ =''

	--Empresa
	Inner Join SYS_COMPANY SYS_COMPANY With (NOLOCK)
	On SYS_COMPANY.M0_CODFIL = SF1.F1_FILIAL
	And SYS_COMPANY.D_E_L_E_T_ =''

	-- Fornecedor
	Inner Join SA2010 SA2 With (NOLOCK)
	ON SA2.A2_COD = SF1.F1_FORNECE
	And SA2.A2_LOJA = SF1.F1_LOJA
	And SA2.D_E_L_E_T_ =''
	

	-- Condição de Pagamento
		Inner Join SE4010 SE4 With (NOLOCK)
	ON SE4.E4_CODIGO = SF1.F1_COND
	And SA2.D_E_L_E_T_ =''

Where SF1.F1_FILIAL <> '' and SF1.F1_IRRF > '0' and SF1.F1_VALIRF > ('0') and SF1.D_E_L_E_T_=''
And SF1.F1_DTDIGIT >= '20230101' And SE2.E2_TIPO = 'TX'

-- Tabelas 
-- SF1 - NF Entrada Cab.
-- SE2 - Conras a Pagar 
-- SA2 - Fornecedor
-- SE4 - Cond. de pagamento
-- SYS_COMPANY - Empresa


--Sum 
--NF Entrada Cab.
Select  SF1.F1_FILIAL,SYS_COMPANY.M0_FILIAL,SF1.F1_FORNECE, SF1.F1_LOJA,SA2.A2_CGC, SA2.A2_NOME, 
SUM (SE2.E2_VALOR) TOTAL_IRPF_RETIDO From SF1010 SF1

	--SE2 - Contas a Pagar
	Inner Join SE2010 SE2 With (Nolock)
	ON SE2.E2_NUM = SF1.F1_DOC
	And SE2.E2_VALOR = SF1.F1_VALIRF
	And SE2.D_E_L_E_T_ =''

	--Empresa
	Inner Join SYS_COMPANY SYS_COMPANY With (NOLOCK)
	On SYS_COMPANY.M0_CODFIL = SF1.F1_FILIAL
	And SYS_COMPANY.D_E_L_E_T_ =''

	-- Fornecedor
	Inner Join SA2010 SA2 With (NOLOCK)
	ON SA2.A2_COD = SF1.F1_FORNECE
	And SA2.A2_LOJA = SF1.F1_LOJA
	And SA2.D_E_L_E_T_ =''
	

	-- Condição de Pagamento
		Inner Join SE4010 SE4 With (NOLOCK)
	ON SE4.E4_CODIGO = SF1.F1_COND
	And SA2.D_E_L_E_T_ =''

Where SF1.F1_FILIAL <> '' and SF1.F1_IRRF > '0' and SF1.F1_VALIRF > ('0') and SF1.D_E_L_E_T_=''
And SF1.F1_DTDIGIT >= '20220101' And SE2.E2_TIPO = 'TX'
Group By SF1.F1_FILIAL,SYS_COMPANY.M0_FILIAL,SF1.F1_FORNECE, SF1.F1_LOJA,SA2.A2_CGC, SA2.A2_NOME
Order By 1


-- Sum Geral
--Sum 
--NF Entrada Cab.
Select  SF1.F1_FILIAL,SYS_COMPANY.M0_FILIAL,SUM (SE2.E2_VALOR) TOTAL_IRPF_RETIDO
From SF1010 SF1

	--SE2 - Contas a Pagar
	Inner Join SE2010 SE2 With (Nolock)
	ON SE2.E2_NUM = SF1.F1_DOC
	And SE2.E2_VALOR = SF1.F1_VALIRF
	And SE2.D_E_L_E_T_ =''

	--Empresa
	Inner Join SYS_COMPANY SYS_COMPANY With (NOLOCK)
	On SYS_COMPANY.M0_CODFIL = SF1.F1_FILIAL
	And SYS_COMPANY.D_E_L_E_T_ =''

	-- Fornecedor
	Inner Join SA2010 SA2 With (NOLOCK)
	ON SA2.A2_COD = SF1.F1_FORNECE
	And SA2.A2_LOJA = SF1.F1_LOJA
	And SA2.D_E_L_E_T_ =''
	

	-- Condição de Pagamento
		Inner Join SE4010 SE4 With (NOLOCK)
	ON SE4.E4_CODIGO = SF1.F1_COND
	And SA2.D_E_L_E_T_ =''

Where SF1.F1_FILIAL <> '' and SF1.F1_IRRF > '0' and SF1.F1_VALIRF > ('0') and SF1.D_E_L_E_T_=''
And SF1.F1_DTDIGIT >= '20220101' And SE2.E2_TIPO = 'TX'
Group By SF1.F1_FILIAL,SYS_COMPANY.M0_FILIAL
Order By 1