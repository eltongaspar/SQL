-- QPK - Insp.Processos - Avaliacoes
Select * From QPK010
Where QPK_FILIAL <> '' and QPK_EMISSA >= '20220524'
Order By QPK_EMISSA Desc

--QPM - Laudo da Operacao
Select * From QPM010
Where QPM_FILIAL <> '' and QPM_DTENLA >= '20220524' and D_E_L_E_T_ =''
Order By QPM_DTLAUD Desc, QPM_HRLAUD Desc

-- QP2 - Nao Conformidade dos Ensaios
Select * From QP2010
Where D_E_L_E_T_ = ''

--QPL - Laudo da Ordem de Producao
Select * From QPL010
Where QPL_FILIAL <> '' and QPL_DTENLA >= '20220524' and D_E_L_E_T_ =''
Order By QPL_DTLAUD Desc ,QPL_HRLAUD Desc

--QPR - Medicoes - Dados Genericos
Select * From QPR010
Where QPR_FILIAL <> '' and QPR_DTMEDI >= '20220524' and D_E_L_E_T_ =''
Order By QPR_DTMEDI Desc, QPR_HRMEDI Desc


--Consulta Código Produto
Select * From SB1010
Where B1_COD = '0100070001'  


-- Erro na QP215ATUSTA
--Referente o errorlog "array out of bounds ( 0 of 14 )  on QP215ATUSTA(QIPA215.PRW) 05/03/2021 16:52:17 line : 11907" reportado, 
--este ocorre quando o(s) ensaio(s) relacionado com a especificação, não possui carta preenchida, campos QP1_TPCART e/ou carta QP1_CARTA.
--Solução executar script, localizar quem falta e prencher 'IND' ou 'TXT'

SELECT * FROM QP1010 WHERE (QP1_TPCART = '' OR QP1_CARTA = '') AND D_E_L_E_T_ = ''

-- QAA - Usuarios - Inspeção de Qualidade

Select * From QAA010
Where QAA_FILIAL = 'BA02' and D_E_L_E_T_= '' 
Order By QAA_MAT
