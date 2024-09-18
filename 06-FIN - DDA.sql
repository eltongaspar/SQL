-- Temp 

-- Bancos 
Select * From SA6010
Where A6_COD = '237' and A6_AGENCIA = '0328' and A6_NUMCON = '59808-9'
AND D_E_L_E_T_ = ''

--SEE - Comunicacao Remota
 /*
Nro Bytes (EE_NRBYTES) = 240
Formato Data (EE_TIPODAT) = 4
*/
SELECT EE_NRBYTES,EE_TIPODAT,* FROM SEE010 
WHERE
EE_CODIGO = '237'  and EE_AGENCIA  = '0328' and EE_CONTA = '59808-9' and EE_SUBCTA = '005'
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
Where X5_FILIAL = '01' and X5_TABELA = '10' and X5_CHAVE In ('02DD','02D')
-- Tabela = Ocorrências CNAB

--XX0 - Cadastro de agents (Schedule)
Select * From XX0
Where D_E_L_E_T_ = ' '

--XX1 - Agendamento (Schedule)
Select * From XX1
Where XX1_ULTDIA >= '20231130'  And XX1_ROTINA Like ('%FINA435%')                                                            
and D_E_L_E_T_ = ' '

--XX2 - Agendamento x Empresa/Filial (Schedule)
Select * From XX2
Where D_E_L_E_T_ = ' '

--SXD - Cadastro de Relatorios e Processos para Agendamento
Select * From SXD010
Where XD_FUNCAO Like ('%FINA')
And D_E_L_E_T_ = ' '

-- Sched
Select *, 
ISNULL(CAST(CAST(TSK_PARM AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG
From SCHDTSK
Where TSK_DIA >= '20240301'  And TSK_ROTINA In ('FINA435') 
And TSK_STATUS = '2'
And TSK_DIA >= '20240301'
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

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_VALDESP'
And D_E_L_E_T_ = ''

-- FIG - Conciliacao DDA
-- Conciliados 
Select FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,* 
From FIG010 With(Nolock)
Where FIG_CONCIL = '1' 
AND D_E_L_E_T_ = ''

-- No Conciliados 
Select FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,* 
From FIG010 With(Nolock)
Where FIG_CONCIL = '2' 
AND D_E_L_E_T_ = ''


-- Contas a pagar 
Select Count(E2_NUM) TOTAL_ From SE2010
Where D_E_L_E_T_ = ''
Union All
-- Contas a pagar 
Select Count(E2_NUM) TOTAL_XXX From SE2010
Where D_E_L_E_T_ = '*'

-- Contas a pagar 
Select MAX(R_E_C_N_O_) R_E_C_N_O_ From SE2010



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

	Inner Join SA2010 SA2FIG
	ON FIG_FORNEC = SA2FIG.A2_COD
	And FIG_LOJA = SA2FIG.A2_LOJA
	And SA2FIG.D_E_L_E_T_ = ''

	Inner Join SA2010 SA2SE2
	On E2_FORNECE = SA2SE2.A2_COD
	And E2_LOJA = SA2SE2.A2_LOJA
	And SA2SE2.D_E_L_E_T_ = ''

Where FIG_CONCIL In ('1','2')
And SA2FIG.A2_CGC = SA2SE2.A2_CGC
And FIG_FORNEC <> ''
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




-- FIG - Nao Conciliacao DDA
Select FIG_CODBAR,
FIG_FILIAL,FIG_FORNEC,FIG_LOJA,FIG_VENCTO,FIG_VALOR,*
From FIG010 FIG With(Nolock)
Where FIG_CONCIL = '2' 
And FIG_FORNEC <>  ''
AND FIG.D_E_L_E_T_ = ''
Order By FIG_TIPO
--FIG_CONCIL = '1' Conciliado - '2' Não Conciliado


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





 -- Contas a pagar 
 Select E2_VENCTO,Count(E2_VENCTO) as QTDE From SE2010 SE2
 Where E2_EMISSAO >= '20231201'
--And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_VENCTO
Order By 2


 -- Contas a pagar 
 Select E2_VALOR,E2_VENCTO,Count(E2_VALOR) as QTDE_VAL,Count(E2_VENCTO) AS QTDE_VENTO From SE2010 SE2
 Where E2_EMISSAO >= '20231201'
--And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_VALOR,E2_VENCTO
Order By 3 Desc

 -- Contas a pagar - Contagem Titulos Chave – Fornecedor+Loja+Filial+Vencimento+Valor
Select E2_FORNECE,E2_VALOR,E2_VENCTO,Count(E2_VALOR) as QTDE_VAL,Count(E2_VENCTO) AS QTDE_VENTO From SE2010 SE2
Where E2_EMISSAO >= '20240301'
--And E2_FORNECE = '000002'
And SE2.D_E_L_E_T_ = ''
Group By E2_FORNECE,E2_VALOR,E2_VENCTO
Having Count(E2_VALOR) > 1 and Count(E2_VENCTO) > 1
Order By 4 Desc


 -- FIG - Conciliacao DDA
 Select FIG_VENCTO,Count(FIG_VENCTO) as QTDE From FIG010 FIG
 Where FIG_DATA >= '20231201'
--And FIG_FORNEC = '000002'
And FIG.D_E_L_E_T_ = ''
Group By FIG_VENCTO
Order By 2


 -- FIG - Conciliacao DDA
 Select FIG_VALOR,FIG_VENCTO,Count(FIG_VALOR) as QTDE_VAL,Count(FIG_VENCTO) AS QTDE_VENTO From FIG010 FIG
 Where FIG_DATA >= '20240301'
--And FIG_FORNEC = '000002'
And FIG.D_E_L_E_T_ = ''
Group By FIG_VALOR,FIG_VENCTO
Order By 3 Desc

 -- FIG - Conciliacao DDA
Select FIG_FORNEC,FIG_VALOR,FIG_VENCTO,Count(FIG_VALOR) as QTDE_VAL,Count(FIG_VENCTO) AS QTDE_VENTO From FIG010 FIG
Where FIG_DATA >= '20231201'
--And FIG_FORNEC = '000002'
And FIG.D_E_L_E_T_ = ''
Group By FIG_FORNEC,FIG_VALOR,FIG_VENCTO
Having Count(FIG_VALOR) > 1 and Count(FIG_VENCTO) > 1
Order By 4 Desc


