-- Proceso Coleta de Coleta (Personalizacao)
--DYM - Identificacao do Produto - TMS 43 - SIGATMS 
Select * From DY3010
Where D_E_L_E_T_ = ''

-- Cadastro Produto
Select * From SB1010

-- SB5 - Dados Adicionais do Produto
Select B5_ONU,* From SB5010
Where B5_ONU <> '' and D_E_L_E_T_ = '' And B5_COD = '0660011209'

--Produtos Solicitação de Coleta
Select * From ZK2010