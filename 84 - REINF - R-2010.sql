-- 84 - REINF - IRRF 

-- NF Entrada Cab.
Select F1_FILIAL,F1_CHVNFE,F1_DTDIGIT,F1_EMISSAO,A2_NOME,A2_CGC,
F1_INSS,F1_BASEINS,F1_BASEINA,F1_VALINA,
F1_IRRF,F1_BASEIR,F1_VALIRF,F1_VALBRUT,
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

Where F1_FORNECE In ('VOPAML') and F1_DOC In ('3612','3671')
And F1_DTDIGIT Between '20231101' and '20231131'
and SF1.D_E_L_E_T_ = ''

--F1_INSS	Valor INSS	Valor do INSS
--F1_BASEINS	Base de INSS	Base de calculo do INSS
--F1_BASEINA	Base INSS Ad	Base do INSS Condicoes Es
--F1_VALINA	Vlr INSS Ad	Valor do INSS Condicoes E

--F1_IRRF	Imp. Renda	Imposto de Renda
--F1_VALIRF	IRRF Ret	Valor do IRRF Retido
--F1_BASEIR Base IRRF   Base do Calculo do IRRF 


-- Fornecedores 
Select * From SA2010
Where A2_CGC = '07210221000303'
and D_E_L_E_T_ = ''

-- NF Entrada Itens 
Select D1_FILIAL,D1_DOC,D1_FORNECE,D1_CNATREC,D1_BASEINS,D1_ALIQINS,D1_VALINS,
D1_BASEIRR,D1_VALIRR,D1_ALIQIRR,* 
From SD1010
Where D1_FORNECE In ('VOPAML') and D1_DOC In ('3612','3671')
and D_E_L_E_T_ = ''


--D1_BASEINS	Base de INSS	Base de calculo do INSS	N
--D1_ALIQINS	Aliq. INSS	Aliquota de INSS	
--D1_VALINS	Vlr. do INSS	Valor do INSS

--D1_BASEIRR	Base de IRRF	Base de calculo do IRRF	
--D1_ALIQIRR	Aliq. IRRF	Aliquota de IRRF	
--D1_VALIRR	Valor IRRF	Valor do IRRF


-- Livro Fiscal Cab.
Select F3_FILIAL,F3_CHVNFE,A2_NOME,A2_CGC,X5_DESCRI,F3_ESPECIE,F3_TIPO,F3_CNATREC,
* From SF3010 SF3

	Inner Join SA2010 SA2
	On F3_CLIEFOR = A2_COD
	And F3_LOJA = A2_LOJA
	and SA2.D_E_L_E_T_ = ''

	
	Inner Join SX5010 SX5
	On X5_FILIAL = F3_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F3_ESPECIE
	And SX5.D_E_L_E_T_ = ''

Where F3_CLIEFOR In ('VOPAML') and F3_NFISCAL In ('3612','3671')
And F3_EMISSAO Between '20231101' and '20231131'
and SF3.D_E_L_E_T_ = ''


-- Livro Fiscal Itens
Select FT_FILIAL,FT_BASEINS,FT_ALIQINS,FT_VALINS,FT_CNATREC,
FT_BASEIRR,FT_ALIQIRR,FT_VALIRR,
FT_PRODUTO,B1_DESC,A2_NOME,A2_CGC,X5_DESCRI,FT_ESPECIE,FT_TIPO,
* From SFT010 SFT

	Inner Join SA2010 SA2
	On FT_CLIEFOR = A2_COD
	And FT_LOJA = A2_LOJA
	and SA2.D_E_L_E_T_ = ''

	
	Inner Join SX5010 SX5
	On X5_FILIAL = FT_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = FT_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1
	On B1_COD = FT_PRODUTO
	And SB1.D_E_L_E_T_ = ''

Where FT_CLIEFOR In ('VOPAML') and FT_NFISCAL In ('3612','3671')
And FT_EMISSAO Between '20231101' and '20231131'
and SFT.D_E_L_E_T_ = ''




