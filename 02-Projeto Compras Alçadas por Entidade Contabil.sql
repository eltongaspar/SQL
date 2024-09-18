-- Projetos Compras Alçadas 


-- Alçadas Aprovação 
Select CR_STATUS,
		Case 
			When CR_STATUS = '01'
			Then 'Pendente em níveis anteriores - azul'
			When CR_STATUS = '02'
			Then 'Pendente - vermelho'
			When CR_STATUS = '03'
			Then 'Aprovado - verde'
			When CR_STATUS = '04'
			Then 'Bloqueado - preto'
			When CR_STATUS = '05'
			Then 'Aprovado/rejeitado pelo nível - cinza'
			When CR_STATUS = '06'
			Then 'Rejeitado - x vermelho '
			When CR_STATUS = '06'
			Then 'Documento Rejeitado ou Bloqueado por outro usuário. - amarelo'
			Else 'XXXXXX'
			End As Status,
* From SCR010
Where CR_FILIAL = '01' and CR_TIPO <> '' and CR_NUM In ('019474')
And D_E_L_E_T_ = ''
Order By CR_USER
--CR_STATUS='01' - Pendente em níveis anteriores - azul
--CR_STATUS='02' - Pendente - vermelho
--CR_STATUS='03' - Aprovado - verde
--CR_STATUS='04' - Bloqueado - preto
--CR_STATUS='05' - Aprovado/rejeitado pelo nível - cinza
--CR_STATUS='06' - Rejeitado - x vermelho                                                                                                                        
--CR_STATUS='07' - Documento Rejeitado ou Bloqueado por outro usuário. - amarelo

-- Alçadas Aprovação Itens 
Select DBM_APROV,
	Case 
		When DBM_APROV = '1'
		Then 'Aprovado - verde'
		When DBM_APROV = '2'
		Then 'Pendente - vermelho'
		When DBM_APROV = '3'
		Then 'Rejeitado - preto'
		Else 'XXXXXXX'
		End as Status,

* From DBM010	
Where DBM_FILIAL = '01' and DBM_TIPO <> 'PC' and DBM_NUM In ('019474')
And D_E_L_E_T_ = ''
Order By DBM_USER
--DBM_APROV - 1=Aprovado;2=Pendente;3=Rejeitado



-- Parametros 
Select * From SX6010
Where X6_VAR In ('MV_APRPCEC','MV_APRSCEC','MV_ALTPDOC')
And D_E_L_E_T_ = ''

-- Grupos de Aprovação 
Select * From SAL010
Where D_E_L_E_T_ = ''

-- Aprovadores 
Select * From SAK010
Where D_E_L_E_T_ = ''

-- Perfil de aprovadores
Select * From DHL010

--Tipos de Compras x Aprovador
Select * From DHM010
Where D_E_L_E_T_ = ''

-- Entidades Contabeis x Grupo Aprovadores 
Select * From DBL010
Where D_E_L_E_T_ = ''

-- Grupos de Aprovação  
Select AL_FILIAL,AL_COD,AL_DESC,
AK_COD,AK_NOME,DHL_COD,DHL_LIMMIN,DHL_LIMMAX,
* From SAL010 SAL -- Grupos de Aprovadores
	
	Inner Join SAK010 SAK -- Aprovadores
	On AK_FILIAL = AL_FILIAL
	And AK_COD = AL_APROV
	And SAK.D_E_L_E_T_ = ''

	Inner Join DHL010 DHL -- Perfil de aprovadores 
	On DHL_FILIAL = AK_FILIAL
	And DHL_COD = AL_PERFIL
	And DHL.D_E_L_E_T_ = ''

Where AL_FILIAL = '01' and AL_COD In ('000001','000002','000003','000004','000005')
And AK_COD Not In ('000009')
And SAL.D_E_L_E_T_ =''



-- Grupos de aprovação x Centro de Custos 
Select Distinct DBL_FILIAL,DBL_GRUPO,AL_COD,AL_DESC,CTT_CUSTO,CTT_DESC01
From DBL010 DBL

	Inner Join SAL010 SAL -- Grupos de aprodores 
	On AL_FILIAL = DBL_FILIAL
	And DBL_GRUPO = AL_COD
	And SAL.D_E_L_E_T_ = ''

	Inner Join CTT010 CTT -- CC
	On DBL_CC = CTT_CUSTO
	And CTT.D_E_L_E_T_ = ''

