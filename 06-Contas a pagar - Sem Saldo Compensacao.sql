-- Tabela Forncedores 
Select * From SA2010
Where D_E_L_E_T_ = '' and A2_COD = '012811'


--Tabela Contas a Pagar
Select E2_SALDO, * From SE2010
Where E2_FILIAL = 'BA' and E2_FORNECE = '012811' and E2_NUM = '041021' and E2_PREFIXO = 'ADC' and D_E_L_E_T_ = '' and E2_VALOR = '250'
