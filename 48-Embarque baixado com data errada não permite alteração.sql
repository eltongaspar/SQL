--Embarque baixado com data errada não permite alteração
--Apresenta o erro: O TITULO SELECIONADO JÁ ESTÁ BAIXADO OU NÃO EXISTEM TÍTULOS A BAIXAR NESSE MOMENTO

--Ao colocar data de embarque o titulo do contas a receber é baixado automaticamente.



--Pra conseguir desfazer precisa localizar e deletar o titulo na SE5

--SE5 - Movimentacao Bancaria
SELECT * FROM SE5010 WHERE E5_HISTOR LIKE '%21/122-SG%' and E5_TIPO = 'NF' and D_E_L_E_T_ =''

--UPDATE SE5010 SET D_E_L_E_T_='*' WHERE E5_HISTOR LIKE '%21/121-SG%'



--E tirar na SE1 a data da baixa, ajustar o saldo e limpar o flag de contabilização
--SE1 - Contas a Receber

SELECT * FROM SE1010 WHERE E1_HIST LIKE '%21/122-SG%' AND E1_BAIXA<>''

--UPDATE SE1010 SET E1_SALDO=E1_VALOR, E1_BAIXA='', E1_LA='' WHERE E1_HIST LIKE '%21/122-SG%' AND E1_BAIXA<>''

