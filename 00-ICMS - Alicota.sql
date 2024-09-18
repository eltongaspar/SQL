/*-- MP - FIS- Como alterar as Alíquotas Internas ICMS
Atualizado em:
15 de março de 2022 14:28

Dúvida

Como alterar a alíquota interna do ICMS? 

Ambiente

Protheus – Livros Fiscais– A partir da versão 11.80

Solução

Diversos Estados alteraram os valores de suas alíquotas internas de ICMS. Os novos valores devem ser alterados nos parâmetros padrões do Protheus para que sejam realizados os cálculos do imposto ICMS corretamente.

 

MV_ICMPAD = Este parâmetro deve receber o valor da alíquota da Filial em que estão sendo feitas as movimentações, sejam elas de entrada ou saída.

Exemplo:

Filial do Estado de SP

MV_ICMPAD = 18

 
MV_ESTICM = Este parâmetro recebe o valor de todas as UFs com suas respectivas alíquotas de ICMS Internas. Estes valores servirão por exemplo, de base para os cálculos de Diferencial de Alíquota para negociações interestaduais.

Exemplo:

MV_ESTICM = AC17AL17AM18AP18BA18CE17DF18ES17GO17MA18MG18MS17MT17PA17PB18PE18PI17PR18RJ18RN18RO17.50RR17RS18SC17SE18SP18TO18

 Ajuste os parâmetros acima de acordo com a sua necessidade. 

Caso o campo Aliq. ICMS (B1_PICM) no cadastro do produto esteja preenchido, o parâmetro MV_ICMPAD não é utilizado para o cálculo do ICMS

As alíquotas exposta acima podem sofrer alterações. Fique atendo às novas alíquotas e altere estes parâmetros sempre que houver mudança destas regras */

-- Parametros
Select * From SX6010
Where X6_VAR In ('MV_ICMPAD','MV_ESTICM')

