--Parametros
Select * From SX6010
Where X6_VAR = 'ZZ_USRLAUD'

--Usuario
Select * From SYS_USR
Where USR_CODIGO Like '%marlon%'

-- Contador do Tamanho Campo (Max. 256)
Select Len (X6_CONTEUD) AS ZZ_USRLAUD_Tamanho_X6_CONTEUD,  
	Case 
	When Len (X6_CONTEUD) <= 256 Then 'Campo Certo'
	Else 'Campo Estourado'
	End As Status_Campo_X6_CONTEUD
From SX6010

Where X6_VAR = 'ZZ_USRLAUD'
