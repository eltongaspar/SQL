--***###REINF - R-2010 - INSS
--Retenções de Contribuição Previdenciária sobre a Receita Bruta (CPRB) nos serviços tomados por empresas
/*
T95 - Ret. Contrib Prev - Serv Tomado
T96 - Detalhamento de NFS
T97 - Tipos de Serviços NF
T98 - Inf. Processos Relacionados XXXXXXX
T99 - Inf. Processos Relacionados Ad XXXXXXX
C20 - Capa do Documento Fiscal  
C30 - Itens do Documento Fiscal  
C35 - Trib Itens Documento Fiscal
LEM - Cadastro de Recibo/Fatura   
T5M - Tipo de Serviço  XXXXXXX
C1H - Participantes*/


-- Identificar CNPJ do Fornecedor 
--Fornecedores 
Select A2_CGC,* From SA2010
Where A2_COD = 'VOP560'
And D_E_L_E_T_ = ''


--Identificar o ID do Partivcipante
----C1H - Participantes
Select * From C1H010
Where C1H_CNPJ = '07448153000145'
And D_E_L_E_T_ = ''

--Analisar Capa da NF em questão
-- Usar C1H_ID > C20_CODPAR
--C20 - Capa do Documento Fiscal 
Select * From C20010
Where C20_CODPAR In ('ae8c8403-98e8-873f-8e5b-1ae27185a974') --and C20_NUMDOC In ('00000270','00000275')
And C20_DTDOC Between '20240801' and '20240831'
and D_E_L_E_T_ = ''

--Usar C20_CHVNF > C30_CHVNF
--C30 - Itens do Documento Fiscal  
Select * From C30010
Where C30_FILIAL = '01'
And C30_CHVNF In ('000000000283416','000000000283421','000000000283432','000000000283437','000000000283184',
'000000000283193','000000000283210','000000000283220','000000000283258','000000000283268','000000000283278',
'000000000283289','000000000283307')
and D_E_L_E_T_ = ''

--C35 - Trib Itens Documento Fiscal   
Select * From C35010
Where C35_FILIAL = '01'
And C35_CHVNF In ('000000000283416','000000000283421','000000000283432','000000000283437','000000000283184',
'000000000283193','000000000283210','000000000283220','000000000283258','000000000283268','000000000283278',
'000000000283289','000000000283307')
And C35_CODITE In ('23f03296-976f-cd9b-dc04-49513da73b0a')
and D_E_L_E_T_ = ''
Order By C35_CHVNF






--T95 - Ret. Contrib Prev - Serv Tomado
Select * From T95010
Where T95_FILIAL = '01' 
And T95_CNPJPR = '07448153000145'
--And T95_IDESTA In ('000001','000002')
And T95_PERAPU = '082024'
and D_E_L_E_T_ = ''
--86cf815b-e039-a13d-3b41-626ec7b0bac8 -- T95_IDPART
-- Or T95_CODPAR In ('FV008L201','FV008L301', 'FV008L401','FV008L201')

--T96 - Detalhamento de NFS
Select * From T96010
Where T96_CHVNF In ('000000000283416','000000000283421','000000000283432','000000000283437','000000000283184',
'000000000283193','000000000283210','000000000283220','000000000283258','000000000283268','000000000283278',
'000000000283289','000000000283307')
and D_E_L_E_T_ = ''   

--T97 - Tipos de Serviços NF
Select * From T97010
Where T97_ID In ('35f58c6b-c10e-e40a-1cde-7cc81c391174','6a4df644-b812-29bd-fbf4-211bddbf711e')
and D_E_L_E_T_ = ''   




--LEM - Cadastro de Recibo/Fatura  
Select * From LEM010
Where LEM_IDPART In ('86cf815b-e039-a13d-3b41-626ec7b0bac8')
And LEM_DOCORI In ('000000000202365','000000000202363')
and D_E_L_E_T_ = ''  





