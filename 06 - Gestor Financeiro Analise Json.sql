-- F79 - Log retorno boleto API Cabec.
SELECT 
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F79_JSON)) AS F79_JSON,
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)) AS F7A_JSON,
    CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_ERREXE)) AS F7A_ERREXE,

    -- Extração do valor da tag 'dataRegistroTituloCobranca'
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

    -- Extração do valor da tag 'dataRegistro'
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

    -- Extração do valor da tag 'codigoEstadoTituloCobranca'
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

    -- Mapeamento do valor da tag 'codigoEstadoTituloCobranca' para descrições
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
            ) AS INT) = 80 THEN 'EM PROCESSAMENTO (ESTADO TRANSITÓRIO)'
            ELSE 'ESTADO DESCONHECIDO'
        END
        ELSE NULL
    END AS codigoEstadoTituloCobrancaDesc,

    -- Extração e mapeamento do valor da tag 'codigoTipoBaixaTitulo'
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

    -- Extração e mapeamento do valor da tag 'codigoTipoBaixaTituloDesc'
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
            ) = '2' THEN 'Baixa por devolução'
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
            ) = '4' THEN 'Baixa por instrução do cliente'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":')) - 
                (CHARINDEX('"codigoTipoBaixaTitulo":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoBaixaTitulo":'))
            ) = '5' THEN 'Baixa por crédito'
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

    -- Extração e mapeamento do valor da tag 'codigoTipoLiquidacao'
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
    
    -- Extração e mapeamento do valor da tag 'codigoTipoLiquidacaoDesc'
    CASE 
        WHEN CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) > 0
        THEN CASE
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '0' THEN 'Não Liquidado'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '1' THEN 'Liquidação normal'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '2' THEN 'Liquidação parcial'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '3' THEN 'Liquidação por saldo devedor'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '4' THEN 'Liquidação em cartório'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '5' THEN 'Liquidação por compensação'
            WHEN SUBSTRING(
                CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)),
                CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'),
                CHARINDEX(',', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON)), CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":')) - 
                (CHARINDEX('"codigoTipoLiquidacao":', CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), F7A_JSON))) + LEN('"codigoTipoLiquidacao":'))
            ) = '9' THEN 'Outras formas de liquidação'
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
codigoTipoBaixaTitulo, conforme a documentação oficial:

1 - Baixa por pagamento:
Indica que o título foi baixado devido ao pagamento realizado.
2 - Baixa por devolução:
Indica que o título foi baixado devido à devolução.
3 - Baixa por protesto:
Indica que o título foi baixado devido ao protesto.
4 - Baixa por instrução do cliente:
Indica que o título foi baixado seguindo uma instrução específica do cliente.
5 - Baixa por crédito:
Indica que o título foi baixado devido ao crédito aplicado.
9 - Outras baixas:


Abaixo está a lista de ocorrências que podem ser retornadas pela API do Banco do Brasil para a tag codigoTipoLiquidacao:
0 - Não Liquidado:
Indica que o título não foi liquidado.
1 - Liquidação normal:
Indica que o título foi liquidado de forma normal, sem nenhuma particularidade.
2 - Liquidação parcial:
Indica que o título foi parcialmente liquidado, ou seja, o pagamento foi feito de forma parcial.
3 - Liquidação por saldo devedor:
Indica que o título foi liquidado com base no saldo devedor.
4 - Liquidação em cartório:
Indica que o título foi liquidado em cartório.
5 - Liquidação por compensação:
Indica que o título foi liquidado por meio de compensação.
9 - Outras formas de liquidação:

*/