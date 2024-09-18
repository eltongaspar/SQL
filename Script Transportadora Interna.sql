SELECT 
            SF2.R_E_C_N_O_		        AS recno,
            SF2.F2_DOC			        AS nota_fiscal ,
            SF2.F2_CHVNFE		        AS chave_nota,
            SF2.F2_EMISSAO		        AS emissao_nota,
            SF2.F2_DTENTR		        AS saida_portaria,
            ZZ9.ZZ9_ORDCAR		        AS numero_carga,	
            SF2.F2_EST,
			SA1.A1_MUN,

			Case 
				When SA1.A1_MUN <> 'ITU'
				Then 100000000000
				Else 000000000000
			End as Teste,


			RTRIM(LTRIM(SA1.A1_NOME))	AS nome_cliente,
			ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'') AS [CTE],
			ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSVOLU)),'') AS [VOL],
			ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSINFO)),'') AS [INFO]

        FROM SF2010 SF2 WITH(NOLOCK)
        INNER JOIN SA1010 SA1 WITH(NOLOCK)
            ON ''				        = SA1.A1_FILIAL
            AND SF2.F2_CLIENTE	        = SA1.A1_COD
            AND SF2.F2_LOJA		        = SA1.A1_LOJA
            AND SF2.D_E_L_E_T_	        = SA1.D_E_L_E_T_
        INNER JOIN SA4010 SA4 WITH(NOLOCK)
            ON ''				        = SA4.A4_FILIAL
            AND SF2.F2_TRANSP	  = SA4.A4_COD
            AND SF2.D_E_L_E_T_	= SA4.D_E_L_E_T_
		INNER JOIN ZZ9010 ZZ9 WITH(NOLOCK)
			ON SF2.F2_FILIAL	= ZZ9.ZZ9_FILIAL
			AND SF2.F2_DOC		= ZZ9.ZZ9_DOC
			AND SF2.F2_SERIE	= ZZ9.ZZ9_SERIE
			AND SF2.D_E_L_E_T_	= ZZ9.D_E_L_E_T_
        WHERE
            SF2.R_E_C_N_O_      > 0
            AND F2_FILIAL IN ('01', '02', '03')
            AND SF2.F2_CHVNFE   <> '' 
            AND SF2.F2_EMISSAO  >= CONVERT(CHAR(8),DATEADD (MONTH, -12, GETDATE() ),112)
            AND SF2.F2_DAUTNFE  <> ''
            AND SA4.A4_HPAGE IN  ('IFC')
            AND SA4.A4_HPAGE <> ''
            AND SF2.F2_DTENTR <> ''
            AND SF2.D_E_L_E_T_  = ''
        ORDER BY numero_carga, SF2.F2_FILIAL, SF2.F2_DTENTR DESC


