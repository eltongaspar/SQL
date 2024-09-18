-- Relatório de frotas
-- SD1 - NF Entrada - Itens 
-- SB1 - Cadastro de produtos
-- CTT - Centro de Custo
-- SNZ - Solicitacao Mobile
-- SA2 - Consulta Fornecedores
-- SX3 - Campos
-- SX2 - Tabelas
--SYS_COMPANY - Cadastro de Empresas / Filiais

--Script Original 
-- SELECT * FROM SD1010 WHERE D1_FILIAL='FE01' AND D1_ZZFROT='C-293' AND D1_DTDIGIT>='20200101' AND D_E_L_E_T_=''

-- Campos de várias tabelas que serão retornados na pesquisa com nomes de colunas
SELECT D1_FILIAL Filial, M0_FILIAL Nome_Filial, D1_ZZFROT Frota, ZN_PLACA Placa_Frota, ZN_MODELO Modelo,
D1_CC Cod_CC, CTT_DESC01 Desc_CC,
SUM (D1_TOTAL) Valor_NF_Total
	FROM SD1010 SD1
	    
		-- Produto
		Inner Join SB1010 SB1 With (NOLOCK)
		ON SB1.B1_COD = D1_COD
		and SB1.D_E_L_E_T_ = ''

		-- Centro de Custo
		Inner Join CTT010 CTT With (NOLOCK)
		On CTT.CTT_CUSTO = D1_CC
		and CTT.D_E_L_E_T_ =''

		-- Frota
		Inner Join SZN010 SZN With (NOLOCK)
		On SZN.ZN_FROTA = D1_ZZFROT
		and SZN.D_E_L_E_T_ =''

		-- Fornecedor
		Inner Join SA2010 SA2 With (NOLOCK)
		ON SA2.A2_COD = D1_FORNECE
		And SA2.A2_LOJA = D1_LOJA
		And SA2.D_E_L_E_T_ =''
		
		--Empresa
		Inner Join SYS_COMPANY SYS_COMPANY With (NOLOCK)
		On SYS_COMPANY.M0_CODFIL = D1_FILIAL
		And SYS_COMPANY.D_E_L_E_T_ =''

		--Ubudade de medida
		Inner Join SAH010 SAH With (NOLOCK)
		On AH_UNIMED = D1_UM
		And SAH.D_E_L_E_T_ =''


WHERE D1_FILIAL='FB02' AND D1_ZZFROT > '' AND D1_DTDIGIT Between '20200601'and '20220630' AND SD1.D_E_L_E_T_=''

Group By D1_FILIAL, M0_FILIAL, D1_ZZFROT, ZN_PLACA, ZN_MODELO, D1_CC, CTT_DESC01



-- Campos
--Select * From SX3010
--Where X3_CAMPO = 'D1_ZZFROT'

-- Tabelas 
--Select * From SX2010
--Where X2_CHAVE In ('SNZ','SX2','SX3')

-- Solicitacao Mobile
--Select * From SZN010

--Consulta Fornecedores
--SELECT * FROM SA2010 

--SYS_COMPANY - Cadastro de Empresas / Filiais
--Select * From SYS_COMPANY

-- Unidades de medidas
--Select * From SAH010
--

