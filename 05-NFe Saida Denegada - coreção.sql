-- Acertar NF denegada com várias tentativas de transmissões 
-- O problema ocorre quando se tenta transmitir uma NFe Denegada mais de uma vez, as Chaves da NFe são trocadas na tabela TSS SPED054 e nas Tabelas SF2 (Cab. NF).
--  Ao consultar a Chave da NFe no SEFAZ, a NFe não é localizada
-- Acertando a Chave da NFe 
-- Acessar a Tabela TSS SPED050 - Nota Fiscal Eletrônica e -- SPED054 - Lotes X Nota Fiscal Eletrônica via APSDU
-- Achar a NFe pela pesquia NFE_ID (Serie  NumeroNFe) com dois espaços entre a Serie+**NumNfe
-- Ex. (6  000018852)
-- Na tabela TSS SPED054, deixar somente a primeira linha, as demais excluir
-- Copiar a Chave da NFe da Tabela SPED54 para a Tabela SF3 - Livro Fiscal e SFT - Itens Livro Fiscal para correção da chave da NFe
--Campos F3_CHVNFE e FT_CHVNFE
-- Verificar se a NF esta excluida nas Tabelas SF2 - Cabecalho NFe e SD2 - Itens da NFe.


--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, * From SF2010
Where F2_FILIAL = 'BA06' and F2_DOC ='000021027' and D_E_L_E_T_=''


--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_TES, * From SD2010
Where D2_FILIAL ='BA06' and D2_DOC ='000021027'  and D_E_L_E_T_=''


--Livro Fiscal 
Select F3_EMISSAO,* From SF3010
Where F3_FILIAL ='BA06' and F3_NFISCAL ='000021026' and D_E_L_E_T_=''

--Livro Fiscal Itens
Select FT_EMISSAO, * From SFT010
Where FT_FILIAL ='BA06' and FT_NFISCAL ='000021026' and D_E_L_E_T_ = ''


SELECT * FROM SYS_USR WHERE USR_MSBLQL='2' AND USR_TIMEOUT<>0

-- SPED050 - Nota Fiscal Eletrônica
Select * From SPED050
Where NFE_ID = '11 000004157' -- com dois espaçes entre Serie + Num NFe
and D_E_L_E_T_ =''
-- SPED054 - Lotes X Nota Fiscal Eletrônica
Select * From SPED054
Where NFE_ID = '11 000004157' and D_E_L_E_T_ =''

--Lotes de Nota Fiscal Eletrônica
Select * From SPED052
Where LOTE = '000000000013689' and D_E_L_E_T_ =''


/*
STATUS DA TABELA SPED050

Status NFe
[1] NFe Recebida
[2] NFe Assinada
[3] NFe com falha no schema XML
[4] NFe transmitida
[5] NFe com problemas
[6] NFe autorizada
[7] Cancelamento

Status Cancelamento/inutilizacão
[1] NFe Recebida
[2] NFe Cancelada
[3] NFe com falha de cancelamento/inutilizacao

Status Mail
[1] A transmitir
[2] Transmitido
[3] Bloqueio de transmissão - cancelamento/inutiliza

Status da SPED052
[1] Lote transmitido
[2] Lote recebido com sucesso
[3] Lote com erro
====================
*/
