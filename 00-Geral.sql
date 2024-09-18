				--00 - Config *********************************************************************************************************************************************

--TTAT_LOG
Select TTAT_DTIME,* FRom SB1010_TTAT_LOG
Where TTAT_UNQ = '  1540804401     '
And TTAT_FIELD = 'B1_ROLO'

-- SX Tabelas 
Select * From SX2010
Where X2_CHAVE In ('GXG','ZZ9')

       
-- Parametros 
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2, X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_BASDENT','MV_CMPALIQ','MV_BDSIMP','MV_UFBDST') 


-- Sys Company
Select * From SYS_COMPANY





-- Qtde usuarios
Select USR_QTDACESSOS, * FROM SYS_USR
WHERE USR_MSBLQL='2' AND USR_QTDACESSOS>'1'
AND D_E_L_E_T_=''
Order By 1 Desc


-- Qtde de Filiais por usuario 
SELECT DISTINCT
	F.USR_CODEMP EMPRESA
	FROM SYS_USR U
INNER JOIN SYS_USR_MODULE M ON M.USR_ID=U.USR_ID AND M.USR_ACESSO='T' AND M.D_E_L_E_T_=''
LEFT JOIN MPMENU_MENU MENU ON MENU.M_ID = M.USR_ARQMENU AND MENU.D_E_L_E_T_=''
LEFT JOIN MPMENU_ITEM ITEM ON MENU.M_ID = ITEM.I_ID_MENU AND ITEM.D_E_L_E_T_=''
LEFT JOIN MPMENU_FUNCTION FUNC ON FUNC.F_ID = ITEM.I_ID_FUNC AND ITEM.D_E_L_E_T_=''
LEFT JOIN SYS_USR_FILIAL F ON F.USR_ID=U.USR_ID AND F.USR_ACESSO='T' AND F.D_E_L_E_T_=''
WHERE U.USR_MSBLQL='2' AND U.D_E_L_E_T_=''  
AND F_FUNCTION IS NOT NULL
--AND U.USR_CODIGO='elton.gaspar'
ORDER BY 1






SELECT Distinct
	U.USR_ID ID_USUARIO,
	U.USR_CODIGO COD_USUARIO,
	U.USR_NOME NOME_USUARIO ,
--	F.USR_GRPEMP GRUPO_EMPRESAS,
--	F.USR_CODEMP EMPRESA,
--	F.USR_FILIAL FILIAL,
	CASE WHEN U.USR_ALLEMP  ='1' THEN 'SIM' ELSE 'NAO' END TODAS_EMPRESAS,
	--M.USR_MODULO CODIGO_MODULO,
	--M.USR_CODMOD NOME_MODULO,
	--MENU.M_NAME,
	F_FUNCTION
FROM SYS_USR U
INNER JOIN SYS_USR_MODULE M ON M.USR_ID=U.USR_ID AND M.USR_ACESSO='T' AND M.D_E_L_E_T_=''
LEFT JOIN MPMENU_MENU MENU ON MENU.M_ID = M.USR_ARQMENU AND MENU.D_E_L_E_T_=''
LEFT JOIN MPMENU_ITEM ITEM ON MENU.M_ID = ITEM.I_ID_MENU AND ITEM.D_E_L_E_T_=''
LEFT JOIN MPMENU_FUNCTION FUNC ON FUNC.F_ID = ITEM.I_ID_FUNC AND ITEM.D_E_L_E_T_=''
LEFT JOIN SYS_USR_FILIAL F ON F.USR_ID=U.USR_ID AND F.USR_ACESSO='T' AND F.D_E_L_E_T_=''
WHERE U.USR_MSBLQL='2' AND U.D_E_L_E_T_=''  
--AND U.USR_ALLEMP <> '1' --AND F.USR_FILIAL LIKE 'AD%'
--AND F_FUNCTION IS NOT NULL
AND F_FUNCTION = 'MATA110'
--AND MENU.M_NAME='MENUSPERSONALIZADOSRBEST_NOVO_DASH'
ORDER BY 1



-- Usuários x Rotinas 
SELECT M_NAME, 
       M_ID, I_ID, I_TP_MENU, I_ITEMID, I_FATHER, F_FUNCTION, I_STATUS, I_ORDER, I_TABLES, I_ACCESS, I_DEFAULT, I_RESNAME, I_TYPE, I_OWNER, F_DEFAULT
       , I_MODULE, I18N1.N_DESC N_PT, I18N2.N_DESC N_ES, I18N3.N_DESC N_EN, KW1.K_DESC K_PT, KW2.K_DESC K_ES, KW3.K_DESC K_EN
FROM MPMENU_MENU MPN
jOIN MPMENU_ITEM MPI ON I_ID_MENU = M_ID AND MPI.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_FUNCTION MPF ON F_ID = I_ID_FUNC AND MPF.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N1 ON I18N1.N_PAREN_ID = I_ID AND I18N1.N_LANG = '1' AND I18N1.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N2 ON I18N2.N_PAREN_ID = I_ID AND I18N2.N_LANG = '2' AND I18N2.D_E_L_E_T_ = ' '
JOIN MPMENU_I18N I18N3 ON I18N3.N_PAREN_ID = I_ID AND I18N3.N_LANG = '3' AND I18N3.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW1 ON KW1.K_ID_ITEM = I_ID AND KW1.K_LANG = '1' AND KW1.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW2 ON KW2.K_ID_ITEM = I_ID AND KW2.K_LANG = '2' AND KW2.D_E_L_E_T_ = ' '
LEFT JOIN MPMENU_KEY_WORDS KW3 ON KW3.K_ID_ITEM = I_ID AND KW3.K_LANG = '3' AND KW3.D_E_L_E_T_ = ' '
WHERE F_FUNCTION IN ('MATA110')
AND '#' <> SUBSTRING(M_NAME,1,1) 
AND MPN.D_E_L_E_T_ = ' ' 
ORDER  BY I_ORDER

-----------------------------------------------
-- Usuários com acesso 
SELECT DISTINCT USR.*
FROM SYS_USR_MODULE USRMOD (NOLOCK)
JOIN SYS_USR USR (NOLOCK)
  ON USR.USR_ID = USRMOD.USR_ID 
WHERE USR_CODMOD like '%MATA110%'
and USR_MSBLQL <> '1'








				--02 - SIGACOMP **********************************************************************************************************************************

-- Compradores 
--SAJ - Grupos de Compras
Select * From SAJ010
Where AJ_USER <> ('') and D_E_L_E_T_ =''
Order By AJ_USER

--SAJ - Grupos de Compras - Validação 
Select Count (AJ_USER) Total, AJ_US2NAME From SAJ010
Where AJ_USER <> ('') and D_E_L_E_T_ =''
Group By AJ_US2NAME


--SY1 - Compradores
Select * From SY1010
Where Y1_USER <> ('') and D_E_L_E_T_ =''
Order By Y1_USER

-- Aprovadores
Select * From SAK010
Where AK_USER In ('000847','000599') and D_E_L_E_T_=''


-- Grupo de Aprovaodres 
Select * From SAL010
Where AL_FILIAL In ('FA03') and AL_USER In ('000847','000599')


--Usuários
Select * From SYS_USR
Where USR_CODIGO Like '%maria%'and D_E_L_E_T_=''


--CADASTRO DE SOLICITANTES
Select * From SAI010
Where AI_FILIAL In ('FA03') and AI_USER In ('000530') and D_E_L_E_T_=''

-- Cadastro de Produtos
Select B1_RASTRO, B1_GRUPO,* From SB1010
Where B1_COD In ('0200500001','0200500002') and D_E_L_E_T_=''

-- Grup de produtos 
Select * From SBM010
Where BM_GRUPO In ('1001')And D_E_L_E_T_ =''



-- PC

-- Pedidos de compras - Soma
Select C7_PRODUTO,C7_NUM,C7_UM,C7_SEGUM,Sum(C7_QUANT)As QUANT, Sum (C7_QTSEGUM) As QUANT2,Sum(C7_QUJE) AS ENTREGUE,Sum(C7_QTDACLA) AS CLASSIFICAR From SC7010
Where C7_FILIAL = '01' and C7_NUM In ('011158' ) and D_E_L_E_T_ = ''
--and C7_FORNECE In ('V00329')  
--and C7_PRODUTO = 'ME01000236'
and C7_ENCER = '' and C7_RESIDUO = ''
--and (C7_QUANT<C7_QUJE)
Group By  C7_PRODUTO,C7_NUM,C7_UM,C7_SEGUM


--Pedido de compras
Select C7_QUANT,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_ENCER,C7_RESIDUO,C7_QTDACLA,C7_NUM,* From SC7010
Where C7_FILIAL = '01' --and C7_NUM In ('012459') 
--and C7_FORNECE In ('V009ZR') and C7_ENCER = '' and C7_RESIDUO = '' 
--and C7_PRODUTO In ('ME02000009','MC15002266')
and D_E_L_E_T_ = ''
and (C7_QUANT-C7_QUJE-C7_QTDACLA) > 0


-- Elimina Residuo PC - Percentual
Declare @PERCENT Float, @QUJE Float, @QUANT Float, @FILIAL VARCHAR(2), @NUMPED VARCHAR(6);
SET @FILIAL = '01'
SET @NUMPED = '009263'
SET @QUJE = (SELECT C7_QUJE FROM SC7010 WHERE C7_FILIAL=@FILIAL AND C7_NUM=@NUMPED)
SET @QUANT = (SELECT C7_QUANT FROM SC7010 WHERE C7_FILIAL=@FILIAL AND C7_NUM=@NUMPED)
SET @PERCENT = @QUJE/@QUANT*100
SELECT C7_QUANT, C7_QUJE, @PERCENT AS PERCENTUAL, C7_RESIDUO,C7_ENCER, *,
	Case 
	When @PERCENT >= '90' Then 'PC C/ +90%'
	Else 'Em andamento'
	End AS Status_,

	Case C7_RESIDUO 
	When 'S' Then 'Finalizado'
	Else 'Aberto'
	End RESIDUO,

	Case C7_ENCER
	When 'E' Then 'Encerrado'
	Else 'Não Encerrado'
	End Encerrado

	
FROM SC7010 
WHERE C7_FILIAL=@FILIAL AND C7_NUM=@NUMPED


--NF Entrada Cab.
Select * From SF1010
Where F1_FILIAL = '01' and F1_DOC In ('000019565')and D_E_L_E_T_ = ''
and F1_FORNECE In ('VOOCRX')

--NF Entrada Cab.
Select D1_DOC,D1_FORNECE,* From SD1010
Where D1_FILIAL = '01' and D1_DOC In ('000019565')and D_E_L_E_T_ = ''
and D1_FORNECE In ('VOOCRX')

-- Estoque 
Select B2_QEMP,B2_RESERVA,* From SB2010
Where B2_FILIAL = '01' and B2_COD In('ME01000236') and D_E_L_E_T_ = ''



-- NF Entrada Cab.
Select F1_CHVNFE,* From SF1010
Where F1_CHVNFE In ('','') 
and F1_FILIAL = '01'  and D_E_L_E_T_ =''

-- NF Entrada Itens - Itens com descrição em branco
Select D1_FORNECE,D1_FILIAL,D1_DOC,* From SD1010 With(NoLock) 
Where D1_DESCRI = ('')  and D1_DTDIGIT >= '20230601' and D_E_L_E_T_ ='' 

--Pedido de compras
Select C7_QUANT,C7_UM,C7_QTSEGUM,C7_SEGUM,C7_QUJE,C7_ENCER,C7_RESIDUO,C7_QTDACLA,C7_NUM,* From SC7010
Where C7_FILIAL = '01' and C7_NUM In ('013800') and D_E_L_E_T_ =''


-- NFs Entrada
--SPEDMANIFE
-- zSchCiencia


-- NF Entrada Cab
Select * From SF1010
Where F1_FILIAL In ('01','02','03') and F1_CHVNFE In ('35230758953795000132550010000195651000113809')
And D_E_L_E_T_ =''

-- NF Saida Cab
Select * From SF2010
Where F2_FILIAL In ('01','02','03')and F2_CHVNFE In ('35230621156486000121550010000051761799669509')
And D_E_L_E_T_ =''

-- NF Entrada Itens
Select D1_PEDIDO,D1_DOC,D1_FORNECE,D1_UM,D1_QTSEGUM,D1_SEGUM,* From SD1010
Where D1_FILIAL = '01' and D1_DOC In ('000003503') and D_E_L_E_T_ = ''
and D1_FORNECE = 'VOOCC8'

Select D1_PEDIDO,D1_ITEMPC,D1_DOC,* From SD1010
Where D1_FILIAL In ('01') and D1_PEDIDO In ('008305') and D_E_L_E_T_ = '' 

Select D1_PEDIDO,D1_ITEMPC,D1_DOC,* From SD1010
Where D1_FILIAL In ('01') and D1_PEDIDO In ('008305') and D_E_L_E_T_ = '' 


--SDS - Cabecalho importacao XML NF-e
Select * From SDS010
Where DS_FILIAL In ('01','02','03')and DS_CHAVENF In ('35230635606053000135550010000035031091223182') 
and D_E_L_E_T_ = ''

--SDT - Itens importacao XML NF-e
Select DT_DOC,* From SDT010
Where DT_FILIAL = '01' and DT_DOC In ('000003503') and D_E_L_E_T_ = ''
And DT_FORNEC In ('VOOCC8')

