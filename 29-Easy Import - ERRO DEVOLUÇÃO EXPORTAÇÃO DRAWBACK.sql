-- ERRO DEVOLUÇÃO EXPORTAÇÃO DRAWBACK

--Texto de erro 

--Documento de Entrada -
--INCLUIR 
--OutrasAções 
--| Cancelar


--A Nota de Devolução não poderá ser gerada.

--O processo de exportação BA0122/018-SC possui vínculo com o ato
--concessório 20210008563 para o produto 0110010251. Antes de
--prosseguir com a operação de devolução o ato concessório deve ser
--estornado do embarque de exportação.




--Script para correção.

--Limpar campo EE9_ATOCON=''  dos itens / NF's  a serem devolvidos.


---EE9 - Itens Embarque
SELECT * FROM EE9010 WHERE EE9_PREEMB='22/077-SG'    -20210008563  

--UPDATE EE9010 SET EE9_ATOCON='' WHERE EE9_PREEMB='22/018-SC'




--EE9 - Itens Embarque
SELECT * FROM EE9010 WHERE EE9_PREEMB='22/077-SG'    -20210008563

--UPDATE EE9010 SET EE9_ATOCON='' WHERE EE9_PREEMB='22/017-SC'