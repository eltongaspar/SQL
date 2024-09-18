-- Ir na Tabela SD7 (Movimentos CQ)

-- Fazer os devidos Filtros Filial, Produto
-- Filtros Ativos Delete = '' e Libera = ' '
--Mudar o campo D7_TIPOCQ para 'M'


--SD7 - Movimentacoes de CQ

SELECT D7_LIBERA, * FROM SD7010 
WHERE D7_FILIAL = 'AE01' AND D_E_L_E_T_='' AND D7_LIBERA <> 'S' and D7_PRODUTO = '0301060004'

--UPDATE SD7010 SET D7_TIPOCQ='M' WHERE D7_FILIAL='AE01' AND D_E_L_E_T_='' AND D7_LIBERA<>'S' and D7_PRODUTO = '0301060005'


--Help: NOCELERINA 
--Problema: Toda a movimentação referente a CQ para 
-- o 001 0301060005 este produto só poderá ser feita pelo módulo Siga Quality. 
-- Solução: Para determinar qual Programa será 
-- utilizado para Manutenção do CQ utilize o campo "Tipo 
-- de CQ" (B1 TIPOCQ) no cadastro de Produtos. Pode-se escolher estre Microsiga ou Celerina. 