-- NF Entrada Itens - Itens com descrição em branco
Select D1_COD,D1_DESCRI,Count(D1_COD) As Qtde From SD1010 With(NoLock) 
Where D1_DESCRI = '' and D1_EMISSAO >= '20230601' and D1_FILIAL = '02' and D_E_L_E_T_ =''
Group By D1_COD,D1_DESCRI

Select D1_DOC,D1_TES,* From SD1010 With(NoLock)
Where D1_DESCRI = '' and D1_EMISSAO >= '20230501' and D_E_L_E_T_ =''
Order By D1_DTDIGIT

-- Etiquetas de Bobinas
Select ZE_RESERVA,ZE_CTRLE,* From SZE010
Where ZE_NUMBOB In ('2228765') and D_E_L_E_T_ = ''

--Carrgemantos 
Select * From ZZF010






-- Produtos ******************************************************************************************************


-- Produtos 
-- Estrutura Codigo do Produto
-- Tipo 

  --Produtos
Select B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,* 
From SB1010
where B1_COD In ('1850704401','1850604401')
And D_E_L_E_T_ = ''
--B1_XPORTAL
--Uso Portal  
--S=Sim;N=Nao;E=Especial  

-- Genericas - Tipos de produtos 
Select * From SX5010
Where X5_TABELA = '02' And X5_CHAVE = 'PA'
 and D_E_L_E_T_ =''

 -- Nome Produto 
 Select * From SZ1010
 Where Z1_COD In ('115','185') and D_E_L_E_T_ =''  

  -- Bitola
 Select * From SZ2010
 Where  D_E_L_E_T_ ='' and Z2_COD = '05'
 Order By Z2_XPORTAL

 --Campos
 Select * From SX3010
 Where X3_CAMPO = 'Z2_XPORTAL'
 And D_E_L_E_T_ =''

   -- Cores
 Select * From SZ3010
 Where  D_E_L_E_T_ =''
 And Z3_COD = '01'


 -- Classe
Select * From SX5010
Where X5_TABELA = 'Z1' 
 and D_E_L_E_T_ =''

   -- Especialidade
 Select * From SZ4010
 Where  D_E_L_E_T_ =''

 
 --LANCES X ACONDICIONAMENTO     
 Select * From ZZZ010
 Where ZZZ_BITOLA <> ('') and ZZZ_ACOND In ('B') and ZZZ_PROD In ('115')
  and D_E_L_E_T_ =''

-- Portal -- 
--SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 
WHERE Z2_COD IN( '08','04','05')

--Produtos Descriçao
Select * From SZ7010


-- SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 WHERE Z2_COD IN( '08','04','05')



-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD = 'PE4016A'  and D_E_L_E_T_ = ''

-- Produtos Complemento
Select * From SB5010
Where B5_COD = 'MC09000022'  and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD = 'MC09000022'  and D_E_L_E_T_ = ''


--Script para analise de Produtos duplicados no Portal 
-- Especialidade + Cor
SELECT DISTINCT Z4_COD    AS 	ID, 	
Z4_DETALHE				  AS	TEXT 		
FROM SB1010 SB1 -- Produtos		
INNER JOIN SZ4010 SZ4 -- Especialidade	
ON B1_FILIAL			= Z4_FILIAL 	
AND B1_ESPECIA			= Z4_COD 			
AND SB1.D_E_L_E_T_	= SZ4.D_E_L_E_T_ 	
INNER JOIN SZ3010 SZ3 -- Cor 
ON B1_FILIAL			= Z3_FILIAL  		
AND B1_COR				= Z3_COD  		
AND SB1.D_E_L_E_T_	= SZ3.D_E_L_E_T_ 
WHERE
B1_FILIAL				= '' 	
AND B1_COD	LIKE '1850%' -- Especialidade + Cor
AND B1_XPORTAL IN ('S','E') -- Ativo no Portal Produto - S-Sim E-Especial N-Não
AND Z3_XPORTAL IN ('S','E') -- Ativo no Portal - Cor - S-Sim E-Especial N-Não
AND B1_MSBLQL			<> '1' 	--Produto Bloqueado = 1-Bloqueado / 2- Não Bloqueado			
AND SB1.D_E_L_E_T_	= '' 		
ORDER BY Z4_COD 	

--Script  2 

SELECT 
    B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,*,
	SUBSTRING(B1_COD, 8, 1) AS CLASSE
FROM 
    SB1010 SB1
WHERE
    B1_FILIAL = ''
    AND B1_COD LIKE '1850%'
    AND B1_ESPECIA = '01'
    AND B1_XPORTAL IN ('S', 'E')
    AND B1_MSBLQL <> '1'
    AND SB1.D_E_L_E_T_ = ''
ORDER BY 
    B1_CLASENC DESC





-- Fornecedor 
Select A2_CGC,* From SA2010
Where A2_COD = 'VOOFM6' and D_E_L_E_T_ =''

-- Produto x Fornecedor 
Select * From SA5010
Where A5_FORNECE In ('V008Q6') and A5_PRODUTO = 'MC02000016' and D_E_L_E_T_ ='' 

--Aprovadores 
Select * From SAK010 Where D_E_L_E_T_ = ''



-- Unidades de Medidas
Select * From C1J010
Where C1J_FILIAL = '01' and C1J_CODIGO In ('L','LT','UN') And D_E_L_E_T_ = ''


-- Alçadas
-- Documentos com Alçadas
Select * From SCR010
Where CR_FILIAL = '01' And CR_NUM = '008488' and CR_TIPO = 'PC'

-- Entidades Contabeis X Grp Ap
Select * From DBL010



--SA7 - Amarracao Produto x Cliente
Select * From SA7010








--******************************************************************************

-- Analise Importador XML 


-- SF1 - NF Entrada 
-- Industraização / Transferencias 
Select F1_OBSTRF,* From SF1010

-- SF1 - NF Entrada - Indicador 
Select F1_FILIAL,Isnull(F1_ORIGEM,'') As F1_ORIGEM,Count (F1_ORIGEM) As QTDE, F1_ESPECIE, X5_DESCRI,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_
	
From SF1010 SF1

	Inner Join SX5010
	On X5_FILIAL = X5_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE

Where F1_DTDIGIT >= '20240229' and F1_FILIAL In('01','02','03') and SF1.D_E_L_E_T_ ='' and F1_OBSTRF = ''
and F1_ORIGEM IN ('COMXCOL')
Group By F1_FILIAL,F1_ORIGEM,F1_ESPECIE,X5_DESCRI
Order By 1,3 Desc

-- Tabelas 
Select * From SX5010
Where X5_TABELA = '42' and X5_CHAVE = 'ND' and D_E_L_E_T_ =''



 -- Tipos Entradas NFs
 SELECT FILIAL, TIPO, Count(*) AS QTDE FROM BF_VW_TIPOENTRADA
 Where DT_DIG >= '20231001'
 Group By FILIAL, TIPO
 Order By 1,2

 Select F1_ESPECIE,* From SF1010

-- Tipos Entradas NFs
 SELECT FILIAL, TIPO, Count(TIPO) AS TIPO_QTDE FROM BF_VW_TIPOENTRADA
 Where DT_DIG >= '20230601'
 Group By FILIAL,TIPO
 Order By 1

 -- Tipos Entradas NFs
 SELECT * FROM BF_VW_TIPOENTRADA


-- SF1 - NF Entrada - Verificação 
Select Distinct F1_ORIGEM,F1_FILIAL,F1_DOC,F1_TIPO,F1_ESPECIE,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_
	
From SF1010
Where F1_DTDIGIT >= '20231001' and D_E_L_E_T_ ='' 
Order By 1


-- SD1 - NF Entrada - Verificação 
Select Distinct  D1_ORIGEM,D1_FILIAL,D1_DOC,D1_PEDIDO
From SD1010
Where D1_DTDIGIT >= '20231120' and D_E_L_E_T_ ='' 
And D1_DOC In ('0000032558')
Order By 1








				-- 03/35 - SIGACONT/SIGACTB ***********************************************************************************************************************

 --CT2 Lanmentos Contábeis
 SELECT *FROM CT2010
WHERE CT2_FILIAL = '01' AND CT2_LOTE = '028850' AND CT2_SBLOTE = '001'AND CT2_DOC = '907126'AND D_E_L_E_T_ = ''

-- Parametros
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_CTGBLOQ','MV_CTVBLOQ','MV_CTGBLOQ','CTBBLOQ','MV_CTBCTG','MV_ALTLCTO','MV_PRELAN')

--MV_CTBCTG - Bloqueio de Movimentação por Amarração Calendário X Moeda X Tipo de Saldo


-- Parametros
Select X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_DESCRIC Like ('%Contabil%')

-- Calendario Contabil 
Select * From CTG010
Where CTG_DTINI Between '20210101' and '20211231' and CTG_DTFIM Between '20210101' and '20211231'
and  D_E_L_E_T_ =''

-- Status 1=Aberto;2=Fechado;3=Transportado;4=Bloqueado

--CQ0 – Saldo por Conta No Mês
Select * From CQ0010
Where CQ0_DATA Between '20210101' and '20211231'
and  D_E_L_E_T_ =''

--CQ1 – Saldo por Conta No Dia
Select * From CQ1010
 Where CQ1_DATA Between '20210101' and '20211231'
and  D_E_L_E_T_ =''

--CTE - Amarracao Moeda x Calendario
Select * From CTE010

-- Moedas Contabeis 
Select * From CT0010

--CQD - Bloqueio do calendário Contábil
Select * From CQD010
Where CQD_EXERC = '2023' and CQD_PERIOD = '08' 
and D_E_L_E_T_ = ''
Order By 3
--1=Aberto;2=Fechado;3=Transportado;4=Bloqueado;5=Periodo

--CTP - Cambio
Select * From CTP010

--Tabela
Select * From SX5010
Where X5_TABELA = 'U1' -- U1 > Lançamentos

--Arquivos de Tabelas 
Select * From SX2010
Where X2_CHAVE = 'CQD' and D_E_L_E_T_ = ''




				-- 04 - SIGAEST ********************************************************************************************************************************
 
-- PC x NF Entada Itens 
-- SC7 - PC
-- SD1 - NF Entrada Itens 
Select C7_NUM,D1_DOC,C7_ITEM,D1_ITEMPC,D1_ITEM,C7_QUANT,C7_QUJE,C7_QTDACLA,D1_QUANT,
(C7_QUANT-C7_QUJE-C7_QTDACLA) As SALDO_PC, C7_ENCER, C7_RESIDUO,C7_CONAPRO, C7_APROV,AK_USER, USR_NOME,
	
	Case 
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) = 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'ATENDIDO'
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) > 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'PARCIAL'
	When C7_QUJE = 0 and C7_QTDACLA = 0   Then 'Em Aberto'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_ENCER = 'E'  Then 'Encerrado'
	When C7_ENCER = ' '  Then 'Nao Encerrado'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_RESIDUO = 'S'  Then 'Eliminado'
	When C7_RESIDUO = ' '  Then 'Nao Eliminado'
	Else 'Verificar'
	End AS Status_,
	   
	Case 
	When C7_CONAPRO = 'B' Then 'BLOQ'
	When C7_CONAPRO = 'L' Then 'LIB'
	When C7_CONAPRO = 'R' Then 'REJ'
	Else 'VERIFICAR'
	End As STATUS_LIB,

* From SC7010 SC7

	LEFT Join SD1010 SD1 With(Nolock)
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''

	LEFT JOIN SAK010 SAK
	On AK_COD = C7_APROV
	And AK_FILIAL = C7_FILIAL
	And SAK.D_E_L_E_T_ = ''

	LEFT JOIN SYS_USR USR
	On AK_USER = USR.USR_ID
	And USR.D_E_L_E_T_ = ''
	   	 
Where C7_FILIAL = '01' --and C7_NUM In ('008305','009179') 
--And D1_DOC In ('000034698','000034698','000034698','328','000004018','000004018','2695','1396')
and SC7.D_E_L_E_T_ ='' and SD1.D_E_L_E_T_ = ''


-- Produtos 
Select B1_COD,B1_POSIPI, * From SB1010
Where B1_COD In ('ME02000007','ME02000008','ME02000009','1041000775') and D_E_L_E_T_ =''
--XML NCM 44151000

-- Estoque 
Select B2_QATU,B2_RESERVA,B2_QEMP, * From SB2010
Where B2_FILIAL In ('01') And B2_COD In ('1141304401') and D_E_L_E_T_ ='' and B2_QATU > 0 

--Acompanha Custos
--Logs de Fechamentos - D3X
Select * From D3X010

--Fechamentos Realizados - D3Y
Select * From D3Y010

--Controle Transacional de Processos - D3W
Select * From D3W010


-- Movimentos Internos 
Select D3_CUSTO1,D3_CF, * From SD3010
Where D3_FILIAL = '01' and D3_CF <> 'DE0' and D3_EMISSAO Between '20231001' and '20231031' 
and D_E_L_E_T_ = '' and D3_ESTORNO = '' and D3_COD = 'SC01000001'
Order By 1 desc
-- D3_CUSTO1 -- Custos
-- D3_CF *Tipo de Requisicao/devolucao
-- D3_TM - Tipo Movimento
-- dbo.userlgi_normal (D3_USERLGI) - usuario

-- Tipos de movimentação
Select * From SF5010
Where F5_CODIGO = '007' and D_E_L_E_T_ = ''

Select * From SYS_USR
Where USR_ID = '000826'

-- Estoque
Select * From SB2010
Where B2_COD = 'MOD300111'
-- 2240400001
-- B2_QFIM - Saldo em qtde no fim mes
-- B2_VFIM1 - Valor final p/transferir

-- Conta Contabil 
Select * From CT1010
Where CT1_CONTA = '113040001' and D_E_L_E_T_ = ''

