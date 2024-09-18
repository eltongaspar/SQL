Declare @CLIINI Char(6), @CLIFIM Char(6), @LOJAINI Char(4), @LOJAFIM Char(4), @PRODINI Char(10), @PRODFIM Char(10)

Set @CLIINI = '000001'
Set @CLIFIM = '999999'
Set @LOJAINI = '01'
Set @LOJAFIM = '99'
Set  @PRODINI = '0000000000'
Set @PRODFIM = '9999999999'

Select ZZR_CLIENT COD_CLIENTE, ZZR_LOJA LOJA ,
A1_NOME NOME_CLIENTE, ZZR_SEQUEN, ZZR_PRODUT, ZZR_DESCRI, ZZR_REQUIS, ZZR_REQNC,ZZR_EMISSA,ZZR_ATIVO,
	
	Case ZZR_ATIVO
	When '1' Then 'SIM'
	Else 'NAO'
	End AS ATIVO

	From ZZR010 ZZR


	-- Clientes
	Inner Join SA1010 SA1 With(Nolock)
	On SA1.A1_COD = ZZR.ZZR_CLIENT 
	And SA1.A1_LOJA = ZZR.ZZR_LOJA
	And SA1.D_E_L_E_T_ =''

Where ZZR_CLIENT Between @CLIINI and @CLIFIM and 
ZZR_LOJA Between @LOJAINI and @LOJAFIM and 
ZZR_PRODUT Between @PRODINI and @PRODFIM
And ZZR.D_E_L_E_T_ =''


-- ZZR - Especificação Produtos (Personalização)
-- SA1 - Clientes
-- SYS_COMPANY - Empresas

--Select * From ZZR010