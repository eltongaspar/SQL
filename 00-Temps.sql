Select * From SF1010
Where F1_DOC = '000000878' and F1_EMISSAO >= '20220101'

Select * From SD1010
Where D1_DOC = '000001164' and D1_EMISSAO >= '20220101'

Select X6_FIL, X6_VAR, X6_CONTEUD,X6_DESC1, X6_DESC2, * From SX6010
Where X6_VAR Like 'Z%'

Select Distinct X6_VAR, COUNT (X6_VAR) QTDE From SX6010
Where X6_VAR Like 'Z%'
Group By X6_VAR
Order By QTDE DESC