-- Contas a Pagar
Select E2_FILIAL,E2_FORNECE,E2_NOMFOR,E2_NUM,E2_SALDO,E2_VALOR,E2_VALLIQ,E2_BAIXA,E2_TIPO,E2_NATUREZ,ED_DESCRIC,
E2_INSS,E2_PARCINS,E2_INSSRET,E2_RETINS,E2_VRETINS,E2_BASEINS,
E2_IRRF,E2_VRETIRF,E2_BASEIRF,E2_TIPO, 
X5_DESCRI,E2_NATUREZ,ED_DESCRIC,
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

Where E2_FORNECE iN ('VOPAML','MUNIC','UNIAO','V00A08') AND E2_NUM IN ('3612','3671')
And E2_FILIAL In ('01','02','03')
And E2_EMISSAO Between '20231101' and '20231130'
And E2_TIPO In ('TX','NF','FT','ISS','TXA','INS','IRF')
and SE2.D_E_L_E_T_ = ''
Order By 4,8

--E2_IRRF	IRRF	Valor do IRRF
--E2_VRETIRF	Valor Rt. IR	Valor Retido - IRRF
--E2_BASEIRF	Base IRRF	Base IRRF

--E2_INSS	INSS	Valor do INSS	
--E2_PARCINS	Parc. INSS	Parcela do INSS
--E2_INSSRET	INSS Retido	INSS Retido
--E2_RETINS	Ret. INSS	Codigo de Retencao INSS	
--E2_VRETINS	Vlr Ret INSS	Valor Retido INSS
--E2_BASEINS	Base INSS	Base INSS


Select E2_NUM,E2_SALDO,E2_BAIXA,
E2_INSS,E2_PARCINS,E2_INSSRET,E2_RETINS,E2_VRETINS,E2_BASEINS,
E2_IRRF,E2_VRETIRF,E2_BASEIRF,E2_TIPO, 
X5_DESCRI,E2_NATUREZ,ED_DESCRIC,
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
	
Where E2_FORNECE iN ('VOPAML','MUNIC','UNIAO','V00A08','V00335','VOOCFX') AND E2_TIPO IN ('PA')	
And E2_EMISSAO Between '20231101' and '20231130'
and SE2.D_E_L_E_T_ = ''

-- Mov. Bancaria 
Select E5_FILIAL,E5_TIPODOC,X5_DESCRI,E5_NATUREZ,ED_DESCRIC,
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

Where E5_FORNECE iN ('VOPAML','MUNIC','UNIAO','V00A08','V00335','VOOCFX') 
AND E5_NUMERO IN ('3612','3671')
And E5_DATA Between '20231101' and '20231231'
and SE5.D_E_L_E_T_ = ''

--FK7 - Tabela Auxiliar
Select * From FK7010 With(Nolock)
Where FK7_CLIFOR In ('VOPAML') and FK7_NUM In('3612','3671')
And D_E_L_E_T_ = ''
Order By FK7_TIPO

--FK7_IDDOC = FKW_IDDOC

--FKW - Impostos x Natureza Rendimento
Select * From FKW010 FKW
Where FKW_IDDOC In ('1752FE3DF58E4E11B49D801844E35029','7D71E7DB76A64E11849F801844E35029','9E957079C3AB4E11B4A0801844E35029')
and FKW.D_E_L_E_T_ = ''
Order By FKW_IDDOC

--C1E - Compl. Estabelecimento
Select * From C1E010
Where D_E_L_E_T_ = ''

--CR9 (Outras Filiais Compl.Empresa)
Select * From CR9010
Where D_E_L_E_T_ = ''

--CRM (Software House)
Select * From CRM010
Where D_E_L_E_T_ = ''

--C1H - Participantes
Select C1H_CNPJ,C1H_PPES,* From C1H010
Where C1H_CNPJ In ('07210221000303')
and D_E_L_E_T_ = ''

--LEM - Cadastro de Recibo/Fatura
Select * From LEM010
Where LEM_IDPART In ('7a945ae9-36c2-bf78-70ad-82c214ffc82c')
And LEM_DTEMIS >= '20231001'
and D_E_L_E_T_ = ''

--Pagtos. parcelas da fat/recibo
Select* From V3U010
Where V3U_IDPART In ('7a945ae9-36c2-bf78-70ad-82c214ffc82c')
And V3U_DTPAGT >= '20231101'
and D_E_L_E_T_ = ''


--C20 - Capa Documento Fiscal
Select * From C20010
Where C20_CODPAR In ('7a945ae9-36c2-bf78-70ad-82c214ffc82c')
And C20_DTDOC >= ('20231101')
and D_E_L_E_T_ = ''
Order By C20_NUMDOC

--C0U (Finalidades Documento Fiscal)
Select * From C0U010
Where C0U_ID In ('000007')
and D_E_L_E_T_ = ''


--C30 - Itens do Documento Fiscal  
Select * From C30010
Where C30_CHVNF In ('')
And D_E_L_E_T_ = ''

--C35 - Trib Itens Documento Fiscal  
Select * From C35010
Where C35_CHVNF In ('000000000281242','000000000281252','000000000281254','000000000281253')
--And C35_CODITE In('7a945ae9-36c2-bf78-70ad-82c214ffc82c')
And D_E_L_E_T_ = ''
Order By C35_FILIAL


--V3O - Natureza de rendimento
Select  * From V3O010

--V3U - Pagtos. parcelas da fat/recibo
Select * From V3U010
Where V3U_IDPART = '7a945ae9-36c2-bf78-70ad-82c214ffc82c'
And D_E_L_E_T_ = ''

--C3S (Codigos de Tributos)
Select * From C3S010
Where C3S_ID In ('000006','000007','000012','000001')
And D_E_L_E_T_ = ''

-- Apuração 
--V5C - R-4020-Retenções na Fonte - PJ
Select * From V5C010
Where V5C_IDPART In ('7a945ae9-36c2-bf78-70ad-82c214ffc82c')
And D_E_L_E_T_ = ''

--V4S - Informações relativas ao pagamento  
Select * From V4S010
Where V4S_ID In ('93ee5b79-bd3b-a58c-912c-addc739720c9')
And D_E_L_E_T_ = ''


--V5D - R-4020 - Identificação do rendimento
Select * From V5D010
Where V5D_ID = '93ee5b79-bd3b-a58c-912c-addc739720c9'
And D_E_L_E_T_ = ''

--V5F - R-4020 - Informações de Processos Referenciados    
Select * From V5F010
Where D_E_L_E_T_ = ''

--V5G - 4020-Identificação do advogado   
Select * From V5G010
Where D_E_L_E_T_ = ''


-- TAF -
-- Ticktes 
--TAFST1 e TAFST2 
-- Gerenciador de Integrações 

--TAFKey
Select * From TAFST1
Where TAFDATA Between '20231101' and '23231130'
And D_E_L_E_T_ = '*'
/*TAFSTATUS ( CHAR(1) ) NOT NULL
Representa o status de processamento das informações por dupla.
0, indica que as informações estão sendo processadas pela aplicação (ERP).
1, indica que as informações estão disponíveis para que a integração a processe, ou seja, está disponível para o TAF processá-la.
2, indica que as informações estão sendo processadas.
3, indica que as informações já foram processadas e estão disponíveis no ambiente do TAF.
7, indica que hove erro na exclusão dos registros (somente para arquivo texto COD_MSG = 1).
8, indica que que a filial do registro não está cadastrada no sistema.
7, indica erro de estrutura no registro (numero de pipes menor que o esperado).*/



-- Eventos TAF TicketxTafKey
Select * From TAFST2
Where TAFDATA Between '20231101' and '20231130' 
And TAFKEY =	'20231206103750000006T154T1545957565'
And TAFTICKET = '2ed72385-f62c-d137-708e-ff72a6816953' 
And TAFMSG Like ('%V00335%') -- Fornecedor 
And TAFMSG Like ('%000020545%') -- Num Documento
And TAFSTATUS Not In ('2')
And D_E_L_E_T_ = ''
--TTAFSTATUS - 2-Não Inegrado / 3-Integrado

--TAFXERP
--Eventos Tickets x ERP
Select * From TAFXERP
Where TAFDATA Between '20231201' and '20231231'
And TAFKEY = '20231206103750000006T154T1545957565'
--And TAFSTATUS = '1'
And D_E_L_E_T_ = ''
-- TAFSTATUS - 1-Nao Integrado / 2-Inegrado


 --Código, descrição e data da inconsistência
Select * From CU0010
Where CU0_CODERR = '000009'
--And CU0_DTOCOR Between '20231001' and '20231031'
And D_E_L_E_T_ = ''


Select * From ST2010