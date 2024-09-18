-- Relatorio PC-Fornecedor-NF

Select
	   D1.D1_DOC                            AS [NF_Numero],
	   (CAST(D1.D1_EMISSAO  AS DATE))       AS [NF_Emissão],
	   (CAST(D1.D1_DTDIGIT  AS DATE))       AS [NF_DT_Digitacao],
	   D1.D1_PEDIDO                         AS [Pedido],
	   D1.D1_FORNECE                        AS [Fornecedor],
	   D1.D1_LOJA                           AS [Loja],
       E2.E2_PARCELA                        AS [Parcela],
       E2.E2_EMISSAO                        AS [Emissao],
       E2.E2_VENCREA                        AS [Vencto_real],
       SUM(E2.E2_VALOR)                          AS [Valor]
	   FROM SD1010 D1
       LEFT JOIN SE2010 AS E2    --contas a Pagar
                  ON D1.D1_DOC      = E2.E2_NUM
			     AND D1.D1_FORNECE = E2.E2_FORNECE
			     AND D1.D1_EMISSAO = E2.E2_EMISSAO
			     AND D1.D1_LOJA     = E2.E2_LOJA
			     AND E2.D_E_L_E_T_=''			     
	   WHERE D1.D1_DTDIGIT >'2022'
	   AND D1.D_E_L_E_T_=''
       AND D1.D1_PEDIDO<>''
       
GROUP BY
	   D1.D1_DOC,
	   D1.D1_EMISSAO,
	   D1.D1_DTDIGIT,
	   D1.D1_PEDIDO,
	   D1.D1_FORNECE,
	   D1.D1_LOJA,
       E2.E2_PARCELA,
       E2.E2_EMISSAO,
       E2.E2_VENCREA