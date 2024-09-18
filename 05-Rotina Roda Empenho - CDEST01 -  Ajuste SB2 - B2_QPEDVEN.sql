--CDEST01
-- Rotina Roda Empenho
-- Ajuste SB2 - B2_QPEDVEN - casas decimais

Select 
--UPDATE SB2010 SET
       B2_QPEDVEN,B2_QPEDVEN2 = ISNULL((SELECT SUM(C6_QTDVEN) 
                           FROM SC6010, SF4010
                          WHERE C6_FILIAL		= B2_FILIAL 
                            AND C6_PRODUTO		= B2_COD
                            AND C6_TES			= F4_CODIGO
                            AND F4_FILIAL		= ' '
                            AND F4_ESTOQUE		= 'S'
                            AND SF4010.D_E_L_E_T_ = ' '
                            AND SC6010.D_E_L_E_T_ = ' '
                            AND C6_NOTA			= ' '
                        ),0),                      
       B2_SALPEDI,B2_SALPEDI2 = ISNULL((SELECT SUM(C7_QUANT-C7_QUJE)
                          FROM SC7010
                         WHERE C7_FILIAL		= B2_FILIAL
                           AND C7_PRODUTO		= B2_COD
                           AND C7_ENCER			!= 'E'
                           AND C7_RESIDUO		!= 'S'
                           AND SC7010.D_E_L_E_T_ =' '),0),



	Case 
	When
		B2_QPEDVEN <> ISNULL((SELECT SUM(C6_QTDVEN) 
                           FROM SC6010, SF4010
                          WHERE C6_FILIAL		= B2_FILIAL 
                            AND C6_PRODUTO		= B2_COD
                            AND C6_TES			= F4_CODIGO
                            AND F4_FILIAL		= ' '
                            AND F4_ESTOQUE		= 'S'
                            AND SF4010.D_E_L_E_T_ = ' '
                            AND SC6010.D_E_L_E_T_ = ' '
                            AND C6_NOTA			= ' '
                        ),0)
	Then '######'

	When 				
		B2_SALPEDI <> ISNULL((SELECT SUM(C7_QUANT-C7_QUJE)
                          FROM SC7010
                         WHERE C7_FILIAL		= B2_FILIAL
                           AND C7_PRODUTO		= B2_COD
                           AND C7_ENCER			!= 'E'
                           AND C7_RESIDUO		!= 'S'
                           AND SC7010.D_E_L_E_T_ =' '),0)
	Then '######'

	Else 'OK'	
	End as STATUS_
						   
						   
						   From SB2010                         
   WHERE B2_FILIAL = '01' AND B2_LOCAL = '01' AND D_E_L_E_T_ = ' '


Order By 5
