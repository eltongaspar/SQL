Declare @PROD Char(10), @NUMCQ Char(10)
Set @PROD = 'MC15001830'
Set @NUMCQ = 'SK1PUR'

Select D7_PRODUTO,
--Entradas
D7_ENT = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' ),

-- Saidas
D7_SAI = (Select Isnull(Sum(D7_QTDE),'') From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ),

--Rejeitados
Rejeicao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ),

-- Devolução
Devolucao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

--Estornos Qtde
Qtde_Estornos = (Select Isnull(Count(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

Total_Estornos = (Select Isnull(Sum(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

-- Calculos Estoques
-- Entradas
Estoques = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' ) -

--Saidas
(Select Sum (D7_QTDE) From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ) - 

(Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ) 


FRom SD7010 SD7

Where D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' 
Group By D7_PRODUTO
/*
Select D7_NUMERO,* From SD7010
Where D7_PRODUTO = 'MC15001830'
And D_E_L_E_T_ = '' 
Order By 1,D7_SEQ*/


