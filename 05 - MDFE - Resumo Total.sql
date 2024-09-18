WITH Entrada AS (
    SELECT 
        COUNT(D1_COD) AS NF_Qtde_Itens,
        SUM(D1_TOTAL) AS NF_Valor_Total_Itens,
        COUNT(DISTINCT F1_DOC) AS NF_Qtde,
        SUM(DISTINCT F1_VALBRUT) AS NF_Valor_Total_Bruto,
        SUM(DISTINCT F1_PBRUTO) AS NF_Valor_Mercadoria,
        COUNT(DISTINCT F1_NUMMDF) AS Manifesto_Qtde,
        SUM(F1_PLIQUI) AS NF_Peso_Liquido,
        SUM(F1_PBRUTO) AS NF_Peso_Bruto
    FROM SF1010 AS SF1 With(Nolock)
    INNER JOIN SD1010 SD1 
        ON D1_FILIAL = F1_FILIAL
        AND D1_FORNECE = F1_FORNECE
        AND D1_LOJA = F1_LOJA
        AND D1_DOC = F1_DOC
        AND D1_SERIE = F1_SERIE
        AND SD1.D_E_L_E_T_ = '' 
    INNER JOIN CC0010 CC0_SF1 With(Nolock)
        ON CC0_SF1.CC0_NUMMDF = F1_NUMMDF
        AND CC0_SF1.CC0_SERMDF = F1_SERMDF
        AND (CC0_SF1.CC0_VEICUL = F1_VEICUL1
             OR CC0_SF1.CC0_VEICUL = F1_VEICUL2
             OR CC0_SF1.CC0_VEICUL = F1_VEICUL3
             OR CC0_SF1.CC0_VEICUL = F1_PLACA)
        AND CC0_SF1.D_E_L_E_T_ = ''
    WHERE F1_SERMDF <> '' AND F1_NUMMDF <> ''
    AND SF1.D_E_L_E_T_ = ''
),
Saida AS (
    SELECT 
        COUNT(D2_COD) AS NF_Qtde_Itens,
        SUM(D2_TOTAL) AS NF_Valor_Total_Itens,
        COUNT(DISTINCT F2_DOC) AS NF_Qtde,
        SUM(DISTINCT F2_VALBRUT) AS NF_Valor_Total_Bruto,
        SUM(DISTINCT F2_VALMERC) AS NF_Valor_Mercadoria,
        COUNT(DISTINCT F2_NUMMDF) AS Manifesto_Qtde,
        SUM(DISTINCT F2_PLIQUI) AS NF_Peso_Liquido,
        SUM(DISTINCT F2_PBRUTO) AS NF_Peso_Bruto
    FROM SF2010 AS SF2 With(Nolock)
    INNER JOIN SD2010 SD2 With(Nolock)
        ON D2_FILIAL = F2_FILIAL
        AND D2_CLIENTE = F2_CLIENTE
        AND D2_LOJA = F2_LOJA
        AND D2_DOC = F2_DOC
        AND D2_SERIE = F2_SERIE
        AND SD2.D_E_L_E_T_ = '' 
    INNER JOIN CC0010 CC0_SF2 With(Nolock)
        ON CC0_SF2.CC0_NUMMDF = F2_NUMMDF
        AND CC0_SF2.CC0_SERMDF = F2_SERMDF
        AND (CC0_SF2.CC0_VEICUL = F2_VEICUL1
             OR CC0_SF2.CC0_VEICUL = F2_VEICUL2
             OR CC0_SF2.CC0_VEICUL = F2_VEICUL3)
        AND CC0_SF2.D_E_L_E_T_ = ''
    WHERE F2_SERMDF <> '' AND F2_NUMMDF <> ''
    AND SF2.D_E_L_E_T_ = ''
)