Where DBL.D_E_L_E_T_ =''
Order By 2



-- Alçadas Aprovação 
Select CR_STATUS,
		Case 
			When CR_STATUS = '02' and CR_APROV = '000007' and CR_DATALIB  = ''
			Then 'Documento em Aprovação Compras - laranja'
			When CR_STATUS = '02' and CR_APROV <> '000007'  and CR_TOTAL > '3000' and CR_DATALIB  = ''
			Then 'Documento em Aprovação Setor - roxo'			
			When CR_STATUS = '01'
			Then 'Pendente em níveis anteriores - azul'
			When CR_STATUS = '02'
			Then 'Pendente - vermelho'
			When CR_STATUS = '03'
			Then 'Aprovado - verde'
			When CR_STATUS = '04'
			Then 'Bloqueado - preto'
			When CR_STATUS = '05'
			Then 'Aprovado/rejeitado pelo nível - cinza'
			When CR_STATUS = '06'
			Then 'Rejeitado - x vermelho '
			When CR_STATUS = '06'
			Then 'Documento Rejeitado ou Bloqueado por outro usuário. - amarelo'
			Else 'XXXXXX'
			End As Status,

DBM_APROV,
			Case 
		When DBM_APROV = '1'
		Then 'Aprovado - verde'
		When DBM_APROV = '2'
		Then 'Pendente - vermelho'
		When DBM_APROV = '3'
		Then 'Rejeitado - preto'
		Else 'XXXXXXX'
	End as Status,

* From SCR010 SCR

	Inner Join DBM010 DBM
	On DBM_FILIAL = CR_FILIAL
	And DBM_NUM = CR_NUM
	And DBM_TIPO = CR_TIPO
	And DBM_USAPRO = CR_APROV
	And DBM.D_E_L_E_T_ = ''
	
Where CR_FILIAL = '01' and CR_TIPO <> '' and CR_NUM In ('019474')
And SCR.D_E_L_E_T_ = ''
Order By CR_USER
--CR_STATUS='01' - Pendente em níveis anteriores - azul
--CR_STATUS='02' - Pendente - vermelho
--CR_STATUS='03' - Aprovado - verde
--CR_STATUS='04' - Bloqueado - preto
--CR_STATUS='05' - Aprovado/rejeitado pelo nível - cinza
--CR_STATUS='06' - Rejeitado - x vermelho                                                                                                                        
--CR_STATUS='07' - Documento Rejeitado ou Bloqueado por outro usuário. - amarelo

-- Alçadas Aprovação Itens 
Select DBM_APROV,
	Case 
		When DBM_APROV = '1'
		Then 'Aprovado - verde'
		When DBM_APROV = '2'
		Then 'Pendente - vermelho'
		When DBM_APROV = '3'
		Then 'Rejeitado - preto'
		Else 'XXXXXXX'
	End as Status,

* From DBM010	
Where DBM_FILIAL = '01' and DBM_TIPO <> 'PC' and DBM_NUM In ('019474')
And D_E_L_E_T_ = ''
Order By DBM_USER
--DBM_APROV - 1=Aprovado;2=Pendente;3=Rejeitado




-- Alçadas Aprovação 
Select CR_STATUS,
		Case 
			When CR_STATUS = '02' and CR_APROV <> '000007'  and CR_TOTAL >= '3000' and CR_DATALIB  = ''
			Then 'Documento em Aprovação Setor - roxo'	
			When CR_STATUS = '02' and CR_APROV = '000007' and CR_DATALIB  = ''
			Then 'Documento em Aprovação Compras - laranja'
			When CR_STATUS = '01'
			Then 'Pendente em níveis anteriores - azul'
			When CR_STATUS = '02'
			Then 'Pendente - vermelho'
			When CR_STATUS = '03'
			Then 'Aprovado - verde'
			When CR_STATUS = '04'
			Then 'Bloqueado - preto'
			When CR_STATUS = '05'
			Then 'Aprovado/rejeitado pelo nível - cinza'
			When CR_STATUS = '06'
			Then 'Rejeitado - x vermelho '
			When CR_STATUS = '06'
			Then 'Documento Rejeitado ou Bloqueado por outro usuário. - amarelo'
			Else 'XXXXXX'
			End As Status,

* From SCR010 SCR
Where CR_FILIAL = '01' and CR_TIPO <> '' and CR_NUM In ('019474')
And SCR.D_E_L_E_T_ = ''
Order By CR_USER