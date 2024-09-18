-- QIP - problemas de produtos com entrada de qualidade no cadastro geral, mas na filial com problemas não precisa 
-- Após ajustes, criar indice tipo 2 para o produto e filial
-- Seguir o script abaixo para correção 

--Alterar campo D7_TIPOCQ de produtos que não deveriam ir para CQ
--Produtos que não precisam ter movimentação de CQ:


--SD7 - Movimentacoes de CQ

SELECT * FROM SD7010 WHERE D7_FILIAL='BA01' AND D7_PRODUTO='0100100002' AND D7_LIBERA='' AND D_E_L_E_T_='' 
--UPDATE SD7010 SET D7_TIPOCQ='M' WHERE D7_FILIAL='BA01' AND D7_PRODUTO='0100100002' AND D7_LIBERA='' AND D_E_L_E_T_='' 