--Devolu��o de Exporta��o - Procedimentos
--1 - Desabilitar par�metro MV_EASY (exclusivo) pois n�o existe processo de importa��o (durante esse per�odo n�o pode haver integra��es entre o modulo de importa��o e compras - avisar Mariana

--2 - Apagar temporariamente o ato concess�rio conforme modelo abaixo (referente ao processo que est� sendo devolvido).

SELECT EE9_ATOCON,* FROM EE9010 WHERE EE9_PREEMB='22/138-SC'    --202100085636   

--UPDATE EE9010 SET EE9_ATOCON='202100085636' WHERE EE9_PREEMB='22/138-SC'

--Ap�s a nota ser colocada, j� pode voltar o ato concess�rio



--3 - preencher a CD5 via APSDU com os dados pertinentes a nf que se est� devolvendo (tem varios modelos na tabela).



--4 - Transmitir a nota



5-- - Ao t�rmino dos processos religar o par�metro MV_EASY na filial desligada