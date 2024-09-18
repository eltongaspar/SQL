-- Stuff 
--*Agrupar Resultados de linhas em uma determinada coluna.
SELECT 
       stuff ((SELECT '; ' + B5_ONU
                 from SB5010 as SB5
                 where B5_COD  IN ('0110020001','0110020002')
                 for xml path('')),
              1, 2, '') as SB5010