--*****Erro ao encerrar embarque****************************

--Pra conseguir ajustar precisa localizar e deletar o titulo na SE5

SELECT * FROM SE5010 WHERE E5_HISTOR LIKE '%22/001-RGS%'

--UPDATE SE5010 SET D_E_L_E_T_='*' WHERE E5_HISTOR LIKE '%22/001-RGS %'


--E tirar na SE1 a data da baixa, ajustar o saldo e limpar o flag de contabilização

SELECT * FROM SE1010 WHERE E1_HIST LIKE '%22/001-RGS %' AND E1_BAIXA<>''

--UPDATE SE1010 SET E1_SALDO=E1_VALOR, E1_BAIXA='', E1_LA='' WHERE E1_HIST LIKE '%22/001-RGS %' AND E1_BAIXA<>''
