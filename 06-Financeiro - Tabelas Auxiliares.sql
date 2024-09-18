--Estudos Tabelas Financeiro (Contas a Pagar e a Receber) com tabelas auxiliares
-- Contas a receber
SELECT
    SE5.R_E_C_N_O_  AS SE5REC,
	FK2.R_E_C_N_O_  AS FK2REC,
    FK7.R_E_C_N_O_  AS FK7REC,
    FKA.R_E_C_N_O_  AS FKAREC,
    FKA2.R_E_C_N_O_ AS FKA2REC
FROM
    SE5010 SE5
    LEFT JOIN FK2010 FK2 ON (
        FK2_FILIAL = 'BA'
        AND FK2_IDFK2 = E5_IDORIG
        AND FK2.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FK7010 FK7 ON (
        FK7_FILIAL = 'BA'
        AND FK7_IDDOC = FK2_IDDOC
        AND FK7.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FKA010 FKA ON (
        FKA.FKA_FILIAL = 'BA'
        AND FKA.FKA_IDORIG = E5_IDORIG
        AND FKA.FKA_TABORI = 'FK2'
        AND FKA.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FKA010 FKA2 ON (
        FKA2.FKA_FILIAL = 'BA'
        AND FKA2.FKA_IDPROC = FKA.FKA_IDPROC
        AND FKA2.FKA_TABORI = 'FK5'
        AND FKA2.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FK5010 FK5 ON (
        FK5_FILIAL = 'BA'
        AND FK5_IDMOV = FKA2.FKA_IDORIG
        AND FK5.D_E_L_E_T_ = ' '
    )
WHERE
    E5_FILIAL = 'BA'
    AND E5_NUMERO = '000073668'
    AND E5_PREFIXO <> ''
    AND SE5.D_E_L_E_T_ = ''




-- Contas a receber 


SELECT
    SE5.R_E_C_N_O_  AS SE5REC,
    FK1.R_E_C_N_O_  AS FK1REC,
    FK7.R_E_C_N_O_  AS FK7REC,
    FKA.R_E_C_N_O_  AS FKAREC,
    FKA2.R_E_C_N_O_ AS FKA2REC
FROM
    SE5010 SE5
    LEFT JOIN FK1010 FK1 ON (
        FK1_FILIAL = 'BA'
        AND FK1_IDFK1 = E5_IDORIG
        AND FK1.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FK7010 FK7 ON (
        FK7_FILIAL = 'BA'
        AND FK7_IDDOC = FK1_IDDOC
        AND FK7.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FKA010 FKA ON (
        FKA.FKA_FILIAL = 'BA'
        AND FKA.FKA_IDORIG = E5_IDORIG
        AND FKA.FKA_TABORI = 'FK1'
        AND FKA.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FKA010 FKA2 ON (
        FKA2.FKA_FILIAL = 'BA'
        AND FKA2.FKA_IDPROC = FKA.FKA_IDPROC
        AND FKA2.FKA_TABORI = 'FK5'
        AND FKA2.D_E_L_E_T_ = ' '
    )
    LEFT JOIN FK5010 FK5 ON (
        FK5_FILIAL = 'BA'
        AND FK5_IDMOV = FKA2.FKA_IDORIG
        AND FK5.D_E_L_E_T_ = ' '
    )
WHERE
    E5_FILIAL = 'BA'
    AND E5_NUMERO = '000001948'
    AND E5_PREFIXO <> ''
    AND SE5.D_E_L_E_T_ = ' '
