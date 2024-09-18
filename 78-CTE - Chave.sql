
	 SELECT	
			GXG.GXG_FILIAL	[FILIAL],              
	        GXG.GXG_NRIMP	[SEQIMPORT],           
	        GXG.GXG_SERDF	[CTE_SERIE],           
	        GXG.GXG_NRDF	[CTE_DOC],             
	        GXG.GXG_DTEMIS	[CTE_EMISSAO],         
	        GXG.GXG_DTENT	[CTE_ENTRADA],         
	        GXG.GXG_DTIMP	[CTE_IMPORTA],         
	        GXG.GXG_EMISDF	[CTE_EMISSOR],         
	    
		    (                                      
	        SELECT GU3_NMEMIT [RAZAO_SOCIAL]       
                FROM GU3010 GU3        
                WHERE GU3.GU3_FILIAL = '' 	       
                AND GU3.GU3_IDFED = GXG.GXG_EMISDF 	       
                AND GU3.D_E_L_E_T_ = ''       
	        ) [CTE_EMISRAZAO],       
	    
		    (       
	        SELECT GU7.GU7_NMCID [CIDADE]        
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	                AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_EMISDF       
	        AND GU3.D_E_L_E_T_ = ''       
	        )[CTE_EMISCID],       
	    
		    (       
	        SELECT GU7.GU7_CDUF [ESTADO]       
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	                AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_EMISDF       
	        AND GU3.D_E_L_E_T_ = ''       
	        )[CTE_EMISUF],       
	    
		    GXG.GXG_CDREM	[CTE_REMETENTE],       
	    
		    (       
	        SELECT GU3_NMEMIT [RAZAO_SOCIAL] FROM GU3010 GU3 WHERE GU3.GU3_FILIAL = '' 	
			AND GU3.GU3_IDFED = GXG.GXG_CDREM 	AND GU3.D_E_L_E_T_ = ''       
	        ) [CTE_REMRAZAO],       
	    
		    (       
	        SELECT GU7.GU7_NMCID [CIDADE]        
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	                AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_CDREM       
	        AND GU3.D_E_L_E_T_ = ''       
	        )[CTE_REMCID],       
	    
		    (       
	        SELECT GU7.GU7_CDUF [ESTADO]        
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	                AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_CDREM       
	        AND GU3.D_E_L_E_T_ = ''       
	        )[CTE_REMUF],       
	    
		    GXG.GXG_CDDEST	[CTE_DESTINATARIO],       
	    
		    (       
	        SELECT GU3_NMEMIT [RAZAO_SOCIAL] FROM GU3010 GU3 WHERE GU3.GU3_FILIAL = '' 	
			AND GU3.GU3_IDFED = GXG.GXG_CDDEST 	AND GU3.D_E_L_E_T_ = ''       
	        ) [CTE_DESTRAZAO],       
	    
		    (       
	        SELECT GU7.GU7_NMCID [CIDADE]        
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	        	    AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_CDDEST       
	        AND GU3.D_E_L_E_T_ = ''       
		    )[CTE_DESTCID],
			
			(       
	        SELECT GU7.GU7_NRCID [IDCIDADE]        
	            FROM GU3010 GU3       
	                INNER JOIN GU7010 GU7        
	                ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
	                AND GU7.GU7_NRCID = GU3.GU3_NRCID       
	        	    AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
	        WHERE GU3.GU3_FILIAL = ''       
	        AND GU3.GU3_IDFED = GXG.GXG_CDDEST       
	        AND GU3.D_E_L_E_T_ = ''       
		    )[CTE_DESTIDCID],       
		
		    (       
			SELECT GU7.GU7_CDUF [ESTADO]       
				FROM GU3010 GU3       
					INNER JOIN GU7010 GU7        
					ON GU7.GU7_FILIAL = GU3.GU3_FILIAL       
					AND GU7.GU7_NRCID = GU3.GU3_NRCID       
					AND GU7.D_E_L_E_T_ = GU3.D_E_L_E_T_       
				WHERE GU3.GU3_FILIAL = ''       
				AND GU3.GU3_IDFED = GXG.GXG_CDDEST       
				AND GU3.D_E_L_E_T_ = ''       
		)[CTE_DESTUF],       
		
		GXG.GXG_ZZIDTO	[CTE_IDTOMADOR],       
		GXG.GXG_ZZDTOM	[CTE_DESCTOMADOR],       
		GXG.GXG_TPDF	[CTE_TPDF],       
		GXG.GXG_CFOP	[CTE_CFOP],       
		GXG.GXG_ZZUFIN	[CTE_UFINICIO],       
		GXG.GXG_ZZUFFI	[CTE_UFFIM],       
		GXG.GXG_PCIMP	[CTE_PERCICM],       
		GXG.GXG_TRBIMP	[CTE_TRIMP],       
		GXG.GXG_PESOC	[CTE_PESOC],       
		GXG.GXG_PESOR	[CTE_PESOR],       
		GXG.GXG_FRPESO	[CTE_FRETEPESO],       
		GXG.GXG_FRVAL	[CTE_FRETEVALOR],       
		GXG.GXG_VLIMP	[CTE_VLIIMP],       
		GXG.GXG_PEDAG	[CTE_PEDAGIO],       
		GXG.GXG_TAXAS	[CTE_TAXAS],       
		GXG.GXG_VLDF	[CTE_VLFRETE],       
		GXG.GXG_BASIMP	[CTE_BASIMP],       
		GXG.GXG_IMPRET	[CTE_IMPRETIDO],       
		GXG.GXG_PCRET	[CTE_PERCRETIDO],       
		GXG.GXG_ORISER	[CTE_SERIEORI],       
		GXG.GXG_ORINR	[CTE_DOCORI],       
		GXG.GXG_CTE		[CTE_CHAVE],       
		GXG.GXG_FILDOC	[CTE_FILDOC],       
		GXG.GXG_QTDCS	[CTE_QTDCARGA],       
		GXG.GXG_VOLUM	[CTE_VOLUME],       
		GXG.GXG_QTVOL	[CTE_QTDVOLUM],       
		GXG.GXG_TPCTE	[CTE_TIPOCTE],       
		GXG.GXG_VLCARG	[CTE_VLCARGA],       
		ISNULL( CONVERT( VARCHAR(6144), CONVERT(VARBINARY(6144), GXG.GXG_OBS)),'') 	[CTE_OBSERV],       
		GXH.GXH_SEQ		[NFE_SEQUEN],       
		CASE       
			WHEN SF2.F2_SERIE <> '' THEN SF2.F2_SERIE       
			WHEN SF1.F1_SERIE <> '' THEN SF1.F1_SERIE       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_SERIE],       
		CASE        
			WHEN SF2.F2_DOC <> '' THEN SF2.F2_DOC       
			WHEN SF1.F1_DOC	 <> '' THEN SF1.F1_DOC	       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_DOC],       
		GXH_DANFE		[NFE_CHAVE],       
		CASE       
			WHEN SF2.F2_PLIQUI <> '' THEN CONVERT(varchar,SF2.F2_PLIQUI)       
			WHEN SF1.F1_PLIQUI <> '' THEN CONVERT(varchar,SF1.F1_PLIQUI)       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_PES_LIQ],       
		CASE       
			WHEN SF2.F2_PBRUTO <> '' THEN CONVERT(varchar,SF2.F2_PBRUTO)       
			WHEN SF1.F1_PBRUTO <> '' THEN CONVERT(varchar,SF1.F1_PBRUTO)       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_PES_BRUT],
		CASE       
			WHEN SF2.F2_PBRUTO <> '' THEN CONVERT(varchar,SF2.F2_VALBRUT)       
			WHEN SF1.F1_PBRUTO <> '' THEN CONVERT(varchar,SF1.F1_VALBRUT)       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_VAL_BRUT],
		CASE       
			WHEN SF2.F2_PBRUTO <> '' THEN CONVERT(varchar,SF2.F2_VALBRUT/SF2.F2_PBRUTO)       
			WHEN SF1.F1_PBRUTO <> '' THEN CONVERT(varchar,SF1.F1_VALBRUT/SF1.F1_PBRUTO)       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_VAL_MERC_KG],
		CASE       
			WHEN SF2.F2_PBRUTO <> '' THEN CONVERT(varchar,SF2.F2_VALBRUT/SF2.F2_PBRUTO)       
			WHEN SF1.F1_PBRUTO <> '' THEN CONVERT(varchar,SF1.F1_VALBRUT/SF1.F1_PBRUTO)       
			ELSE 'N.ENCONTRADO'       
		END AS [NFE_VAL_MERC_KG] ,

		Round((GXG.GXG_VLDF/GXG.GXG_PESOR),4) [CTE_VAL_FRETE_KG],
		Round((GXG.GXG_VLCARG/GXG.GXG_PESOR),4) [CTE_VAL_CARGA_KG]

		
	FROM GXG010 GXG  		        
		LEFT JOIN GXH010 GXH      
			ON GXG.GXG_FILIAL = GXH.GXH_FILIAL	    
			AND GXG.GXG_NRIMP = GXH_NRIMP		    
			AND GXG.D_E_L_E_T_ = GXH.D_E_L_E_T_    
			AND GXH.GXH_DANFE <> ''	
		 LEFT JOIN SF2010 SF2  	    
			ON  GXH.GXH_DANFE = SF2.F2_CHVNFE	    
			AND GXH.D_E_L_E_T_ = SF2.D_E_L_E_T_	
		 LEFT JOIN SF1010 SF1  	    
			ON  GXH.GXH_DANFE = SF1.F1_CHVNFE	    
			AND GXH.D_E_L_E_T_ = SF1.D_E_L_E_T_	
	
	WHERE 
	GXG_FILIAL BETWEEN '01' AND '03'		
	AND GXG_DTEMIS >= CONVERT(CHAR(8),DATEADD (YEAR, -5, GETDATE() ),112)	
	--AND GXG_DTEMIS >= CONVERT(CHAR(8),dateadd(year, datediff(year,0, GETDATE()), 0),112) 
	And GXG_CTE = '35200589823918003089570000004361591290202896'
	AND GXG_CDREM <> ''
	AND GXG_CDDEST <> ''	
	AND GXG.D_E_L_E_T_ = ''		                
	
			
--GO
