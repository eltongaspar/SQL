--Para  resolver, limpa o campo de data real fim da op

--Ao estornar apontamento de produção na rotina PCP mod 2, cliquei em não ao inves de sim na opção de reabrir apontamento

--LIMPAR CAMPO DATA REAL FIM NA C2 (OP)
--SC2 - Ordens de Producao
SELECT * FROM SC2010 WHERE C2_FILIAL='BA02' AND C2_NUM='039653'  AND C2_SEQUEN='002'

--UPDATE SC2010 SET C2_DATRF='' WHERE C2_FILIAL='BA02' AND C2_NUM='034992' AND C2_SEQUEN='001'



--Confere se todos movimentos da D3 estão estornados
--SD3 - Movimentacoes Internas
SELECT D3_ESTORNO,* FROM SD3010 WHERE D3_FILIAL='BA02' AND D3_OP='03965301002'



--Caso precisar reabrir o empenho roda o script abaixo

--VOLTAR O EMPENHO PRA PESSOA PODER ALTERAR
--SD4 - Requisicoes Empenhadas
--SD4010 SET D4_QUANT=D4_QTDEORI

SELECT * FROM SD4010 WHERE D4_OP='03965301002' AND D_E_L_E_T_='' AND D4_FILIAL='BA02'

--UPDATE SD4010 SET D4_QUANT=D4_QTDEORI WHERE D4_OP='03965301002' AND D_E_L_E_T_='' AND D4_FILIAL='BA02'
