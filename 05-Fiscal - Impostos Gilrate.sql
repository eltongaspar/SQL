-- Consultar dados Gilrate
--**Caso as informmações não forem para o REINF, é possivel lançar manualmente.
-- Fotos Imagens/Totvs/Impostos/Gilrate
-- Tabelas SF4 (TES) Campo F4_CONTSOC
--SF2 (Cab. da NF Saida) F2_CONTSOC
-- SF3 (Livro Fiscal Cab.) F3_VALFUN
--SFT (Livro Fiscal Itens ) FT_VALFUN
--SE2 (Conta a pagar) - Documento com a Filial, Número de NF e Tipo TX
--C20 - Capa do Documento Fiscal  (REINF) -- C20_NUMDOC
--C30 - Itens do Documento Fiscal   (REINF) -- C30_CHVNF
--C35 - Trib Itens Documento Fiscal (REINF) -- C35_CHVNF

-- Links de apoios.
-- https://tdn.totvs.com/display/public/PROT/FIS0111+-+SENAR+%2C+INSS+E+GILRAT

--Tabelas Utilizadas

--SA1 – Cadastro de Clientes

--SA2 - Cadastro de Fornecedores

--SD2 – Itens de venda da NF

--SE2 – Contas a Pagar

--SED - Naturezas

--SF2 – Cabeçalho de Notas Fiscais de Saída

--SF3 – Livros Fiscais

--SFT – Itens Livros Fiscais;

--Funções Envolvidas

--MATXFIS - Rotinas Fiscais.

--MATA103 - Documento de Entrada

--MATA460A – Documento de Saída
--REINF
--C20 - Capa do Documento Fiscal  (REINF)
--C30 - Itens do Documento Fiscal   (REINF)
--C35 - Trib Itens Documento Fiscal (REINF)


-- TES
Select F4_CONTSOC, * From SF4010
Where F4_CODIGO In ('857','859')

--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, F2_CONTSOC, * From SF2010
Where F2_FILIAL = 'FJ01' and F2_DOC ='000002353' and D_E_L_E_T_=''

--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_TES, * From SD2010
Where D2_FILIAL ='FJ01' and D2_DOC ='000002353'  and D_E_L_E_T_=''

--Livro Fiscal 
Select F3_EMISSAO, F3_VALFUN, * From SF3010
Where F3_FILIAL ='FJ01' and F3_NFISCAL ='000002353' and D_E_L_E_T_=''

--Livro Fiscal Itens
Select FT_EMISSAO, FT_VALFUN, * From SFT010
Where FT_FILIAL ='FJ01' and FT_NFISCAL ='000002353' and D_E_L_E_T_=''

--SE2 - Contas a Pagar
Select E2_LA, E2_SALDO, E2_VALOR,E2_VLCRUZ,E2_BASECOF,E2_BASEPIS,E2_BASECSL,E2_BASEINS,E2_BASEIRF,E2_BASEISS, * From SE2010
Where E2_FILORIG= 'FJ01' and E2_TIPO In ('TX') and D_E_L_E_T_ = '' and E2_NUM = '000002353'


----C20 - Capa do Documento Fiscal  (REINF)
Select * From C20010
Where C20_FILIAL = 'FJ01' and C20_NUMDOC = '000002353' and D_E_L_E_T_=''

--C30 - Itens do Documento Fiscal   (REINF)
Select * From C30010
Where C30_FILIAL = 'FJ01' and C30_CHVNF = '000000000002136' and D_E_L_E_T_=''

--C35 - Trib Itens Documento Fiscal (REINF)
Select * From C35010
Where C35_FILIAL = 'FJ01' and C35_CHVNF = '000000000002136' and D_E_L_E_T_=''
