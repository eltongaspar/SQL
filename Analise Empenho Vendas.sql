-- Analise Emepnho Vendas 
Select  
       B2_QPEDVEN = ISNULL((SELECT SUM(C6_QTDVEN) 
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
       B2_SALPEDI = ISNULL((SELECT SUM(C7_QUANT-C7_QUJE)
                          FROM SC7010
                         WHERE C7_FILIAL		= B2_FILIAL
                           AND C7_PRODUTO		= B2_COD
                           AND C7_ENCER			!= 'E'
                           AND C7_RESIDUO		!= 'S'
                           AND SC7010.D_E_L_E_T_ =' '),0)
   From SB2010                           
   WHERE B2_FILIAL = '01' AND B2_LOCAL = '01' AND D_E_L_E_T_ = ' '
   And B2_COD = '2010000000'

-- PV Itens 
Select * From SC6010 SC6

Inner Join SF4010 SF4
On C6_TES = F4_CODIGO
And SF4.D_E_L_E_T_ = ' '


Where C6_FILIAL = '01' and C6_PRODUTO = '2010000000'
And (C6_QTDVEN-C6_QTDENT) > 0
And C6_BLQ Not In ('S')
 AND F4_ESTOQUE		= 'S'
AND SC6.D_E_L_E_T_ = ' '


  