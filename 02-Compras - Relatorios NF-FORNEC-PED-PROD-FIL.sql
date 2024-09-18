-- Relatorio NF Entrada Analitico 

--Tabelas 
-- SD1 - NF entrada Itens 
--Select * From SD1010

-- SYS_COMPANY (COMPANY) - Empresas
--Select * FRom SYS_COMPANY

-- SB1 (Produto)
-- Select * From SB1010

-- SA2 (Fornecedores) - Fornece
--Select * From SA2010

Declare @Filial Varchar(04), @Fornec Varchar(06), @DTIni Date, @DTFim Date

Set @Filial = 'BA01'
Set @Fornec = '000044'
Set @DTIni = '20220601'
Set @DTFim = '20220630'

	
Select D1_FILIAL COD_FILIAL, COMPANY.M0_FILIAL NOME_FIL, D1_PEDIDO PED, D1_DOC NF, D1_COD COD_PROD, SB1.B1_DESC DESC_PROD,
D1_FORNECE FORNECEDOR, SA2.A2_NOME,
* From SD1010 SD1

	-- Empresas
	Inner Join SYS_COMPANY COMPANY With(Nolock)
	ON COMPANY.M0_CODFIL = @Filial
	And COMPANY.D_E_L_E_T_ =''

	--Produtos 
	Inner Join SB1010 SB1 With(Nolock)
	ON SB1.B1_COD = SD1.D1_COD
	And SB1.D_E_L_E_T_ =''

	--Fornecedores 
	Inner Join SA2010 SA2 With(Nolock)
	ON SA2.A2_COD = D1_FORNECE
	And SA2.D_E_L_E_T_ =''

Where D1_FILIAL = @Filial And D1_DTDIGIT Between @DTIni and @DTFim and D1_FORNECE = @Fornec and SD1.D_E_L_E_T_ = ''


