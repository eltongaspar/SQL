--SCR - Documentos com Alcada
--Select * From SCR010
--Where CR_FILIAL = 'BA03' and CR_NUM = '018333' and D_E_L_E_T_ =''
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.


--SCR - Documentos com Alcada com Inner Join

Declare @APROV Varchar (50)
--Set @APROV_NOME = (Select USR_NOME From SYS_USR USR_APRV)
Select  USR.USR_ID USR_ID, USR.USR_NOME USR_NOME, SAK.AK_COD, SAK.AK_NOME, *
From SCR010 SCR

	-- Usuários x Usuários
	Inner Join SYS_USR USR With (NOLOCK)
	On USR_ID = CR_USER
	And USR.D_E_L_E_T_ = ''
	--Set  @APROV = CR_APROV

	-- Aprovadores
	Inner Join SAK010 SAK With (NOLOCK)
	ON SAK.AK_COD = CR_APROV
	AND SAK.AK_FILIAL = CR_FILIAL
	AND SAK.D_E_L_E_T_ = ''

	-- Usuários x Aprovadores
	Inner Join SYS_USR USR_APROV With (NOLOCK)
	On USR_APROV.USR_ID = SAK.AK_COD
	And USR.D_E_L_E_T_ = ''

	
Where CR_FILIAL = 'BA03' and CR_NUM = '018333' and SCR.D_E_L_E_T_ =''  
--Set  @APROV = 

--Select  @APROV_NOME2


--Testes de Variavies
--DECLARE @MeuNome varchar(20)
--SET @MeuNome='Macoratti'
--SELECT @MeuNome

