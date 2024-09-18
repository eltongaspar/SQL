--Acompanha Custos
--Logs de Fechamentos - D3X
Select  ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), D3X_DET)),'') AS [OBS],
* From D3X010
Where D3X_DATA >= '20231201' and D_E_L_E_T_ =''
Order By R_E_C_N_O_ Desc

--Fechamentos Realizados - D3Y
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), D3Y_STRUCT)),'') AS [STRUCT],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), D3Y_PARAMS)),'') AS [PARAMS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), D3Y_BRANCH)),'') AS [BRANCH],
* From D3Y010 D3Y
Where D3Y_DATAIN = '20231214'  and D_E_L_E_T_ =''
Order By R_E_C_N_O_ Desc


--Controle Transacional de Processos - D3W
Select * From D3W010  
Where D_E_L_E_T_ =''


--CV8 - Log de Processamento
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), CV8_DET)),'') AS [DET],
* From CV8010
Where CV8_DATA >= '20231214'  and D_E_L_E_T_ =''
--And CV8_PROC In ('CTBA190EXEC')
Order By R_E_C_N_O_ Desc

-- Lançamentos Contab.
Select CT2_VALOR,CT2_HIST,CT2_MANUAL,CT2_ROTINA,CT2_DTCONF,CT2_DATAEN,CT2_DTENVI,CT2_SEQUEN,
CTK_VLR01,CTK_HIST,CV3_VLR01,CV3_HIST,CT2_TPSALD,CTK_TPSALD,*
From CT2010 CT2 With(Nolock)

	-- Contra Prova Contab.
	Left Join CTK010 CTK With(Nolock)
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK_KEY = CT2_KEY
	And CTK_FILIAL = CT2_FILIAL
	And CTK_VLR01 = CT2_VALOR
	And CTK_ITEMC = CT2_ITEMC
	and CTK.D_E_L_E_T_ =''

	-- Rastreamento Contab.
	Left Join CV3010 CV3 With(Nolock)
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3_KEY = CT2_KEY
	And CV3_FILIAL = CT2_FILIAL
	And CV3_VLR01 = CT2_VALOR
	And CV3_ITEMC = CT2_ITEMC
	and CV3.D_E_L_E_T_ =' '


	--CABECA DE LOTE DE TRANSF. BENS
	Left Join TRC01SP TRC With(Nolock)
	On TRC_SEQUEN = CT2_SEQUEN
	and TRC.D_E_L_E_T_ =' '

	
Where CT2_FILIAL In ('01')
And CT2_DATA Between '20230901' and '20230930'
and CT2_TPSALD = '9'
and CT2.D_E_L_E_T_ =''


-- Contra Prva Contabil 
Select * From CTK010 With(Nolock)
Where  CTK_TPSALD  = '9'
And CTK_DATA Between '20230901' and '20230930'
--And CTK_LOTE = '8840'
And D_E_L_E_T_ =' '

-- Lançamentos Contabeis
Select * From CT2010 With(Nolock)
Where  CT2_TPSALD  = '9'
And CT2_DATA Between '20230901' and '20230930'
--And CT2_LOTE = '008840'
And D_E_L_E_T_ =' '
Order By CT2_FILIAL, CT2_LOTE, CT2_SBLOTE,CT2_DOC


-- Mov.. Inernos 
Select * From SD3010
Where D3_EMISSAO Between '20230701' and '20230731'
And D_E_L_E_T_ =' '
And D3_CUSTO1 In ('169.56','181.95','564.92','1082.55','1533.5','2103.24','2912.5','5279.78','8748.14','9408.55',
'10266.1','10753.46','11466.5','12556.13','13021','19204.93','38725.01','46859.34','48886.08','51750.66 ','129298.53',
'253817.28','371943.27','934575.97')



--Parametros
Select X6_FIL,X6_VAR,X6_CONTEUD,X6_DESCRIC,X6_DESC1,X6_DESC2,* From SX6010
Where X6_VAR In ('MV_CUSFIL','MV_M330THR','MV_M330JCM','MV_THRSEQ','MV_A330GRV','MV_CUSTEXC','MV_CMDBLQV') 
Order By 2,1

Select * From SX6010
Where X6_VAR = 'MV_ULMES'


--Parametros
Select * From SX6010
Where X6_VAR In ('MV_ULTDEPR','MV_ATFMOED','MV_TIPDEPR','MV_CBASEAF','MV_ZERADEPR','MV_ATFCONT','MV_VLRATF') 

