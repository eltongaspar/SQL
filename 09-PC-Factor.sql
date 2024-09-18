-- Analisar Erros de Pesagem de Integração 
-- Analisar Protheus SZL 3.4
-- Analisar Banco de Dados PCFactory 3.9
-- 
/*
--SZL > Controle de Pesagem
Select ZL_UNMOV,ZL_TIPO,ZL_STATUS,ZL_COMENTS,
	Case 
	When ZL_STATUS = 'A' Then 'A PROCESSAR'
	When ZL_STATUS = 'E' Then 'ERRO'
	When ZL_STATUS = 'Q' Then 'BLOQUEIO CQ'
	When ZL_STATUS = 'P' Then 'PROCESSADO'
	Else 'ANALISAR'
	End as OBS_,
* From SZL010
Where ZL_FILIAL In ('01','02') and ZL_STATUS In ('A','C','E','Q')
And ZL_NUM In ('367880','366270','366325','366716','367497')
And D_E_L_E_T_ ='' 
-- ZL_TIPO - P=Producao;D=Prod.+1500Kg;R=Retrabalho;T=Troca Etiqueta;S=Sucata;F=Troca Filial;U=Prod.Unimov
-- ZL_STATUS - A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ      */


-- PC Facotor
select movev.IDMovUn as [IDMOVUN]
from TBLMovEv movev
inner join TBLMovType movtype on movev.IDMovType = movtype.IDMovType
where movev.IDLot = (
	select submovev.IDLot as [idlote]
	from TBLMovEv submovev
	inner join TBLMovType submovtype on submovev.IDMovType = submovtype.IDMovType
	where submovev.IDMovUn In (2958172)
	and submovtype.Code = '010'
	)
and movev.IDMovUn =	(
	select ssubmovev.IDMovUn as [idlote]
	from TBLMovEv ssubmovev
	inner join TBLMovType ssubmovtype on ssubmovev.IDMovType = ssubmovtype.IDMovType
	where ssubmovev.IDMovUn = movev.IDMovUn
	and ssubmovtype.Code in ('PR0','PR1')
	)
and movtype.Code = 'DM1'


