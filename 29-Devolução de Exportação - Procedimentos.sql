--Devolução de Exportação - Procedimentos
--1 - Desabilitar parâmetro MV_EASY (exclusivo) pois não existe processo de importação (durante esse período não pode haver integrações entre o modulo de importação e compras - avisar Mariana

--2 - Apagar temporariamente o ato concessório conforme modelo abaixo (referente ao processo que está sendo devolvido).

SELECT EE9_ATOCON,* FROM EE9010 WHERE EE9_PREEMB='22/138-SC'    --202100085636   

--UPDATE EE9010 SET EE9_ATOCON='202100085636' WHERE EE9_PREEMB='22/138-SC'

--Após a nota ser colocada, já pode voltar o ato concessório



--3 - preencher a CD5 via APSDU com os dados pertinentes a nf que se está devolvendo (tem varios modelos na tabela).



--4 - Transmitir a nota



5-- - Ao término dos processos religar o parâmetro MV_EASY na filial desligada