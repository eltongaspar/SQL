--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, F1_ISS, F1_RECISS, F1_BASECPM, F1_VLCPM, F1_DTCPISS, F1_INCISS,   * From SF1010
Where F1_FILIAL = 'CA01' and F1_DOC ='000000443' and D_E_L_E_T_='' and F1_FORNECE = '000295'

/*
F1_ISS	Valor ISS	Valor do ISS
F1_RECISS	Rec Iss	Recolhe ISS ?
F1_BASECPM	Bs.ISS CPM	Base ISS CPM	
F1_VLCPM	Vl.ISS CPM	Valor ISS CPM
F1_DTCPISS	Dt. Comp ISS	Desc. Data Competencia
F1_INCISS	Mun. Incid.	Munic. de Incid. do ISS
*/

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC, D1_BASEISS, D1_ALIQISS, D1_VALISS,D1_ABATMAT,
D1_CODISS,D1_ABATISS,D1_ALQCPM,D1_BASECPM,D1_VALCPM, * From SD1010
Where D1_FILIAL ='CA01' and D1_DOC ='000000443' and D_E_L_E_T_ ='' and D1_FORNECE = '000295'
/*
D1_BASEISS	Base de ISS	Base de calculo do ISS	
D1_ALIQISS	Aliq. ISS	Aliquota de ISS	
D1_VALISS	Valor do ISS	Valor do ISS
D1_ABATMAT	Abat. Mat.	Abatimento ISS material
D1_CODISS	Cod.Serv.ISS	Codigo de Servico do ISS
D1_ABATISS	Abatim. ISS	Valor abatimento / ISS
D1_ALQCPM	Alq.ISS CPM	Aliquota ISS CPM	
D1_BASECPM	Bs.ISS CPM	Base ISS CPM	
D1_VALCPM	Vl.ISS CPM	Valor ISS CPM
*/


--Livro Fiscal 
Select F3_EMISSAO,F3_CODISS,F3_ISSST,F3_RECISS,F3_ABATISS,F3_ISSSUB,	
F3_CSTISS,F3_VALCPM,F3_BASECPM,F3_ALQCPM,F3_ISSMAT,	* From SF3010
Where F3_FILIAL ='CA01' and F3_NFISCAL ='000000443' and D_E_L_E_T_='' and F3_CLIEFOR = '000295'

/*
F3_CODISS	Cod.Serv.ISS	Codigo de Servico do ISS
F3_ISSST	Pgto Imposto	Pagamento Imposto
F3_RECISS	Recolhe ISS	Indica se recolhe ISS
F3_ABATISS	ISS Subempr.	ISS da Subempreitada
F3_ISSSUB	Iss Subempr.	ISS da Subempreitada
F3_CSTISS	Sit.Trib.ISS	Situacao Trib. do ISS
F3_VALCPM	Vl.ISS CPM	Valor ISS CPM	
F3_BASECPM	Bs.ISS CPM	Base ISS CPM	
F3_ALQCPM	Alq.ISS CPM	Aliquota ISS CPM
F3_ISSMAT	ISS Mat.	Material Aplicado
*/


--Livro Fiscal Itens
Select FT_EMISSAO,FT_CODISS,FT_ISSST,FT_ISSSUB,FT_RECISS,FT_ISSMAT,FT_CSTISS,	
FT_VALCPM,FT_BASECPM,FT_ALQCPM, * From SFT010
Where FT_FILIAL ='CA01' and FT_NFISCAL ='000000443' and FT_CLIEFOR = '000295'

/*
FT_CODISS	Cod. Servico	Codigo Servico
FT_ISSST	Pagto Imp.	Origem pagto do ISS
FT_ISSSUB	ISS Subempr.	ISS subempreitada		
FT_RECISS	ISS Retido	ISS Retido
FT_ISSMAT	ISS Mat.	Material Aplicado
FT_CSTISS	Sit.Trib.ISS	Situacao Trib. do ISS
FT_VALCPM	Vl.ISS CPM	Valor ISS CPM	
FT_BASECPM	Bs.ISS CPM	Base ISS CPM	
FT_ALQCPM	Alq.ISS CPM	Aliquota ISS CPM
*/


--SE2 - Contas a Pagar
Select E2_LA, E2_SALDO, E2_VALOR,E2_VLCRUZ,E2_BASECOF,E2_BASEPIS,E2_BASECSL,E2_BASEINS,E2_BASEIRF,E2_BASEISS, * From SE2010
Where E2_FILORIG= 'CA01' and E2_NUM In ('000000443') and D_E_L_E_T_ = '' 
