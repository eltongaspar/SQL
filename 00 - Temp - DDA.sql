-- Temp 

-- Tarefas
--XX0 - Cadastro de agents (Schedule)
Select * From XX0
Where D_E_L_E_T_ = ' '

--XX1 - Agendamento (Schedule)
Select ISNULL(CAST(CAST(XX1_DESCR AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS XX1_DESCR,
ISNULL(CAST(CAST(XX1_RECORR AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS RECORR,
* From XX1
Where XX1_ULTDIA >= '20240301'  And XX1_ROTINA Like ('%FINA711%')                                                            
and D_E_L_E_T_ = ' '


--SIF - Cabeçalho do Extrato Bancário
Select * From SIF010
--SIG - Registros do Extrato Bancário
Select * From SIG010




--Bancos 
Select A6_COD,A6_DVAGE,A6_DVCTA,A6_BCOOFI,A6_BLOCKED, 
* From SA6010
Where A6_COD = '001'
And A6_AGENCIA = '1912'
And D_E_L_E_T_ = ''

/*
Atualização de Banco (MATA070)
Agência (A6_AGÊNCIA) sem digito
Conta( A6_NUMCON) sem digito
Banco Oficial (A6_BCOOF ) = 001 (Banco do Brasil )
Campo Bloqueada (A6_BLOCKED) Precisa estar preenchido= 2
*/



/*
Atualiza Parâmetro de Bancos - CNAB (FINA130)

Aba Cadastrais 
Cód. Empresa( EE_CODEMP ) Convênio da empresa, disponibilizado pelo Banco do Brasil no link
https://apoio.developers.bb.com.br/referency/post/5ffc477c3b02bd0012ecaa1a

Cod. Empresa(EE_CODEMP) = 3128557 (número fictício para teste.)
Extensão(EE_EXTEN)= TXT
Faixa Inicio (EE_FAXINI) = 000000000001 
Faixa Fim (EE_FAXFIM) = 999999999999
Faixa Atual (EE_FAXATU ) = 00000000001
Tabela (EE_TABELA) = 17
Nro Byte (EE_NRBYTES) = 240

Aba Outros
Cód Carteira (EE_CODCART) = 17
Bco. Oficial (EE_CODOFI) = 001  ( Banco do Brasil )
Var. Carteira (EE_VARCART) = 035*/


--SEE - Comunicacao Remota
SELECT EE_CODEMP,EE_EXTEN,EE_FAXFIM,EE_FAXATU,EE_TABELA,EE_NRBYTES,EE_CODCART,EE_CODOFI,EE_VARCART,
* FROM SEE010 
WHERE
EE_CODIGO = '001'
And EE_CODEMP = '3128557'
AND D_E_L_E_T_ = ''

--SEA - Titulos Enviados ao Banco
Select * From SEA010
Where EA_NUM >= '108167'
And EA_DATABOR >= '20240801'
AND D_E_L_E_T_ = ''

-- Contas a Receber 
Select E1_NUMBOR,* From SE1010
Where E1_NUM In ('000399567','999999999')
And E1_FILIAL = '01'
AND D_E_L_E_T_ = ''










-- DDA
--SEE - Comunicacao Remota
 /*
Nro Bytes (EE_NRBYTES) = 240
Formato Data (EE_TIPODAT) = 4
*/
SELECT EE_NRBYTES,EE_TIPODAT,* FROM SEE010 
WHERE
EE_CODIGO = '237'  and EE_AGENCIA  = '0328' and EE_CONTA = '59808-9' and EE_SUBCTA = '004'
AND D_E_L_E_T_ = ''

--SEB - Ocorrencias da Transm Bancaria
/*
Ocorr Banco (EB_REFBAN)= 01
Ocorr Sist (EB_OCORR)= 02
Tipo (EB_TIPO) = D
*/
SELECT EB_TIPO,EB_OCORR,EB_REFBAN,* 
FROM SEB010
WHERE
EB_BANCO = '237' 
AND D_E_L_E_T_ = '' and EB_TIPO = 'D' and EB_REFBAN = '01' and EB_OCORR = '02'

-- Genericas
Select * From SX5010
Where X5_FILIAL = '01' and X5_TABELA = '10' and X5_CHAVE = '02D'



-- Tarefas
--XX0 - Cadastro de agents (Schedule)
Select * From XX0
Where D_E_L_E_T_ = ' '

--XX1 - Agendamento (Schedule)
Select ISNULL(CAST(CAST(XX1_DESCR AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS XX1_DESCR,
ISNULL(CAST(CAST(XX1_RECORR AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS RECORR,
* From XX1
Where XX1_ULTDIA >= '20240301'  And XX1_ROTINA Like ('%FINA435%')                                                            
and D_E_L_E_T_ = ' '

--XX2 - Agendamento x Empresa/Filial (Schedule)
Select * From XX2
Where XX2_AGEND In ('000055')
And D_E_L_E_T_ = ' '

--SXD - Cadastro de Relatorios e Processos para Agendamento
Select * From SXD010
Where XD_FUNCAO Like ('%FIN435%')
And D_E_L_E_T_ = ' '

-- Sched
Select *, 
ISNULL(CAST(CAST(TSK_PARM AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG
From SCHDTSK
Where TSK_DIA >= '20240301'  And TSK_ROTINA In ('FINA435') 
And TSK_STATUS = '2'
And TSK_DIA >= '20231204'
and D_E_L_E_T_ = ' '
Order By TSK_CODIGO,TSK_HORA Desc

/*Status
0 = "Aguardando execução"
1 = "Em execução"☻
2 = "Finalizada"
3 = "Falhou"
4 = "Permanente"
5 = "Descartada"*/

--



-- FIG - Conciliacao DDA
Select Count(FIG_CONCIL) AS DDA_CONCIL
From FIG010 FIG With(Nolock)
Where FIG_CONCIL = '1' 
AND FIG.D_E_L_E_T_ = ''
--FIG_CONCIL = '1' Conciliado - '2' Não Conciliado

Union All

-- FIG - Conciliacao DDA
Select Count(FIG_CONCIL) AS DDA_NOT
From FIG010 FIG With(Nolock)
Where FIG_CONCIL = '2' 
AND FIG.D_E_L_E_T_ = ''
--FIG_CONCIL = '1' Conciliado - '2' Não Conciliado

--11/03/24
-- No Concil - 1637
-- Concil - 0

-- FIG - Conciliacao DDA - Com Fornecedores 
Select FIG_CODBAR,
FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,*
From FIG010 FIG With(Nolock)
Where FIG_CONCIL = '2' 
And FIG_FORNEC <>  ''
AND FIG.D_E_L_E_T_ = ''
Order By FIG_TIPO
--FIG_CONCIL = '1' Conciliado - '2' Não Conciliado

-- FIG - Conciliacao DDA - Comparacao 
Select E2_CODBAR,FIG_CODBAR,
SA2FIG.A2_CGC,SA2SE2.A2_CGC,
SA2FIG.A2_NOME as FIG_FOR_NOME,
SA2SE2.A2_NOME as SE2_FOR,

FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,
E2_FILIAL,E2_FORNECE,E2_LOJA,E2_VENCTO,E2_VALOR,E2_SALDO,E2_BAIXA,E2_CODBAR,*
From FIG010 FIG With(Nolock)

	Inner Join SE2010 SE2
	On FIG_FILIAL = E2_FILIAL
	And (FIG_VENCTO = E2_VENCTO or FIG_VENCTO = E2_VENCORI)
	And FIG_VALOR = E2_VALOR
	And SE2.D_E_L_E_T_ = ''
	And E2_BAIXA = ''
	And E2_SALDO > 0
	And E2_CODBAR = ''

	Inner Join SA2010 SA2FIG
	ON FIG_FORNEC = SA2FIG.A2_COD
	And FIG_LOJA = SA2FIG.A2_LOJA
	And SA2FIG.D_E_L_E_T_ = ''

	Inner Join SA2010 SA2SE2
	On E2_FORNECE = SA2SE2.A2_COD
	And E2_LOJA = SA2SE2.A2_LOJA
	And SA2SE2.D_E_L_E_T_ = ''

Where FIG_CONCIL In ('2')
And SA2FIG.A2_CGC = SA2SE2.A2_CGC
And FIG_FORNEC <> ''
And E2_EMISSAO Between '20231201' and '20241231'
and E2_VENCTO Between '20231201' and '20241231'
AND FIG.D_E_L_E_T_ = ''

-- Comparativo Datas 
Select SE2.R_E_C_N_O_,FIG.R_E_C_N_O_, FIG_VENCTO,E2_VENCTO,
DateDiff(Day,E2_VENCTO,FIG_VENCTO) As DIAS_DIF,
E2_CODBAR,FIG_CODBAR,
FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,
E2_FILIAL,E2_FORNECE,E2_LOJA,E2_VENCTO,E2_VALOR,E2_SALDO,E2_BAIXA,E2_CODBAR,*
--UPDATE SE2010 SET E2_CODBAR = ''
From FIG010 FIG With(Nolock)

	Inner Join SE2010 SE2
	On FIG_FILIAL = E2_FILIAL
	And FIG_FORNEC = E2_FORNECE
	And FIG_LOJA = E2_LOJA
	And FIG_VALOR = E2_VALOR
	--And FIG_VENCTO = E2_VENCTO
	And E2_BAIXA = ''
	And E2_SALDO > 0
	And SE2.D_E_L_E_T_ = ''

Where FIG_CONCIL = '2'
And FIG_FORNEC <> ''
AND FIG.D_E_L_E_T_ = ''


 -- Contas a pagar - Contagem Titulos Chave – Fornecedor+Loja+Filial+Vencimento+Valor
Select E2_FORNECE,E2_VALOR,E2_VENCTO,Count(E2_VALOR) as QTDE_VAL,Count(E2_VENCTO) AS QTDE_VENTO From SE2010 SE2
Where E2_EMISSAO >= '20240301'
--And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_FORNECE,E2_VALOR,E2_VENCTO
Having Count(E2_VALOR) > 1 and Count(E2_VENCTO) > 1
Order By 4 Desc

 -- DDA  - Contagem Titulos Chave – Fornecedor+Loja+Filial+Vencimento+Valor
Select FIG_FORNEC,FIG_VALOR,FIG_VENCTO,Count(FIG_VALOR) as QTDE_VAL,Count(FIG_VENCTO) AS QTDE_VENTO From FIG010 FIG
Where FIG_DATA >= '20240301'
--And E2_FORNECE = '000002'
And FIG.D_E_L_E_T_ = ''
Group By FIG_FORNEC,FIG_VALOR,FIG_VENCTO
Having Count(FIG_VALOR) > 1 and Count(FIG_VENCTO) > 1
Order By 4 Desc




-- Painel Posição Cliente - Analise Credito - SIGAFIN

--F75 - Saldos de titulos
Select * From F75010
Where D_E_L_E_T_ = ''
--148.898
--148.243

--F76 - TFC-Saldos de Pedidos por Data
Select * From F76010
Where D_E_L_E_T_ = ''
--1.693.583
--185.246

--A tabela F75 – Saldos de títulos deve possuir o mesmo nível de compartilhamento das tabelas SE1 e SE2.
--A tabela F76 – Saldos de Pedidos deve possuir o mesmo nível de compartilhamento das tabelas SC5, SC6 e SC7.

