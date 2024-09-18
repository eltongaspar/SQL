-- Vendas por vendedores
SELECT 
	C5_VEND1 COD_VENDEDOR,
	D2_CLIENTE COD_CLIENTE,
	A1_NOME RAZAO_SOCIAL, 
	D2_COD PRODUTO, 
	B1_DESC DESCRICAO_PRODUTO, 
	A1_EST ESTADO,
	A1_MUN CIDADE,
	D2_QUANT VOLUME,
	D2_TOTAL PREÇO_ESTIMADO                                                                                                                                                                                                                           
FROM 
    SD2010 SD2

	INNER JOIN SF2010 SF2 WITH (NOLOCK) 
	ON  F2_FILIAL  = D2_FILIAL 
    AND F2_DOC     = D2_DOC 
    AND F2_SERIE   = D2_SERIE 
    AND F2_CLIENTE = D2_CLIENTE 
    AND F2_LOJA    = D2_LOJA
	AND F2_TIPO IN ('N','C')
	AND SF2.D_E_L_E_T_= ' '

	INNER JOIN SA1010 SA1 WITH (NOLOCK)
	ON A1_FILIAL= ' '
	AND A1_COD=D2_CLIENTE
	AND	A1_LOJA=D2_LOJA
	AND SA1.D_E_L_E_T_=''
		
	INNER JOIN SB1010 SB1 WITH (NOLOCK)
	ON B1_FILIAL= ' '
	AND B1_COD=D2_COD
	AND SB1.D_E_L_E_T_=''

	INNER JOIN SC5010 SC5 WITH (NOLOCK)
	ON B1_FILIAL= ' '
	AND D2_PEDIDO=C5_NUM
	AND SC5.D_E_L_E_T_=''

	INNER JOIN SF4010 SF4 WITH (NOLOCK)
	ON F4_FILIAL = ' '
	AND F4_CODIGO=D2_TES
	AND F4_DUPLIC='S'
	AND SF4.D_E_L_E_T_=''
	
WHERE 
    SD2.D_E_L_E_T_='' AND D2_EMISSAO BETWEEN '20210101' AND '2021231' and 
	C5_VEND1 IN 
	--('000004','000005','000006','000007','000015')
	('000008','000009','000011')
	--And C5_FILIAL = 'BA'



