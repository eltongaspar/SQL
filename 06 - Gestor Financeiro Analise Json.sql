-- F79 - Log retorno boleto API Cabec.
SELECT 
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) AS F79_JSON,
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)) AS F7A_JSON,
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_ERREXE)) AS F7A_ERREXE,

    -- Extra��o do valor da tag 'dataRegistroTituloCobranca'
    CASE 
        WHEN CHARINDEX('"dataRegistroTituloCobranca":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN SUBSTRING(
            CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
            CHARINDEX('"dataRegistroTituloCobranca":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"dataRegistroTituloCobranca":"'),
            CHARINDEX('"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"dataRegistroTituloCobranca":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"dataRegistroTituloCobranca":"')) - 
            (CHARINDEX('"dataRegistroTituloCobranca":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"dataRegistroTituloCobranca":"'))
        )
        ELSE NULL
    END AS dataRegistroTituloCobranca,

    -- Extra��o do valor da tag 'dataRegistro'
    CASE 
        WHEN CHARINDEX('"dataRegistro":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON))) > 0
        THEN SUBSTRING(
            CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)),
            CHARINDEX('"dataRegistro":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON))) + LEN('"dataRegistro":"'),
            CHARINDEX('"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)), CHARINDEX('"dataRegistro":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON))) + LEN('"dataRegistro":"')) - 
            (CHARINDEX('"dataRegistro":"', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON))) + LEN('"dataRegistro":"'))
        )
        ELSE NULL
    END AS dataRegistro,

    -- Extra��o do valor da tag 'codigoEstadoTituloCobranca'
    CASE 
        WHEN CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN CAST(SUBSTRING(
            CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
            CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
            CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
            (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
        ) AS INT)
        ELSE NULL
    END AS codigoEstadoTituloCobranca,

    -- Mapeamento do valor da tag 'codigoEstadoTituloCobranca' para descri��es
    CASE 
        WHEN CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN CASE 
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 1 THEN 'NORMAL'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 2 THEN 'MOVIMENTO CARTORIO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 3 THEN 'EM CARTORIO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 4 THEN 'TITULO COM OCORRENCIA DE CARTORIO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 5 THEN 'PROTESTADO ELETRONICO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 6 THEN 'LIQUIDADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 7 THEN 'BAIXADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 8 THEN 'TITULO COM PENDENCIA DE CARTORIO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 9 THEN 'TITULO PROTESTADO MANUAL'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 10 THEN 'TITULO BAIXADO/PAGO EM CARTORIO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 11 THEN 'TITULO LIQUIDADO/PROTESTADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 12 THEN 'TITULO LIQUID/PGCRTO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 13 THEN 'TITULO PROTESTADO AGUARDANDO BAIXA'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 14 THEN 'TITULO EM LIQUIDACAO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 15 THEN 'TITULO AGENDADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 16 THEN 'TITULO CREDITADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 17 THEN 'PAGO EM CHEQUE - AGUARD.LIQUIDACAO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 18 THEN 'PAGO PARCIALMENTE CREDITADO'
            WHEN CAST(SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":')) - 
                (CHARINDEX('"codigoEstadoTituloCobranca":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoEstadoTituloCobranca":'))
            ) AS INT) = 80 THEN 'EM PROCESSAMENTO (ESTADO TRANSIT�RIO)'
            ELSE 'ESTADO DESCONHECIDO'
        END
        ELSE NULL
    END AS codigoEstadoTituloCobrancaDesc,

    -- Extra��o e mapeamento do valor da tag 'codigoTipoBaixaTitulo'
    CASE 
        WHEN CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN SUBSTRING(
            CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
            CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
            CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
            (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
        )
        ELSE NULL
    END AS codigoTipoBaixaTitulo,

    -- Extra��o e mapeamento do valor da tag 'codigoTipoBaixaTituloDesc'
    CASE 
        WHEN CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN CASE 
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '1' THEN 'Baixa por pagamento'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '2' THEN 'Baixa por devolu��o'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '3' THEN 'Baixa por protesto'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '4' THEN 'Baixa por instru��o do cliente'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '5' THEN 'Baixa por cr�dito'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '9' THEN 'Outras baixas'
            ELSE NULL
        END
        ELSE NULL
    END AS codigoTipoBaixaTituloDesc,

    -- Extra��o e mapeamento do valor da tag 'codigoTipoLiquidacao'
    CASE 
        WHEN CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN SUBSTRING(
            CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
            CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
            CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
            (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
        ) 
        ELSE NULL
    END AS codigoTipoLiquidacao,
    
    -- Extra��o e mapeamento do valor da tag 'codigoTipoLiquidacaoDesc'
    CASE 
        WHEN CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN CASE
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '0' THEN 'N�o Liquidado'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '1' THEN 'Liquida��o normal'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '2' THEN 'Liquida��o parcial'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '3' THEN 'Liquida��o por saldo devedor'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '4' THEN 'Liquida��o em cart�rio'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '5' THEN 'Liquida��o por compensa��o'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '9' THEN 'Outras formas de liquida��o'
            ELSE NULL
        END
        ELSE NULL
    END AS codigoTipoLiquidacaoDesc,

    *
FROM F79010 F79
    INNER JOIN F7A010 F7A -- Log retorno boleto API Itens  
    ON F79_FILIAL = F7A.F7A_FILIAL
    AND F79.F79_CODIGO = F7A.F7A_CODIGO
    AND F7A.D_E_L_E_T_ = ''

WHERE F79.D_E_L_E_T_ = ''
AND F79_QTPROC > 0
AND (CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%00031285577777777777%' 
    OR CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%00031285577777777778%'
    OR CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%00031285577777777779%'
)
AND (CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%555.55%' 
    OR CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%888.88%' 
    OR CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) LIKE '%777.77%'
)
AND CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)) LIKE '%DOCERIA BARBOSA DE ALMEIDA%'
AND F7A_CLIENT <> ''

ORDER BY F79.R_E_C_N_O_ DESC;

/*
codigoTipoBaixaTitulo, conforme a documenta��o oficial:

1 - Baixa por pagamento:
Indica que o t�tulo foi baixado devido ao pagamento realizado.
2 - Baixa por devolu��o:
Indica que o t�tulo foi baixado devido � devolu��o.
3 - Baixa por protesto:
Indica que o t�tulo foi baixado devido ao protesto.
4 - Baixa por instru��o do cliente:
Indica que o t�tulo foi baixado seguindo uma instru��o espec�fica do cliente.
5 - Baixa por cr�dito:
Indica que o t�tulo foi baixado devido ao cr�dito aplicado.
9 - Outras baixas:


Abaixo est� a lista de ocorr�ncias que podem ser retornadas pela API do Banco do Brasil para a tag codigoTipoLiquidacao:
0 - N�o Liquidado:
Indica que o t�tulo n�o foi liquidado.
1 - Liquida��o normal:
Indica que o t�tulo foi liquidado de forma normal, sem nenhuma particularidade.
2 - Liquida��o parcial:
Indica que o t�tulo foi parcialmente liquidado, ou seja, o pagamento foi feito de forma parcial.
3 - Liquida��o por saldo devedor:
Indica que o t�tulo foi liquidado com base no saldo devedor.
4 - Liquida��o em cart�rio:
Indica que o t�tulo foi liquidado em cart�rio.
5 - Liquida��o por compensa��o:
Indica que o t�tulo foi liquidado por meio de compensa��o.
9 - Outras formas de liquida��o:

*/