--CTT - Centro de Custo            
Select * From CTT010
Where CTT_CUSTO = '300111' and D_E_L_E_T_ = ''




-- CT2 - Lancamentos Contabeis
Select * From CT2010
Where CT2_FILIAL = '01' and CT2_LOTE = '008840' and CT2_SBLOTE = '001' and CT2_DOC = '000011' 
And CT2_CCD = '300111'
And CT2_DATA Between '20230301' and '20230331'  and D_E_L_E_T_ = '' and CT2_FILIAL = '01' and D_E_L_E_T_ = ''
Order By CT2_VALOR Desc

Select * From CT2010
Where CT2_FILIAL = '01' and CT2_LOTE = '008840' and CT2_SBLOTE = '001' and CT2_DOC = '000011' 
And CT2_CCC = '300111'
And CT2_DATA Between '20230301' and '20230331'  and D_E_L_E_T_ = '' and CT2_FILIAL = '01' and D_E_L_E_T_ = ''
Order By CT2_VALOR Desc




--Estoque Terceiros
Select SD2.D2_DOC,* From SB6010 SB6

    -- SD2 - NF Saida Itens
	Left Join SD2010 SD2
	On SD2.D2_FILIAL = SB6.B6_FILIAL 
	And SD2.D2_LOJA = SB6.B6_LOJA
	And SD2.D2_CLIENTE = SB6.B6_CLIFOR
	And SD2.D2_DOC = SB6.B6_DOC 
	And SD2.D_E_L_E_T_ = ''

	   
Where B6_FILIAL In ('01','02','03') and 
B6_DOC In ('000125448','000126719','000126720') and SB6.D_E_L_E_T_ = ''

--Estoque Terceiros
Select SB6.B6_FILIAL, SB6.B6_CLIFOR,SB6.B6_PRODUTO,SB6.B6_DOC,
SB6.B6_FILIAL,SD1.D1_FORNECE,SD1.D1_DOC,
SB6.B6_CUSTO1, SD1.D1_CUSTO,
(SB6.B6_CUSTO1 - SD1.D1_CUSTO) As DIF_CUSTO_ENTRADA,SB6.B6_IDENT
From SB6010 SB6

	-- SD1 - NF Entrada Itens
	Inner Join SD1010 SD1
	On SD1.D1_FILIAL = SB6.B6_FILIAL 
	And SD1.D1_LOJA = SB6.B6_LOJA
	And SD1.D1_FORNECE = SB6.B6_CLIFOR
	And SD1.D1_DOC = SB6.B6_DOC 
	And SD1.D1_COD = SB6.B6_PRODUTO
	And SD1.D1_IDENTB6 = SB6.B6_IDENT
	And SD1.D_E_L_E_T_ = ''
	   
Where B6_FILIAL In ('02') and 
B6_DOC In ('000076048') and SB6.D_E_L_E_T_ = ''



--Estoque Terceiros
Select SB6.B6_FILIAL, SB6.B6_CLIFOR,A1_NOME,A2_NOME,SB6.B6_PRODUTO,B1_DESC,SB6.B6_DOC,SB6.B6_FILIAL, 
Isnull(SD1.D1_FORNECE,'')D1_FORNECE, Isnull(SD1.D1_DOC,'') D1_DOC,Isnull(SD1.D1_NFORI,'') D1_NFORI,
Isnull(SD2.D2_CLIENTE,'') D2_CLIENTE, Isnull(SD2.D2_DOC,'') D2_DOC, 
Isnull(SB6.B6_CUSTO1,'') B6_CUSTO1, Isnull(SD1.D1_CUSTO,'') D1_CUSTO, Isnull(SD2.D2_CUSTO1,'') D2_CUSTO1,
Isnull((SB6.B6_CUSTO1 - SD1.D1_CUSTO),'') As DIF_CUSTO_ENTRADA, Isnull((SB6.B6_CUSTO1 - SD2.D2_CUSTO1),'') As DIF_CUSTO_SAIDA,
Isnull(SD1.D1_EMISSAO,'')D1_EMISSAO,Isnull(SD2.D2_EMISSAO,'') D2_EMISSAO, B6_EMISSAO,
Isnull(SB6.B6_LOJA,'') B6_LOJA,Isnull(SD1.D1_LOJA,'') D1_LOJA,Isnull(SD2.D2_LOJA,'') D2_LOJA,SB6.B6_IDENT,B6_SALDO
From SB6010 SB6

	-- SD1 - NF Entrada Itens
	Left Join SD1010 SD1
	On SD1.D1_FILIAL = SB6.B6_FILIAL 
	And SD1.D1_LOJA = SB6.B6_LOJA
	And SD1.D1_FORNECE = SB6.B6_CLIFOR
	And SD1.D1_DOC = SB6.B6_DOC 
	And SD1.D1_COD = SB6.B6_PRODUTO
	And SD1.D1_IDENTB6 = SB6.B6_IDENT
	And SD1.D_E_L_E_T_ = ''

	    -- SD2 - NF Saida Itens
	LEFT Join SD2010 SD2
	On SD2.D2_FILIAL = SB6.B6_FILIAL 
	And SD2.D2_LOJA = SB6.B6_LOJA
	And SD2.D2_CLIENTE = SB6.B6_CLIFOR
	And SD2.D2_DOC = SB6.B6_DOC 
	And SD2.D2_COD = SB6.B6_PRODUTO
	And SD2.D_E_L_E_T_ = ''

	Left Join SA1010 SA1
	On SD2.D2_LOJA = SA1.A1_LOJA
	And SD2.D2_CLIENTE = SA1.A1_COD
	And SA1.D_E_L_E_T_ = ''

	Left Join SA2010 SA2
	On SD1.D1_LOJA = SA2.A2_LOJA
	And SD1.D1_FORNECE = SA2.A2_COD
	And SA2.D_E_L_E_T_ = ''

	Left Join SB1010 SB1
	On B1_COD = B6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

		   
Where B6_FILIAL In ('01','02','03') 
--And B6_SALDO > 0
--and B6_CLIFOR In ('000130') and B6_DOC In ('000125448','000126719','000126720','000076048')
--And SB6.B6_PRODUTO In ('PF1820A')
And SB6.B6_EMISSAO Between '20240801' And '20240831'
And SB6.D_E_L_E_T_ = ''
Order By SB6.B6_DOC



--Estoque Terceiros
Select B6_CUSTO1,* From SB6010
Where B6_FILIAL In ('01','02','03') and 
B6_DOC In ('000076048') and D_E_L_E_T_ = ''


Select B6_PRODUTO,Sum(B6_QUANT) QUANT, Sum(B6_CUSTO1) TOTAL From SB6010
Where B6_FILIAL In ('01') --and B6_SALDO > 0  
And B6_DOC In ('000374820','000060291') and D_E_L_E_T_ = ''
Group By B6_PRODUTO



-- Saldo Fisico e Financeiro (Estoque)
-- Script Simples para analise de Total de caracteres numéricos na SB2 com Case
Declare @FILINI Char(4), @FILFIM Char(4), @CODPRODINI Char(10), @CODPRODFIM Char(10);
Set @FILINI = '01'
Set @FILFIM = '03'
Set @CODPRODINI = '1320504401'
Set @CODPRODFIM = '1320504401'

Select B2_FILIAL, B2_COD,B1_DESC, B2_LOCAL, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL, Len(B2_CM1) AS CUS_MED ,

