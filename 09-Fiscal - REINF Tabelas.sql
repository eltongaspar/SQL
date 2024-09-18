--Evento R-2050 → Comercialização da Produção por Produtor Rural PJ/Agroindústria
 --O cadastro para o evento R-2050 → Comercialização da Produção por Produtor Rural PJ/Agroindústria e consolida os dados apurados com origem nos seguintes cadastros:

--Estabelecimento
--Participante
--Documenta de Saída
--Informações de Processos
--Pode ser acessado através do menu Eventos REINF → Periódicos → R-2050 - Comercialização da Produção por Produtor Rural PJ/Agroindústria pelo programa TAFA492, onde são utilizadas as seguintes tabelas:

--C35 – Trib. Itens Documentos Fiscais
--V1D – Comerc. Produção Produtor Rural
--V1E – Tipo de Comercialização
--V1F – Processos Administrativos/Judiciais
--C20 - Capa do Documento Fiscal  
--C30 - Itens do Documento Fiscal  
--C1H - Participantes
--Evento R-2055→ Aquisição de Produtor Rural
--O cadastro para o evento R-2055 → Aquisição de Produtor Rural e consolida os dados apurados com origem nos seguintes cadastros:

--Estabelecimento
--Participante
--Documenta de Entrada
--Informações de Processos
--Pode ser acessado através do menu Eventos REINF → Periódicos → R-2055 - Aquisição de Produtor Rural pelo programa TAFA576, onde são utilizadas as seguintes tabelas:

--V5S – Aquisição de Produção Rural  
--V5T – Detalhes Aquisição Prod Rural 
--V5U – Inf.Processos Aquis.Prod.Rural
--V5V – Detalhes NFs Aquisição Rural  
 

----C20 - Capa do Documento Fiscal  (REINF)
Select * From C20010
Where C20_FILIAL = 'FJ01' and C20_NUMDOC = '000002353' and D_E_L_E_T_=''

--C30 - Itens do Documento Fiscal   (REINF)
Select * From C30010
Where C30_FILIAL = 'FJ01' and C30_CHVNF = '000000000002136' and D_E_L_E_T_=''

--C35 - Trib Itens Documento Fiscal (REINF)
Select * From C35010
Where C35_FILIAL = 'FJ01' and C35_CHVNF = '000000000002136' and D_E_L_E_T_=''