SELECT 
    'Entrada' AS Tipo,
    FORMAT(SUM(NF_Qtde_Itens),'#,0.0000', 'pt-BR') AS NF_Qtde_Itens,
    FORMAT(SUM(NF_Valor_Total_Itens),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Itens,
    FORMAT(SUM(NF_Qtde),'#,0.0000', 'pt-BR') AS NF_Qtde,
    FORMAT(SUM(NF_Valor_Total_Bruto),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Bruto,
    FORMAT(SUM(NF_Valor_Mercadoria),'#,0.0000', 'pt-BR') AS NF_Valor_Mercadoria,
    FORMAT(SUM(Manifesto_Qtde),'#,0.0000', 'pt-BR') AS Manifesto_Qtde,
    FORMAT(SUM(NF_Peso_Liquido),'#,0.0000', 'pt-BR') AS NF_Peso_Liquido,
    FORMAT(SUM(NF_Peso_Bruto),'#,0.0000', 'pt-BR') AS NF_Peso_Bruto
FROM Entrada
UNION ALL
SELECT 
    'Saida' AS Tipo,
    FORMAT(SUM(NF_Qtde_Itens),'#,0.0000', 'pt-BR') AS NF_Qtde_Itens,
    FORMAT(SUM(NF_Valor_Total_Itens),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Itens,
    FORMAT(SUM(NF_Qtde),'#,0.0000', 'pt-BR') AS NF_Qtde,
    FORMAT(SUM(NF_Valor_Total_Bruto),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Bruto,
    FORMAT(SUM(NF_Valor_Mercadoria),'#,0.0000', 'pt-BR') AS NF_Valor_Mercadoria,
    FORMAT(SUM(Manifesto_Qtde),'#,0.0000', 'pt-BR') AS Manifesto_Qtde,
    FORMAT(SUM(NF_Peso_Liquido),'#,0.0000', 'pt-BR') AS NF_Peso_Liquido,
    FORMAT(SUM(NF_Peso_Bruto),'#,0.0000', 'pt-BR') AS NF_Peso_Bruto
FROM Saida
UNION ALL
SELECT 
    'Geral' AS Tipo,
    FORMAT(SUM(NF_Qtde_Itens),'#,0.0000', 'pt-BR') AS NF_Qtde_Itens,
    FORMAT(SUM(NF_Valor_Total_Itens),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Itens,
    FORMAT(SUM(NF_Qtde),'#,0.0000', 'pt-BR') AS NF_Qtde,
    FORMAT(SUM(NF_Valor_Total_Bruto),'#,0.0000', 'pt-BR') AS NF_Valor_Total_Bruto,
    FORMAT(SUM(NF_Valor_Mercadoria),'#,0.0000', 'pt-BR') AS NF_Valor_Mercadoria,
    FORMAT(SUM(Manifesto_Qtde),'#,0.0000', 'pt-BR') AS Manifesto_Qtde,
    FORMAT(SUM(NF_Peso_Liquido),'#,0.0000', 'pt-BR') AS NF_Peso_Liquido,
    FORMAT(SUM(NF_Peso_Bruto),'#,0.0000', 'pt-BR') AS NF_Peso_Bruto
FROM (
    SELECT * FROM Entrada
    UNION ALL
    SELECT * FROM Saida
) AS Total






/*
-- NF Entrada - Soma Manifesto
Select 
	FORMAT((Count(D1_COD)),'#,0.0000', 'pt-BR') As NF_Qtde_Itens,
	FORMAT((SUM(D1_TOTAL)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Itens,
	FORMAT((COUNT(Distinct F1_DOC)),'#,0.0000', 'pt-BR') As NF_Qtde,
	FORMAT((SUM(Distinct F1_VALBRUT)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Bruto,
	FORMAT((Sum(Distinct F1_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Valor_Mercadoria,
	FORMAT((COUNT(Distinct F1_NUMMDF)),'#,0.0000', 'pt-BR') As Manifesto_Qtde,
	FORMAT((Sum(F1_PLIQUI)),'#,0.0000', 'pt-BR') As NF_Peso_Liquido,
	FORMAT((Sum(F1_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Peso_Bruto
	 
From SF1010 As SF1

	Inner Join SD1010 SD1 -- NF Entrada Itens
		On D1_FILIAL = F1_FILIAL
		And D1_FORNECE = F1_FORNECE
		And D1_LOJA = F1_LOJA
		And D1_DOC = F1_DOC
		And D1_SERIE = F1_SERIE
		And SD1.D_E_L_E_T_ ='' 
			   
	Inner Join CC0010 CC0_SF1
		On CC0_SF1.CC0_NUMMDF = F1_NUMMDF
		And CC0_SF1.CC0_SERMDF = F1_SERMDF
		And (CC0_SF1.CC0_VEICUL = F1_VEICUL1
				Or CC0_SF1.CC0_VEICUL = F1_VEICUL2
				Or CC0_SF1.CC0_VEICUL = F1_VEICUL3
				Or CC0_SF1.CC0_VEICUL = F1_PLACA)
		And CC0_SF1.D_E_L_E_T_ = ''

Where F1_SERMDF <> '' And F1_NUMMDF <> ''
And SF1.D_E_L_E_T_ ='' 

Union All

-- NF Saida - Soma Manifesto
Select 
	FORMAT((Count(D2_COD)),'#,0.0000', 'pt-BR') As NF_Qtde_Itens,
	FORMAT((SUM(D2_TOTAL)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Itens,
	FORMAT((COUNT(Distinct F2_DOC)),'#,0.0000', 'pt-BR') As NF_Qtde,
	FORMAT((SUM(Distinct F2_VALBRUT)),'#,0.0000', 'pt-BR') As NF_Valor_Total_Bruto,
	FORMAT((SUM(Distinct F2_VALMERC)),'#,0.0000', 'pt-BR') As NF_Valor_Mercadoria,
	FORMAT((COUNT(Distinct F2_NUMMDF)),'#,0.0000', 'pt-BR') As Manifesto_Qtde,
	FORMAT((Sum(Distinct F2_PLIQUI)),'#,0.0000', 'pt-BR') As NF_Peso_Liquido,
	FORMAT((Sum(Distinct F2_PBRUTO)),'#,0.0000', 'pt-BR') As NF_Peso_Bruto
From SF2010 As SF2 With(Nolock)

	Inner Join SD2010 SD2 With(Nolock) -- NF Saida Itens 
		On D2_FILIAL = F2_FILIAL
		And D2_CLIENTE = F2_CLIENTE
		And D2_LOJA = F2_LOJA
		And D2_DOC = F2_DOC
		And D2_SERIE = F2_SERIE
		And SD2.D_E_L_E_T_ ='' 
		
	Inner Join CC0010 CC0_SF2 With(Nolock) --Manifesto
		On CC0_SF2.CC0_NUMMDF = F2_NUMMDF
		And CC0_SF2.CC0_SERMDF = F2_SERMDF
		And (CC0_SF2.CC0_VEICUL = F2_VEICUL1
				Or CC0_SF2.CC0_VEICUL = F2_VEICUL2
				Or CC0_SF2.CC0_VEICUL = F2_VEICUL3)
		And CC0_SF2.D_E_L_E_T_ = ''

					   
Where F2_SERMDF <> '' And F2_NUMMDF <> ''
And SF2.D_E_L_E_T_ ='' */