Case 
When Len(B2_VATU1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VATUAL,

Case 
When Len(B2_CM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM

From SB2010 SB2-- With(NoLock)

	Inner Join SB1010 SB1
	On SB1.B1_COD = B2_COD
	And SB1.D_E_L_E_T_ = ''

Where B2_FILIAL Between @FILINI and @FILFIM and B2_COD Between @CODPRODINI and @CODPRODFIM
--and B2_VATU1 <> 0 and B2_CM1 <> 0 and Len(B2_CM1) >= '10' and Len(B2_VATU1) >= '10'
and  SB2.D_E_L_E_T_='' 

-- Casas Decimais        
Declare @FILINI Char(4), @FILFIM Char(4), @CODPRODINI Char(10), @CODPRODFIM Char(10);
Set @FILINI = '01'
Set @FILFIM = '31'
Set @CODPRODINI = '0000000000'
Set @CODPRODFIM = '9999999999'

Select B2_FILIAL, B2_COD,B1_DESC, B2_LOCAL,B1_CUSTD, B2_VATU1, B2_CM1,
Len(B2_VATU1) AS VL_ATUAL_CASAS, Len(B2_CM1) AS CUS_MED_CASAS,

Case 
When Len(B2_VATU1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_VATUAL,

Case 
When Len(B2_CM1) >= '12' Then '************'
Else '0123456789'
End AS Casas_Decimais_CM

From SB2010 SB2-- With(NoLock)

	Inner Join SB1010 SB1
	On SB1.B1_COD = B2_COD
	And SB1.D_E_L_E_T_ = ''

Where B2_FILIAL Between @FILINI and @FILFIM  
and B2_VATU1 <> 0 and B2_CM1 <> 0  and  SB2.D_E_L_E_T_=''   
And Len(B2_VATU1) >= 12
And Len(B2_CM1) >= 12
--and B2_COD In('')
Order By 5 Desc


-- Movimentos Internos 
Select D3_CUSTO1,D3_CF, * From SD3010
Where D3_FILIAL = '01' and D3_CF <> 'DE4'  and D3_EMISSAO Between '20230901' and '20230930' 
and D_E_L_E_T_ = '' and D3_ESTORNO = '' and D3_COD = 'PF1820A'
Order By 1 desc
-- D3_CUSTO1 -- Custos
-- D3_CF *Tipo de Requisicao/devolucao
-- D3_TM - Tipo Movimento
-- dbo.userlgi_normal (D3_USERLGI) - usuario

-- Tipos de movimentação
Select * From SF5010
Where F5_CODIGO = '007' and D_E_L_E_T_ = ''






				-- 05 - SIGAFAT ***********************************************************************************************************************************


--Processamento de NF TSS
Select * From TSSTR1

-- PV - Itens 
Select C6_SEMANA, * From SC6010
Where C6_ENTREG >= '20230101' and D_E_L_E_T_ =''

Select Max(C7_NUM) From SC7010

-- Lista de Repasse 
Select Z9_SEMANA,* From  SZ9010
Where Z9_SEMANA >= '2023001' and D_E_L_E_T_ =''


-- Pedido de Vendas - Cab.
Select  C5_ZZPVDIV,* From SC5010
Where C5_FILIAL In ('01','02','03') and C5_NUM In ('340257')  and D_E_L_E_T_ =''

-- PV - Liberados 
Select C9_BLEST,* From SC9010
--Where C9_FILIAL = '01' and C9_PEDIDO In ('336843') and D_E_L_E_T_ =''
Order By C9_PEDIDO

-- Pedido de Vendas Itens
Select C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,  * From SC6010
Where C6_FILIAL = '01' and C6_NUM = '384171' and (C6_QTDVEN - C6_QTDENT) > 0 and D_E_L_E_T_ =''

-- Pedido de Vendas Itens - Soma 
Select C6_FILIAL,C6_PRODUTO,SUM(C6_QTDVEN) As QTDE_VEDAS, SUM(C6_QTDENT) As QTDE_ENTREGUE, Sum(C6_QTDEMP) As QTDE_EMPENHO,
Sum(C6_QTDVEN - C6_QTDENT) AS SALDO
From SC6010
Where C6_FILIAL = '01' and C6_PRODUTO = '1151002442' and (C6_QTDVEN - C6_QTDENT) > '0' and D_E_L_E_T_ =''
and C6_NUM In ('384171')
Group By C6_FILIAL,C6_PRODUTO

-- Pedido de Vendas Itens
Select C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_BLQ,C6_NUM,  * From SC6010
Where C6_FILIAL = '01' and C6_NUM In ('336843')  and D_E_L_E_T_ =''

Select C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_BLQ, C6_NUM,
(C6_QTDVEN-C6_QTDENT-C6_QTDEMP-C6_RESERVA-C6_BLQ) As Saldo_PV,
* From SC6010
Where C6_FILIAL In ('01') and C6_NUM In ('384171')  and D_E_L_E_T_ =''



--Produto x Cliente 
Select SA1.A1_COD,SA1.A1_LOJA,A1_NOME,A7_PRODUTO, B1_DESC,* From SA7010 SA7 

	Inner Join SA1010 SA1
	On SA1.A1_COD = SA7.A7_CLIENTE
	And SA1.A1_LOJA = SA7.A7_LOJA
	And SA1.D_E_L_E_T_ =''

	Inner Join SB1010 SB1
	On SB1.B1_COD = A7_PRODUTO
	And SB1.D_E_L_E_T_ = ''

Where A7_CLIENTE In ('018043') and A7_LOJA In ('03','04','05','08')
and SA7.D_E_L_E_T_ = ''

--Cliente+Loja para sair na NFe Descrição conforme  tabela SA7 preenchida                             
Select * From SX6010
Where X6_VAR In ('MV_CLNFPRO') and D_E_L_E_T_ =''





Select C6_FILIAL,C6_PRODUTO,C6_DESCRI,Sum(C6_QTDVEN) As VEND, Sum(C6_QTDENT) As ENTREG, Sum(C6_QTDEMP) As EMPEN From SC6010
Where C6_FILIAL In ('01') and C6_NUM In ('384171')  and D_E_L_E_T_ =''
Group BY C6_FILIAL,C6_PRODUTO,C6_DESCRI
Order By 1

Select C6_FILIAL,C6_PRODUTO,C6_DESCRI,Sum(C6_QTDVEN) As VEND, Sum(C6_QTDENT) As ENTREG, Sum(C6_QTDEMP) As EMPEN From SC6010
Where C6_FILIAL In ('01') and C6_NUM In ('098127')  and D_E_L_E_T_ =''
Group BY C6_FILIAL,C6_PRODUTO,C6_DESCRI
Order By 1

Select Sum(C6_QTDVEN) As VEND, Sum(C6_QTDENT) As ENTREG, Sum(C6_QTDEMP) As EMPEN From SC6010
Where C6_FILIAL In ('01') and C6_NUM In ('098127')  and D_E_L_E_T_ =''
Order By 1

Select Sum(C6_QTDVEN) As VEND, Sum(C6_QTDENT) As ENTREG, Sum(C6_QTDEMP) As EMPEN From SC6010
Where C6_FILIAL In ('03') and C6_NUM In ('004172')  and D_E_L_E_T_ =''
Order By 1

Select SC6.C6_FILIAL,SC6.C6_PRODUTO,SC6.C6_DESCRI, SC6.C6_QTDVEN, SC6.C6_QTDENT,SC6.C6_QTDEMP,
SC62.C6_FILIAL,SC62.C6_PRODUTO,SC6.C6_DESCRI,SC62.C6_QTDVEN,SC62.C6_QTDENT,SC62.C6_QTDEMP,
(SC62.C6_QTDVEN-SC6.C6_QTDVEN) As Saldo
From SC6010 SC6

	Left Join SC6010 SC62
	On SC62.C6_PRODUTO = SC6.C6_PRODUTO
	And SC62.C6_FILIAL = '01'
	And SC62.C6_NUM = '098127'
	And SC62.D_E_L_E_T_ =''

Where SC6.C6_FILIAL In ('02') and SC6.C6_NUM In ('107984') and SC6.D_E_L_E_T_ = ''
Order By SC62.C6_PRODUTO


-- Portal de Vendas 

-- Usuarios Portal Vendas
Select * From ZP1010

-- Logs portal Vendas ********
Select ISNULL(CAST(CAST(ZP2_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP2010

-- ZP3 - Orcamento Msg *******
Select ISNULL(CAST(CAST(ZP3_MSG AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS MSG,
* From ZP3010
Where ZP3_NUMORC = ('107984')
And D_E_L_E_T_ =' '

-- Orçamentos
Select   * From ZP4010
Where ZP4_CODIGO = '107984'

-- ZP5 - Orcamento Cab. *******
Select ISNULL(CAST(CAST(ZP5_OBPROC AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSPROC,
ISNULL(CAST(CAST(ZP5_OBS AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBS,
ISNULL(CAST(CAST(ZP5_OBSNF AS VARBINARY(MAX)) AS VARCHAR(MAX)),'') AS OBSNF,ZP5_OBSCAN,ZP5_APROVA,ZP5_LOCKED,
* From ZP5010
Where ZP5_NUM = '379075' and  D_E_L_E_T_ =''
--ZP5_STATUS 
--1=Em Manutencao;2=Aguardando Aprovacao;3=Em Aprovacao;4=Aguardando Confirmacao;5=Confirmado;6=Nao aprovado;7=Cancelado          

-- ZP6 - Orcamento Itens 
Select * From ZP6010
Where ZP6_NUM = '340884'
And D_E_L_E_T_ =' '

-- USUARIOS PORTAL COBRECOM      
Select * From ZP1010
Where ZP1_CODIGO = '000107'
And D_E_L_E_T_ =' '


--Produtos Descriçao
Select * From SZ7010

-------------
Select * From SZ8010


-- ZP9 - Orcamento Itens Cores 
Select * From ZP9010


-- SZ2 - Produto - Bitola 
SELECT  * FROM SZ2010 WHERE Z2_COD IN( '08','04','05')

-- Produtos - Ativo no portal ou nao 
SELECT B1_XPORTAL,* FROM SB1010 WHERE B1_COD IN ('1140805401','1340404401','1340504401')     


--	Anslise PV com a NFe de Cleintes que usam Produto x Cliente Personalizado 
-- Código e Descrição do Produto na NF conforme Cliente
-- Produtos
Select B1_COD, B1_DESC,B1_UM, B1_SEGUM,B1_CONV,B1_TIPCONV, * From SB1010
Where B1_COD = '1150702401'  and D_E_L_E_T_ = ''

-- Produtos Complemento
Select * From SB5010
Where B5_COD = '1150702401'  and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD = '1150702401'  and D_E_L_E_T_ = ''

--SA7 - Amarracao Produto x Cliente
Select * From SA7010
Where A7_CLIENTE = '018043' and A7_LOJA = '05' and A7_PRODUTO = '1150702401'
and D_E_L_E_T_ = ''



-- Clientes
Select A1_XCLICOD,A1_XTRCCOD, * From SA1010
Where A1_COD = '018043' and D_E_L_E_T_ =''

-- NF Saida Itens 
Select D2_DOC,* From SD2010
Where D2_FILIAL = '01' and D2_DOC = '000366590' and D2_COD Like '%1150702401%'
and D_E_L_E_T_ =''


-- NF Saida Cab. 
Select F2_DOC,* From SF2010
Where F2_FILIAL = '02' and F2_DOC = '000148756' 
and D_E_L_E_T_ =''


-- Livro Fiscal Cab.
Select F3_NFISCAL,* From SF3010
Where F3_FILIAL = '01' and F3_NFISCAL = '000366590' --and D2_COD Like '%1150702401%'
and D_E_L_E_T_ =''


-- Livro Fiscal Itens
Select FT_NFISCAL,* From SFT010
Where FT_FILIAL = '01' and FT_NFISCAL = '000366590' 
and D_E_L_E_T_ =''


--Processamento de NF TSS
Select * From TSSTR1  
Where D_E_L_E_T_ = ''

--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
* From SPED050
Where NFE_ID In ('1  000414998') or DATE_NFE >= '20230701' and D_E_L_E_T_ = ''

--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where NFE_ID In ('1  000414998') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''





--Produtos
Select B1_ROLO,B1_BOBINA,B1_XPORTAL,* From SB1010
--B1_XPORTAL
--Uso Portal  
--S=Sim;N=Nao;E=Especial  


-- Analise se PV esta conforme Cadastro de Produtos
-- 
-- PV Itens
Select C6_PRODUTO,B1_XPORTAL,B1_BOBINA,B1_ROLO,C6_QTDVEN,C6_LANCES,C6_METRAGE,C6_ACONDIC,

	--Verifica Tipo de Acondicionamento 
	Case 
	When C6_ACONDIC = 'B' Then 'BOBINA'
	When C6_ACONDIC = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When C6_ACONDIC = 'B' and Isnull((NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When C6_ACONDIC = 'B' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When C6_ACONDIC = 'R' and (NULLIF(C6_QTDVEN,0)/NULLIF(C6_LANCES,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS RECOMENDACAO,


C5_LUCROBR
From SC6010 SC6 With(Nolock)

	--Produtos
	Inner Join SB1010 SB1 With(Nolock)
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	--Produtos
	Inner Join SC5010 SC5 With(Nolock)
	On C5_NUM = C6_NUM
	And C5_FILIAL = C6_FILIAL 
	And SC5.D_E_L_E_T_ = ''



Where C6_FILIAL = '01' and C6_NUM In ('358924')
And SC6.D_E_L_E_T_ = ''
Order By 10

-- ZP9 - Orcamento Itens Cores 
Select B1_XPORTAL,ZP9_NUM,ZP9_ITEM,B1_BOBINA,B1_ROLO,ZP9_TOTAL,ZP9_QUANT,B1_COD,B1_DESC,B1_XPORTAL,

	--Verifica Tipo de Acondicionamento 
	Case 
	When ZP6_ACOND = 'B' Then 'BOBINA'
	When ZP6_ACOND = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS RECOMENDACAO,


* From ZP9010 ZP9

	Inner Join SB1010 SB1
	On B1_COD = ZP9_CODPRO
	And SB1.D_E_L_E_T_ = ''

	Inner Join ZP6010 ZP6
	On ZP6_NUM = ZP9_NUM
	And ZP6_ITEM = ZP9_ITEM
    And ZP6.D_E_L_E_T_ = ''

Where ZP9_NUM = '361525'
And ZP9.D_E_L_E_T_ =' '
Order By 2
--Tipos de Acondionamento 
--{B','BOBINA'}
--{'R','ROLO'}
--{'C','CARRETEL PLASTICO'}
--{'M','CARRETEL MADEIRA'}
--{'L','BLISTER'}



 -- Rasterar Bobinas Empenhadas
--01 - Rasterar Numero de Bobina 
--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,* From SZE010
Where ZE_FILIAL In ('02') and ZE_PRODUTO In ('1520604401') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
And ZE_NUMBOB = '2085868'

-- 02 - Verificar Empenho 
 --SDC - Composicao do Empenho
 -- Verificar Produtos e Qtde e Filial e PV = ZE_CTRLE e Sattus <> ('F','C')
 -- Endereço DC_LOCALIZ = BF_LOCALIZ
Select * From SDC010
Where DC_FILIAL = '02' and DC_PRODUTO = '1520604401'and DC_QUANT > 0
and D_E_L_E_T_ ='' and DC_PEDIDO In ('000032') and DC_LOCALIZ = 'B00389'

-- 03- Verificar Saldos , Empenhos e Endereços
--SBF - Saldos por Endereco
 -- Verificar Produtos e Qtde e Filial Qtde e Qtde Empenhada e Endereço 
Select * From SBF010
Where BF_FILIAL = '02' and BF_PRODUTO = '1520604401'and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ ='' and BF_LOCALIZ = 'B00389'


-- 04 - Rastrar Controle de Vendas 
--ZE_CTRLE = ZZV_ID
-- Verificar Vendedor Responsavel = ZZV_SUPER = SA3 Vendedores 
--ZZV_SUPER = A3_COD
--CONTROLE NEGOCIO VENDAS       
Select ZZV_SUPER,* From ZZV010
Where ZZV_ID = '000032'and D_E_L_E_T_ = ''


-- Vendedores 
Select * From SA3010
Where A3_COD = '159188' and D_E_L_E_T_ = ''



-- Analise Emepnho Vendas 
Select  
       B2_QPEDVEN = ISNULL((SELECT SUM(C6_QTDVEN) 
                           FROM SC6010, SF4010
                          WHERE C6_FILIAL		= B2_FILIAL 
                            AND C6_PRODUTO		= B2_COD
                            AND C6_TES			= F4_CODIGO
                            AND F4_FILIAL		= ' '
                            AND F4_ESTOQUE		= 'S'
                            AND SF4010.D_E_L_E_T_ = ' '
                            AND SC6010.D_E_L_E_T_ = ' '
                            AND C6_NOTA			= ' '
                        ),0),                      
       B2_SALPEDI = ISNULL((SELECT SUM(C7_QUANT-C7_QUJE)
                          FROM SC7010
                         WHERE C7_FILIAL		= B2_FILIAL
                           AND C7_PRODUTO		= B2_COD
                           AND C7_ENCER			!= 'E'
                           AND C7_RESIDUO		!= 'S'
                           AND SC7010.D_E_L_E_T_ =' '),0)
   From SB2010                           
   WHERE B2_FILIAL = '01' AND B2_LOCAL = '01' AND D_E_L_E_T_ = ' '
   And B2_COD = '2010000000'

-- PV Itens 
Select * From SC6010 SC6

Inner Join SF4010 SF4
On C6_TES = F4_CODIGO
And SF4.D_E_L_E_T_ = ' '


Where C6_FILIAL = '01' and C6_PRODUTO = '2010000000'
And (C6_QTDVEN-C6_QTDENT) > 0
And C6_BLQ Not In ('S')
 AND F4_ESTOQUE		= 'S'
AND SC6.D_E_L_E_T_ = ' '


  





				--06 - SIGAFIN ************************************************************************************************************************************

--Financeiro
-- Contas a Receber
Select E1_NUMBOR,E1_SALDO,E1_BAIXA,E1_ZZBC2, E1_ZZBOR1,E1_ZZDTBOR, * From SE1010
Where E1_ZZBOR1 = '907126' and D_E_L_E_T_ =''


-- SE5 - Mov. Bancaria
Select * From SE5010
Where E5_BANCO = '000' and E5_CONTA = '0000000000' and D_E_L_E_T_ = ''

 -- Bordero
 Select * From SEA010
Where EA_NUMBOR In ('S06344') and EA_NUM = '000328311'
Order BY EA_NUMBOR

--SEQ Cabeçalho do Bordero
Select * From SEQ010

--SER Itens do Bordero
Select * From SER010

--SA6 Bancos
Select * From SA6010

-- Clientes
Select * From SA1010
Where A1_CGC = '22902694010310' and D_E_L_E_T_ = ''

--AG1 - CADASTRO DE MODELOS CABECALHO
Select * From AG1010

-- Condicao de Pagamentos 
Select * From SE4010
Where D_E_L_E_T_ ='' and E4_TIPO = 'B'

--SEC - Desmembramento de Cond Pagt
Select * From SEC010


-- Natureza da Operação
Select ED_CALCISS,* From SED010
Where ED_CODIGO In ('C0907') and D_E_L_E_T_ ='' 

-- TES 
Select F4_ISS,F4_LFISS,* From SF4010
Where F4_CODIGO In ('811') and D_E_L_E_T_ ='' 


--Contas a pagar
Select E2_FILIAL,E2_FORNECE,E2_NOMFOR,E2_NUM,E2_TIPO,Sum(E2_VALOR) AS TOTAL, Count(E2_PARCELA) As Parcelas  From SE2010
Where E2_FILIAL In ('01','02','03') and D_E_L_E_T_ ='' --E2_NUM = '000252678'
And E2_BAIXA ='' and E2_SALDO > '0' and E2_VENCTO >= '20230601'
Group By E2_FILIAL,E2_FORNECE,E2_NOMFOR,E2_NUM,E2_TIPO

-- Contas a Receber 
Select E1_FILIAL, E1_CLIENTE, E1_NOMCLI, E1_NUM,E1_TIPO,Sum(E1_VALOR) AS TOTAL, Count(E1_PARCELA) As Parcelas, 
(Sum(E1_VALOR)-Sum(E1_VALLIQ)) As Saldo, SUM(E1_VALLIQ)-Sum(E1_VALOR) As Diferenca
From SE1010
Where E1_FILIAL In ('01','02','03') and D_E_L_E_T_ ='' 
--And E1_BAIXA ='' And E1_SALDO > '0' and E1_EMISSAO >= '20100101'
And E1_CLIENTE In ('031622')
Group By E1_FILIAL,E1_CLIENTE,E1_NOMCLI,E1_NUM,E1_TIPO





-- 07 SIGAGPE - RH ********************************************************************************************************************************


-- RH - Geração de Arquivo de Folha de pagamento - Personalizado
-- Contas a pagar 
Select E2_NUM,E2_PARCELA,E2_PREFIXO,* From SE2010
Where E2_TIPO = 'FOL'
And E2_EMISSAO >= '20240101'
And E2_FORNECE = 'V0076R'
And E2_NUM = 'FER022024'
and D_E_L_E_T_ =''
Order By E2_EMISSAO

--FOLHA PAGAMENTO FINANCEIRA    
Select ZT_NUMSE2,ZT_PARCELA,ZT_PREFIXO,* From SZT010
Where ZT_NUMSE2 = 'FER022024'
and D_E_L_E_T_ =''

Select * From SX3010
Where X3_CAMPO In ('ZT_PARCELA','E2_PARCELA')
and D_E_L_E_T_ =''


--RH
--SR6 - Turnos de Trabalho
Select * From SR6010
Where R6_FILIAL In ('01') and R6_TURNO In ('003') and D_E_L_E_T_ =''
Union 
Select * From SR6010
Where R6_FILIAL In ('02') and R6_TURNO In ('005') and D_E_L_E_T_ =''


-- Horario Padrao  SPJ
Select * From SPJ010
Where PJ_FILIAL In ('01') and PJ_TURNO In ('003') and D_E_L_E_T_ =''
Union 
Select * From SPJ010
Where PJ_FILIAL In ('02') and PJ_TURNO In ('005') and D_E_L_E_T_ =''

--SP8 - Movimento de Marcacoes         
Select * From SP8010
--SPC - Apontamentos
Select * From SPC010

/*
egue tabelas que fazem parte e ou tem influencia no modulo Ponto, espero que ajude:

SP0 - Relógios
SP8 - Marcações
SPG - Marcações Acumuladas
SPC - Apontamento
SPH - Apontamentos Acumulados
SPA - Regra de Apontamento
SP9 - Eventos
SPJ - Tabela de Horário Padrão
RFE - Pré-leitura
RFB - Cabeçalho Pré-leitura
RFD - Motivos de Manutenção
RFF - Pré-ACJEF
RFG - Acumulado Pré-ACJEF
RFH - Acumulado Pré-Leitura
CTT - Centro de Custo
RCE - Sindicatos
SP2 - Exceções
SP3 - Feriados
SPA - Regras de Apontamento
SPE - Crachás Provisórios
SPF - Transferência de Turno
SPJ - Horário Padrão
SR6 - Turnos de Trabalho
SR8 - Controle de Ausências
SRA - Funcionários
SRG - Rescisões
SRH - Férias
SRJ - Funções
*/



-- Parametros S000
Select * From RCC010

--Configuraçoes de Parametros S000
Select * From RCB010

--RCE - Sindicatos
Select * From RCE010


-- LEJ - Predecessao de Eventos
Select * From LEJ010

--C1E - Compl. Estabelecimento
Select C1E_EVENTO,* From C1E010

--C8E - Tipos de Arquivo da e-Social
Select * From C8E010
Where D_E_L_E_T_ =''

 -- RH 
 --RGB - Incidencias
 --SRC - Movimento do Periodo
 --SRD - Historico de Movimentos
 --SRR - Itens de Ferias e Rescisoes
 --SRQ - Beneficiarios
 --RJK - Historico de Medias
 --SRP - Demonstrativo de Medias
 
 -- Ataulização - Calculos 
--SRY; SRY - Roteiros de Cálculo 
--SRM; SRM - Itens Roteiro de Calculo
--RCA; RCA - Mnemonicos
--RC2; RC2 - Cabecalho de Formula
--RC3; RC3 - Formulas

-- Planos de saude 
--RHK - Planos Ativos do Titular/Funcionários 
--RHL - Planos Ativos dos Dependentes
--RH< - Planos Ativos dos Agregados






				-- 09 - SIGAFIS - Livros Fiscais *****************************************************************************************************************
--Fornecedores
Select A2_COD,A2_NOME,A2_DEDBSPC,A2_NATUREZ,A2_RECISS,A2_RECINSS,A2_RECCIDE,A2_GRPTRIB,A2_RECCOFI,A2_RECCSLL,A2_RETISI,A2_PRSTSER,A2_SIMPNAC,
A2_CODINSS,A2_TPJ,A2_IRPROG,* 
From SA2010
Where A2_COD In ('VOP442','V009IX') And D_E_L_E_T_ =''

--A2_DEDBSPC - 
--Titulo: Ded.PIS/COF
--Descricao: Ded. Base de PIS/COFINS
--Help de Campo: Informe o(s) tributo(s) que deve(m) serdeduzido(s) da base de PIS/COFINS nasaquisicoes deste fornecedor.
--As opcoes sao:1 - Legado: Deduz conforme parametros MV_DEDBPIS e MV_DEDBCOF.2 - ICMS e IPI: Deduz ICMS e IPI.
--3 - ICMS: Deduz apenas o ICMS.4 - IPI: Deduz apenas o IPI.5 - Nenhum: Nao deduz nem o ICMS e nem oIPI.
--6 - Soma IPI: Soma IPI quando naoCredita IPI (F4_LFIPI) diferente deTributado

--A2_NATUREZ
--Titulo: Natureza
--Descricao: Cod Natureza Financeira
--Help de Campo: Campo utilizado para informar anaturezado titulo, quando gerado, para omodulo financeiro.


-- TES
Select F4_ISS,F4_LFISS,F4_ICM,F4_BASEICM,F4_LFICM,F4_BASEICM,F4_CONSUMO,F4_PISCOF,F4_PISCRED,
F4_IPI,F4_CREDIPI,
* From SF4010
Where F4_CODIGO In ('050','001','017','403','034','435','437') and D_E_L_E_T_ = ''
--F4_ISS	Calculo ISS	Incide ISS ?	
--F4_LFISS	L.Fiscal ISS	
-- Calc. ICMS (F4_ICM) = S
--%Red.do ICMS (F4_BASEICM) = Informe o valor a ser calculado do ICMS próprio
--Livro Fiscal ICMS (F4_LFICM) = ISENTO/ OUTROS
-- F4_CONSUMO - Material de Consumo?
--F4_PISCOF	PIS/COFINS	Define se gera PIS/COFINS	
--F4_PISCRED	Cred.PIS/COF	Credita PIS/COFINS
--F4_IPI	Calcula IPI	Calcula IPI (SNR)?	C	Real	1
--F4_CREDIPI	Credita IPI	Credita IPI?

--Excessão Fiscal 
Select * From SF7010


--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_TEXTO,F4_FORMULA,* From SF4010
Where F4_CODIGO In ('502','552','629') and D_E_L_E_T_ =''

--SM4 - Formulas
Select * From SM4010
Where M4_CODIGO In ('20','031','19')and D_E_L_E_T_ =''

-- NF Saida Itens 
Select Distinct D2_TES,F4_TEXTO,D2_FORMUL, M4_FORMULA, D2_DOC From SD2010 SD2
 
    -- TES
	Inner Join SF4010 SF4 With(Nolock)
	ON SF4.F4_CODIGO = D2_TES
	And SF4.D_E_L_E_T_ = ''

	 -- Formulas
	LEFT Join SM4010 SM4 With(Nolock)
	ON SM4.M4_CODIGO = F4_FORMULA
	And SF4.D_E_L_E_T_ = ''


Where D2_FILIAL = '03' and D2_DOC In ('000004791','000004804','000005295','000005304') and SD2.D_E_L_E_T_ =''
 
 -- NF Saida Cab.
Select  F2_DOC,F2_FORMUL,M4_FORMULA From SF2010 SF2
 
   	 -- Formulas
	LEFT Join SM4010 SM4 With(Nolock)
	ON SM4.M4_CODIGO = F2_FORMUL
	And SM4.D_E_L_E_T_ = ''


Where F2_FILIAL = '03' and F2_DOC In ('000004791','000004804','000005295','000005304') and SF2.D_E_L_E_T_ =''
 




-- PV Cab.
Select C5_MENNOTA,C5_MENPAD,M4_FORMULA,C5_NOTA,* From SC5010 SC5

	 -- Formulas
	LEFT Join SM4010 SM4 With(Nolock)
	ON SM4.M4_CODIGO = C5_MENPAD
	And SM4.D_E_L_E_T_ = ''

Where C5_FILIAL = '03' and C5_NUM In ('003721','004123','003597','004148') and SC5.D_E_L_E_T_ =''
 
 -- Clientes 
 Select A1_MENPAD,M4_FORMULA,* From SA1010 SA1

	-- Formulas
	LEFT Join SM4010 SM4 With(Nolock)
	ON SM4.M4_CODIGO = A1_MENPAD
	And SM4.D_E_L_E_T_ = ''


 Where A1_COD In ('032895','011940','042528','002560') and SA1.D_E_L_E_T_ =''

 --Pedidos de Vendas Cab.
  Select * From SC5010
  --Pedidos de Vendas Itens 
  Select * From SC6010
  -- NF Saida Itens
  Select * From SD2010
  -- NF Saida Cab.
  Select * From SF2010
  -- Formulas
  Select * From SM4010
  -- TES
 Select * From SF4010

 
 --ISS 
 -- Produtos
Select B1_ALIQISS,B1_CODISS, * From SB1010
Where B1_COD = 'MC13000952'  and D_E_L_E_T_ = ''

/*-- Produtos Complemento
Select * From SB5010
Where B5_COD = 'MC13000952'  and D_E_L_E_T_ = ''

-- Produtos Indicadores 
Select * From SBZ010
Where BZ_COD = 'MC13000952'  and D_E_L_E_T_ = ''*/

-- Fornecedor
Select A2_RECISS,* From SA2010
Where A2_COD In ('V0080Q') and D_E_L_E_T_ = ''

-- Clientes 
Select A1_RECISS, A1_FRETISS,* From SA1010
Where A1_COD In ('V0080Q') and D_E_L_E_T_ = ''


-- NF Tipo I = Complementar 
-- Livro Fiscal Cab.
Select F3_NFISCAL,FT_NFORI,FT_PRODUTO,B1_DESC,SF3.F3_OBSERV,F3_TIPO,FT_TES,F4_TEXTO,F4_CREDST,F3_ICMSRET,F3_ICMSCOM,F3_CREDST,F3_CREDACU,
SFT.FT_NFISCAL,SF1.F1_DOC,SD1.D1_DOC,SF2.F2_DOC,SD2.D2_DOC,SF3.F3_ENTRADA,SF3.F3_CLIEFOR
 From SF3010 SF3 -- Livro Fiscal Cab.
	
	-- Livro Fiscal Itens
	Inner Join SFT010 SFT
	On SFT.FT_FILIAL = SF3.F3_FILIAL
	And SFT.FT_CLIEFOR = SF3.F3_CLIEFOR
	And SFT.FT_LOJA = SF3.F3_LOJA
	And SFT.FT_NFISCAL = SF3.F3_NFISCAL
	And SFT.FT_SERIE = SF3.F3_SERIE
	And SFT.D_E_L_E_T_ = ''

	--NF Entrada Cab.
	Left Join SF1010 SF1
	On SF1.F1_FILIAL = SF3.F3_FILIAL
	And SF1.F1_FORNECE = SF3.F3_CLIEFOR
	And SF1.F1_LOJA = SF3.F3_LOJA
	And SF1.F1_DOC = SF3.F3_NFISCAL
	And SF1.F1_SERIE = SF3.F3_SERIE
	And SF1.D_E_L_E_T_ = ''

	--NF Entrada Itens 
	Left Join SD1010 SD1
	On SD1.D1_FILIAL = SF3.F3_FILIAL
	And SD1.D1_FORNECE = SF3.F3_CLIEFOR
	And SD1.D1_LOJA = SF3.F3_LOJA
	And SD1.D1_DOC = SF3.F3_NFISCAL
	And SD1.D1_SERIE = SF3.F3_SERIE
	And SD1.D_E_L_E_T_ = ''

	--NF Entrada Cab.
	Left Join SF2010 SF2
	On SF2.F2_FILIAL = SF3.F3_FILIAL
	And SF2.F2_CLIENT = SF3.F3_CLIEFOR
	And SF2.F2_LOJA = SF3.F3_LOJA
	And SF2.F2_DOC = SF3.F3_NFISCAL
	And SF2.F2_SERIE = SF3.F3_SERIE
	And SF2.D_E_L_E_T_ = ''

	--NF Entrada Itens 
	Left Join SD2010 SD2
	On SD2.D2_FILIAL = SF3.F3_FILIAL
	And SD2.D2_CLIENTE = SF3.F3_CLIEFOR
	And SD2.D2_LOJA = SF3.F3_LOJA
	And SD2.D2_DOC = SF3.F3_NFISCAL
	And SD2.D2_SERIE = SF3.F3_SERIE
	And SD2.D_E_L_E_T_ = ''


	-- TES 
	Left Join SF4010 SF4
	On FT_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1
	On SB1.B1_COD = FT_PRODUTO
	And SB1.D_E_L_E_T_ = ''
	   	
Where F3_ICMSRET > 0  and F3_TIPO = 'I'and SF3.D_E_L_E_T_ =''
And F3_CFO Between '1000' and '2999'
Order By 17


--MATA953
--CDH - Apuracao de ICMS
Select Distinct  
CDH_FILIAL,CDH_DESC,CDH_VALOR,CDH_DTINI, CDH_DTFIM,CDH_LINHA From CDH010
Where CDH_FILIAL In ('01','02','03') and CDH_LINHA In ('009','014') --004 014 009
And CDH_DTINI >= '20230501' and CDH_DTFIM <=  '20230731' And CDH_VALOR >= 0
And CDH_TIPOIP In ('IC')
And CDH_DESC In ('Saldo Credor do Periodo Anterior','Saldo Credor ( Credito menos Debito)')
and D_E_L_E_T_ ='' 
Group By CDH_FILIAL,CDH_DESC,CDH_VALOR,CDH_DTINI, CDH_DTFIM,CDH_LINHA
Order By 1,4,6




--CDP - Apuracoes de IPI
Select CDP_FILIAL,CDP_DESC,CDP_VALOR,CDP_DTINI, CDP_DTFIM,CDP_LINHA From CDP010
Where CDP_FILIAL In ('01','02','03') and CDP_LINHA In ('007','017')
And CDP_DTINI >= '20230401' and CDP_DTFIM >=  '20230430'
and D_E_L_E_T_ ='' 
Group By  CDP_FILIAL,CDP_DESC,CDP_VALOR,CDP_DTINI, CDP_DTFIM,CDP_LINHA
Order By CDP_DTINI,CDP_LINHA


--TAFA063
--C2S - Apuração de ICMS
Select C2S_CRESEG,C2S_CREANT,(C2S_TOTCRE - C2S_TOTDEB + C2S_TOTREC) as DIF, 
(C2S_TOTCRE - C2S_TOTDEB) as CRED_DEB,C2S_SDOAPU,C2S_TOTREC,
* From C2S010




--Cadastro Ajustes IPI
Select * From CCK010

--Cadastro Ajustes IPI
Select * From CC6010


--C3E - Códigos das obrigações de ICMS
Select * From C3E010

--C3J - Apuração de ICMS ST
Select * From C3J010

--C3M - Informações adicionais ICMS ST
Select * From C3M010

--C3N - Obrigações a recolher ICMS ST
Select * From C3N010



--CDV - INFORMACOES ADICIONAIS DA APUR
Select * From CDV010

--CE0 - REFLEXO LANCAMENTO NF
Select * From CE0010

-- Campos das Tabelas
Select * From SX3010
Where X3_ARQUIVO = 'SA4' and X3_CAMPO = 'A4_COD'
And D_E_L_E_T_ = ''






-- 10 - PCP **************************************************************************************************************************************

-- ZZR Aglutinação Ordens de Separação
-- Ultimo númeração
SELECT MAX(ZZR_OS)
FROM ZZR010
WHERE ZZR_FILIAL = '01'
AND ZZR_OS LIKE 'OS%'
AND D_E_L_E_T_ = ''

-- SC2 - Ordens de Producao 
-- Ajustes Números OS
SELECT C2_FILIAL, MAX(C2_NUM)
FROM SC2010
WHERE D_E_L_E_T_ = ''
AND C2_EMISSAO >= '20230524'
AND C2_NUM NOT LIKE '2023%'
AND C2_NUM NOT LIKE '55%'
GROUP BY C2_FILIAL


--SDC - Composicao do Empenho
Select * From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = '11409004401'and DC_QUANT > 0
and D_E_L_E_T_ ='' and DC_PEDIDO In ('384171')

--SDC - Composicao do Empenho - Soma Empenho
Select DC_FILIAL, DC_PRODUTO, Sum(DC_QUANT) Empenho 
From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = '1150904401'and DC_QUANT > 0 and 
D_E_L_E_T_ =''
Group By DC_FILIAL, DC_PRODUTO

--SBF - Saldos por Endereco
Select * From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO = '1151002442'and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ =''

--SBF - Saldos por Endereco - Soma Empenho
Select BF_FILIAL, BF_PRODUTO, Sum(BF_QUANT) QTDE, Sum(BF_EMPENHO) EMPENHO
From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO = '1151002442'and BF_QUANT > 0 and BF_EMPENHO > 0
And D_E_L_E_T_ =''
Group By BF_FILIAL, BF_PRODUTO

--SZE -> Tabela de Bobinas
Select * From SZE010
Where ZE_FILIAL In ('01') and ZE_PRODUTO In ('1151002442') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')

-- Valida Números Decimais
Select (ZE_QUANT-Cast(ZE_QUANT As Int))As RESTO,Cast(ZE_QUANT As Int) As Inteiro, ZE_QUANT,* From SZE010
Where ZE_STATUS Not in  ('F','C') And D_E_L_E_T_ =''
And (ZE_QUANT-Cast(ZE_QUANT As Int)) > 0

 
 --SBF -> Controla o saldo no acondicionamento
Select * From SBF010
Where BF_FILIAL In ('01') and BF_PRODUTO In ('1151002442') and D_E_L_E_T_ =''

-- Valida Números Decimais
Select (BF_QUANT-Cast(BF_QUANT As Int))As RESTO,Cast(BF_QUANT As Int) As Inteiro, BF_QUANT,* From SBF010
Where D_E_L_E_T_ =' '
And (BF_QUANT-Cast(BF_QUANT As Int)) > 0


--SZL > Controle de Pesagem
Select * From SZL010
Where ZL_FILIAL In ('02') and ZL_PRODUTO In ('1041000775') and D_E_L_E_T_ ='' and ZL_NUMBOB = '2213653'

-- Valida Números Decimais
Select (ZL_QTUNMOV-Cast(ZL_QTUNMOV As Int))As RESTO,Cast(ZL_QTUNMOV As Int) As Inteiro, ZL_QTUNMOV,* From SZL010
Where D_E_L_E_T_ =' '
And (ZL_QTUNMOV-Cast(ZL_QTUNMOV As Int)) > 0


-- Funcao Industrializacao
--CDEST20
-- NF Saida
Select D2_TES, D2_XOPER,* From SD2010
Where D2_FILIAL = '01'and D2_DOC = '000392741' and D_E_L_E_T_ ='' 
and D2_XOPER = '09'


Select D1_TES, * From SD1010
Where D1_FILIAL = '01'and D1_DOC = '000000227' and D_E_L_E_T_ ='' 

  -- TES
 Select * From SF4010
 Where F4_CODIGO In ('539','551','839')
 
 SELECT D2_XOPER, *
--UPDATE SD2010 SET D2_TES = '551'
FROM SD2010
WHERE D2_FILIAL = '01'
--AND D2_DOC = '000361140'
AND D2_TES NOT IN ('551','539')
AND D_E_L_E_T_ = ''


-- Transferencia ITU - Tres Lagoas - Produto acabado
--ctrlTransFilial

--Produtos 
Select B1_LOCALIZ,B1_TIPO,* From SB1010
Where B1_COD = '1910200100'
--B1_LOCALIZ - Controle por Endereço.
--B1_TIPO - PA,01,99
---Não permitir classificar documento se campo F4_ESTOQUE == S e o B1_TIPO do item contido no parametro MV_ZZB1F4E

-- Parametros 
Select * From SX6010
Where X6_VAR = 'MV_ZZB1F4E'

-- Tabelas Genericas 
Select * From SX5010
Where X5_TABELA = '02' and X5_CHAVE In ('AI','MC','MO') and X5_FILIAL = ''
and D_E_L_E_T_ = ''

--SDB - Movimentos de Distribuicao
Select * From SDB010
Where DB_FILIAL In ('01','02','03') and DB_PRODUTO = '1910200100' and D_E_L_E_T_ =''

--SDA - Saldos a Distribuir
Select * From SDA010
Where DA_FILIAL In ('01','02','03') and DA_PRODUTO = '1910200100' and D_E_L_E_T_ =''

--Ordens em Processo de Expedição
SELECT ZZR_OS, ZZR_SITUAC, ZZR_DOC, *

FROM ZZR010

WHERE ZZR_FILIAL = '02'

AND ZZR_PEDIDO = '39271'

AND D_E_L_E_T_ = ''

AND ZZR_DOC = ''



SELECT ZZR_OS, ZZR_SITUAC, ZZR_DOC, *

FROM ZZR010

WHERE ZZR_FILIAL = '01'

AND ZZR_OS = 'OS000730'

AND D_E_L_E_T_ = ''

AND ZZR_DOC = ''



-- PV / Expedição Empenho com Problemas
--Faturamento tem que ser Completo 01 OS para 01 NF, não pode ser parcial
-- PV Liberado 
Select C9_SEQOS,* From SC9010
Where C9_PRODUTO In ('1150401401') and C9_PEDIDO = '099131' and D_E_L_E_T_ = ''

-- ZZR Aglutinação Ordens de Separação
Select ZZR_SEQOS,ZZR_OS,* From ZZR010
Where ZZR_PEDIDO = '099131' and ZZR_PRODUT In ('1150401401') and D_E_L_E_T_ =''
and ZZR_ITEMPV In ('01') and ZZR_SITUAC <> '9'
-- ZZR_OS - ZZ9_ORDSEP


--Bobinas 
Select ZE_SEQOS,* From SZE010
Where ZE_PEDIDO = '099131' and ZE_PRODUTO In ('1150401401') and D_E_L_E_T_= ''
and ZE_ITEM In ('01')

--Ordem de Carga 
Select * From ZZ9010
Where ZZ9_FILIAL = '02'and ZZ9_ORDSEP = '09913101' and D_E_L_E_T_= ''
-- ZZR_OS - ZZ9_ORDSEP

-- Desbalanceamento Tabelas 

-- ZZR Aglutinação Ordens de Separação
SELECT ZZR_DOC, ZZR_SERIE, ZZR_ITEM,*
--UPDATE ZZR010 SET ZZR_DOC = '000366325', ZZR_SERIE = '1  '
FROM ZZR010
WHERE ZZR_FILIAL = '01'
AND ZZR_OS LIKE '387470%'
--AND ZZR_ITEMPV = '08'
AND D_E_L_E_T_ = ''

----Bobinas 
SELECT *
--UPDATE SZE010 SET ZE_DOC = '000366325', ZE_SERIE = '1  ', ZE_STATUS = 'F'
FROM SZE010
WHERE ZE_FILIAL = '01'
AND ZE_PEDIDO = '387470'
--AND ZE_STATUS = 'E'
AND D_E_L_E_T_ = ''

--ZZ_USAPRTE - Aprovação Tecnica - CADORCPORT

				-- 78 - SIGAGFE - Gestao de Fretes CTe **********************************************************************************************************

 -- Verificador CTEx NF Entrada x NF Saida x Financeiro x TES x Fornecedor x Transportadora x Ordem de Carga 
 -- NF Entrada Cab
Select Distinct  F1_FILIAL,F1_ESPECIE,F1_DOC,F1_DUPL,E2_NUM,F2_DOC,ZZ9_DOC,
E2_VALOR,F1_VALBRUT,F1_VALMERC, F1_VALPEDG,GXG_PEDAG,(F1_VALBRUT-F1_VALMERC) As DIF,
D1_TES,F4_TEXTO, F4_AGRPEDG,
(F1_VALPEDG-GXG_PEDAG) As DIF_PEDG,
F1_VALICM,F1_VALIMP5,F1_VALIMP6,D1_COD,
F1_FORNECE,F2_TRANSP,ZZ9_TRANSP,A2_CGC,A2_NOME,A4_CGC,A4_NOME,E2_FORNECE,E2_NOMFOR,
GXG_CTE,GXH_NRIMP,GXG.GXG_NRIMP,F2_CHVNFE,GXH_DANFE,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'') AS [CTE],
	
	Case 
	When F1_VALMERC <> E2_VALOR Then 'CALC C/ PEDAGIO'
	When F1_VALMERC = E2_VALOR Then 'CALC S/ PEDAGIO'
	Else 'ANALISAR'
	End AS Status_ 


From SF1010 SF1 With(NoLock)

	-- Contas a pagar
	Inner Join SE2010 SE2 With(NoLock)
	On E2_FILIAL = F1_FILIAL
	And E2_LOJA = F1_LOJA
	And E2_NUM = F1_DOC
	And E2_FORNECE = F1_FORNECE
	And SE2.D_E_L_E_T_ = ''

	--NF Entrada Itens 
	Inner Join SD1010 SD1 With(NoLock)
	On D1_FILIAL = F1_FILIAL
	And D1_LOJA = F1_LOJA
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And SD1.D_E_L_E_T_ = ''
	
	-- GXG - EDI - Documento de Frete
	Inner Join GXG010 GXG With(NoLock)
	On GXG.GXG_FILIAL = F1_FILIAL
	And GXG.GXG_CTE = F1_CHVNFE
	And GXG.D_E_L_E_T_ = ''

	--GXH - EDI - DOC CARGA DO DOC FRETE
	Inner Join GXH010 GXH With(NoLock)
	On GXH.GXH_FILIAL = GXG.GXG_FILIAL
	And GXH.GXH_NRIMP = GXG.GXG_NRIMP
	And GXH.D_E_L_E_T_ = ''
	And GXH.GXH_SEQ = '00001'

	-- NF Saida - Cab.
	Left Join SF2010 SF2 With(NoLock)
	On SF2.F2_FILIAL = GXH.GXH_FILIAL
	And SF2.F2_CHVNFE = GXH.GXH_DANFE
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SF2.D_E_L_E_T_ = ''

	-- NF Saida - Itens 
	Left Join SD2010 SD2 With(NoLock)
	On SD2.D2_FILIAL = SF2.F2_FILIAL
	And SD2.D2_DOC = SF2.F2_DOC
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SD2.D_E_L_E_T_ = ''

		
	-- Ordem de Carga 
	Left Join ZZ9010 ZZ9 With(NoLock)
	On ZZ9_FILIAL = F2_FILIAL
	And ZZ9_DOC = F2_DOC
	And ZZ9_TRANSP = F2_TRANSP
	And ZZ9.D_E_L_E_T_ =''

	-- Transpotadora
	Left Join SA4010 SA4 With(NoLock)
	On SA4.A4_COD = F2_TRANSP
	And SA4.D_E_L_E_T_ = ''

		-- Fornecedor
	Left Join SA2010 SA2 With(NoLock)
	On SA2.A2_COD = F1_FORNECE
	And SA2.A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''


	-- TES
	Inner Join SF4010 SF4 With(NoLock)
	On F4_CODIGO = D1_TES
	And SF4.D_E_L_E_T_ =''
	
Where F1_FILIAL In ('01','02','03') and F1_CHVNFE In ('35231236291207000100570020000029761000750894') or GXG.GXG_CTE In ('35231236291207000100570020000029761000750894')
And SF1.F1_EMISSAO Between '20230112' and '20240131'
--And (F1_VALPEDG-GXG_PEDAG) > 0
--And SF1.F1_VALMERC <> SE2.E2_VALOR 
--And SE2.E2_BAIXA = '' and SE2.E2_SALDO > 0
--AND GXG.GXG_NRIMP IN ('4A095576264D4E11') 
And SF1.D_E_L_E_T_ =''
Order By  25,3



--GU3 - EMITENTES DE TRANSPORTE
Select * From GU3010
Where GU3_DTIMPL = '20230531' and D_E_L_E_T_ =''

--GXG - EDI - Documento de Frete
Select GXG_CTE,GXG_CDDEST,GXG_PEDAG,* From GXG010
Where GXG_FILIAL In ('01','02','03') and GXG_DTENT >= '20231201' and D_E_L_E_T_ = ''
and GXG_CDDEST = ''


--GXG - EDI - Documento de Frete
Select GXG_ZZIDTO TOMADOR,GXG_CDREM REMETENTE,GXG_CDDEST DESTINO, GXG_CTE, * From GXG010
Where GXG_CTE In ('35231236291207000100570020000029761000750894') and D_E_L_E_T_ = ''

-- Validador --GXH - EDI - DOC CARGA DO DOC FRETE - CTEs com mesma Chave
Select GXG_CTE,Count(GXG_CTE) As QTDE_CTE  From GXG010
Where  D_E_L_E_T_ = '' and GXG_DTEMIS >= '20240101' 
Group By GXG_CTE
Order By 2 Desc

-- Validador - --GXH - EDI - DOC CARGA DO DOC FRETE - CTEs Filial em Branco
SELECT GXG_DTEMIS, GXG.*
--UPDATE GXG010 SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = GXG.R_E_C_N_O_
FROM GXG010 GXG
WHERE GXG_FILIAL BETWEEN '01' AND '03'
--AND GXG_DTEMIS BETWEEN '20230501' AND '20230531'
--AND GXG_DTEMIS >= '20230501'
AND GXG.GXG_CDDEST = ''
--AND GXG_CTE = '35230533674308000171570010000222571000222579'
--AND GXG.R_E_C_N_O_ = 145084
AND GXG.D_E_L_E_T_ = '' and GXG_DTEMIS >= '20240601' 
--GXG_CDDEST	Cod Dest	Codigo do Destinatario

-- Fornecedores Tranportadoras não cadastradas 
SELECT *
FROM GXG010 GXG
LEFT JOIN SA2010 SA2 ON '' =A2_FILIAL
					AND  GXG_EMISDF = SA2.A2_CGC
					AND GXG.D_E_L_E_T_ = SA2.D_E_L_E_T_
WHERE GXG_FILIAL = '01'
AND GXG_EDISIT = '1' --STATUS IMPORTADO
AND SA2.A2_COD IS NULL --NÃO TEM CADASTRO DE FORNECEDOR
AND GXG.D_E_L_E_T_ = ''



--GXH - EDI - DOC CARGA DO DOC FRETE

Select * From GXH010
Where GXH_NRIMP = '5fc0813522474000' and D_E_L_E_T_ = ''



--ORDEM DE CARGA                
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'') AS [CTE],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSVOLU)),'') AS [VOL],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSINFO)),'') AS [INFO],
* From  ZZ9010 With(Nolock)
Where ZZ9_DOC In ('')
and D_E_L_E_T_ = ''
Order By ZZ9_DOC


 --- GXG - EDI - Documento de Frete
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_OBS)),'') AS [OBS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_EDIMSG)),'') AS [MGS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_ZZMSG)),'') AS [ZZMGS],
* From  GXG010
Where GXG_CTE In ('35231236291207000100570020000029761000750894')
And D_E_L_E_T_ = ''


--Company
Select * From SYS_COMPANY
Where M0_CGC In ('02544042000208','02544042000119') and D_E_L_E_T_ = ''

--NF Entrada Cab.
Select * From SF1010
Where F1_CHVNFE = '35230524146818000185570010000726851003657350'and D_E_L_E_T_ =''

--NF Entrada Itens 
Select * From SD1010
Where D1_FILIAL In('02' ) and D1_DOC In ('000072685') and D_E_L_E_T_ ='' 

-- Livro Fiscal Cab.
Select * From SF3010
Where F3_CHVNFE = '35230524146818000185570010000726851003657350'and D_E_L_E_T_ =''

--Livro Fiscal Itens 
Select * From SFT010
Where FT_FILIAL In('02' ) and FT_NFISCAL In ('000072685') and FT_CLIEFOR = 'VOOYCV'
and D_E_L_E_T_ ='' 



-- Tranportadoras x Transportadoras (Fat x GFE)
Select A4_CGC,* From SA4010
Where A4_COD = '000976'

Select A4_COD,A4_CGC,A4_NOME,* From GU3010 GU3

	Inner Join SA4010 SA4
	On A4_CGC = GU3_CDEMIT
	And SA4.D_E_L_E_T_ = ''

Where GU3.D_E_L_E_T_ = ''



-- 84 - SIGATAF - Automação Fiscal ***************************************************************************************************************
-- NF Saida Cabec.
Select F2_FIMP,F2_DTLANC,F2_STATUS,* From SF2010
Where F2_FILIAL  = '03' and F2_DOC >= '000005615'
--F2_FIMP - Flag de Impressao
--F2_DTLANC - Data do Lanc. Contab.
--F2_STATUS - 	Status NFE	Status Canc. NFE


--Processamento de NF TSS
Select * From TSSTR1  
Where D_E_L_E_T_ = ''

--Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_ERP)),'') AS [XML_ERP],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_SIG)),'') AS [XML_SIG],
ISNULL(CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), XML_TSS)),'') AS [XML_TSS],
* From SPED050
Where NFE_ID In ('1  000366590') and DATE_NFE >= '20230701' and D_E_L_E_T_ = ''

