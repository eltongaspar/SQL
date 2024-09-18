/*-- MP - FIS- Como alterar as Al�quotas Internas ICMS
Atualizado em:
15 de mar�o de 2022 14:28

D�vida

Como alterar a al�quota interna do ICMS? 

Ambiente

Protheus � Livros Fiscais� A partir da vers�o 11.80

Solu��o

Diversos Estados alteraram os valores de suas al�quotas internas de ICMS. Os novos valores devem ser alterados nos par�metros padr�es do Protheus para que sejam realizados os c�lculos do imposto ICMS corretamente.

 

MV_ICMPAD = Este par�metro deve receber o valor da al�quota da Filial em que est�o sendo feitas as movimenta��es, sejam elas de entrada ou sa�da.

Exemplo:

Filial do Estado de SP

MV_ICMPAD = 18

 
MV_ESTICM = Este par�metro recebe o valor de todas as UFs com suas respectivas al�quotas de ICMS Internas. Estes valores servir�o por exemplo, de base para os c�lculos de Diferencial de Al�quota para negocia��es interestaduais.

Exemplo:

MV_ESTICM = AC17AL17AM18AP18BA18CE17DF18ES17GO17MA18MG18MS17MT17PA17PB18PE18PI17PR18RJ18RN18RO17.50RR17RS18SC17SE18SP18TO18

 Ajuste os par�metros acima de acordo com a sua necessidade. 

Caso o campo Aliq. ICMS (B1_PICM) no cadastro do produto esteja preenchido, o par�metro MV_ICMPAD n�o � utilizado para o c�lculo do ICMS

As al�quotas exposta acima podem sofrer altera��es. Fique atendo �s novas al�quotas e altere estes par�metros sempre que houver mudan�a destas regras */

-- Parametros
Select * From SX6010
Where X6_VAR In ('MV_ICMPAD','MV_ESTICM')

