-- Contas a receber 
SELECT
    FI0_DTPRC,
    E1_NUM,
    E5_ARQCNAB,
    E5_LOTE,
    FI0_LOTE,
    FI0_IDARQ,
    FRV_CODIGO,
    FRV_DESCRI,
    A6_NOME,
    EE_CODIGO,
    EE_AGENCIA,
    EE_CONTA,
    EB_REFBAN,
    EB_OCORR,
    EB_DESCRI,
    EB_TIPO,
    EB_OCORR,
    -- Colunas X5_CHAVE e X5_DESCRI montadas com STUFF e FOR XML PATH
    X5_CHAVE = STUFF((
        SELECT DISTINCT ',' + LTRIM(RTRIM(X5_CHAVE)) 
        FROM SX5010 SX5 With(Nolock)
        WHERE EB_FILIAL = ''
            AND X5_TABELA = '10'
            AND SUBSTRING(X5_CHAVE,1,2) = EB_OCORR
            AND EB_TIPO IN ('R')
            AND SX5.D_E_L_E_T_ = ''
        FOR XML PATH('')), 1, 1, ''),
    X5_DESCRI = STUFF((
        SELECT DISTINCT ',' + LTRIM(RTRIM(X5_DESCRI))
        FROM SX5010 SX5 With(Nolock)
        WHERE EB_FILIAL = ''
            AND X5_TABELA = '10'
            AND SUBSTRING(X5_CHAVE,1,2) = EB_OCORR
            AND EB_TIPO IN ('R')
            AND SX5.D_E_L_E_T_ = ''
        FOR XML PATH('')), 1, 1, ''),
    -- Status do t�tulo
    CASE 
        WHEN E1_STATUS = 'A' THEN 'Aberto'
        WHEN E1_STATUS = 'B' THEN 'Baixado'
        WHEN E1_STATUS = 'R' THEN 'Reliquidado'
        ELSE 'Desconhecido'
    END AS Titulos_Status,
    -- Tipo de Documento
    CASE 
        WHEN E5_TIPODOC = 'AP' THEN 'Aplica��o'
        WHEN E5_TIPODOC = 'BA' THEN 'Baixa de t�tulo'
        WHEN E5_TIPODOC = 'BD' THEN 'Transfer�ncia por border� descontado'
        WHEN E5_TIPODOC = 'BL' THEN 'Baixa por Lote'
        WHEN E5_TIPODOC = 'C2' THEN 'Corre��o Monet�ria de t�tulo em carteira descontada'
        WHEN E5_TIPODOC = 'CA' THEN 'Cheque Avulso / Cancelamento de Cheque Avulso'
        WHEN E5_TIPODOC = 'CB' THEN 'Cancelamento de Transfer�ncia por border� descontado'
        WHEN E5_TIPODOC = 'CD' THEN 'Cheque pr�-datado via Movimento Banc�rio Manual'
        WHEN E5_TIPODOC = 'CH' THEN 'Cheque'
        WHEN E5_TIPODOC = 'CM' THEN 'Corre��o Monet�ria'
        WHEN E5_TIPODOC = 'CP' THEN 'Compensa��o CR ou CP'
        WHEN E5_TIPODOC = 'CX' THEN 'Corre��o Monet�ria'
        WHEN E5_TIPODOC = 'D2' THEN 'Desconto em t�tulo em carteira descontada'
        WHEN E5_TIPODOC = 'DB' THEN 'Despesas banc�rias'
        WHEN E5_TIPODOC = 'DC' THEN 'Desconto'
        WHEN E5_TIPODOC = 'DH' THEN 'Dinheiro'
        WHEN E5_TIPODOC = 'E2' THEN 'Estorno de movimento de desconto (Cobran�a Descontada)'
        WHEN E5_TIPODOC = 'EC' THEN 'Estorno de cheque'
        WHEN E5_TIPODOC = 'EP' THEN 'Empr�stimo'
        WHEN E5_TIPODOC = 'ES' THEN 'Estorno de Baixa'
        WHEN E5_TIPODOC = 'IS' THEN 'Imposto Substitutivo (Localiza��es)'
        WHEN E5_TIPODOC = 'J2' THEN 'Juros de t�tulo em carteira descontada'
        WHEN E5_TIPODOC = 'JR' THEN 'Juros'
        WHEN E5_TIPODOC = 'LJ' THEN 'Movimento do SigaLoja'
        WHEN E5_TIPODOC = 'M2' THEN 'Multa de t�tulo em carteira descontada'
        WHEN E5_TIPODOC = 'MT' THEN 'Multa'
        WHEN E5_TIPODOC = 'OC' THEN 'Outros Cr�ditos'
        WHEN E5_TIPODOC = 'OD' THEN 'Outras Despesas'
        WHEN E5_TIPODOC = 'OG' THEN 'Outras Gan�ncias (Localiza��es)'
        WHEN E5_TIPODOC = 'PA' THEN 'Inclus�o PA'
        WHEN E5_TIPODOC = 'PE' THEN 'Pagamento Empr�stimo'
        WHEN E5_TIPODOC = 'R$' THEN 'Dinheiro'
        WHEN E5_TIPODOC = 'RA' THEN 'Inclus�o RA'
        WHEN E5_TIPODOC = 'RF' THEN 'Resgate de Aplica��es'
        WHEN E5_TIPODOC = 'SG' THEN 'Entrada de Dinheiro no Caixa (Loja)'
        WHEN E5_TIPODOC = 'TC' THEN 'Troco'
        WHEN E5_TIPODOC = 'TE' THEN 'Estorno de transfer�ncia (Movimento Banc�rio Manual)'
        WHEN E5_TIPODOC = 'TL' THEN 'Toler�ncia de Recebimento'
        WHEN E5_TIPODOC = 'TR' THEN 'Transfer�ncia para carteira descontada'
        WHEN E5_TIPODOC = 'V2' THEN 'Baixa de t�tulo em carteira descontada'
        WHEN E5_TIPODOC = 'VL' THEN 'Baixa de t�tulo'
        WHEN E5_TIPODOC = 'VM' THEN 'Varia��o Monet�ria'
        ELSE 'Desconhecido'
    END AS Tipo_Documento,
    -- Motivo da Baixa
    CASE 
        WHEN E5_MOTBX = 'NOR' THEN 'Normal'
        WHEN E5_MOTBX = 'DEV' THEN 'Devolu��o'
        WHEN E5_MOTBX = 'DAC' THEN 'Da��o'
        WHEN E5_MOTBX = 'VEND' THEN 'Vendor'
        WHEN E5_MOTBX = 'DBCC' THEN 'D�bito em Conta Corrente'
        WHEN E5_MOTBX = 'MPR' THEN 'Mais Prazo'
        ELSE 'Desconhecido'
    END AS MOTIVO_BAIXA,
    FI1_OCORB,
    -- Ocorr�ncia no Arquivo de Retorno
    CASE 
        WHEN FI0_BCO = '001' THEN
            CASE 
                WHEN FI1_OCORB = '02' THEN 'Confirma��o de Entrada de Boleto'
                WHEN FI1_OCORB = '03' THEN 'Comando recusado (Motivo indicado na posi��o 087/088)'
                WHEN FI1_OCORB = '05' THEN 'Liquidado sem registro (carteira 17-tipo4)'
                WHEN FI1_OCORB = '06' THEN 'Liquida��o Normal'
                WHEN FI1_OCORB = '07' THEN 'Liquida��o por Conta/Parcial'
                WHEN FI1_OCORB = '08' THEN 'Liquida��o por Saldo'
                WHEN FI1_OCORB = '09' THEN 'Baixa de T�tulo'
                WHEN FI1_OCORB = '10' THEN 'Baixa Solicitada'
                WHEN FI1_OCORB = '11' THEN 'Boletos em Ser'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Altera��o de Vencimento do Boleto'
                WHEN FI1_OCORB = '15' THEN 'Liquida��o em Cart�rio'
                WHEN FI1_OCORB = '16' THEN 'Confirma��o de altera��o de juros de mora'
                WHEN FI1_OCORB = '19' THEN 'Confirma��o de recebimento de instru��es para protesto'
                WHEN FI1_OCORB = '20' THEN 'D�bito em Conta'
                WHEN FI1_OCORB = '21' THEN 'Altera��o do Nome do Sacado'
                WHEN FI1_OCORB = '22' THEN 'Altera��o do Endere�o do Sacado'
                WHEN FI1_OCORB = '23' THEN 'Indica��o de encaminhamento a cart�rio'
                WHEN FI1_OCORB = '24' THEN 'Sustar Protesto'
                WHEN FI1_OCORB = '25' THEN 'Dispensar Juros de Mora'
                WHEN FI1_OCORB = '26' THEN 'Altera��o do n�mero do boleto dado pelo Cedente'
                WHEN FI1_OCORB = '28' THEN 'Manuten��o de t�tulo vencido'
                WHEN FI1_OCORB = '31' THEN 'Conceder desconto'
                WHEN FI1_OCORB = '32' THEN 'N�o conceder desconto'
                WHEN FI1_OCORB = '33' THEN 'Retificar desconto'
                WHEN FI1_OCORB = '34' THEN 'Alterar data para desconto'
                WHEN FI1_OCORB = '35' THEN 'Cobrar Multa'
                WHEN FI1_OCORB = '36' THEN 'Dispensar Multa'
                WHEN FI1_OCORB = '37' THEN 'Dispensar Indexador'
                WHEN FI1_OCORB = '38' THEN 'Dispensar prazo limite para recebimento'
                WHEN FI1_OCORB = '39' THEN 'Alterar prazo limite para recebimento'
                WHEN FI1_OCORB = '41' THEN 'Altera��o do n�mero do controle do participante'
                WHEN FI1_OCORB = '42' THEN 'Altera��o do n�mero do documento do sacado (CNPJ/CPF)'
                WHEN FI1_OCORB = '44' THEN 'Boleto pago com cheque devolvido'
                WHEN FI1_OCORB = '46' THEN 'Boleto pago com cheque, aguardando compensa��o'
                WHEN FI1_OCORB = '47' THEN 'Altera��o de valor nominal do boleto'
                WHEN FI1_OCORB = '61' THEN 'Registrado QR Code Pix'
                WHEN FI1_OCORB = '72' THEN 'Altera��o de tipo de cobran�a'
                WHEN FI1_OCORB = '73' THEN 'Confirma��o de Instru��o de Par�metro de Pagamento Parcial'
                WHEN FI1_OCORB = '85' THEN 'Inclus�o de Negativa��o'
                WHEN FI1_OCORB = '86' THEN 'Exclus�o de Negativa��o'
                WHEN FI1_OCORB = '93' THEN 'Baixa Operacional'
                WHEN FI1_OCORB = '96' THEN 'Despesas de Protesto'
                WHEN FI1_OCORB = '97' THEN 'Despesas de Susta��o de Protesto'
                WHEN FI1_OCORB = '98' THEN 'D�bito de Custas Antecipadas'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '033' THEN
            CASE 
                WHEN FI1_OCORB = '02' THEN 'Entrada boleto Confirmada'
                WHEN FI1_OCORB = '03' THEN 'Entrada boleto Rejeitada'
                WHEN FI1_OCORB = '04' THEN 'Transfer�ncia para carteira Simples'
                WHEN FI1_OCORB = '05' THEN 'Transfer�ncia para Carteira Penhor/Desconto/Cess�o'
                WHEN FI1_OCORB = '06' THEN 'Liquida��o do Boleto Efetivada'
                WHEN FI1_OCORB = '07' THEN 'Liquida��o por Conta'
                WHEN FI1_OCORB = '08' THEN 'Liquida��o por Saldo'
                WHEN FI1_OCORB = '09' THEN 'Baixa Autom�tica'
                WHEN FI1_OCORB = '10' THEN 'Boleto Baixado Conforme Instru��o'
                WHEN FI1_OCORB = '11' THEN 'Boletos em carteira (em ser)'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Altera��o de Vencimento'
                WHEN FI1_OCORB = '15' THEN 'Confirma��o de Protesto'
                WHEN FI1_OCORB = '16' THEN 'Boleto Baixado/Liquidado'
                WHEN FI1_OCORB = '17' THEN 'Liquidado em Cart�rio'
                WHEN FI1_OCORB = '21' THEN 'Boleto Enviado a Cart�rio'
                WHEN FI1_OCORB = '22' THEN 'Boleto Retirado do Cart�rio'
                WHEN FI1_OCORB = '24' THEN 'Custas de Cart�rio'
                WHEN FI1_OCORB = '25' THEN 'Boleto Protestado'
                WHEN FI1_OCORB = '26' THEN 'Sustar Protesto'
                WHEN FI1_OCORB = '27' THEN 'Cancelar Boleto Protestado'
                WHEN FI1_OCORB = '35' THEN 'Boleto DDA Reconhecido pelo Pagador'
                WHEN FI1_OCORB = '36' THEN 'Boleto DDA N�o Reconhecido pelo Pagador'
                WHEN FI1_OCORB = '37' THEN 'Boleto DDA Recusado pela PCR'
                WHEN FI1_OCORB = '38' THEN 'N�o Protestar (antes de iniciar o ciclo de protesto)'
                WHEN FI1_OCORB = '39' THEN 'Esp�cie de Boleto n�o permite a instru��o'
                WHEN FI1_OCORB = '61' THEN 'Confirma��o de Altera��o do Valor Nominal do Boleto'
                WHEN FI1_OCORB = '62' THEN 'Confirma��o de Altera��o do Valor ou Percentual m�nimo'
                WHEN FI1_OCORB = '63' THEN 'Confirma��o de Altera��o do Valor ou Percentual m�ximo'
                WHEN FI1_OCORB = '93' THEN 'Pagamento do Boleto Recebido'
                WHEN FI1_OCORB = '94' THEN 'Cancelamento do Pagamento Recebido'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '237' THEN
            CASE
                WHEN FI1_OCORB = '02' THEN 'Entrada Confirmada (verificar motivo nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '03' THEN 'Entrada Rejeitada (verificar motivo nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '06' THEN 'Liquida��o Normal (sem motivo)'
                WHEN FI1_OCORB = '07' THEN 'Conf. Exc. Cadastro Pagador D�bito (verificar motivos nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '08' THEN 'Rej. Ped. Exc. Cadastro de Pagador D�bito (verificar motivos nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '09' THEN 'Baixado Automat. via Arquivo (verificar motivo posi��es 319 a 328)'
                WHEN FI1_OCORB = '10' THEN 'Baixado conforme instru��es da Ag�ncia (verificar motivo Pos.319 a 328)'
                WHEN FI1_OCORB = '11' THEN 'Em Ser - Arquivo de T�tulos Pendentes'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Vencimento Alterado'
                WHEN FI1_OCORB = '15' THEN 'Liquida��o em Cart�rio (sem motivo)'
                WHEN FI1_OCORB = '16' THEN 'T�tulo Pago em Cheque - Vinculado'
                WHEN FI1_OCORB = '17' THEN 'Liquida��o ap�s Baixa ou T�tulo n�o Registrado (verificar motivo nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '18' THEN 'Acerto de Deposit�ria'
                WHEN FI1_OCORB = '19' THEN 'Confirma��o Receb. Inst. de Protesto (verificar motivo pos.295 a 295)'
                WHEN FI1_OCORB = '20' THEN 'Confirma��o Recebimento Instru��o Susta��o de Protesto'
                WHEN FI1_OCORB = '21' THEN 'Acerto do Controle do Participante'
                WHEN FI1_OCORB = '22' THEN 'T�tulo com Pagamento Cancelado'
                WHEN FI1_OCORB = '23' THEN 'Entrada do T�tulo em Cart�rio'
                WHEN FI1_OCORB = '24' THEN 'Entrada Rejeitada por CEP Irregular (verificar motivo pos.319 a 328)'
                WHEN FI1_OCORB = '25' THEN 'Confirma��o Receb.Inst.de Protesto Falimentar (verificar pos.295 a 295)'
                WHEN FI1_OCORB = '27' THEN 'Baixa Rejeitada (verificar motivo posi��es 319 a 328)'
                WHEN FI1_OCORB = '28' THEN 'D�bito de Tarifas/Custas (verificar motivo nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '29' THEN 'Ocorr�ncias do Pagador (verificar motivo nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '30' THEN 'Altera��o de Outros Dados Rejeitados (verificar motivo Pos.319 a 328)'
                WHEN FI1_OCORB = '31' THEN 'Confirmado Inclus�o Cadastro Pagador'
                WHEN FI1_OCORB = '32' THEN 'Instru��o Rejeitada (verificar motivo posi��es 319 a 328)'
                WHEN FI1_OCORB = '33' THEN 'Confirma��o Pedido Altera��o Outros Dados'
                WHEN FI1_OCORB = '34' THEN 'Retirado de Cart�rio e Manuten��o Carteira'
                WHEN FI1_OCORB = '35' THEN 'Cancelamento do Agendamento do D�bito Autom�tico (verificar motivos pos. 319 a 328)'
                WHEN FI1_OCORB = '37' THEN 'Rejeitado Inclus�o Cadastro Pagador (verificar motivos nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '38' THEN 'Confirmado Altera��o Pagador'
                WHEN FI1_OCORB = '39' THEN 'Rejeitado Altera��o Cadastro Pagador (verificar motivos nas posi��es 319 a 328)'
                WHEN FI1_OCORB = '40' THEN 'Estorno de Pagamento'
                WHEN FI1_OCORB = '55' THEN 'Sustado Judicial'
                WHEN FI1_OCORB = '66' THEN 'T�tulo Baixado por Pagamento via Pix'
                WHEN FI1_OCORB = '68' THEN 'Acerto dos Dados do Rateio de Cr�dito (verificar motivo posi��o de status do registro Tipo 3)'
                WHEN FI1_OCORB = '69' THEN 'Cancelamento de Rateio (verificar motivo posi��o de status do registro Tipo 3)'
                WHEN FI1_OCORB = '73' THEN 'Confirma��o Receb. Pedido de Negativa��o'
                WHEN FI1_OCORB = '74' THEN 'Confir Pedido de Excl de Negat (com ou sem baixa)'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '341' THEN
            CASE
                WHEN FI1_OCORB = '03' THEN 'ENTRADA REJEITADA (NOTA 20 � TABELA 1)'
                WHEN FI1_OCORB = '04' THEN 'ALTERA��O DE DADOS � NOVA ENTRADA OU ALTERA��O/EXCLUS�O DE DADOS ACATADA'
                WHEN FI1_OCORB = '05' THEN 'ALTERA��O DE DADOS � BAIXA'
                WHEN FI1_OCORB = '06' THEN 'LIQUIDA��O NORMAL'
                WHEN FI1_OCORB = '07' THEN 'LIQUIDA��O PARCIAL � COBRAN�A INTELIGENTE (B2B)'
                WHEN FI1_OCORB = '08' THEN 'LIQUIDA��O EM CART�RIO'
                WHEN FI1_OCORB = '09' THEN 'BAIXA SIMPLES'
                WHEN FI1_OCORB = '10' THEN 'BAIXA POR TER SIDO LIQUIDADO'
                WHEN FI1_OCORB = '11' THEN 'EM SER (S� NO RETORNO MENSAL)'
                WHEN FI1_OCORB = '12' THEN 'ABATIMENTO CONCEDIDO'
                WHEN FI1_OCORB = '13' THEN 'ABATIMENTO CANCELADO'
                WHEN FI1_OCORB = '14' THEN 'VENCIMENTO ALTERADO'
                WHEN FI1_OCORB = '15' THEN 'BAIXAS REJEITADAS (NOTA 20 � TABELA 4)'
                WHEN FI1_OCORB = '16' THEN 'INSTRU��ES REJEITADAS (NOTA 20 � TABELA 3)'
                WHEN FI1_OCORB = '17' THEN 'ALTERA��O/EXCLUS�O DE DADOS REJEITADOS (NOTA 20 � TABELA 2)'
                WHEN FI1_OCORB = '18' THEN 'COBRAN�A CONTRATUAL � INSTRU��ES/ALTERA��ES REJEITADAS/PENDENTES (NOTA 20 � TABELA 5)'
                WHEN FI1_OCORB = '19' THEN 'CONFIRMA RECEBIMENTO DE INSTRU��O DE PROTESTO'
                WHEN FI1_OCORB = '20' THEN 'CONFIRMA RECEBIMENTO DE INSTRU��O DE SUSTA��O DE PROTESTO /TARIFA'
                WHEN FI1_OCORB = '21' THEN 'CONFIRMA RECEBIMENTO DE INSTRU��O DE N�O PROTESTAR'
                WHEN FI1_OCORB = '23' THEN 'T�TULO ENVIADO A CART�RIO/TARIFA'
                WHEN FI1_OCORB = '24' THEN 'INSTRU��O DE PROTESTO REJEITADA / SUSTADA / PENDENTE (NOTA 20 � TABELA 7)'
                WHEN FI1_OCORB = '25' THEN 'ALEGA��ES DO PAGADOR (NOTA 20 � TABELA 6)'
                WHEN FI1_OCORB = '26' THEN 'TARIFA DE AVISO DE COBRAN�A'
                WHEN FI1_OCORB = '27' THEN 'TARIFA DE EXTRATO POSI��O (B40X)'
                WHEN FI1_OCORB = '28' THEN 'TARIFA DE RELA��O DAS LIQUIDA��ES'
                WHEN FI1_OCORB = '29' THEN 'TARIFA DE MANUTEN��O DE T�TULOS VENCIDOS'
                WHEN FI1_OCORB = '30' THEN 'D�BITO MENSAL DE TARIFAS (PARA ENTRADAS E BAIXAS)'
                WHEN FI1_OCORB = '32' THEN 'BAIXA POR TER SIDO PROTESTADO'
                WHEN FI1_OCORB = '33' THEN 'CUSTAS DE PROTESTO'
                WHEN FI1_OCORB = '34' THEN 'CUSTAS DE SUSTA��O'
                WHEN FI1_OCORB = '35' THEN 'CUSTAS DE CART�RIO DISTRIBUIDOR'
                WHEN FI1_OCORB = '36' THEN 'CUSTAS DE EDITAL'
                WHEN FI1_OCORB = '37' THEN 'TARIFA DE EMISS�O DE BOLETO/TARIFA DE ENVIO DE DUPLICATA'
                WHEN FI1_OCORB = '38' THEN 'TARIFA DE INSTRU��O'
                WHEN FI1_OCORB = '39' THEN 'TARIFA DE OCORR�NCIAS'
                WHEN FI1_OCORB = '40' THEN 'TARIFA MENSAL DE EMISS�O DE BOLETO/TARIFA MENSAL DE ENVIO DE DUPLICATA'
                WHEN FI1_OCORB = '41' THEN 'D�BITO MENSAL DE TARIFAS � EXTRATO DE POSI��O (B4EP/B4OX)'
                WHEN FI1_OCORB = '42' THEN 'D�BITO MENSAL DE TARIFAS � OUTRAS INSTRU��ES'
                WHEN FI1_OCORB = '43' THEN 'D�BITO MENSAL DE TARIFAS � MANUTEN��O DE T�TULOS VENCIDOS'
                WHEN FI1_OCORB = '44' THEN 'D�BITO MENSAL DE TARIFAS � OUTRAS OCORR�NCIAS'
                WHEN FI1_OCORB = '45' THEN 'D�BITO MENSAL DE TARIFAS � PROTESTO'
                WHEN FI1_OCORB = '46' THEN 'D�BITO MENSAL DE TARIFAS � SUSTA��O DE PROTESTO'
                WHEN FI1_OCORB = '47' THEN 'BAIXA COM TRANSFER�NCIA PARA DESCONTO'
                WHEN FI1_OCORB = '48' THEN 'CUSTAS DE SUSTA��O JUDICIAL'
                WHEN FI1_OCORB = '51' THEN 'TARIFA MENSAL REF A ENTRADAS BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '52' THEN 'TARIFA MENSAL BAIXAS NA CARTEIRA'
                WHEN FI1_OCORB = '53' THEN 'TARIFA MENSAL BAIXAS EM BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '54' THEN 'TARIFA MENSAL DE LIQUIDA��ES NA CARTEIRA'
                WHEN FI1_OCORB = '55' THEN 'TARIFA MENSAL DE LIQUIDA��ES EM BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '56' THEN 'CUSTAS DE IRREGULARIDADE'
                WHEN FI1_OCORB = '57' THEN 'INSTRU��O CANCELADA (NOTA 20 � TABELA 8)'
                WHEN FI1_OCORB = '59' THEN 'BAIXA POR CR�DITO EM C/C ATRAV�S DO SISPAG'
                WHEN FI1_OCORB = '60' THEN 'ENTRADA REJEITADA CARN� (NOTA 20 � TABELA 1)'
                WHEN FI1_OCORB = '61' THEN 'TARIFA EMISS�O AVISO DE MOVIMENTA��O DE T�TULOS (2154)'
                WHEN FI1_OCORB = '62' THEN 'D�BITO MENSAL DE TARIFA � AVISO DE MOVIMENTA��O DE T�TULOS (2154)'
                WHEN FI1_OCORB = '63' THEN 'T�TULO SUSTADO JUDICIALMENTE'
                WHEN FI1_OCORB = '64' THEN 'ENTRADA CONFIRMADA COM RATEIO DE CR�DITO'
                WHEN FI1_OCORB = '65' THEN 'PAGAMENTO COM CHEQUE � AGUARDANDO COMPENSA��O'
                WHEN FI1_OCORB = '69' THEN 'CHEQUE DEVOLVIDO (NOTA 20 � TABELA 9)'
                WHEN FI1_OCORB = '71' THEN 'ENTRADA REGISTRADA, AGUARDANDO AVALIA��O'
                WHEN FI1_OCORB = '72' THEN 'BAIXA POR CR�DITO EM C/C ATRAV�S DO SISPAG SEM T�TULO CORRESPONDENTE'
                WHEN FI1_OCORB = '73' THEN 'CONFIRMA��O DE ENTRADA NA COBRAN�A SIMPLES � ENTRADA N�O ACEITA NA COBRAN�A CONTRATUAL'
                WHEN FI1_OCORB = '74' THEN 'INSTRU��O DE NEGATIVA��O EXPRESSA REJEITADA (NOTA 20 � TABELA 11)'
                WHEN FI1_OCORB = '75' THEN 'CONFIRMA��O DE RECEBIMENTO DE INSTRU��O DE ENTRADA EM NEGATIVA��O EXPRESSA'
                WHEN FI1_OCORB = '76' THEN 'CHEQUE COMPENSADO'
                WHEN FI1_OCORB = '77' THEN 'CONFIRMA��O DE RECEBIMENTO DE INSTRU��O DE EXCLUS�O DE ENTRADA EM NEGATIVA��O EXPRESSA'
                WHEN FI1_OCORB = '78' THEN 'CONFIRMA��O DE RECEBIMENTO DE INSTRU��O DE CANCELAMENTO DE NEGATIVA��O EXPRESSA'
                WHEN FI1_OCORB = '79' THEN 'NEGATIVA��O EXPRESSA INFORMACIONAL (NOTA 20 � TABELA 12)'
                WHEN FI1_OCORB = '80' THEN 'CONFIRMA��O DE ENTRADA EM NEGATIVA��O EXPRESSA � TARIFA'
                WHEN FI1_OCORB = '82' THEN 'CONFIRMA��O DO CANCELAMENTO DE NEGATIVA��O EXPRESSA � TARIFA'
                WHEN FI1_OCORB = '83' THEN 'CONFIRMA��O DE EXCLUS�O DE ENTRADA EM NEGATIVA��O EXPRESSA POR LIQUIDA��O � TARIFA'
                WHEN FI1_OCORB = '85' THEN 'TARIFA POR BOLETO (AT� 03 ENVIOS) COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '86' THEN 'TARIFA EMAIL COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '87' THEN 'TARIFA SMS COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '88' THEN 'TARIFA MENSAL POR BOLETO (AT� 03 ENVIOS) COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '89' THEN 'TARIFA MENSAL EMAIL COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '90' THEN 'TARIFA MENSAL SMS COBRAN�A ATIVA ELETR�NICA'
                WHEN FI1_OCORB = '91' THEN 'TARIFA MENSAL DE EXCLUS�O DE ENTRADA DE NEGATIVA��O EXPRESSA'
                WHEN FI1_OCORB = '92' THEN 'TARIFA MENSAL DE CANCELAMENTO DE NEGATIVA��O EXPRESSA'
                WHEN FI1_OCORB = '93' THEN 'TARIFA MENSAL DE EXCLUS�O DE NEGATIVA��O EXPRESSA POR LIQUIDA��O'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '422' THEN
            CASE
                WHEN FI1_OCORB = '02' THEN 'ENTRADA CONFIRMADA'
                WHEN FI1_OCORB = '03' THEN 'ENTRADA REJEITADA'
                WHEN FI1_OCORB = '04' THEN 'TRANSFER�NCIA DE CARTEIRA (ENTRADA)'
                WHEN FI1_OCORB = '05' THEN 'TRANSFER�NCIA DE CARTEIRA (BAIXA)'
                WHEN FI1_OCORB = '06' THEN 'LIQUIDA��O NORMAL'
                WHEN FI1_OCORB = '09' THEN 'BAIXADO AUTOMATICAMENTE'
                WHEN FI1_OCORB = '10' THEN 'BAIXADO CONFORME INSTRU��ES'
                WHEN FI1_OCORB = '11' THEN 'T�TULOS EM SER (PARA ARQUIVO MENSAL)'
                WHEN FI1_OCORB = '12' THEN 'ABATIMENTO CONCEDIDO'
                WHEN FI1_OCORB = '13' THEN 'ABATIMENTO CANCELADO'
                WHEN FI1_OCORB = '14' THEN 'VENCIMENTO ALTERADO'
                WHEN FI1_OCORB = '15' THEN 'LIQUIDA��O EM CART�RIO'
                WHEN FI1_OCORB = '19' THEN 'CONFIRMA��O DE INSTRU��O DE PROTESTO'
                WHEN FI1_OCORB = '20' THEN 'CONFIRMA��O DE SUSTAR PROTESTO'
                WHEN FI1_OCORB = '21' THEN 'TRANSFER�NCIA DE BENEFICI�RIO'
                WHEN FI1_OCORB = '23' THEN 'T�TULO ENVIADO A CART�RIO'
                WHEN FI1_OCORB = '40' THEN 'BAIXA DE T�TULO PROTESTADO'
                WHEN FI1_OCORB = '41' THEN 'LIQUIDA��O DE T�TULO BAIXADO'
                WHEN FI1_OCORB = '42' THEN 'T�TULO RETIRADO DO CART�RIO'
                WHEN FI1_OCORB = '43' THEN 'DESPESA DE CART�RIO'
                WHEN FI1_OCORB = '44' THEN 'ACEITE DO T�TULO DOA PELO PAGADOR'
                WHEN FI1_OCORB = '45' THEN 'N�O ACEITE DO T�TULO DOA PELO PAGADOR'
                WHEN FI1_OCORB = '51' THEN 'VALOR DO T�TULO ALTERADO'
                WHEN FI1_OCORB = '52' THEN 'ACERTO DE DATA DE EMISS�O'
                WHEN FI1_OCORB = '53' THEN 'ACERTO DE C�DIGO ESP�CIE DO DOCUMENTO'
                WHEN FI1_OCORB = '54' THEN 'ALTERA��O DE SEU N�MERO'
                WHEN FI1_OCORB = '56' THEN 'INSTRU��O NEGATIVA��O ACEITA'
                WHEN FI1_OCORB = '57' THEN 'INSTRU��O BAIXA DE NEGATIVA��O ACEITA'
                WHEN FI1_OCORB = '58' THEN 'INSTRU��O N�O NEGATIVAR ACEITA'
                ELSE 'Desconhecido'
            END
        ELSE
            'Banco n�o identificado'
    END AS Ocorrencia_Arquivo_Retorno,
    FI1_OCORS,
    -- Tipo de Instru��o
    CASE 
        WHEN EB_TIPO = 'R' THEN 'Retorno'
        WHEN EB_TIPO = 'P' THEN 'Contas a pagar'
        WHEN EB_TIPO = 'E' THEN 'Envio'
        WHEN EB_TIPO = 'D' THEN 'DDA'
        ELSE 'Desconhecido'
    END AS TIPO_INSTRUCAO
FROM 
    SE1010 SE1 With(Nolock)
    LEFT JOIN SE5010 SE5 With(Nolock) -- Mov. Banc�ria
        ON E5_FILIAL = E1_FILIAL
            AND E5_CLIFOR = E1_CLIENTE
            AND E5_LOJA = E1_LOJA
            AND E5_TIPO = E1_TIPO 
            AND E5_NUMERO = E1_NUM
            AND E5_PARCELA = E1_PARCELA
            AND E5_PREFIXO = E1_PREFIXO 
            AND SE5.D_E_L_E_T_ = ''
    LEFT JOIN FI0010 FI0 With(Nolock) -- Cabe�alho Log Processamento CNAB
        ON FI0_FILIAL = '01'
            AND FI0_LOTE = E5_LOTE
            AND FI0.D_E_L_E_T_ = ''
    LEFT JOIN FI1010 FI1 With(Nolock) -- Detalhe do Log Processamento
        ON FI1_FILIAL = FI0_FILIAL 
            AND FI1_IDARQ = FI0_IDARQ
            AND FI1_IDTIT = E1_IDCNAB
            AND FI1.D_E_L_E_T_ = ''
    LEFT JOIN FRV010 FRV With(Nolock) -- Situa��o Cobran�a - FINA022
        ON FRV_FILIAL = ''
            AND FRV_CODIGO = E1_SITUACA
            AND FRV.D_E_L_E_T_ = ''
    LEFT JOIN SEE010 SEE With(Nolock) -- Comunica��o Banc�ria 
        ON EE_FILIAL = ''
            AND EE_CODIGO = E5_BANCO 
            AND EE_AGENCIA = E5_AGENCIA
            AND EE_CONTA = E5_CONTA
            AND SEE.D_E_L_E_T_ = ''
    LEFT JOIN SA6010 SA6 With(Nolock) -- Bancos 
        ON A6_FILIAL = ''
            AND A6_COD = EE_CODIGO
            AND A6_AGENCIA = EE_AGENCIA
            AND A6_NUMCON = EE_CONTA
            AND SA6.D_E_L_E_T_ = ''
    LEFT JOIN SEB010 SEB With(Nolock) -- Ocorr�ncias da Transmiss�o Banc�ria
        ON EB_FILIAL = ''
            AND EB_BANCO = FI0_BCO
            AND EB_REFBAN = FI1_OCORB
            AND EB_OCORR = FI1_OCORS
            AND EB_TIPO = 'R'
            AND SEB.D_E_L_E_T_ = ''
WHERE 
    FI0_DTPRC >= '20240901'
    --AND E5_BANCO IN ('001', '033', '237', '341', '400') 
    AND SE1.D_E_L_E_T_ = ''
ORDER BY 
    8,24;



--E1_STATUS = Status do titulo. A = Aberto B = Baixado R = Reliquidado

--Existem seis motivos padr�es de baixa de t�tulos a pagar:
--Normal (NOR): t�tulos de pagamentos normais. Atualiza automaticamente a movimenta��o banc�ria, caso tenha sido gerado cheque para o t�tulo.
--Devolu��o (DEV): recebimentos referentes a devolu��es. N�o atualiza a movimenta��o banc�ria.
--Da��o (DAC): ocorre quando algo � oferecido como pagamento de outro. N�o atualiza a movimenta��o banc�ria.
--Vendor (VEND):pagamento de t�tulo via empr�stimo banc�rio. O Banco passa a ser o benefici�rio, por�m, � necess�rio que a empresa possua um contrato banc�rio cadastrado para possibilitar este empr�stimo. Atualiza automaticamente a movimenta��o banc�ria.
--D�bito CC: debita automaticamente a movimenta��o banc�ria sem a necessidade de gerar cheque sobre o t�tulo.
--Mais Prazo (MPR ou conforme par�metro MV_MBXTECF): Utilizado na Integra��o com TOTVS Mais Prazo. Utilizado na carteira a pagar. N�o movimenta saldo banc�rio, n�o considera c�lculo

--FI1_OCORB	Ocor.Arq.Ret	Ocorrencia Arq Retorno	
--FI1_OCORS	Ocorr. Sist.	Ocorrencia no sistema



--EB_REFBAN	Ocorr Banco	Codigo Ocorrencia Banco
--EB_TIPO	Tipo	Envio ou Retorno --E=Envio;R=Retorno;P=Contas a Pagar;D=DDA
--EB_OCORR	Ocorr Sist.	Codigo Ocorrencia Sistema	
--EB_DESCRI	Descricao	Descricao da Ocorrencia
