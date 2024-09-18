-- QAA - Usu�rios QIP
Select * From QAA010

-- QEK - Entradas 
Select * From QEK010

--QER - Medicoes - Dados Genericos
Select * From QER010

--QET - Instrumentos x Resultados ***
Select * From QET010

--QEL - Laudos das Entradas
Select * From QEL010

--QEU - Nao Conformidades das Entradas
Select * From QEU010

--QP6 - Historico dos Produtos
Select * From QP6010

--QP7 - Ensaios Mensur�veis dos Produtos
Select * From QP7010

--QP8 - Ensaios Textos dos Produtos
Select * From QP8010

--QP9 - N�o-Conformidades dos Produtos 
Select * From QP9010

--QQK - Especifica��es das Opera��es
Select * From QQK010

--QEQ - Valores das Medicoes (Texto)
Select * From QEQ010

--QEF - Tabela do Skip-Lote - Plano de amostragem de Entradas 
Select * From QEF010


--QPK - Insp.Processos - Avaliacoes
Select * From QPK010
Where QPK_FILIAL In ('BA01') and QPK_PRODUT = '0110020020' and 
QPK_LOTE In ('12220618') and D_E_L_E_T_ = ''

-- QPM - Laudo da Operacao
Select * From QPM010
Where QPM_FILIAL In ('BA01','BA03') and QPM_PRODUT = '0400710021' and 
QPM_LOTE In ('12220618') and D_E_L_E_T_ = ''

--QPR - Medi��es - Dados Genericos
Select * From QPS010

--QPS - Processo Medi��es Mensur�veis
Select * From QPR010

--QE1 - Ensaios
Select * From QE1010

-- SX5 -SX5 - Tabelas - ***CARTA*** QE1
Select * From SX5010
Where X5_CHAVE = 'XBR'