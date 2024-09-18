WITH XMLData AS (
    SELECT 
        CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), [CC0_XMLMDF])) AS XMLContent,
        CC0.CC0_FILIAL,
        CC0.CC0_SERMDF,
        CC0.CC0_NUMMDF,
        CC0.CC0_CHVMDF,
        CC0.CC0_STATUS,
        CC0.CC0_STATEV,
        CC0.CC0_CODRET,
        CC0.CC0_MSGRET,
        CC0.CC0_PROTOC,
        CC0.CC0_DTEMIS,
        CC0.CC0_HREMIS,
        CC0.CC0_UFINI,
        CC0.CC0_UFFIM,
        CC0.CC0_XMLMDF,
        CC0.CC0_QTDNFE,
        CC0.CC0_VTOTAL,
        CC0.CC0_PESOB,
        CC0.CC0_VEICUL,
        CC0.CC0_TPEVEN,
        CC0.CC0_TPNF,
        CC0.CC0_CARGA,
        CC0.CC0_VINCUL,
        CC0.CC0_CARPST,
        CC0.CC0_MOTORI,
        CC0.CC0_MODAL,
        CC0.D_E_L_E_T_,
        DA4.DA4_COD,
        DA4.DA4_NOME,
        DA4.DA4_CGC,
        DA4.DA4_MAT,
        DA4.DA4_NUMCNH,
        CASE 
            WHEN CC0.CC0_STATUS = '1' THEN 'Transmitido'
            WHEN CC0.CC0_STATUS = '2' THEN 'Não Transmitido'
            WHEN CC0.CC0_STATUS = '3' THEN 'Autorizado'
            WHEN CC0.CC0_STATUS = '4' THEN 'Não Autorizado'
            WHEN CC0.CC0_STATUS = '5' THEN 'Cancelado'
            WHEN CC0.CC0_STATUS = '6' THEN 'Encerrado'
        END AS CC0_STATUS_DESC,
        CASE
            WHEN CC0.CC0_STATEV = '1' THEN 'Evento não Realizado'
            WHEN CC0.CC0_STATEV = '2' THEN 'Evento Realizado'
            WHEN CC0.CC0_STATEV = '3' THEN 'Evento Vinculado'
            WHEN CC0.CC0_STATEV = '4' THEN 'Evento não Vinculado'
            WHEN CC0.CC0_STATEV = ''  THEN ''
        END AS CC0_STATEV_DESC,
        CASE
            WHEN CC0.CC0_TPNF = '1' THEN 'NF Entrada'
            WHEN CC0.CC0_TPNF = '2' THEN 'NF Saída'
            WHEN CC0.CC0_TPNF = '3' THEN 'Outros'
        END AS CC0_TPNF_DESC
    FROM CC0010 CC0
    INNER JOIN DA4010 DA4 ON CC0.CC0_MOTORI = DA4.DA4_COD AND DA4.D_E_L_E_T_ = ''
    WHERE CC0.D_E_L_E_T_ = ''
),
SegTagData AS (
    SELECT
        XMLContent,
        CHARINDEX('<seg>', XMLContent) AS StartTag,
        CHARINDEX('</seg>', XMLContent) AS EndTag,
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<vCarga>'), 
                    CHARINDEX('</vCarga>', XMLContent, CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<vCarga>')
                )
            ELSE 'N/A'
        END AS vCarga,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qCTe>'), 
                    CHARINDEX('</qCTe>', XMLContent, CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qCTe>')
                )
            ELSE 'N/A'
        END AS qCTe,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qMDFe>'), 
                    CHARINDEX('</qMDFe>', XMLContent, CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qMDFe>')
                )
            ELSE 'N/A'
        END AS qMDFe,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qCarga>'), 
                    CHARINDEX('</qCarga>', XMLContent, CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qCarga>')
                )
            ELSE 'N/A'
        END AS qCarga
    FROM XMLData
    WHERE CHARINDEX('<seg>', XMLContent) > 0
    UNION ALL
    SELECT
        XMLContent,
        CHARINDEX('<seg>', XMLContent, EndTag + LEN('</seg>')) AS StartTag,
        CHARINDEX('</seg>', XMLContent, EndTag + LEN('</seg>')),
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC,
        vCarga,
        qCTe,
        qMDFe,
        qCarga
    FROM SegTagData
    WHERE CHARINDEX('<seg>', XMLContent, EndTag + LEN('</seg>')) > 0
),
ParsedSegData AS (
    SELECT
        XMLContent,
        SUBSTRING(XMLContent, StartTag, EndTag - StartTag + LEN('</seg>')) AS SegContent,
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC,
        vCarga,
        qCTe,
        qMDFe,
        qCarga
    FROM SegTagData
    WHERE StartTag > 0 AND EndTag > StartTag
),
ExtractedCNPJData AS (
    SELECT
        CASE 
            WHEN CHARINDEX('<respSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS resp_CNPJ,
        CASE 
            WHEN CHARINDEX('<infSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS Seg_CNPJ,
        CASE 
            WHEN CHARINDEX('<nApol>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nApol>', SegContent) + LEN('<nApol>'), 
                    CHARINDEX('</nApol>', SegContent) - CHARINDEX('<nApol>', SegContent) - LEN('<nApol>')
                )
            ELSE 'N/A'
        END AS nApol,
        CASE 
            WHEN CHARINDEX('<nAver>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nAver>', SegContent) + LEN('<nAver>'), 
                    CHARINDEX('</nAver>', SegContent) - CHARINDEX('<nAver>', SegContent) - LEN('<nAver>')
                )
            ELSE 'N/A'
        END AS nAver,
        CASE 
            WHEN CHARINDEX('<infSeg>', SegContent) > 0 AND CHARINDEX('<xSeg>', SegContent, CHARINDEX('<infSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent)) + LEN('<xSeg>'), 
                    CHARINDEX('</xSeg>', SegContent, CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent))) - CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent)) - LEN('<xSeg>')
                )
            ELSE 'N/A'
        END AS Seg_Nome,
        vCarga,
        qCTe,
        qMDFe,
        qCarga,
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC
    FROM ParsedSegData
)
SELECT 
    resp_CNPJ,
    Seg_CNPJ,
    Seg_Nome,
    nApol,
    nAver,
    vCarga,
    qCTe,
    qMDFe,
    qCarga,
    CC0_FILIAL,
    CC0_SERMDF,
    CC0_NUMMDF,
    CC0_CHVMDF,
    CC0_STATUS,
    CC0_STATEV,
    CC0_CODRET,
    CC0_MSGRET,
    CC0_PROTOC,
    CC0_DTEMIS,
    CC0_HREMIS,
    CC0_UFINI,
    CC0_UFFIM,
    CC0_XMLMDF,
    CC0_QTDNFE,
    CC0_VTOTAL,
    CC0_PESOB,
    CC0_VEICUL,
    CC0_TPEVEN,
    CC0_TPNF,
    CC0_CARGA,
    CC0_VINCUL,
    CC0_CARPST,
    CC0_MOTORI,
    CC0_MODAL,
    D_E_L_E_T_,
    DA4_COD,
    DA4_NOME,
    DA4_CGC,
    DA4_MAT,
    DA4_NUMCNH,
    CC0_STATUS_DESC,
    CC0_STATEV_DESC,
    CC0_TPNF_DESC
FROM ExtractedCNPJData;