--Lotes X Nota Fiscal Eletrônica
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), XML_PROT)),'') AS [XML_PROT],
* From SPED054
Where NFE_ID In ('1  000366590') and DTREC_SEFR >= '20230701' and D_E_L_E_T_ = ''

/*Status NF-e (tabela SPED050)
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status de Cancelamento/Inutilização (tabela SPED050)
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilização

Status Mail (tabela SPED050) 
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissao – cancelamento/inutilização*/

/*
Segue abaixo lista de Rotinas, eventos e tabelas relacionadas:
ROTINA EVENTO TABELAS DO BANCO DE DADOS
TAFA050 => S-1000 => C1E, C1F, CR9, CRM, CUW, CZR
TAFA253 => S-1005 => C92, T0Z
TAFA232 => S-1010 => C8R, T5N, C1G
TAFA246 => S-1020 => C99, T03, C1G
TAFA235 => S-1030 => C8V, T10, T11
TAFA467 => S-1035 => T5K
TAFA236 => S-1040 => C8X
TAFA238 => S-1050 => C90, CRL
TAFA389 => S-1060 => T04, T09
TAFA051 => S-1070 => C1G, T5L
TAFA248 => S-1080 => C8W
TAFA250 => S-1200 => C91, T6W, CRN, C1G, T14, C9K, C9L, C9M, T6Y, T6Z, C9N, C9O, C9P, C9Q, C9R, C9V
TAFA413 => S-1202 => C91, C9Y, CRN, C1G, T14, T6C, T6D, C8R, T6E, T6F, T6G, T61, T6H, T6I, T6J, T6K, C9V
TAFA470 => S-1207 => T62, T63, T5T, C8R, T6O
TAFA407 => S-1210 => T3P, T3Q, T3R , LE2, LE3, LE4, T6P, T6Q, T6R, T5V, T5U, T5Y, T5Z, T5X, T5Z, T3Q
TAFA272 => S-1250 => CMR, CMS, CMT, CMU, CMV, T1Z
TAFA414 => S-1260 => T1M, T1N, T1O, T1P, T6B
TAFA408 => S-1270 => T2A, T1Y
TAFA410 => S-1280 => T3V, T3X
TAFA477 => S-1295 => T72
TAFA416 => S-1298 => T1S
TAFA303 => S-1299 => CUO
TAFA412 => S-1300 => T3Z, T2L
TAFA403 => S-2190 => T3A
TAFA278 => S-2200 => C9V, C9Y, CUP, CRQ, T3L, T80, T90
TAFA275 => S-2205 => T1U, T3T
TAFA276 => S-2206 => T1V, T79
TAFA257 => S-2210 => CM0, CM1, CM2, CM7, C9V
TAFA258 => S-2220 => C8B, C9W, CM7, CRP, C9V
TAFA528 => S-2221 => V3B, C9V
TAFA261 => S-2230 => CM6, CM7, T6M, C9V
TAFA264 => S-2240 => CM9, T0Q, CMA, LEA, LEB, CMB, CM9, T3S, V3E, C9V
TAFA404 => S-2241 => T3B, T3C, T3D, T3N, T3O, C9V
TAFA529 => S-2245 => V3C, V3G, C9V, C87
TAFA263 => S-2250 => CM8, C9V
TAFA484 => S-2260 => T87, C9V
TAFA267 => S-2298 => CMF, C9V
TAFA266 => S-2299 => CMD, T06, T05, T15, T16, T3G, T5I, T5J, T3G, T5S, T5Q, T3H, C9J, T88, C9V
TAFA279 => S-2300 => CUU, T2F, C9V
TAFA277 => S-2306 => T0F
TAFA280 => S-2399 => CUU, T92, T3I, T3J, CMK, T15, T16, T3H, C9J, C9V
TAFA469 => S-2400 => T5T
TAFA269 => S-3000 => CMJ
TAFA423 => S-5001 => T2M, T2N, T2O, T2P, T2Q, T2R, T2S
TAFA422 => S-5002 => T2G, T2H, T2I, T2J
TAFA520 => S-5003 => V2P, V2Q, V2R, V2S, V2T, V2U, V2V, V2W, V2X, V2Y
TAFA425 => S-5011 => T2V, T2X, T2Y, T0E, T2Z, T0A, T70, T0B, T0C, T0D
TAFA426 => S-5012 => T0G, T0H
TAFA521 => S-5013 => V2Z, V20, V21, V22, V23, V24, V25


EVENTO | ROTINA  | TABELA | DETALHES
| -----------------------   |
| S-1000 | TAFA050 |  C1E   | - Informações do Empregador/Contribuinte/Órgão Público
| S-1005 | TAFA253 |  C92   | - Tabela de Estabelecimentos, Obras ou Unidades de Órgãos Públicos
| S-1010 | TAFA232 |  C8R   | - Tabela de Rubricas
| S-1020 | TAFA246 |  C99   | - Tabela de Lotações Tributárias
| S-1030 | TAFA235 |  C8V   | - Tabela de Cargos/Empregos Públicos
| S-1035 | TAFA467 |  T5K   | - Tabela de Carreiras Públicas
| S-1040 | TAFA236 |  C8X   | - Tabela de Funções e Cargos em Comissão
| S-1050 | TAFA238 |  C90   | - Tabela de Horários/Turnos de Trabalho
| S-1060 | TAFA389 |  T04   | - Tabela de Ambientes de Trabalho
| S-1070 | TAFA051 |  C1G   | - Tabela de Processos Administrativos/Judiciais
| S-1080 | TAFA248 |  C8W   | - Tabela de Operadores Portuários
| S-1200 | TAFA250 |  C91   | - Remuneração de trabalhador vinculado ao Regime Geral de Previdência Social
| S-1202 | TAFA413 |  C91   | - Remuneração de servidor vinculado a Regime Próprio de Previdência Social – RPPS
| S-1207 | TAFA470 |  T62   | - Benefícios Previdenciários - RPPS
| S-1210 | TAFA407 |  T3P   | - Pagamentos de Rendimentos do Trabalho
| S-1250 | TAFA272 |  CMR   | - Aquisição de Produção Rural
| S-1260 | TAFA414 |  T1M   | - Comercialização da Produção Rural Pessoa Física
| S-1270 | TAFA408 |  T2A   | - Contratação de Trabalhadores Avulsos Não Portuários
| S-1280 | TAFA410 |  T3V   | - Informações Complementares aos Eventos Periódicos
| S-1295 | TAFA477 |  T72   | - Solicitação de Totalização para Pagamento em Contingência
| S-1298 | TAFA416 |  T1S   | - Reabertura dos Eventos Periódicos
| S-1299 | TAFA303 |  CUO   | - Fechamento dos Eventos Periódicos
| S-1300 | TAFA412 |  T3Z   | - Contribuição Sindical Patronal
| S-2190 | TAFA403 |  T3A   | - Admissão de Trabalhador – Registro Preliminar
| S-2200 | TAFA278 |  C9V   | - Cadastramento Inicial do Vínculo e Admissão/Ingresso de Trabalhador
| S-2205 | TAFA275 |  T1U   | - Alteração de Dados Cadastrais do Trabalhador
| S-2206 | TAFA276 |  T1V   | - Alteração de Contrato de Trabalho
| S-2210 | TAFA257 |  CM0   | - Comunicação de Acidente de Trabalho
| S-2220 | TAFA258 |  C8B   | - Monitoramento da Saúde doTrabalhador
| S-2230 | TAFA261 |  CM6   | - Afastamento Temporário
| S-2240 | TAFA264 |  CM9   | - Condições Ambientais do Trabalho - Fatores de Risco
| S-2241 | TAFA404 |  T3B   | - Insalubridade, Periculosidade e Aposentadoria Especial
| S-2250 | TAFA263 |  CM8   | - Aviso Prévio
| S-2260 | TAFA484 |  T87   | - Convocação para Trabalho Intermitente
| S-2298 | TAFA267 |  CMF   | - Reintegração
| S-2299 | TAFA266 |  CMD   | - Desligamento
| S-2300 | TAFA279 |  C9V   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Início
| S-2306 | TAFA277 |  T0F   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Alteração Contratual
| S-2399 | TAFA280 |  T92   | - Trabalhador Sem Vínculo de Emprego/Estatutário - Término
| S-2400 | TAFA469 |  T5T   | - Cadastro de Benefícios Previdenciários - RPPS
| S-3000 | TAFA269 |  CMJ   | - Exclusão de Eventos
| S-5001 | TAFA423 |  T2M   | - Informações das contribuições sociais consolidadas por trabalhador
| S-5002 | TAFA422 |  T2G   | - Imposto de Renda Retido na Fonte
| S-5011 | TAFA425 |  T2V   | - Informações das contribuições sociais consolidadas por contribuinte
| S-5012 | TAFA426 |  T0G   | - Informações do IRRF consolidadas por contribuinte
-----------------------------

Cross Segmentos - Backoffice Protheus - TAF - REINF - Tabelas utilizadas na Reinf
Atualizado em:
4 de abril de 2023 09:06
 

Dúvida

Quais tabelas são utilizadas na Reinf? 

 

Solução

Apuração dos Eventos

R-2030
R-2040
R-2050
R-2055
R-2060
R-2098
R-2099
R-3010
R-5001
 

Evento R-1000 → Informações do Contribuinte
T9U - Informação do Contribuinte

 

Evento R-1070 → Tabela de Processos Administrativos/Judiciais
O cadastro para o evento R-1070 → Tabela de Processos Administrativos/Judiciais armazena os dados de origem do cadastro de Informações de Processos.

Pode ser acessado através do menu Eventos REINF → Tabelas → R-1070 - Processo Referenciado pelo programa TAFA495, onde são utilizadas as seguinte tabelas:

T9V - Tab. Processos Adm/Judiciais
T9X - Informações de Suspensão
 
Evento R-2010 → Retenção Contribuição Previdenciária - Serviços Tomados
O cadastro para o evento R-2010 → Retenção Contribuição Previdenciária - Serviços Tomados e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Cadastro de Obras
Participante
Documento de Entrada
Fatura
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2010 - Retenção Cont. Previd. Serviços Tomado pelo programa TAFA486, onde são utilizadas as seguinte tabelas:

T95 - Ret. Contrib Prev - Serv Tomado
T96 - Detalhamento de NFS
T97 - Tipos de Serviços NF
T98 - Inf. Processos Relacionados
T99 - Inf. Processos Relacionados Ad
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C35 - Trib Itens Documento Fiscal  
LEM - Cadastro de Recibo/Fatura  
T5M - Tipo de Serviço  
C1H - Participantes
 

Evento R-2020 → Retenção Contribuição Previdenciária - Serviços Prestados
O cadastro para o evento R-2020 → Retenção Contribuição Previdenciária - Serviços Prestados e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Cadastro de Obras
Documento de Saída
Fatura
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2020 - Contr. Previd. - Serviços Prestados pelo programa TAFA478, onde são utilizadas as seguinte tabelas:

CMN - Ret. Contrib Prev - Serv Prest
CRO - Detalhamento de NFS
T9Y - Tipos de Serviços NF
T9Z - Inf. Processos Relacionados
V0A - Inf. Processos Relacionados Ad
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C35 - Trib Itens Documento Fiscal  
LEM - Cadastro de Recibo/Fatura  
T5M - Tipo de Serviço  
C1H - Participantes
 

Evento R-2030 → Recursos Recebidos por Associação Desportiva
O cadastro para o evento R-2030 → Recursos Recebidos por Associação Desportiva e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Participante
Documenta de Saída
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2030 - Recursos Rec. Por Associação Desportiva pelo programa TAFA255, onde são utilizadas as seguinte tabelas:

C9B - Recursos Receb Associação Desp
V1G - Recursos Recebidos
V1H - Det. Recursos Recebidos
V1I - Processos Adm/jud
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C35 - Trib Itens Documento Fiscal  
LEM - Cadastro de Recibo/Fatura  
T5M - Tipo de Serviço  
C1H - Participantes
 
Evento R-2040 → Recursos Repassados para Associação Desportiva
O cadastro para o evento R-2040 → Recursos Repassados por Associação Desportiva e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Participante
Documenta de Entrada
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2040 - Recursos Rep. Por Associação Despo pelo programa TAFA491, onde são utilizadas as seguinte tabelas:

T9K - Recursos Rep Associação Desp
V1J - Recursos Recebidos
V1K - Det. Recursos Repassados
V1L - Processos Adm/jud
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C35 - Trib Itens Documento Fiscal  
LEM - Cadastro de Recibo/Fatura  
T5M - Tipo de Serviço  
C1H - Participantes


Pode ser acessado através do menu Eventos REINF → Periódicos → R-4020 - Pagamentos/créditos a beneficiário pessoa jurídica pelo programa TAFA546, onde são utilizadas as seguintes tabelas:
V4S - Informações relativas ao pagamento  
V5C - R-4020-Retenções na Fonte - PJ
V5D - R-4020 - Identificação do rendimento
V5F - R-4020 - Informações de Processos Referenciados          
V5G - 4020-Identificação do advogado   

 
Evento R-2050 → Comercialização da Produção por Produtor Rural PJ/Agroindústria
 O cadastro para o evento R-2050 → Comercialização da Produção por Produtor Rural PJ/Agroindústria e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Participante
Documenta de Saída
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2050 - Comercialização da Produção por Produtor Rural PJ/Agroindústria pelo programa TAFA492, onde são utilizadas as seguintes tabelas:

C35 – Trib. Itens Documentos Fiscais
V1D – Comerc. Produção Produtor Rural
V1E – Tipo de Comercialização
V1F – Processos Administrativos/Judiciais
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C1H - Participantes
Evento R-2055→ Aquisição de Produtor Rural
O cadastro para o evento R-2055 → Aquisição de Produtor Rural e consolida os dados apurados com origem nos seguintes cadastros:

Estabelecimento
Participante
Documenta de Entrada
Informações de Processos
Pode ser acessado através do menu Eventos REINF → Periódicos → R-2055 - Aquisição de Produtor Rural pelo programa TAFA576, onde são utilizadas as seguintes tabelas:

V5S – Aquisição de Produção Rural  
V5T – Detalhes Aquisição Prod Rural 
V5U – Inf.Processos Aquis.Prod.Rural
V5V – Detalhes NFs Aquisição Rural  
 
Evento R-2060 → Contribuição Previdenciária sobre a Receita Bruta - CPRB
 O cadastro para o evento R-2060 → Contribuição Previdenciária sobre a Receita Bruta - CPRB consolida os dados apurados com origem nos seguintes cadastros:

Contrib Prev Receita Bruta (cadastro legado origem TAFA097)

Pode ser acessado através do menu Eventos REINF → Periódicos → R-2060 - Cprb Contr. Previdênciária Receita Bruta pelo programa TAFA499, onde são utilizadas as seguinte tabelas:

V0S - Contribuição Prev. Recei. Bruta
V0T - Registro Estabelecimento R2060
V0U - R-2060 Ajustes Contrib. Apurad
V0V - R-2060 Processos Susp Cprb
C5M - Contrib Prev Receita Bruta  
C5O - Processos Referenciados - CP  
T9T - Tipo de Ajuste
Evento R-2098 → Reabertura dos Eventos Periódicos
V1A - Reabertura Eventos Periódicos
Evento R-2099 → Fechamento dos Eventos Periódicos
V1O - Controle de Períodos REINF
V0B - Fechamento periódicos
Evento R-3010 → Receita de Espetáculo Desportivo
ode ser acessado através do menu Eventos REINF → Não Periódicos → R-3010 - Receita de Espetáculo Desportivo pelo programa TAFA298, onde são utilizadas as seguintes tabelas:

T9F - Receita de Espetáculo Desportivo
T9J - Processos Judiciais
T9G - Boletim Espetáculo Desportivo
T9H - Receita de Ingressos
T9I - Outras Receitas
 
Evento R-5001 → Informações de Bases e Tributos por Evento
O evento R-5001 apresenta o retorno do RET contendo as informações de bases e tributos para cada um dos eventos enviados.
Estes dados são obtidos durante o monitoramento da transmissão dos eventos, quando estes foram transmitidos com sucesso, e armazenados nas tabelas correspondentes.  

Os dados armazenados podem ser acessados através do menu Eventos REINF → Totalizadores → R-5001- Informações de Bases/Tributos por Eventos, através do programa TAFA501, no qual são utilizadas as seguintes tabelas:

V0W - Evento Totalização            
V0X  - Totalizador do evento R-2050           
V0Y  - Totalizador do evento R-2040  
V0Z  - Totalizador do evento R-2040 
 
Evento R-5011 → Informações de Bases e Tributos Consolidadas por Período de Apuração
O evento R-5011 apresenta o retorno do RET contendo as informações de bases e tributos consolidadas por período de apuração. 
Estes dados são obtidos durante o monitoramento da transmissão do evento R-2099 - Fechamento dos Eventos Periódicos, quando este for transmitido com sucesso, e armazenados nas tabelas correspondentes.  

Os dados armazenados podem ser acessados através do menu Eventos REINF → Totalizadores → R-5011 - Informações de Bases/Tributos Consolidado, através do programa TAFA497, no qual são utilizadas as seguintes tabelas:

V0C - Inf. Bases e Trib. consolidado
V0E - Informações Consolidadas           
V0F - Totalizador Serviços Tomados   
V0G -Totalizador Serviços Prestados
V0H - Totalizador Associações Desp  
V0I  - Totalizador Com. Produção 
V0J - Totalizador CPRB  
*/

