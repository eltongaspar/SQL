SELECT 
    D2_PEDIDO, 
    D2_SEQOS, 
    D2_ITEMPV, 
    F2_CDROMA, 
    D2_COD, 
    DB_LOCALIZ, 
	F4_ESTOQUE,
	B1_LOCALIZ,
    SUM(DB_QUANT) AS DBQUANT, 
    0 AS ZZRQUANT, 
	B2_CM1,
	B2_VATU1,
	D2_CUSTO1,

    (
        SELECT ISNULL(SUM(ZZR_QUAN), 0) 
        FROM ZZR010 ZZR WITH (NOLOCK) 
        WHERE 
            ZZR_FILIAL = D2_FILIAL 
            AND ZZR_PEDIDO = D2_PEDIDO 
            AND ZZR_ITEMPV = D2_ITEMPV 
            AND ZZR_SEQOS = D2_SEQOS 
            AND LEFT(ZZR_PRODUT, 10) = LEFT(D2_COD, 10) 
            AND ZZR_LOCALI = DB_LOCALIZ 
            AND ZZR.D_E_L_E_T_ = ''
    ) AS ZZRQUANT2, 
    D2_FILIAL
FROM 
    SF2010 F2 WITH (NOLOCK)
    INNER JOIN SD2010 D2 WITH (NOLOCK) 
        ON F2_FILIAL = D2_FILIAL 
        AND F2_DOC = D2_DOC 
        AND F2_SERIE = D2_SERIE 
        AND F2_CLIENTE = D2_CLIENTE 
        AND F2_LOJA = D2_LOJA 
        AND F2.D_E_L_E_T_ = D2.D_E_L_E_T_
    INNER JOIN SB1010 B1 WITH (NOLOCK) 
        ON B1_FILIAL = '  ' 
        AND D2_COD = B1_COD 
        AND D2.D_E_L_E_T_ = B1.D_E_L_E_T_
    INNER JOIN SF4010 F4 WITH (NOLOCK) 
        ON F4_FILIAL = '  ' 
        AND D2_TES = F4_CODIGO 
        AND D2.D_E_L_E_T_ = F4.D_E_L_E_T_
    LEFT JOIN SDB010 DB WITH (NOLOCK) 
        ON D2_FILIAL = DB_FILIAL 
        AND D2_COD = DB_PRODUTO 
        AND D2_LOCAL = DB_LOCAL 
        AND D2_NUMSEQ = DB_NUMSEQ 
        AND D2_DOC = DB_DOC 
        AND D2_SERIE = DB_SERIE 
        AND D2.D_E_L_E_T_ = F4.D_E_L_E_T_

	INNER JOIN SB2010 B2 WITH (NOLOCK) 
        ON B2_FILIAL = D2_FILIAL 
		AND D2_COD = B2_COD 
		And D2_LOCAL = B2_LOCAL
        AND D2.D_E_L_E_T_ = B1.D_E_L_E_T_

WHERE 
    F2_FILIAL = '03' 
    AND F2_CDROMA >= '363391' 
 --   AND F2_CDROMA <= '363391' 
    AND F2.D_E_L_E_T_ = '' 
    AND F4_ESTOQUE = 'S' 
    AND D2_SEQOS <> '  ' 
    AND B1_LOCALIZ = 'S'
GROUP BY 
    D2_FILIAL, 
    F2_CDROMA, 
    D2_PEDIDO, 
    D2_ITEMPV, 
    D2_SEQOS, 
    D2_COD, 
    DB_LOCALIZ,
	F4_ESTOQUE,
	B1_LOCALIZ,
	B2_CM1,
	B2_VATU1,
	D2_CUSTO1;
