-- 84 - REINF - IRRF 

-- NF Entrada Cab.
Select F1_CHVNFE,F1_DTDIGIT,F1_EMISSAO,A2_NOME,A2_CGC,F1_IRRF,F1_BASEIR,F1_VALIRF,
X5_DESCRI,F1_ESPECIE,F1_TIPO,

Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,
	--N = NF Normal C = Compl. Preco D = Devolucao I = NF Compl. ICMS P = NF Compl. IPI B = NF Beneficiamento

* From SF1010 SF1
	
	Inner Join SA2010 SA2
	On F1_FORNECE = A2_COD
	And F1_LOJA = A2_LOJA
	and SA2.D_E_L_E_T_ = ''

	
	Inner Join SX5010 SX5
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

Where F1_FORNECE In ('VOP070') --and F1_DOC In ('00000031')
And F1_DTDIGIT Between '20231001' and '20231031'
and SF1.D_E_L_E_T_ = ''

-- Fornecedores 
Select * From SA2010
Where A2_CGC = '19850613000146'

-- NF Entrada Itens 
Select D1_BASEIRR,D1_VALIRR,D1_ALIQIRR,* From SD1010
Where D1_FORNECE = 'VOP070' and D1_DOC In ('00000165','00000166')
and D_E_L_E_T_ = ''

-- Contas a Pagar
Select E2_SALDO,E2_BAIXA,E2_IRRF,E2_VRETIRF,E2_BASEIRF,E2_TIPO, X5_DESCRI,
E2_NATUREZ,ED_DESCRIC,
* From SE2010 SE2

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E2_FILIAL
	And E2_TIPO = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''

		-- Natureza Financeiras
	Inner Join SED010 SED
	On ED_CODIGO = E2_NATUREZ
	And SED.D_E_L_E_T_ = ''

Where E2_FORNECE iN ('VOP070','MUNIC','UNIAO') AND E2_NUM IN ('00000163','00000165','00000166','164')
And E2_FILIAL In ('02')
And E2_EMISSAO Between '20231001' and '20231031'
--And E2_TIPO In ('TX','NF','FT','ISS','TXA')
and SE2.D_E_L_E_T_ = ''
Order By E2_NUM



Select E2_SALDO,E2_BAIXA,E2_IRRF,E2_VRETIRF,E2_BASEIRF,E2_TIPO,X5_DESCRI,
E2_NATUREZ,ED_DESCRIC,
* From SE2010 SE2

	--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E2_FILIAL
	And E2_TIPO = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''
	
	-- Natureza Financeiras
	Inner Join SED010 SED
	On ED_CODIGO = E2_NATUREZ
	And SED.D_E_L_E_T_ = ''
	
Where E2_FORNECE iN ('VOP070','MUNIC','UNIAO') AND E2_TIPO IN ('PA')	
And E2_EMISSAO Between '20230101' and '20231031'
and SE2.D_E_L_E_T_ = ''

-- Mov. Bancaria 
Select E5_TIPODOC,X5_DESCRI,E5_NATUREZ,ED_DESCRIC,
* From SE5010 SE5
		--Genericas 
	Inner Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E5_FILIAL
	And E5_TIPODOC = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''

	-- Natureza Financeiras
	Inner Join SED010 SED
	On ED_CODIGO = E5_NATUREZ
	And SED.D_E_L_E_T_ = ''

Where E5_FORNECE iN ('VOP070','MUNIC','UNIAO') --AND E5_NUMERO IN ('00000165','00000166')
And E5_DATA Between '20231001' and '20231031'
and SE5.D_E_L_E_T_ = ''




--FK7 - Tabela Auxiliar
Select * From FK7010 With(Nolock)
Where FK7_CLIFOR In ('VOP070') and FK7_NUM In('00000163','00000165','00000166','164')
And D_E_L_E_T_ = ''
Order By FK7_TIPO

--FKW - Impostos x Natureza Rendimento
Select * From FKW010 FKW
Where FKW_IDDOC In ('D6D9B457526F4E11849B801844E35029','6CF9695B8C634E11B49B801844E35029',
'8C5B58918B634E11949B801844E35029','8B3F986779734E11849B801844E35029')
and FKW.D_E_L_E_T_ = ''
Order By FKW_IDDOC

--LEM - Cadastro de Recibo/Fatura
Select * From LEM010
Where LEM_IDPART In ('ef1a182a-a7b4-6005-0c7c-c6e269a90759')

--Parcelas da Fatura/Recibo
Select * From T51010
Where T51_IDPART In ('ef1a182a-a7b4-6005-0c7c-c6e269a90759')
and D_E_L_E_T_ = ''

--Pagtos. parcelas da fat/recibo
Select* From V3U010
Where V3U_IDPART In ('ef1a182a-a7b4-6005-0c7c-c6e269a90759')
and D_E_L_E_T_ = ''

--C1H - Participantes
Select C1H_CNPJ,C1H_PPES,* From C1H010
Where C1H_CNPJ = '19850613000146'
and D_E_L_E_T_ = ''

--CR9 - Outras Filiais Compl.Empresa
Select * From CR9010

--C20 - Capa Documento Fiscal
Select * From C20010
Where C20_CODPAR In ('10ee8692-21d4-123e-72ef-ceacc2de337b')
And C20_NUMDOC In ('630')
and D_E_L_E_T_ = ''
Order By C20_NUMDOC

--C0U (Finalidades Documento Fiscal)
Select * From C0U010
Where C0U_ID In ('000007')
and D_E_L_E_T_ = ''


--C30 - Itens do Documento Fiscal  
Select * From C30010
Where C30_CHVNF In ('000000000202605')
And D_E_L_E_T_ = ''


--C35 - Trib Itens Documento Fiscal  
Select * From C35010
Where C35_CHVNF In ('000000000202605')
And C35_CODITE In('5480d66f-8ed4-ee7d-7eea-7d88e44fd235')
And D_E_L_E_T_ = ''

--V3O - Natureza de rendimento
Select  * From V3O010

--V3U - Pagtos. parcelas da fat/recibo
Select * From V3U010
Where V3U_ID = '28282880-2014-bb04-e833-26e0d174df5e'

--C3S (Codigos de Tributos)
Select * From C3S010
Where C3S_ID In ('000006','000007','000012','000001')
And D_E_L_E_T_ = ''

-- Apuração 
--V5C - R-4020-Retenções na Fonte - PJ
Select * From V5C010
Where V5C_IDPART In ('10ee8692-21d4-123e-72ef-ceacc2de337b')
And D_E_L_E_T_ = ''

--V4S - Informações relativas ao pagamento  
Select * From V4S010
Where V4S_ID In ('28282880-2014-bb04-e833-26e0d174df5e')
And D_E_L_E_T_ = ''


--V5D - R-4020 - Identificação do rendimento
Select * From V5D010
Where V5D_ID = '28282880-2014-bb04-e833-26e0d174df5e'
And D_E_L_E_T_ = ''

--V5F - R-4020 - Informações de Processos Referenciados    
Select * From V5F010
Where D_E_L_E_T_ = ''

--V5G - 4020-Identificação do advogado   
Select * From V5G010
Where D_E_L_E_T_ = ''


-- Parametros 
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD, * From SX6010
Where X6_VAR = 'MV_TAFRVLD'
And D_E_L_E_T_ = ''

--T9U - Informação do Contribuinte
Select * From T9U010
Where D_E_L_E_T_ = ''

--T9B - Eventos da EFD-Reinf
Select * From T9B010