-- Parametro Etiquetas
SELECT * FROM SX6010 WHERE X6_VAR='ZZ_ETQCOMB'

--Habilita ponto de entrada para validacao da sequencia de numeracao da NFE                           
SELECT * FROM SX6010 WHERE X6_VAR='ZZ_MTVALRP'	

--Parametro para gerar NF Retroativa.
-- Clicar em Pesquisar por X6_Parametro = MV_HORARMT
-- Selecionar o parametro da Filial em PT  e mudar para 1 
SELECT * FROM SX6010 WHERE X6_VAR='MV_HORARMT'	

--Parametro para cancelamento de NF após 24 h
--MV_SPEDEXC
--Entrar no parametro da sua filial e colocar o numero de horas para o cancelamento da NF.
SELECT * FROM SX6010 WHERE X6_VAR='MV_SPEDEXC'	

--Define a quantidade de dias para transmissão do Cancelamento Extemporâneo.
--MV_CANCEXT
-- Parâmtro para todas empresas Padrão 1 Dias.
Select * From SX6010
Where X6_VAR = 'MV_CANCEXT'


--Ativar o Cancelamento da NF-e como Evento     
--T = Sim ou F = Não  
--MV_NFECAEV
Select * From SX6010
Where X6_VAR = 'MV_NFECAEV'


--Consulta Chave nas NFe de entrada.
--Desabilitar por Filial.
--MV_CHVNFE
--Informa se havera consulta da NFE/CTE no portal da SEFAZ .T.
 --= Sim; .F. = Nao.
 SELECT * FROM SX6010 WHERE X6_VAR='MV_CHVNFE'	

 --Messagem Rodape P
--Parametro ZZ_MSGNFE1
--Mensagem na nota fiscal de certificacao florestal 
--Produtos provindos de floresta bem manejada. IMA-FM/COC-156864 – FSC 100%.                                                                                                                                               
--Hoje a msg é por filial e está ligada na BA13 e BA14.
--Na BA14 ocorre a venda de madeira serrada 
--e segundo a Vanessa, não pode sair com a msg de certificação que se encontra neste parametro.
SELECT * FROM SX6010 WHERE X6_VAR='ZZ_MSGNFE1'	


--Messagem Dados Adicionais NF 
-- Grup de produtos 
Select BM_ZZMSG,* From SBM010
Where BM_GRUPO In ('1001')And D_E_L_E_T_ =''
--SX3 - Campos
Select * From SX3010
Where X3_CAMPO Like 'BM_ZZMSG%'


-- Mensagem Rpdape da NF

--Caso nao receba o boleto antes do vencimento, favor entrar em contato através do e-mail: financeiro@gruporesinasbrasil.com.br ou telefone (14) 3711-2222.
-- Antigo Ponto de entrada ponto de entrada PE01NFSEFAZ
--Parametro criado ZZ_DANFBOL como .T.  para as filiais onde deve aparecer a mensagem, no padrão é falso
 SELECT * FROM SX6010 WHERE X6_VAR Like'ZZ_DANFBOL%'	


 
--Serie da Nota de Complemento de Preco no Fat.     
SELECT * FROM SX6010 WHERE X6_FIL='DB01' AND X6_VAR='MV_EECSERI'




--ZZ_RBCOM08	-	E-mail comprador envio SC Emergencial   
Select X6_CONTEUD,* From SX6010
Where X6_VAR = 'ZZ_RBCOM08'


-- Parametros 
Select * From SX6010
Where X6_VAR = 'ZZ_MAILFUN'
--E-mail do responsável referente a apuração funrural     