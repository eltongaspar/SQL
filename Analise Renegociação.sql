--PV Renegociação
Select C6_XNEGOC,C6_ZZPVORI,C6_QTDVEN, C6_QTDENT, C6_QTDEMP, C6_RESERVA,C6_QTDLIB,C6_SEMANA,R_E_C_N_O_, * From SC6010
Where C6_FILIAL = '01' and C6_NUM In ('429797','430186')  
and D_E_L_E_T_ =''
And C6_XNEGOC <> '' 
--C6_XNEGOC
--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO

-- PV itens Lib.
Select * From SC9010
Where C9_FILIAL = '01' and ((C9_PEDIDO In ('429797') and C9_ITEM In ('11') or (C9_PEDIDO In ('430186') and C9_ITEM In ('30'))))
and D_E_L_E_T_ ='' 


-- Negociação
Select ZZV_ID,ZZV_FILIAL,
(ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), [ZZV_OBSF])),'')) As [ZZV_OBSF],
ZZV_NUMBOB,ZZV_RESP,ZZV_NOMEC,ZZV_OBS01,ZZV_STATUS,ZZV_ACOND,ZZV_LANCES,ZZV_METRAG,ZZV_ACONAL,ZZV_LANCEA,ZZV_METRAL,ZZV_ACEITE,ZZV_PROALT,

	Case 
		When ZZV_STATUS = '1' Then 'Falta Iniciar atendimento'
		When ZZV_STATUS = '2' Then 'Em negociacao'
		When ZZV_STATUS = '3' Then 'Agendamento futuro'
		When ZZV_STATUS = '4' Then 'Falta aprovacao supervisao'
		When ZZV_STATUS = '5' Then 'Falta alterar pedido'
		When ZZV_STATUS = '6' Then 'Rejeitado cobrecom'
		When ZZV_STATUS = '7' Then 'Pedido Alterado'
		When ZZV_STATUS = '' Then 'NAO ESTA EM NEGOCIACAO'
		End as ZZV_STATUS_DESC,

* From ZZV010
Where ZZV_ID In ('006362','006371')
--Or (ZZV_FILPV = '02' and ZZV_PEDIDO = '113074')
and D_E_L_E_T_ = ''

--"1" // Falta iniciar atendimento ZZV_STATUS
--"2" // Em negociacao	
--"3" // Agendamento futuro
--"4" // Falta aprovacao supervisao
--"5" // Falta alterar pedido
--"6" // Rejeitado cobrecom
--"7" // Pedido Alterado
--"" // NAO ESTA EM NEGOCIACAO

 --SDC - Composicao do Empenho
Select * From SDC010
Where DC_FILIAL In ('01') 
--And DC_ORIGEM In('SC6') 
And (DC_PEDIDO In ('006362','006371')) 
Or ((DC_PEDIDO In ('429797') and DC_ITEM In ('11')))
Or ((DC_PEDIDO In ('430186') and DC_ITEM In ('30')))
And D_E_L_E_T_ = '' 



 -- Rasterar Bobinas Empenhadas
--01 - Rasterar Numero de Bobina 
--SZE -> Tabela de Bobinas
-- ZE_CTRLE = ZZV_ID
Select ZE_CTRLE,ZE_STATUS,ZE_CONDIC,ZE_SITUACA,ZE_SEQOS,* From SZE010
Where ZE_FILIAL In ('01') 
and ZE_CTRLE In ('006362','006371')
--Or ZE_NUMBOB In ('SEQ0001','SEQ0019','SEQ0002','2327907','SEQ0005'))
and D_E_L_E_T_ ='' 
and ZE_STATUS Not in  ('F','C')
--ZE_STATUS  - I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 
--ZE_CONDIC - A=Adiantada;F=Faturada;L=Liberada                   
--ZE_SITUACA - 0=Substituida;1=Ativa     



--SZL > Controle de Pesagem
Select ZL_STATUS,* From SZL010  With(Nolock)
Where ZL_FILIAL In ('01') and ZL_NUMBOB In ('2349915 ') and D_E_L_E_T_ ='' 
--and ZL_PEDIDO = ''
And ZL_STATUS Not In ('C')
Order By ZL_PEDIDO
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ   