--SZE -> Tabela de Bobinas
Select * From SZE010
Where ZE_FILIAL In ('02') and ZE_PRODUTO In ('1041000775') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
 
--SBF -> Controla o saldo no acondicionamento
Select * From SBF010
Where BF_FILIAL In ('02') and BF_PRODUTO In ('1041000775') and D_E_L_E_T_ =''


--SZL > Controle de Pesagem
Select * From SZL010
Where ZL_FILIAL In ('02') and ZL_PRODUTO In ('1041000775') and D_E_L_E_T_ ='' and ZL_NUMBOB = '2213653'




-- SZE -> Tabela de Bobinas 
-- Valida Números Decimais
Select (ZE_QUANT-Cast(ZE_QUANT As Int))As RESTO,Cast(ZE_QUANT As Int) As Inteiro, ZE_QUANT,* From SZE010
Where ZE_STATUS Not in  ('F','C') And D_E_L_E_T_ =''
And (ZE_QUANT-Cast(ZE_QUANT As Int)) > 0

--SBF -> Controla o saldo no acondicionamento
-- Valida Números Decimais
Select (BF_QUANT-Cast(BF_QUANT As Int))As RESTO,Cast(BF_QUANT As Int) As Inteiro, BF_QUANT,* From SBF010
Where D_E_L_E_T_ =' '
And (BF_QUANT-Cast(BF_QUANT As Int)) > 0

--SZL > Controle de Pesagem
-- Valida Números Decimais
Select (ZL_QTUNMOV-Cast(ZL_QTUNMOV As Int))As RESTO,Cast(ZL_QTUNMOV As Int) As Inteiro, ZL_QTUNMOV,* From SZL010
Where D_E_L_E_T_ =' '
And (ZL_QTUNMOV-Cast(ZL_QTUNMOV As Int)) > 0

Select ZZ9_ORDCAR, * From ZZ9010