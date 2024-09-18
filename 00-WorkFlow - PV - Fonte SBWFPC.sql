/*Fonte SBWFPC


ZZ_ENVWFPV - esse parametro com conte�do = 1, Habilita o envio de pedido para cliente e vendedor (parametro por filial), 2 - desabilita

----------------------------------------------------------------------------------------------
Se precisar mandar pra mais algu�m al�m de vendedor e cliente, usar os parametros abaixo (por filial)

ZZ_WFPVEM1 e ZZ_WFPVEM2 - basta colocar os e-mails separados por ponto e virgula, s�o 2 parametros pro caso 
			de querer usar v�rios e-mails

Sintaxe:
o 1 primeiro par�metro coloca ;email;outroemail
e no segundo par�metro ;email;outroemail

----------------------------------------------------------------------------------------------
para os respons�veis por amostra tamb�m receberem copia dos pedidos de venda, criar de modo exclusivo os parametros abaixo:

parametros cfops amostra (5911;6911;7949) - definir os cfops nesse parametro - ZZ_WFCFOAM

ZZ_WFPVEM3 - basta colocar os e-mails separados por ponto e virgula*/


--Parametros 
Select * From SX6010
Where X6_FIL = 'BA11' and X6_VAR In ('ZZ_ENVWFPV','ZZ_WFPVEM1','ZZ_WFPVEM2','ZZ_WFCFOAM','ZZ_WFPVEM3') 

--Parametros 
Select * From SX6010
Where X6_VAR In ('ZZ_WFPVEM1') 

