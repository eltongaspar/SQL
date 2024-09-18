Declare @FILIAL Char(4), @FILFIM Char(4), @PRODINI Char(10), @PRODFIM Char(10), 
@CLIINI Char(6), @CLIFIM Char(6), @LOJAINI Char(2),  @LOJAFIM Char(2) 
SET @FILIAL = 'AA01'
SET @FILFIM = 'ZZ99'
SET @PRODINI = '0000000000'
SET @PRODFIM = '9999999999'
SET @CLIINI = '000000'
SET @CLIFIM = '999999'
SET @LOJAINI = '01'
SET @LOJAFIM = '99'

Select ZZR_FILIAL FILIAL, COM.M0_FILIAL NOME_FILIAL, ZZR_CLIENT COD_CLIENTE, ZZR_LOJA LOJA ,
A1_NOME NOME_CLIENTE, ZZR_SEQUEN, ZZR_PRODUT, ZZR_DESCRI, ZZR_REQUIS, ZZR_ATIVO,
	
	Case ZZR_ATIVO
	When '1' Then 'SIM'
	Else 'NAO'
	End AS ATIVO

	From ZZR010 ZZR

	Inner Join SA1010 SA1 With(Nolock)
	On SA1.A1_COD = ZZR.ZZR_CLIENT 
	And SA1.A1_LOJA = ZZR.ZZR_LOJA
	And SA1.D_E_L_E_T_ =''

	Inner Join SYS_COMPANY COM With (Nolock)
	ON COM.M0_CODFIL = ZZR_FILIAL
	And COM.D_E_L_E_T_ =''

Where ZZR_FILIAL Between @FILIAL and @FILFIM and ZZR_CLIENT Between @CLIINI and @CLIFIM and 
ZZR_LOJA Between @LOJAINI and @LOJAFIM and ZZR_PRODUT Between @PRODINI and @PRODFIM
--And ZZR.D_E_L_E_T_ =''


-- ZZR - Especificação Produtos (Personalização)
-- Select * From ZZR010
-- SA1 - Clientes
-- Select * From SA1010
-- SYS_COMPANY - Empresas
-- Select * From SYS_COMPANY */
-- 




