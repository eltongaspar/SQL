--Consulta Cabeçalho da NF Saida
Select * From SF2010
Where F2_FILIAL = 'EC01' and F2_DOC = '000013059' and F2_EMISSAO >= 20211228

-- Consulta Itens NF Saida
Select * From SD2010
Where D2_FILIAL = 'EC01' and D2_DOC = '000013059' and D2_EMISSAO >= 20211228

-- TES - Troca de TES
--TIPOS DE ENTRADA E SAIDA (TES)
Select * From SF4010
Where F4_CODIGO in ('857')

-- D2_ZZSAIDA - Campo Fisico 