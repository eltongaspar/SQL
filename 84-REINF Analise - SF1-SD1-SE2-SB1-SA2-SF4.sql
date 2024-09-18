-- NF Entrada Cab.
Select F1_FORNECE,F1_LOJA,
A2_CGC,A2_NOME,
D1_TES,F4_TEXTO,D1_COD,
B1_DESC,B1_IRRF,B1_REDIRRF,
A2_CALCIRF,A2_GROSSIR,A2_MINIRF,A2_IRPROG,
F1_DOC,F1_IRRF,F1_BASEIR,F1_VALIRF,
E2_NATUREZ,
D1_BASEIRR,D1_ALIQIRR,D1_VALIRR,
F1_DTDIGIT,F1_EMISSAO

From SF1010 SF1

	Inner Join SA2010 SA2 -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA =F1_LOJA
	and SA2.D_E_L_E_T_ = ''

	Inner Join SD1010 SD1 -- NF Ent Itens
	On D1_FILIAL = F1_FILIAL
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And SD1.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 -- TES
	On F4_CODIGO = D1_TES
	And SF4.D_E_L_E_T_= ''

	Inner Join SB1010 SB1 -- Produtos 
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ = ''


	Inner Join SE2010 SE2
	On E2_FILIAL = F1_FILIAL
	And E2_FORNECE = F1_FORNECE
	And E2_LOJA = F1_LOJA
	And E2_NUM = F1_DOC
	And SE2.D_E_L_E_T_ = ''

Where F1_FILIAL = '01'
--And F1_DOC In ('00000270','00000275')
And F1_EMISSAO Between '20240801' and '20240831'
And F1_FORNECE In ('VOP560')
And F1_DTDIGIT Between '20240801' and '20240831' 
--And F1_BASEIR > 0 And F1_IRRF = 0 and F1_VALIRF = 0 
and SF1.D_E_L_E_T_ = ''
Order By 1

--Select * From SX6010 Where X6_VAR Like ('%MV_IRF%')

--A2_CALCIRF	Calc. IRRF	Calculo do IRRF. 
--1=Normal;2=IRRF Baixa;3=Simples;4=Empresa Individual

--A2_GROSSIR	Base Calc IR	Base de Calculo IRRF
-- 0=Sem Gross UP;1=Imp. Serv. IRRF;2=Imp. Serv. IRRF + CIDE;3=Imp. Serv. IRRF + Val. Servico
--Help de Campo: Campo que indica se no calculo do IRRF devera realizar o Gross UP na base de Calculo do IRRF, 
--ou seja, de devera incluir o valor do IRRF em sua propria Base de Calculo. As opcoes disponiveis sao: 
--0 - Sem Gross UP; 
--1 - Fara GrossUp na Importacao de Servico na base de calculo do IRRF e PIS e COFINS Importacao; 
--2 - Fara GrossUp na Importacao de Servico na base de calculo do IRRF, PIS e COFINS Importacao e CIDE; 
--3 - Fara GrossUp na Importacao de Servico na base de calculo do IRRF, PIS e COFINS Importacao 
--e tambem no valor do Servico. Esta opcao altera o valor da nota fiscal e o valor da duplicata, pois o IRRF foi embutido no valor do servico tomado;

--A2_MINIRF	Vlr. Min. IR	Valor Minimo de IRRF
--1=Sim;2=Nao
--Help de Campo: Define se havera dispensa da verificacao do valor minimo para retencao de IRRF. 
--(1 = Sim) Dispensa a verificacao do valor minimo de retencao do IRRF (retem para qualquer valor de imposto). 
--(2 = Nao) Verifica o valor minimo de retencao do IRRF (valor contido no parametro MV_VLRETIR).

--A2_IRPROG	IRRF Prog	Calcula IRRF Progressivo
--Help de Campo: Indica se Calcula IRRF conforme Tabela Progressiva mesmo que o Fornecedor seja pessoa Juridica.


--B1_IRRF	Impos.Renda	Incide imposto renda
--Help de Campo: Define se deve ser calculado imposto de renda para este produto na nota fiscal.

--B1_REDIRRF	% Red. IRRF	Perc. de reducao do IRRF
--Help de Campo: Reducao da base do IRRF. Informe o percentual a ser considerado em relacao a base de calculo. Ex: Se for informado 60%, 
--a base de calculo ficara com 60% de seu valor original.

--D1_BASEIRR	Base de IRRF	Base de calculo do IRRF	
--Help de Campo: Base de calculo para o Imposto de Renda no item.

--D1_ALIQIRR	Aliq. IRRF	Aliquota de IRRF	
--Help de Campo: Aliquota de imposto de Renda para o item.

--D1_VALIRR	Valor IRRF	Valor do IRRF
--Help de Campo: Valor do imposto de Renda para o item.





/*
-- TES 
Select * From SF4010
Where F4_CODIGO In ('039','438')
and D_E_L_E_T_ = ''

-- Fornecedores 
Select A2_CALCIRF,A2_GROSSIR,A2_IRPROG,
* From SA2010
Where A2_CGC = '04016208000150'
and D_E_L_E_T_ = ''

-- Produtos 
Select * From SB1010*/

