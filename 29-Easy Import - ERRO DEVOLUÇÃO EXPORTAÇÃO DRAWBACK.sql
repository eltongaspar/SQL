-- ERRO DEVOLU��O EXPORTA��O DRAWBACK

--Texto de erro 

--Documento de Entrada -
--INCLUIR 
--OutrasA��es 
--| Cancelar


--A Nota de Devolu��o n�o poder� ser gerada.

--O processo de exporta��o BA0122/018-SC possui v�nculo com o ato
--concess�rio 20210008563 para o produto 0110010251. Antes de
--prosseguir com a opera��o de devolu��o o ato concess�rio deve ser
--estornado do embarque de exporta��o.




--Script para corre��o.

--Limpar campo EE9_ATOCON=''  dos itens / NF's  a serem devolvidos.


---EE9 - Itens Embarque
SELECT * FROM EE9010 WHERE EE9_PREEMB='22/077-SG'    -20210008563  

--UPDATE EE9010 SET EE9_ATOCON='' WHERE EE9_PREEMB='22/018-SC'




--EE9 - Itens Embarque
SELECT * FROM EE9010 WHERE EE9_PREEMB='22/077-SG'    -20210008563

--UPDATE EE9010 SET EE9_ATOCON='' WHERE EE9_PREEMB='22/017-SC'