-- Manutenção de Tabelas GPE - Tabelas S000
--RCC - Parametros
Select * From RCC010

--RCB - Configuracao de Parametros
Select * From RCB010






				--Temp ************************************************************************************************************************************

-- Stuff 
--*Agrupar Resultados de linhas em uma determinada coluna.
-- Stuff 
--*Agrupar Resultados de linhas em uma determinada coluna.
SELECT 
       stuff ((SELECT '; ' + B5_ONU
                 from SB5010 as SB5
                 where B5_COD  In ('4050404401','')
                 for xml path('')),
              1, 2, '') as SB5010



			  --Pivot 
				-- Agrupar linhas em uma determinada coluna***********************************************************************************************


 -- Saldos Iniciais 
  SELECT Distinct B9_COD, 
  [20200131] AS JANEIRO
, [20200229] AS FEVEREIRO
, [20200331] AS MARÇO
, [20200430] AS ABRIL
, [20200531] AS MAIO
, [20200630] AS JUNHO
, [20200731] AS JULHO
, [20200831] AS AGOSTO
, [20200930] AS SETEMBRO
, [20201031] AS OUTUBRO
, [20201130] AS NOVEMBRO
, [20201231] AS DEZEMBRO

FROM SB9010 
PIVOT (SUM(B9_VINI1) FOR B9_DATA IN ([20200131],[20200229],[20200331],[20200430],[20200531],[20200630],[20200731],[20200831],[20200930],[20201031],[20201130],[20201231]))P
WHERE B9_FILIAL = '01' AND D_E_L_E_T_ = '' AND B9_QINI > 0 AND B9_COD = '4050404401' and D_E_L_E_T_ =''
/*And B9_DATA Between '20200101' and '20201231'*/ and B9_LOCAL ='01'
ORDER BY 1;





































