-- Banco de dados TSS
--Processamento de NF TSS
Select * From TSSTR1

-- controlar as requisi��es na tabela tss0011 evitando o excesso no consumo da Sefaz
select * From TSS0011 


--Credenciais para gera��o/valida��o do token de autentica��o, nos campos: CLIENT_ID ("Client Id")
--CLIENT_SEC ("Client Secret")
--Nos campos  DATE_GER" e TIME_GER ficam registradas a Data\hora que foram gerada as Credenciais.
Select * From TSS0012

--bjetivo de registrar os processos ass�ncronos do tss para uso interno de processamento.
--Como por exemplo temos: Emiss�o, Cancelamento, Carta de corre��o etc.
Select * From TSS0002


--Registrar os certificados na base de dados � garantir a configura��o dos certificados em caso de perda da instala��o do TSS ou replica de instala��o. Por padr�o a aplica��o exige que os certificados estejam dispon�veis no diret�rio de instala��o.
--Esse comportamento exige a configura��o ou replica manual do certificado para cada inst�ncia do TSS instalada em file system distinto.
--Para definir a persist�ncia do certificado na base de dados � necess�rio habilit�-lo no environment do TSS. Conforme abaixo:
--[SPED]
--AUTOSCALING=1egistrar os certificados na base de dados � garantir a configura��o dos certificados em caso de perda da instala��o do TSS ou replica de instala��o. Por padr�o a aplica��o exige que os certificados estejam dispon�veis no diret�rio de instala��o.
--Esse comportamento exige a configura��o ou replica manual do certificado para cada inst�ncia do TSS instalada em file system distinto.
--Para definir a persist�ncia do certificado na base de dados � necess�rio habilit�-lo no environment do TSS. Conforme abaixo:
--[SPED]
--AUTOSCALING=1
Select * FRom TSS0006



--Funcionalidade do comando LOG_PERIOD_TR2
--Ambiente
--TSS12.1.25 e TSS12.1.27
--Solu��o
--LOG_PERIOD_TR2: Configura a quantidade de dias retroativos para, a partir desta data, realizar a limpeza da tabela TSSTR2.
--Exemplo:
--Neste exemplo, foi definido que deve ser realizado a limpeza da tabela TSSTR2, 10 dias retroativos.
--[Environment]
--LOG_PERIOD_TR2=10
Select * From  TSSTR2

--A tabela TSS0010 � a tabela de schedule do TSS, nela contem todas as rotinas executadas pelo TSSTASKPROC.
Select * From TSS0010 
