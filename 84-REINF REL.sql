Declare @DTINI Char(8), @DTFIM Char(8);
Set @DTINI = '20240801'
Set @DTFIM = '20240831'

SELECT TBGER.FILIAL FILIAL,
TBGER.CNPJ CNPJ,
TBGER.CODPAR,
TBGER.INDNIF,
TBGER.NIF,
TBGER.FORMATRIBUTACAO,
TBGER.NOME NOME,
TBGER.INDFCISCP,
TBGER.CNPJFCISCP,
TBGER.INDRRA,
TBGER.NRRRAPJD,
TBGER.CNPJOR,
TBGER.CUSTADV,
TBGER.CUSTJUD,
TBGER.TIPO,
TBGER.SERIE_PARC,
TBGER.NUMERO,
TBGER.NUMITE,
TBGER.DTEMISPGT,
TBGER.ID,
TBGER.CODNAT,
TBGER.DSCNAT,
TBGER.VALBRUTO,
TBGER.BASEIR,
TBGER.ALIQIR,
TBGER.VALIR,
TBGER.BASEPIS,
TBGER.ALIQPIS,
TBGER.VALPIS,
TBGER.BASECOFINS,
TBGER.ALIQCOFINS,
TBGER.VALCOFINS,
TBGER.BASECSLL,
TBGER.ALIQCSLL,
TBGER.VALCSLL,
TBGER.BSEAGREG,
TBGER.VAGREG,
TBGER.VBSIR,
TBGER.VRSIR,
TBGER.VBSPIS,
TBGER.VRSPIS,
TBGER.VBSCOFINS,
TBGER.VRSCOFINS,
TBGER.VBSCSLL,
TBGER.VRSCSLL,
TBGER.NPROCREF 
FROM (
		SELECT C20.C20_FILIAL FILIAL,
		C1H.C1H_CNPJ CNPJ,
		C1H.C1H_CODPAR CODPAR,
		C1H.C1H_INDNIF INDNIF,
		C1H.C1H_NIF NIF,
		COALESCE(T9A.T9A_DESCRI,' ') FORMATRIBUTACAO,
		C1H.C1H_NOME NOME,
		C20.C20_FCISCP INDFCISCP,
		COALESCE(V3X.V3X_CNPJ,' ') CNPJFCISCP,
		' ' INDRRA,
		' ' NRRRAPJD,
		' ' CNPJOR,
		0 CUSTADV,
		0 CUSTJUD,
		C20.C20_CHVNF ID,
		'NFS' TIPO,
		C20.C20_NUMDOC NUMERO,
		C30.C30_NUMITE NUMITE,
		C20.C20_SERIE SERIE_PARC,
		C20.C20_DTDOC DTEMISPGT,
		V3O.V3O_CODIGO CODNAT,
		V3O.V3O_DESCR DSCNAT,
		COALESCE(SUM(C30.C30_TOTAL),0) VALBRUTO,
		COALESCE(SUM(C35.C35_BASE),0) BASEIR,
		COALESCE(C35.C35_ALIQ,0) ALIQIR,
		COALESCE(SUM(C35.C35_VALOR),0) VALIR,
		0 BASEPIS,
		0 ALIQPIS,
		0 VALPIS,
		0 BASECOFINS,
		0 ALIQCOFINS,
		0 VALCOFINS,
		0 BASECSLL,
		0 ALIQCSLL,
		0 VALCSLL,
		0 BSEAGREG,
		0 VAGREG,
		COALESCE((
					SELECT SUM(T9Q.T9Q_BSSUSP) 
					FROM T9Q010 T9Q 
					WHERE  T9Q.T9Q_FILIAL = C20.C20_FILIAL 
					AND T9Q.T9Q_CHVNF = C20.C20_CHVNF 
					AND T9Q.T9Q_NUMITE = C30.C30_NUMITE 
					AND T9Q.D_E_L_E_T_ = ' ' 
					AND T9Q.T9Q_CODTRI = '000012'),0
		) VBSIR,
		COALESCE((
					SELECT SUM(T9Q.T9Q_VALSUS) 
					FROM T9Q010 T9Q 
					WHERE  T9Q.T9Q_FILIAL = C20.C20_FILIAL 
					AND T9Q.T9Q_CHVNF = C20.C20_CHVNF 
					AND T9Q.T9Q_NUMITE = C30.C30_NUMITE 
					AND T9Q.D_E_L_E_T_ = ' ' 
					AND T9Q.T9Q_CODTRI = '000012'),0
		) VRSIR,
		0 VBSPIS,
		0 VRSPIS,
		0 VBSCOFINS,
		0 VRSCOFINS,
		0 VBSCSLL,
		0 VRSCSLL,
		COALESCE((
					SELECT TOP 1 C1G.C1G_NUMPRO 
					FROM T9Q010 T9Q 
					INNER JOIN C1G010 C1G ON C1G.C1G_FILIAL = T9Q.T9Q_FILIAL 
										 AND C1G.C1G_ID = T9Q.T9Q_NUMPRO 
										 AND C1G.D_E_L_E_T_ = ' ' 
					WHERE  T9Q.T9Q_FILIAL = C20.C20_FILIAL 
					AND T9Q.T9Q_CHVNF = C20.C20_CHVNF 
					AND T9Q.T9Q_NUMITE = C30.C30_NUMITE 
					AND T9Q.D_E_L_E_T_ = ' ' 
					AND T9Q.T9Q_CODTRI = '000012' ),' '
		) NPROCREF 
		FROM C20010 C20 
		INNER JOIN C1H010 C1H ON C1H.C1H_FILIAL =''
							 AND C1H.C1H_ID = C20.C20_CODPAR 
							 AND ((C1H.C1H_CNPJ <> '              ' AND C1H.C1H_PPES = '2') OR (C1H.C1H_PEEXTE = '2' AND C1H.C1H_PAISEX <> ' ')) 
							 AND C1H.D_E_L_E_T_ = ' ' 
		LEFT JOIN T9A010 T9A ON T9A.T9A_FILIAL = '  ' 
							 AND T9A.T9A_ID = C1H.C1H_IDTRIB 
							 AND T9A.D_E_L_E_T_ = ' ' 
		INNER JOIN C30010 C30 ON C30.C30_FILIAL = C20.C20_FILIAL 
							 AND C30.C30_CHVNF = C20.C20_CHVNF 
							 AND C30.C30_CNATRE <> '      ' 
							 AND C30.D_E_L_E_T_ = ' ' 
		INNER JOIN V3O010 V3O ON V3O.V3O_FILIAL = '  ' 
							 AND V3O.V3O_ID = C30.C30_CNATRE 
							 AND V3O.D_E_L_E_T_ = ' ' 
		LEFT JOIN V3X010 V3X ON V3X.V3X_FILIAL = C20.C20_FILIAL 
							AND V3X.V3X_ID = C30.C30_IFCISC 
							AND V3X.D_E_L_E_T_ = ' ' 
		LEFT JOIN C35010 C35 ON C35.C35_FILIAL = C30.C30_FILIAL 
							AND C35.C35_CHVNF = C30.C30_CHVNF 
							AND C35.C35_NUMITE = C30.C30_NUMITE 
							AND C35.C35_CODITE = C30.C30_CODITE 
							AND C35.C35_CODTRI = '000012' 
							AND C35.D_E_L_E_T_ = ' ' 
		LEFT JOIN LEM010 LEM ON LEM.LEM_FILIAL = C20.C20_FILIAL 
							AND LEM.LEM_DOCORI = C20.C20_CHVNF 
							AND LEM.D_E_L_E_T_ = ' ' 
		WHERE  C20.C20_FILIAL IN ('01','02','03') 
		AND C20.C20_DTDOC BETWEEN @DTINI AND @DTFIM 
		AND C20.C20_INDOPE = '0' 
		AND LEM.LEM_DOCORI IS NULL 
		AND (
			C35.C35_BASE > 0 OR 
			(C35.C35_CODTRI IS NULL 
			AND C30.C30_CNATRE IN (
									SELECT V3O.V3O_ID 
									FROM V3O010 V3O 
									WHERE  V3O.D_E_L_E_T_ = ' ' 
									AND V3O.V3O_CODIGO LIKE '20%'
									)  
			)
		) 
		AND C20.D_E_L_E_T_ = ' ' 
		GROUP BY C20.C20_FILIAL,
		C1H.C1H_CNPJ,
		C1H.C1H_CODPAR,
		C1H.C1H_INDNIF,
		C1H.C1H_NIF,
		T9A.T9A_DESCRI,
		C1H.C1H_NOME,
		C20.C20_FCISCP,
		V3X.V3X_CNPJ,
		C1H.C1H_PAISEX, 
		C20.C20_CHVNF,
		C20.C20_NUMDOC,
		C30.C30_NUMITE,
		C20.C20_SERIE,
		C20.C20_DTDOC,
		V3O.V3O_CODIGO,
		V3O.V3O_DESCR,
		C35.C35_ALIQ 
		
		UNION ALL  
		
		SELECT TMPFAT.FILIAL,
		TMPFAT.CNPJ,
		TMPFAT.CODPAR,
		TMPFAT.INDNIF,
		TMPFAT.NIF,
		TMPFAT.FORMATRIBUTACAO,
		TMPFAT.NOME NOME,
		TMPFAT.INDFCISCP,
		TMPFAT.CNPJFCISCP,
		TMPFAT.INDRRA,
		TMPFAT.NRRRAPJD,
		TMPFAT.CNPJOR,
		COALESCE(
				(SELECT SUM(V4GADV.V4G_VLDESP) 
				 FROM V4F010 V4F 
				 INNER JOIN V4G010 V4GADV ON V4GADV.V4G_FILIAL = V4F.V4F_FILIAL 
										 AND V4GADV.V4G_ID = V4F.V4F_ID 
										 AND V4GADV.V4G_TPDESP = '1' 
										 AND V4GADV.V4G_DTDESP BETWEEN @DTINI AND @DTFIM 
										 AND V4GADV.D_E_L_E_T_ = ' ' 
				 WHERE  V4F.V4F_FILIAL = TMPFAT.FILIAL 
				 AND V4F.V4F_ID = TMPFAT.IDRRAPJUD 
				 AND V4F.D_E_L_E_T_ = ' ' )
		,0) CUSTADV,
		COALESCE(
				(SELECT SUM(V4GJUD.V4G_VLDESP) 
				 FROM V4F010 V4F 
				 INNER JOIN V4G010 V4GJUD ON V4GJUD.V4G_FILIAL = V4F.V4F_FILIAL 
										 AND V4GJUD.V4G_ID = V4F.V4F_ID 
										 AND V4GJUD.V4G_TPDESP = '2' 
										 AND V4GJUD.V4G_DTDESP BETWEEN @DTINI AND @DTFIM 
										 AND V4GJUD.D_E_L_E_T_ = ' ' 
				 WHERE  V4F.V4F_FILIAL = TMPFAT.FILIAL 
				 AND V4F.V4F_ID = TMPFAT.IDRRAPJUD 
				 AND V4F.D_E_L_E_T_ = ' ' )
		,0) CUSTJUD,
		TMPFAT.ID,
		TMPFAT.TIPO,
		TMPFAT.NUMERO,
		' ' NUMITE,
		TMPFAT.SERIE_PARC,
		TMPFAT.DTEMISPGT,
		TMPFAT.CODNAT,
		TMPFAT.DSCNAT,
		TMPFAT.VALBRUTO,
		TMPFAT.BASEIR,
		TMPFAT.ALIQIR,
		TMPFAT.VALIR,
		0 BASEPIS,
		0 ALIQPIS,
		0 VALPIS,
		0 BASECOFINS,
		0 ALIQCOFINS,
		0 VALCOFINS,
		0 BASECSLL,
		0 ALIQCSLL,
		0 VALCSLL,
		0 BSEAGREG,
		0 VAGREG,
		TMPFAT.VBSIR,
		TMPFAT.VRSIR,
		0 VBSPIS,
		0 VRSPIS,
		0 VBSCOFINS,
		0 VRSCOFINS,
		0 VBSCSLL,
		0 VRSCSLL,
		TMPFAT.NPROCREF 
		FROM (
				SELECT LEM.LEM_FILIAL FILIAL,
				C1H.C1H_CNPJ CNPJ,
				C1H.C1H_CODPAR CODPAR,
				C1H.C1H_INDNIF INDNIF,
				C1H.C1H_NIF NIF,
				COALESCE(T9A.T9A_DESCRI,' ') FORMATRIBUTACAO,
				C1H.C1H_NOME NOME,
				LEM.LEM_FCISCP INDFCISCP,
				COALESCE(V3X.V3X_CNPJ,' ') CNPJFCISCP,
				V3S.V3S_IDPROC IDRRAPJUD,
				COALESCE(V4F.V4F_INDRRA,' ') INDRRA,
				COALESCE(V4F.V4F_NRPROC,' ') NRRRAPJD,
				COALESCE(V4F.V4F_CNPJOR,' ') CNPJOR,
				'FAT' TIPO,
				LEM.LEM_NUMERO NUMERO,
				' ' SERIE_PARC,
				LEM.LEM_DTEMIS DTEMISPGT,
				LEM.LEM_ID ID,
				V3S.V3S_IDNATR IDNATR,
				V3O.V3O_CODIGO CODNAT,
				V3O.V3O_DESCR DSCNAT,
				LEM.LEM_VLBRUT VALBRUTO,
				COALESCE(SUM(V47.V47_BASECA),0) BASEIR,
				COALESCE(V47.V47_ALIQ,0) ALIQIR,
				COALESCE(SUM(V47.V47_VLTRIB),0) VALIR,
				COALESCE(
						(SELECT TOP 1 C1G.C1G_NUMPRO 
						 FROM T9E010 T9E 
						 INNER JOIN C1G010 C1G ON C1G.C1G_FILIAL = T9E.T9E_FILIAL 
											  AND C1G.C1G_ID = T9E.T9E_NUMPRO 
											  AND C1G.D_E_L_E_T_ = ' ' 
						 WHERE  T9E.T9E_FILIAL = LEM.LEM_FILIAL 
						 AND T9E.T9E_ID = LEM.LEM_ID 
						 AND T9E.T9E_IDPART = LEM.LEM_IDPART 
						 AND T9E.T9E_NUMFAT = LEM.LEM_NUMERO 
						 AND T9E.T9E_CNATRE = V3S.V3S_IDNATR 
						 AND T9E.T9E_CODTRI = '000012' 
						 AND T9E.D_E_L_E_T_ = ' ' )
				,' ') NPROCREF,
				COALESCE(
						(SELECT SUM(T9E.T9E_BSSUSP) 
						 FROM T9E010 T9E 
						 WHERE  T9E.T9E_FILIAL = LEM.LEM_FILIAL 
						 AND T9E.T9E_ID = LEM.LEM_ID
						 AND T9E.T9E_IDPART = LEM.LEM_IDPART 
						 AND T9E.T9E_NUMFAT = LEM.LEM_NUMERO 
						 AND T9E.T9E_CNATRE = V3S.V3S_IDNATR 
						 AND T9E.T9E_CODTRI = '000012' 
						 AND T9E.D_E_L_E_T_ = ' ')
				,0) VBSIR,
				COALESCE(
						(SELECT SUM(T9E.T9E_VALSUS) 
						 FROM T9E010 T9E 
						 WHERE  T9E.T9E_FILIAL = LEM.LEM_FILIAL 
						 AND T9E.T9E_ID = LEM.LEM_ID 
						 AND T9E.T9E_IDPART = LEM.LEM_IDPART 
						 AND T9E.T9E_NUMFAT = LEM.LEM_NUMERO 
						 AND T9E.T9E_CNATRE = V3S.V3S_IDNATR 
						 AND T9E.T9E_CODTRI = '000012' 
						 AND T9E.D_E_L_E_T_ = ' ')
				,0) VRSIR 
				FROM LEM010 LEM 
				INNER JOIN C1H010 C1H ON C1H.C1H_FILIAL = '' 
									 AND C1H.C1H_ID = LEM.LEM_IDPART 
									 AND ((C1H.C1H_CNPJ <> '              ' AND C1H.C1H_PPES = '2') OR (C1H.C1H_PEEXTE = '2' AND C1H.C1H_PAISEX <> ' ')) 
									 AND C1H.D_E_L_E_T_ = ' ' 
				LEFT JOIN T9A010 T9A ON T9A.T9A_FILIAL = '  ' 
									AND T9A.T9A_ID = C1H.C1H_IDTRIB 
									AND T9A.D_E_L_E_T_ = ' ' 
				INNER JOIN V3S010 V3S ON V3S.V3S_FILIAL = LEM.LEM_FILIAL 
									 AND V3S.V3S_ID = LEM.LEM_ID 
									 AND V3S.V3S_IDPART = LEM.LEM_IDPART 
									 AND V3S.V3S_NUMFAT = LEM.LEM_NUMERO 
									 AND V3S.V3S_IDNATR <> '      ' 
									 AND V3S.D_E_L_E_T_ = ' ' 
				INNER JOIN V3O010 V3O ON V3O.V3O_FILIAL = '  ' 
									 AND V3O.V3O_ID = V3S.V3S_IDNATR 
									 AND V3O.D_E_L_E_T_ = ' ' 
				LEFT JOIN T9E010 T9E ON T9E.T9E_FILIAL = LEM.LEM_FILIAL 
									AND T9E.T9E_ID = LEM.LEM_ID 
									AND T9E.T9E_CNATRE = V3S.V3S_IDNATR 
									AND T9E.T9E_CODTRI = '000012' 
									AND T9E.D_E_L_E_T_ = ' ' 
				LEFT JOIN V4F010 V4F ON V4F.V4F_FILIAL = V3S.V3S_FILIAL 
									AND V4F.V4F_ID = V3S.V3S_IDPROC 
									AND V4F.D_E_L_E_T_ = ' ' 
				LEFT JOIN V3X010 V3X ON V3X.V3X_FILIAL = LEM.LEM_FILIAL 
									AND V3X.V3X_ID = V3S.V3S_IFCISC 
									AND V3X.D_E_L_E_T_ = ' ' 
				LEFT JOIN V47010 V47 ON V47.V47_FILIAL = V3S.V3S_FILIAL 
									AND V47.V47_ID = V3S.V3S_ID 
									AND V47.V47_IDPART = V3S.V3S_IDPART 
									AND V47.V47_NUMFAT = V3S.V3S_NUMFAT 
									AND V47.V47_IDNATR = V3S.V3S_IDNATR 
									AND V47.V47_DECTER = V3S.V3S_DECTER 
									AND V47.V47_IDTRIB = '000012' 
									AND V47.D_E_L_E_T_ = ' ' 
				WHERE  LEM.LEM_FILIAL IN ('01','02','03') 
				AND LEM.LEM_DTEMIS BETWEEN @DTINI AND @DTFIM 
				AND LEM.LEM_NATTIT = '0' 
				AND LEM.D_E_L_E_T_ = ' ' 
				AND (
					 V47.V47_BASECA > 0 
					 OR (
						 V47.V47_IDTRIB IS NULL 
						 AND V3S.V3S_IDNATR IN (
												SELECT V3O.V3O_ID 
												FROM V3O010 V3O 
												WHERE  V3O.D_E_L_E_T_ = ' ' 
												AND V3O.V3O_CODIGO LIKE '20%'
												)  
						)
				) 
				GROUP BY LEM.LEM_FILIAL,
				C1H.C1H_CNPJ,
				C1H.C1H_PAISEX,
				C1H.C1H_CODPAR,
				C1H.C1H_INDNIF,
				C1H.C1H_NIF,
				C1H.C1H_NOME,
				T9A.T9A_DESCRI, 
				LEM.LEM_FCISCP,
				LEM.LEM_NUMERO,
				LEM.LEM_DTEMIS,
				LEM.LEM_ID,
				LEM.LEM_VLBRUT,
				LEM.LEM_IDPART,
				V3X.V3X_CNPJ, 
				V4F.V4F_INDRRA, 
				V4F.V4F_NRPROC,
				V4F.V4F_CNPJOR,
				V3S.V3S_IDNATR,
				V3O.V3O_CODIGO,
				V3S.V3S_IDPROC,
				V3O.V3O_DESCR,
				V47.V47_ALIQ 
		)  TMPFAT  
		
		UNION ALL  
		
		SELECT TMPPGT.FILIAL,
		TMPPGT.CNPJ,
		TMPPGT.CODPAR,
		TMPPGT.INDNIF,
		TMPPGT.NIF,
		TMPPGT.FORMATRIBUTACAO,
		TMPPGT.NOME NOME,
		TMPPGT.INDFCISCP,
		TMPPGT.CNPJFCISCP,
		TMPPGT.INDRRA,
		TMPPGT.NRRRAPJD,
		TMPPGT.CNPJOR,
		COALESCE(
				(SELECT SUM(V4GADV.V4G_VLDESP) 
				 FROM V4F010 V4F 
				 INNER JOIN V4G010 V4GADV ON V4GADV.V4G_FILIAL = V4F.V4F_FILIAL 
										 AND V4GADV.V4G_ID = V4F.V4F_ID 
										 AND V4GADV.V4G_TPDESP = '1' 
										 AND V4GADV.V4G_DTDESP BETWEEN @DTINI AND @DTFIM 
										 AND V4GADV.D_E_L_E_T_ = ' ' 
				 WHERE  V4F.V4F_FILIAL = TMPPGT.FILIAL 
				 AND V4F.V4F_ID = TMPPGT.IDRRAPJUD 
				 AND V4F.D_E_L_E_T_ = ' ' )
		,0) CUSTADV,
		COALESCE(
				(SELECT SUM(V4GJUD.V4G_VLDESP) 
				 FROM V4F010 V4F 
				 INNER JOIN V4G010 V4GJUD ON V4GJUD.V4G_FILIAL = V4F.V4F_FILIAL 
										 AND V4GJUD.V4G_ID = V4F.V4F_ID 
										 AND V4GJUD.V4G_TPDESP = '2' 
										 AND V4GJUD.V4G_DTDESP BETWEEN @DTINI AND @DTFIM 
										 AND V4GJUD.D_E_L_E_T_ = ' ' 
				 WHERE  V4F.V4F_FILIAL = TMPPGT.FILIAL 
				 AND V4F.V4F_ID = TMPPGT.IDRRAPJUD 
				 AND V4F.D_E_L_E_T_ = ' ' )
		,0) CUSTJUD,
		TMPPGT.ID,
		TMPPGT.TIPO,
		TMPPGT.NUMERO,
		TMPPGT.NUMITE,
		TMPPGT.SERIE_PARC,
		TMPPGT.DTEMISPGT,
		TMPPGT.CODNAT,
		TMPPGT.DSCNAT,
		TMPPGT.VALBRUTO,
		TMPPGT.BASEIR,
		TMPPGT.ALIQIR,
		TMPPGT.VALIR,
		TMPPGT.BASEPIS,
		TMPPGT.ALIQPIS,
		TMPPGT.VALPIS,
		TMPPGT.BASECOFINS,
		TMPPGT.ALIQCOFINS,
		TMPPGT.VALCOFINS,
		TMPPGT.BASECSLL,
		TMPPGT.ALIQCSLL,
		TMPPGT.VALCSLL,
		TMPPGT.BSEAGREG,
		TMPPGT.VAGREG,
		TMPPGT.VBSIR,
		TMPPGT.VRSIR,
		TMPPGT.VBSPIS,
		TMPPGT.VRSPIS,
		TMPPGT.VBSCOFINS,
		TMPPGT.VRSCOFINS,
		TMPPGT.VBSCSLL,
		TMPPGT.VRSCSLL,
		TMPPGT.NPROCREF 
		FROM (
			  SELECT DISTINCT V3U.V3U_FILIAL FILIAL,
			  C1H.C1H_CNPJ CNPJ,
			  C1H.C1H_CODPAR CODPAR,
			  C1H.C1H_INDNIF INDNIF,
			  C1H.C1H_NIF NIF,
			  COALESCE(T9A.T9A_DESCRI,' ') FORMATRIBUTACAO,
			  C1H.C1H_NOME NOME,
			  V3U.V3U_FCISCP INDFCISCP,
			  COALESCE(V3X.V3X_CNPJ,' ') CNPJFCISCP,
			  V3V.V3V_IDPROC IDRRAPJUD,
			  COALESCE(V4F.V4F_INDRRA,' ') INDRRA,
			  COALESCE(V4F.V4F_NRPROC,' ') NRRRAPJD,
			  COALESCE(V4F.V4F_CNPJOR,' ') CNPJOR,
			  'PGT' TIPO,
			  V3U.V3U_NUMERO NUMERO,
			  ' ' NUMITE,
			  V3U.V3U_PARCEL SERIE_PARC,
			  V3U.V3U_DTPAGT DTEMISPGT,
			  V3U.V3U_ID ID,
			  V3O.V3O_CODIGO CODNAT,
			  V3O.V3O_DESCR DSCNAT,
			  CASE 
				  WHEN (
						SELECT SUM(LEM.LEM_VLBRUT) 
						FROM LEM010 LEM 
						INNER JOIN V3S010 V3S ON V3S.V3S_FILIAL = LEM.LEM_FILIAL 
											 AND V3S.V3S_ID = LEM.LEM_ID 
											 AND V3S.V3S_IDPART = LEM.LEM_IDPART 
											 AND V3S.V3S_NUMFAT = LEM.LEM_NUMERO 
											 AND V3S.V3S_IDNATR <> '      ' 
											 AND V3S.D_E_L_E_T_ = ' ' 
						LEFT JOIN V47010 V47 ON V47.V47_FILIAL = V3S.V3S_FILIAL 
											AND V47.V47_ID = V3S.V3S_ID 
											AND V47.V47_IDPART = V3S.V3S_IDPART 
											AND V47.V47_NUMFAT = V3S.V3S_NUMFAT 
											AND V47.V47_IDNATR = V3S.V3S_IDNATR 
											AND V47.V47_DECTER = V3S.V3S_DECTER 
											AND V47.V47_IDTRIB = '000012' 
											AND V47.D_E_L_E_T_ = ' ' 
						WHERE  LEM.LEM_FILIAL = V3U.V3U_FILIAL 
						AND LEM.LEM_NUMERO = V3U.V3U_NUMERO 
						AND LEM.LEM_DTEMIS = V3U.V3U_DTPAGT 
						AND LEM.LEM_NATTIT = '0' 
						AND LEM.D_E_L_E_T_ = ' ' 
						AND (
							 V47.V47_BASECA > 0 
							 OR (
								 V47.V47_IDTRIB IS NULL 
								 AND V3S.V3S_IDNATR IN (
														SELECT V3O.V3O_ID 
														FROM V3O010 V3O 
														WHERE  V3O.D_E_L_E_T_ = ' ' 
														AND V3O.V3O_CODIGO LIKE '20%'
														)  
							)
						) 
					)  > 0 
						THEN 0 
					ELSE V3V.V3V_VALOR 
				END VALBRUTO,
				COALESCE(
						 (SELECT SUM(V46.V46_BASE) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000028' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) BASEIR,
				COALESCE(
						 (SELECT V46.V46_ALIQ 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000028' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) ALIQIR,
				COALESCE(
						 (SELECT SUM(V46.V46_VALOR) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000028' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) VALIR,
				COALESCE(
						 (SELECT SUM(V46.V46_BASE) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000010' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) BASEPIS,
				COALESCE(
						 (SELECT V46.V46_ALIQ 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000010' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) ALIQPIS,
				COALESCE(
						 (SELECT SUM(V46.V46_VALOR) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000010' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) VALPIS,
				COALESCE(
						 (SELECT SUM(V46.V46_BASE) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000011' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) BASECOFINS,
				COALESCE(
						 (SELECT V46.V46_ALIQ 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000011' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) ALIQCOFINS,
				COALESCE(
						 (SELECT SUM(V46.V46_VALOR) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000011' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) VALCOFINS,
				COALESCE(
						 (SELECT SUM(V46.V46_BASE) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000018' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) BASECSLL,
				COALESCE(
						 (SELECT V46.V46_ALIQ 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000018' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) ALIQCSLL,
				COALESCE(
						 (SELECT SUM(V46.V46_VALOR) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB = '000018' 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) VALCSLL,
				COALESCE(
						 (SELECT SUM(V46.V46_BASE) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB IN ('000029','000030') 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) BSEAGREG,
				COALESCE(
						 (SELECT SUM(V46.V46_VALOR) 
						  FROM V46010 V46 
						  WHERE  V46.V46_FILIAL = V3V.V3V_FILIAL 
						  AND V46.V46_ID = V3V.V3V_ID 
						  AND V46.V46_IDNAT = V3V.V3V_CNATRE 
						  AND V46.V46_IDTRIB IN ('000029','000030') 
						  AND V46.D_E_L_E_T_ = ' ' )
				,0) VAGREG,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VBASSU) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000028' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VBSIR,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VALSUS) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000028' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VRSIR,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VBASSU) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000010' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VBSPIS,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VALSUS) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000010' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VRSPIS,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VBASSU) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000011' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VBSCOFINS,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VALSUS) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000011' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VRSCOFINS,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VBASSU) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000018' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VBSCSLL,
				COALESCE(
						 (SELECT SUM(V4H.V4H_VALSUS) 
						  FROM V4H010 V4H 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.V4H_IDTRIB = '000018' 
						  AND V4H.D_E_L_E_T_ = ' ')
				,0) VRSCSLL,
				COALESCE(
						 (SELECT TOP 1 C1G.C1G_NUMPRO 
						  FROM V4H010 V4H 
						  INNER JOIN C1G010 C1G ON C1G.C1G_FILIAL = V4H.V4H_FILIAL 
											   AND C1G.C1G_ID = V4H.V4H_IDPROC 
											   AND C1G.D_E_L_E_T_ = ' ' 
						  WHERE  V4H.V4H_FILIAL = V3U.V3U_FILIAL 
						  AND V4H.V4H_ID = V3U.V3U_ID 
						  AND V4H.V4H_CNATRE = V3V.V3V_CNATRE 
						  AND V4H.D_E_L_E_T_ = ' ' 
						  AND V4H.V4H_IDTRIB IN ('000010','000011','000018','000028','000029','000030') 
						  )
				,' ') NPROCREF 
				FROM V3U010 V3U 
				INNER JOIN C1H010 C1H ON C1H.C1H_FILIAL = '' 
									 AND C1H.C1H_ID = V3U.V3U_IDPART 
									 AND ((C1H.C1H_CNPJ <> '              ' AND C1H.C1H_PPES = '2') OR (C1H.C1H_PEEXTE = '2' AND C1H.C1H_PAISEX <> ' ')) 
									 AND C1H.D_E_L_E_T_ = ' ' 
				LEFT JOIN T9A010 T9A ON T9A.T9A_FILIAL = '  ' 
									AND T9A.T9A_ID = C1H.C1H_IDTRIB 
									AND T9A.D_E_L_E_T_ = ' ' 
				INNER JOIN V3V010 V3V ON V3V.V3V_FILIAL = V3U.V3U_FILIAL 
									 AND V3V.V3V_ID = V3U.V3U_ID 
									 AND V3V.V3V_CNATRE <> '      ' 
									 AND V3V.D_E_L_E_T_ = ' ' 
				INNER JOIN V3O010 V3O ON V3O.V3O_FILIAL = '  ' 
									 AND V3O.V3O_ID = V3V.V3V_CNATRE 
									 AND V3O.D_E_L_E_T_ = ' ' 
				LEFT JOIN V4F010 V4F ON V4F.V4F_FILIAL = V3V.V3V_FILIAL 
									AND V4F.V4F_ID = V3V.V3V_IDPROC 
									AND V4F.D_E_L_E_T_ = ' ' 
				LEFT JOIN V3X010 V3X ON V3X.V3X_FILIAL = V3V.V3V_FILIAL 
									AND V3X.V3X_ID = V3V.V3V_IFCISC 
									AND V3X.D_E_L_E_T_ = ' ' 
				LEFT JOIN V46010 V46 ON V46.V46_FILIAL = V3V.V3V_FILIAL 
									AND V46.V46_ID = V3V.V3V_ID 
									AND V46.V46_IDNAT = V3V.V3V_CNATRE 
									AND V46.V46_IDTRIB IN ('000010' , '000011' , '000018' , '000028' , '000029' , '000030') 
									AND V46.D_E_L_E_T_ = ' ' 
				WHERE  V3U.V3U_FILIAL IN ('01','02','03') 
				AND V3U.V3U_DTPAGT BETWEEN @DTINI AND  @DTFIM
				AND (
					 V46.V46_BASE > 0 
					 OR (
						 V46.V46_IDTRIB IS NULL 
						 AND V3V.V3V_CNATRE IN (
												SELECT V3O.V3O_ID 
												FROM V3O010 V3O 
												WHERE  (V3O.V3O_CODIGO LIKE '20%' OR V3O.V3O_TRIB = '8') 
												AND V3O.D_E_L_E_T_ = ' '
												)  
					)
				) 
				AND V3U.D_E_L_E_T_ = ' ' 
		)  TMPPGT   
)  TBGER 
ORDER BY  FILIAL, CNPJ, NUMERO, CODNAT, NUMITE, SERIE_PARC 
