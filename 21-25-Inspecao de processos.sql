-- QPK - Insp.Processos - Avaliacoes
Select * From QPK010
Where QPK_FILIAL = 'BA03'and QPK_OP like '026853%' and D_E_L_E_T_ =''


--QPM - Laudo da Operacao
Select * From QPM010
Where QPM_FILIAL = 'BA03' and QPM_OP like '026853%' and D_E_L_E_T_ =''

-- QP2 - Nao Conformidade dos Ensaios
Select * From QP2010
Where D_E_L_E_T_ = ''

--QPL - Laudo da Ordem de Producao
Select * From QPL010
Where QPL_FILIAL = 'BA03' and QPL_OP like '026853%' and D_E_L_E_T_ =''

--QPR - Medicoes - Dados Genericos
Select * From QPR010
Where QPR_FILIAL = 'BA03' and QPR_OP like '026853%' and D_E_L_E_T_ =''

--Consulta Código Produto
Select * From SB1010
Where B1_COD = '0100070001'  


-- QAA - Usuarios - Inspeção de Qualidade

Select * From QAA010
Where QAA_FILIAL = 'BA02' and D_E_L_E_T_= '' 
Order By QAA_MAT