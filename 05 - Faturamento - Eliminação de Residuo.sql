-- PV 
Select C5_FILIAL,C5_NUM,C6_ITEM,C5_NOTA,C9_FILIAL, C9_PEDIDO, C9_ITEM,C9_QTDLIB,C9_BLCRED,
C6_BLQ,C5_ORIGEM,C6_ENTREG,C6_NFORI,C6_QTDEMP,D2_COD,D2_DOC,F4_CODIGO,F4_TEXTO,F4_PODER3,C6_QTDVEN,C6_QTDENT,(C6_QTDVEN-C6_QTDENT) as Saldo,
* From SC5010 SC5 

	Inner Join SC6010 SC6 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	--And C5_NOTA Not In ('XXXXXX')
	--And C5_NOTA = ('') -- PV em Aberto
	And SC6.D_E_L_E_T_ = ''

	Inner Join SF4010 SF4 --TES
	On F4_FILIAL = ''
	And F4_CODIGO = C6_TES
	And SF4.D_E_L_E_T_ = ''

	Left Join SD2010 SD2 -- NF Saida Itens
	On D2_FILIAL = C5_FILIAL 
	And D2_PEDIDO = C6_NUM 
	And D2_ITEMPV = C6_ITEM 
	And D2_COD = C6_PRODUTO
	And SD2.D_E_L_E_T_ = ''

	Left Join SC9010 SC9 
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM 
	And C9_PRODUTO = C6_PRODUTO
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''


Where (C5_FILIAL = '01' and C5_NUM= '425342') 
or (C5_FILIAL = '02' and C5_NUM = '112703')
and SC5.D_E_L_E_T_ =''
Order By 1,2,3

/*
Causa

Ao acionar a Eliminação de Resíduo MATA500, se não é processada a eliminação, indica que algum fator deste Pedido não atende às premissas.

Solução

Verifique se:

O Pedido está em aberto sem liberação (credito/estoque/regra) pendente? Se o Pedido não será entregue por completo recomenda-se excluir o Pedido;
O pedido esta parcialmente faturado? Se houver dúvida, verifique no campo D2_PEDIDO se é localizado algum registro em Nota já emitida para esse Pedido;
O Pedido tem relação com operação para Controle de Poder de Terceiro (TES preenchido com F4_PODER3 igual a Remessa ou Devolução / Campo C6_NFORI preenchido com uma Nota que controla Poder de Terceiro). É necessário que não;
O Pedido já foi submetido à Liberação (conteúdo no campo C6_QTDEMP). É necessário que não;
Os parâmetros de entrada da Rotina estão corretamente preenchidos;
O campo C6_ENTREG (Data de entrega) do item está preenchido. É necessário que sim.
Há conteúdo no campo C5_ORIGEM? É necessário que não. Este campo deve estar em branco para que ocorra a eliminação.
O campo C6_BLQ está com conteúdo igual a "R" ou "S"? É necessário que não, este campo deve estar com conteúdo igual a "N" ou em branco para que ocorra a eliminação.
Importante: em caso onde haja não permissão de usuário para  utilização da rotina de reíduo, conforme a imagem abaixo, valide as seguinte considerações:
*/