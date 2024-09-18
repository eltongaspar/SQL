DECLARE @DATEINI varchar(8)
DECLARE @DATEFIM varchar(8)
DECLARE @FILIALINI varchar(4)
DECLARE @FILIALFIM varchar(4)

SET @DATEINI = '20220401'
SET @DATEFIM = '20220430'
SET @FILIALINI = ''
SET @FILIALFIM = 'ZZZZ'

--UPDATE C35010 SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = C35.R_E_C_N_O_ FROM C20010 C20
INNER JOIN C35010 C35 ON C20_FILIAL = C35_FILIAL AND C35_CHVNF = C20_CHVNF AND C35_CODTRI = '000024' AND C35.D_E_L_E_T_ = ''
WHERE 
C20_FILIAL BETWEEN @FILIALINI AND @FILIALFIM AND
C20_TPDOC = '000002' AND
C20_DTES BETWEEN @DATEINI AND @DATEFIM AND 
C20.D_E_L_E_T_ = ''

--UPDATE C30010 SET C30_VLOPER = C30_TOTAL FROM C20010 C20
INNER JOIN C30010 C30 ON C20_FILIAL = C30_FILIAL AND C30_CHVNF = C20_CHVNF AND C30.D_E_L_E_T_ = ''
INNER JOIN C35010 C35 ON C20_FILIAL = C35_FILIAL AND C35_CHVNF = C20_CHVNF AND C35_CODTRI = '000013' and C35.D_E_L_E_T_ = ''
WHERE 
C20_FILIAL BETWEEN @FILIALINI AND @FILIALFIM AND
C20_INDOPE = '0' AND
--C20_NUMDOC = '000042763' AND
C20_DTES BETWEEN @DATEINI AND @DATEFIM AND 
C30_VLOPER <> C30_TOTAL and
C20.D_E_L_E_T_ = ''
