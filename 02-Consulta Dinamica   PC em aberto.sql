-- Relatorio NF Entrada Analitico 

--Tabelas 
-- SC7 -- PC - Pedidos de Compras
-- Select * From SC7010

-- SD1 - NF entrada Itens 
--Select * From SD1010

-- SYS_COMPANY (COMPANY) - Empresas
--Select * FRom SYS_COMPANY

-- SB1 (Produto)
-- Select * From SB1010

-- SA2 (Fornecedores) - Fornece
--Select * From SA2010

-- CTT - Centro de Custo
-- Select * From CTT010

-- CT1 - Conta Contabil 
-- Select * From CT1010

-- Usuarios 
--Select * From SYS_USR 

Declare @Filial Varchar(04),  @DTIni Date, @DTFim Date, @CODUSER VARCHAR(6)

Set @Filial = 'BA01'
Set @DTIni = '20230101'
Set @DTFim = '20230425'
Set @CODUSER = '000079'

	
Select C7_USER,USR.USR_CODIGO, C7_FILIAL COD_FILIAL, COMPANY.M0_FILIAL NOME_FIL, C7_NUM, SD1.D1_DOC NF, C7_PRODUTO COD_PROD, SB1.B1_DESC DESC_PROD,
C7_FORNECE FORNECEDOR, SA2.A2_NOME, C7_CC, CTT_DESC01 CC_DESC, C7_OBS, C7_CONTA, CT1_DESC01, C7_QUJE QTDE_ENTREGUE, C7_QUANT QTDE_COMPRA,
C7_CONAPRO,

Case When C7_CONAPRO = 'L' Then 'LIBERADO' When C7_CONAPRO = 'B' Then 'BLOQUEADO' When C7_CONAPRO = 'R' Then 'REJEITADO' End As APROVADO,
CASE WHEN C7_QUJE=0 THEN 'EM ABERTO' WHEN (C7_QUANT> C7_QUJE) THEN 'PARC ATENDIDO' WHEN (C7_QUANT<= C7_QUJE) THEN 'ATENDIDO' END AS STATUS,
Case When C7_RESIDUO = '' Then 'NAO' When C7_RESIDUO = 'S' Then 'ELIMINADO' End As RESIDUO,
Case When C7_ENCER = '' Then 'NAO' When C7_ENCER = 'E' Then 'SIM' End As ENCERRADO

From SC7010 SC7

	-- Empresas
	Inner Join SYS_COMPANY COMPANY With(Nolock)
	ON COMPANY.M0_CODFIL = @Filial
	And COMPANY.D_E_L_E_T_ =''

	--Produtos 
	Inner Join SB1010 SB1 With(Nolock)
	ON SB1.B1_COD = SC7.C7_PRODUTO
	And SB1.D_E_L_E_T_ =''

	--Fornecedores 
	Inner Join SA2010 SA2 With(Nolock)
	ON SA2.A2_COD = SC7.C7_FORNECE
	And SA2.D_E_L_E_T_ =''
	
	--NF Entrada Itens 
	Left Join SD1010 SD1 With(Nolock)
	ON  SD1.D1_PEDIDO = SC7.C7_NUM
	And SD1.D_E_L_E_T_ =''

	--Centro de Custos CC
	Inner Join CTT010 CTT With(Nolock)
	ON  CTT.CTT_FILIAL = SC7.C7_FILIAL
	And CTT.CTT_CUSTO = SC7.C7_CC
	And CTT.D_E_L_E_T_ =''

	--Centro de Custos CC
	Inner Join CT1010 CT1 With(Nolock)
	ON CT1.CT1_CONTA = SC7.C7_CONTA
	And CT1.D_E_L_E_T_ =''

	--Usuarios
	Inner Join SYS_USR USR With(Nolock)
	ON USR.USR_ID = SC7.C7_USER
	And USR.D_E_L_E_T_ =''



Where C7_FILIAL = @Filial And C7_EMISSAO Between @DTIni and @DTFim and C7_USER = @CODUSER 
and C7_QUANT-C7_QUJE > '0' and C7_RESIDUO = '' and SC7.D_E_L_E_T_ = '' 


