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
    -- Status do título
    CASE 
        WHEN E1_STATUS = 'A' THEN 'Aberto'
        WHEN E1_STATUS = 'B' THEN 'Baixado'
        WHEN E1_STATUS = 'R' THEN 'Reliquidado'
        ELSE 'Desconhecido'
    END AS Titulos_Status,
    -- Tipo de Documento
    CASE 
        WHEN E5_TIPODOC = 'AP' THEN 'Aplicação'
        WHEN E5_TIPODOC = 'BA' THEN 'Baixa de título'
        WHEN E5_TIPODOC = 'BD' THEN 'Transferência por borderô descontado'
        WHEN E5_TIPODOC = 'BL' THEN 'Baixa por Lote'
        WHEN E5_TIPODOC = 'C2' THEN 'Correção Monetária de título em carteira descontada'
        WHEN E5_TIPODOC = 'CA' THEN 'Cheque Avulso / Cancelamento de Cheque Avulso'
        WHEN E5_TIPODOC = 'CB' THEN 'Cancelamento de Transferência por borderô descontado'
        WHEN E5_TIPODOC = 'CD' THEN 'Cheque pré-datado via Movimento Bancário Manual'
        WHEN E5_TIPODOC = 'CH' THEN 'Cheque'
        WHEN E5_TIPODOC = 'CM' THEN 'Correção Monetária'
        WHEN E5_TIPODOC = 'CP' THEN 'Compensação CR ou CP'
        WHEN E5_TIPODOC = 'CX' THEN 'Correção Monetária'
        WHEN E5_TIPODOC = 'D2' THEN 'Desconto em título em carteira descontada'
        WHEN E5_TIPODOC = 'DB' THEN 'Despesas bancárias'
        WHEN E5_TIPODOC = 'DC' THEN 'Desconto'
        WHEN E5_TIPODOC = 'DH' THEN 'Dinheiro'
        WHEN E5_TIPODOC = 'E2' THEN 'Estorno de movimento de desconto (Cobrança Descontada)'
        WHEN E5_TIPODOC = 'EC' THEN 'Estorno de cheque'
        WHEN E5_TIPODOC = 'EP' THEN 'Empréstimo'
        WHEN E5_TIPODOC = 'ES' THEN 'Estorno de Baixa'
        WHEN E5_TIPODOC = 'IS' THEN 'Imposto Substitutivo (Localizações)'
        WHEN E5_TIPODOC = 'J2' THEN 'Juros de título em carteira descontada'
        WHEN E5_TIPODOC = 'JR' THEN 'Juros'
        WHEN E5_TIPODOC = 'LJ' THEN 'Movimento do SigaLoja'
        WHEN E5_TIPODOC = 'M2' THEN 'Multa de título em carteira descontada'
        WHEN E5_TIPODOC = 'MT' THEN 'Multa'
        WHEN E5_TIPODOC = 'OC' THEN 'Outros Créditos'
        WHEN E5_TIPODOC = 'OD' THEN 'Outras Despesas'
        WHEN E5_TIPODOC = 'OG' THEN 'Outras Ganâncias (Localizações)'
        WHEN E5_TIPODOC = 'PA' THEN 'Inclusão PA'
        WHEN E5_TIPODOC = 'PE' THEN 'Pagamento Empréstimo'
        WHEN E5_TIPODOC = 'R$' THEN 'Dinheiro'
        WHEN E5_TIPODOC = 'RA' THEN 'Inclusão RA'
        WHEN E5_TIPODOC = 'RF' THEN 'Resgate de Aplicações'
        WHEN E5_TIPODOC = 'SG' THEN 'Entrada de Dinheiro no Caixa (Loja)'
        WHEN E5_TIPODOC = 'TC' THEN 'Troco'
        WHEN E5_TIPODOC = 'TE' THEN 'Estorno de transferência (Movimento Bancário Manual)'
        WHEN E5_TIPODOC = 'TL' THEN 'Tolerância de Recebimento'
        WHEN E5_TIPODOC = 'TR' THEN 'Transferência para carteira descontada'
        WHEN E5_TIPODOC = 'V2' THEN 'Baixa de título em carteira descontada'
        WHEN E5_TIPODOC = 'VL' THEN 'Baixa de título'
        WHEN E5_TIPODOC = 'VM' THEN 'Variação Monetária'
        ELSE 'Desconhecido'
    END AS Tipo_Documento,
    -- Motivo da Baixa
    CASE 
        WHEN E5_MOTBX = 'NOR' THEN 'Normal'
        WHEN E5_MOTBX = 'DEV' THEN 'Devolução'
        WHEN E5_MOTBX = 'DAC' THEN 'Dação'
        WHEN E5_MOTBX = 'VEND' THEN 'Vendor'
        WHEN E5_MOTBX = 'DBCC' THEN 'Débito em Conta Corrente'
        WHEN E5_MOTBX = 'MPR' THEN 'Mais Prazo'
        ELSE 'Desconhecido'
    END AS MOTIVO_BAIXA,
    FI1_OCORB,
    -- Ocorrência no Arquivo de Retorno
    CASE 
        WHEN FI0_BCO = '001' THEN
            CASE 
                WHEN FI1_OCORB = '02' THEN 'Confirmação de Entrada de Boleto'
                WHEN FI1_OCORB = '03' THEN 'Comando recusado (Motivo indicado na posição 087/088)'
                WHEN FI1_OCORB = '05' THEN 'Liquidado sem registro (carteira 17-tipo4)'
                WHEN FI1_OCORB = '06' THEN 'Liquidação Normal'
                WHEN FI1_OCORB = '07' THEN 'Liquidação por Conta/Parcial'
                WHEN FI1_OCORB = '08' THEN 'Liquidação por Saldo'
                WHEN FI1_OCORB = '09' THEN 'Baixa de Título'
                WHEN FI1_OCORB = '10' THEN 'Baixa Solicitada'
                WHEN FI1_OCORB = '11' THEN 'Boletos em Ser'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Alteração de Vencimento do Boleto'
                WHEN FI1_OCORB = '15' THEN 'Liquidação em Cartório'
                WHEN FI1_OCORB = '16' THEN 'Confirmação de alteração de juros de mora'
                WHEN FI1_OCORB = '19' THEN 'Confirmação de recebimento de instruções para protesto'
                WHEN FI1_OCORB = '20' THEN 'Débito em Conta'
                WHEN FI1_OCORB = '21' THEN 'Alteração do Nome do Sacado'
                WHEN FI1_OCORB = '22' THEN 'Alteração do Endereço do Sacado'
                WHEN FI1_OCORB = '23' THEN 'Indicação de encaminhamento a cartório'
                WHEN FI1_OCORB = '24' THEN 'Sustar Protesto'
                WHEN FI1_OCORB = '25' THEN 'Dispensar Juros de Mora'
                WHEN FI1_OCORB = '26' THEN 'Alteração do número do boleto dado pelo Cedente'
                WHEN FI1_OCORB = '28' THEN 'Manutenção de título vencido'
                WHEN FI1_OCORB = '31' THEN 'Conceder desconto'
                WHEN FI1_OCORB = '32' THEN 'Não conceder desconto'
                WHEN FI1_OCORB = '33' THEN 'Retificar desconto'
                WHEN FI1_OCORB = '34' THEN 'Alterar data para desconto'
                WHEN FI1_OCORB = '35' THEN 'Cobrar Multa'
                WHEN FI1_OCORB = '36' THEN 'Dispensar Multa'
                WHEN FI1_OCORB = '37' THEN 'Dispensar Indexador'
                WHEN FI1_OCORB = '38' THEN 'Dispensar prazo limite para recebimento'
                WHEN FI1_OCORB = '39' THEN 'Alterar prazo limite para recebimento'
                WHEN FI1_OCORB = '41' THEN 'Alteração do número do controle do participante'
                WHEN FI1_OCORB = '42' THEN 'Alteração do número do documento do sacado (CNPJ/CPF)'
                WHEN FI1_OCORB = '44' THEN 'Boleto pago com cheque devolvido'
                WHEN FI1_OCORB = '46' THEN 'Boleto pago com cheque, aguardando compensação'
                WHEN FI1_OCORB = '47' THEN 'Alteração de valor nominal do boleto'
                WHEN FI1_OCORB = '61' THEN 'Registrado QR Code Pix'
                WHEN FI1_OCORB = '72' THEN 'Alteração de tipo de cobrança'
                WHEN FI1_OCORB = '73' THEN 'Confirmação de Instrução de Parâmetro de Pagamento Parcial'
                WHEN FI1_OCORB = '85' THEN 'Inclusão de Negativação'
                WHEN FI1_OCORB = '86' THEN 'Exclusão de Negativação'
                WHEN FI1_OCORB = '93' THEN 'Baixa Operacional'
                WHEN FI1_OCORB = '96' THEN 'Despesas de Protesto'
                WHEN FI1_OCORB = '97' THEN 'Despesas de Sustação de Protesto'
                WHEN FI1_OCORB = '98' THEN 'Débito de Custas Antecipadas'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '033' THEN
            CASE 
                WHEN FI1_OCORB = '02' THEN 'Entrada boleto Confirmada'
                WHEN FI1_OCORB = '03' THEN 'Entrada boleto Rejeitada'
                WHEN FI1_OCORB = '04' THEN 'Transferência para carteira Simples'
                WHEN FI1_OCORB = '05' THEN 'Transferência para Carteira Penhor/Desconto/Cessão'
                WHEN FI1_OCORB = '06' THEN 'Liquidação do Boleto Efetivada'
                WHEN FI1_OCORB = '07' THEN 'Liquidação por Conta'
                WHEN FI1_OCORB = '08' THEN 'Liquidação por Saldo'
                WHEN FI1_OCORB = '09' THEN 'Baixa Automática'
                WHEN FI1_OCORB = '10' THEN 'Boleto Baixado Conforme Instrução'
                WHEN FI1_OCORB = '11' THEN 'Boletos em carteira (em ser)'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Alteração de Vencimento'
                WHEN FI1_OCORB = '15' THEN 'Confirmação de Protesto'
                WHEN FI1_OCORB = '16' THEN 'Boleto Baixado/Liquidado'
                WHEN FI1_OCORB = '17' THEN 'Liquidado em Cartório'
                WHEN FI1_OCORB = '21' THEN 'Boleto Enviado a Cartório'
                WHEN FI1_OCORB = '22' THEN 'Boleto Retirado do Cartório'
                WHEN FI1_OCORB = '24' THEN 'Custas de Cartório'
                WHEN FI1_OCORB = '25' THEN 'Boleto Protestado'
                WHEN FI1_OCORB = '26' THEN 'Sustar Protesto'
                WHEN FI1_OCORB = '27' THEN 'Cancelar Boleto Protestado'
                WHEN FI1_OCORB = '35' THEN 'Boleto DDA Reconhecido pelo Pagador'
                WHEN FI1_OCORB = '36' THEN 'Boleto DDA Não Reconhecido pelo Pagador'
                WHEN FI1_OCORB = '37' THEN 'Boleto DDA Recusado pela PCR'
                WHEN FI1_OCORB = '38' THEN 'Não Protestar (antes de iniciar o ciclo de protesto)'
                WHEN FI1_OCORB = '39' THEN 'Espécie de Boleto não permite a instrução'
                WHEN FI1_OCORB = '61' THEN 'Confirmação de Alteração do Valor Nominal do Boleto'
                WHEN FI1_OCORB = '62' THEN 'Confirmação de Alteração do Valor ou Percentual mínimo'
                WHEN FI1_OCORB = '63' THEN 'Confirmação de Alteração do Valor ou Percentual máximo'
                WHEN FI1_OCORB = '93' THEN 'Pagamento do Boleto Recebido'
                WHEN FI1_OCORB = '94' THEN 'Cancelamento do Pagamento Recebido'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '237' THEN
            CASE
                WHEN FI1_OCORB = '02' THEN 'Entrada Confirmada (verificar motivo nas posições 319 a 328)'
                WHEN FI1_OCORB = '03' THEN 'Entrada Rejeitada (verificar motivo nas posições 319 a 328)'
                WHEN FI1_OCORB = '06' THEN 'Liquidação Normal (sem motivo)'
                WHEN FI1_OCORB = '07' THEN 'Conf. Exc. Cadastro Pagador Débito (verificar motivos nas posições 319 a 328)'
                WHEN FI1_OCORB = '08' THEN 'Rej. Ped. Exc. Cadastro de Pagador Débito (verificar motivos nas posições 319 a 328)'
                WHEN FI1_OCORB = '09' THEN 'Baixado Automat. via Arquivo (verificar motivo posições 319 a 328)'
                WHEN FI1_OCORB = '10' THEN 'Baixado conforme instruções da Agência (verificar motivo Pos.319 a 328)'
                WHEN FI1_OCORB = '11' THEN 'Em Ser - Arquivo de Títulos Pendentes'
                WHEN FI1_OCORB = '12' THEN 'Abatimento Concedido'
                WHEN FI1_OCORB = '13' THEN 'Abatimento Cancelado'
                WHEN FI1_OCORB = '14' THEN 'Vencimento Alterado'
                WHEN FI1_OCORB = '15' THEN 'Liquidação em Cartório (sem motivo)'
                WHEN FI1_OCORB = '16' THEN 'Título Pago em Cheque - Vinculado'
                WHEN FI1_OCORB = '17' THEN 'Liquidação após Baixa ou Título não Registrado (verificar motivo nas posições 319 a 328)'
                WHEN FI1_OCORB = '18' THEN 'Acerto de Depositária'
                WHEN FI1_OCORB = '19' THEN 'Confirmação Receb. Inst. de Protesto (verificar motivo pos.295 a 295)'
                WHEN FI1_OCORB = '20' THEN 'Confirmação Recebimento Instrução Sustação de Protesto'
                WHEN FI1_OCORB = '21' THEN 'Acerto do Controle do Participante'
                WHEN FI1_OCORB = '22' THEN 'Título com Pagamento Cancelado'
                WHEN FI1_OCORB = '23' THEN 'Entrada do Título em Cartório'
                WHEN FI1_OCORB = '24' THEN 'Entrada Rejeitada por CEP Irregular (verificar motivo pos.319 a 328)'
                WHEN FI1_OCORB = '25' THEN 'Confirmação Receb.Inst.de Protesto Falimentar (verificar pos.295 a 295)'
                WHEN FI1_OCORB = '27' THEN 'Baixa Rejeitada (verificar motivo posições 319 a 328)'
                WHEN FI1_OCORB = '28' THEN 'Débito de Tarifas/Custas (verificar motivo nas posições 319 a 328)'
                WHEN FI1_OCORB = '29' THEN 'Ocorrências do Pagador (verificar motivo nas posições 319 a 328)'
                WHEN FI1_OCORB = '30' THEN 'Alteração de Outros Dados Rejeitados (verificar motivo Pos.319 a 328)'
                WHEN FI1_OCORB = '31' THEN 'Confirmado Inclusão Cadastro Pagador'
                WHEN FI1_OCORB = '32' THEN 'Instrução Rejeitada (verificar motivo posições 319 a 328)'
                WHEN FI1_OCORB = '33' THEN 'Confirmação Pedido Alteração Outros Dados'
                WHEN FI1_OCORB = '34' THEN 'Retirado de Cartório e Manutenção Carteira'
                WHEN FI1_OCORB = '35' THEN 'Cancelamento do Agendamento do Débito Automático (verificar motivos pos. 319 a 328)'
                WHEN FI1_OCORB = '37' THEN 'Rejeitado Inclusão Cadastro Pagador (verificar motivos nas posições 319 a 328)'
                WHEN FI1_OCORB = '38' THEN 'Confirmado Alteração Pagador'
                WHEN FI1_OCORB = '39' THEN 'Rejeitado Alteração Cadastro Pagador (verificar motivos nas posições 319 a 328)'
                WHEN FI1_OCORB = '40' THEN 'Estorno de Pagamento'
                WHEN FI1_OCORB = '55' THEN 'Sustado Judicial'
                WHEN FI1_OCORB = '66' THEN 'Título Baixado por Pagamento via Pix'
                WHEN FI1_OCORB = '68' THEN 'Acerto dos Dados do Rateio de Crédito (verificar motivo posição de status do registro Tipo 3)'
                WHEN FI1_OCORB = '69' THEN 'Cancelamento de Rateio (verificar motivo posição de status do registro Tipo 3)'
                WHEN FI1_OCORB = '73' THEN 'Confirmação Receb. Pedido de Negativação'
                WHEN FI1_OCORB = '74' THEN 'Confir Pedido de Excl de Negat (com ou sem baixa)'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '341' THEN
            CASE
                WHEN FI1_OCORB = '03' THEN 'ENTRADA REJEITADA (NOTA 20 – TABELA 1)'
                WHEN FI1_OCORB = '04' THEN 'ALTERAÇÃO DE DADOS – NOVA ENTRADA OU ALTERAÇÃO/EXCLUSÃO DE DADOS ACATADA'
                WHEN FI1_OCORB = '05' THEN 'ALTERAÇÃO DE DADOS – BAIXA'
                WHEN FI1_OCORB = '06' THEN 'LIQUIDAÇÃO NORMAL'
                WHEN FI1_OCORB = '07' THEN 'LIQUIDAÇÃO PARCIAL – COBRANÇA INTELIGENTE (B2B)'
                WHEN FI1_OCORB = '08' THEN 'LIQUIDAÇÃO EM CARTÓRIO'
                WHEN FI1_OCORB = '09' THEN 'BAIXA SIMPLES'
                WHEN FI1_OCORB = '10' THEN 'BAIXA POR TER SIDO LIQUIDADO'
                WHEN FI1_OCORB = '11' THEN 'EM SER (SÓ NO RETORNO MENSAL)'
                WHEN FI1_OCORB = '12' THEN 'ABATIMENTO CONCEDIDO'
                WHEN FI1_OCORB = '13' THEN 'ABATIMENTO CANCELADO'
                WHEN FI1_OCORB = '14' THEN 'VENCIMENTO ALTERADO'
                WHEN FI1_OCORB = '15' THEN 'BAIXAS REJEITADAS (NOTA 20 – TABELA 4)'
                WHEN FI1_OCORB = '16' THEN 'INSTRUÇÕES REJEITADAS (NOTA 20 – TABELA 3)'
                WHEN FI1_OCORB = '17' THEN 'ALTERAÇÃO/EXCLUSÃO DE DADOS REJEITADOS (NOTA 20 – TABELA 2)'
                WHEN FI1_OCORB = '18' THEN 'COBRANÇA CONTRATUAL – INSTRUÇÕES/ALTERAÇÕES REJEITADAS/PENDENTES (NOTA 20 – TABELA 5)'
                WHEN FI1_OCORB = '19' THEN 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE PROTESTO'
                WHEN FI1_OCORB = '20' THEN 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE SUSTAÇÃO DE PROTESTO /TARIFA'
                WHEN FI1_OCORB = '21' THEN 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO DE NÃO PROTESTAR'
                WHEN FI1_OCORB = '23' THEN 'TÍTULO ENVIADO A CARTÓRIO/TARIFA'
                WHEN FI1_OCORB = '24' THEN 'INSTRUÇÃO DE PROTESTO REJEITADA / SUSTADA / PENDENTE (NOTA 20 – TABELA 7)'
                WHEN FI1_OCORB = '25' THEN 'ALEGAÇÕES DO PAGADOR (NOTA 20 – TABELA 6)'
                WHEN FI1_OCORB = '26' THEN 'TARIFA DE AVISO DE COBRANÇA'
                WHEN FI1_OCORB = '27' THEN 'TARIFA DE EXTRATO POSIÇÃO (B40X)'
                WHEN FI1_OCORB = '28' THEN 'TARIFA DE RELAÇÃO DAS LIQUIDAÇÕES'
                WHEN FI1_OCORB = '29' THEN 'TARIFA DE MANUTENÇÃO DE TÍTULOS VENCIDOS'
                WHEN FI1_OCORB = '30' THEN 'DÉBITO MENSAL DE TARIFAS (PARA ENTRADAS E BAIXAS)'
                WHEN FI1_OCORB = '32' THEN 'BAIXA POR TER SIDO PROTESTADO'
                WHEN FI1_OCORB = '33' THEN 'CUSTAS DE PROTESTO'
                WHEN FI1_OCORB = '34' THEN 'CUSTAS DE SUSTAÇÃO'
                WHEN FI1_OCORB = '35' THEN 'CUSTAS DE CARTÓRIO DISTRIBUIDOR'
                WHEN FI1_OCORB = '36' THEN 'CUSTAS DE EDITAL'
                WHEN FI1_OCORB = '37' THEN 'TARIFA DE EMISSÃO DE BOLETO/TARIFA DE ENVIO DE DUPLICATA'
                WHEN FI1_OCORB = '38' THEN 'TARIFA DE INSTRUÇÃO'
                WHEN FI1_OCORB = '39' THEN 'TARIFA DE OCORRÊNCIAS'
                WHEN FI1_OCORB = '40' THEN 'TARIFA MENSAL DE EMISSÃO DE BOLETO/TARIFA MENSAL DE ENVIO DE DUPLICATA'
                WHEN FI1_OCORB = '41' THEN 'DÉBITO MENSAL DE TARIFAS – EXTRATO DE POSIÇÃO (B4EP/B4OX)'
                WHEN FI1_OCORB = '42' THEN 'DÉBITO MENSAL DE TARIFAS – OUTRAS INSTRUÇÕES'
                WHEN FI1_OCORB = '43' THEN 'DÉBITO MENSAL DE TARIFAS – MANUTENÇÃO DE TÍTULOS VENCIDOS'
                WHEN FI1_OCORB = '44' THEN 'DÉBITO MENSAL DE TARIFAS – OUTRAS OCORRÊNCIAS'
                WHEN FI1_OCORB = '45' THEN 'DÉBITO MENSAL DE TARIFAS – PROTESTO'
                WHEN FI1_OCORB = '46' THEN 'DÉBITO MENSAL DE TARIFAS – SUSTAÇÃO DE PROTESTO'
                WHEN FI1_OCORB = '47' THEN 'BAIXA COM TRANSFERÊNCIA PARA DESCONTO'
                WHEN FI1_OCORB = '48' THEN 'CUSTAS DE SUSTAÇÃO JUDICIAL'
                WHEN FI1_OCORB = '51' THEN 'TARIFA MENSAL REF A ENTRADAS BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '52' THEN 'TARIFA MENSAL BAIXAS NA CARTEIRA'
                WHEN FI1_OCORB = '53' THEN 'TARIFA MENSAL BAIXAS EM BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '54' THEN 'TARIFA MENSAL DE LIQUIDAÇÕES NA CARTEIRA'
                WHEN FI1_OCORB = '55' THEN 'TARIFA MENSAL DE LIQUIDAÇÕES EM BANCOS CORRESPONDENTES NA CARTEIRA'
                WHEN FI1_OCORB = '56' THEN 'CUSTAS DE IRREGULARIDADE'
                WHEN FI1_OCORB = '57' THEN 'INSTRUÇÃO CANCELADA (NOTA 20 – TABELA 8)'
                WHEN FI1_OCORB = '59' THEN 'BAIXA POR CRÉDITO EM C/C ATRAVÉS DO SISPAG'
                WHEN FI1_OCORB = '60' THEN 'ENTRADA REJEITADA CARNÊ (NOTA 20 – TABELA 1)'
                WHEN FI1_OCORB = '61' THEN 'TARIFA EMISSÃO AVISO DE MOVIMENTAÇÃO DE TÍTULOS (2154)'
                WHEN FI1_OCORB = '62' THEN 'DÉBITO MENSAL DE TARIFA – AVISO DE MOVIMENTAÇÃO DE TÍTULOS (2154)'
                WHEN FI1_OCORB = '63' THEN 'TÍTULO SUSTADO JUDICIALMENTE'
                WHEN FI1_OCORB = '64' THEN 'ENTRADA CONFIRMADA COM RATEIO DE CRÉDITO'
                WHEN FI1_OCORB = '65' THEN 'PAGAMENTO COM CHEQUE – AGUARDANDO COMPENSAÇÃO'
                WHEN FI1_OCORB = '69' THEN 'CHEQUE DEVOLVIDO (NOTA 20 – TABELA 9)'
                WHEN FI1_OCORB = '71' THEN 'ENTRADA REGISTRADA, AGUARDANDO AVALIAÇÃO'
                WHEN FI1_OCORB = '72' THEN 'BAIXA POR CRÉDITO EM C/C ATRAVÉS DO SISPAG SEM TÍTULO CORRESPONDENTE'
                WHEN FI1_OCORB = '73' THEN 'CONFIRMAÇÃO DE ENTRADA NA COBRANÇA SIMPLES – ENTRADA NÃO ACEITA NA COBRANÇA CONTRATUAL'
                WHEN FI1_OCORB = '74' THEN 'INSTRUÇÃO DE NEGATIVAÇÃO EXPRESSA REJEITADA (NOTA 20 – TABELA 11)'
                WHEN FI1_OCORB = '75' THEN 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA'
                WHEN FI1_OCORB = '76' THEN 'CHEQUE COMPENSADO'
                WHEN FI1_OCORB = '77' THEN 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA'
                WHEN FI1_OCORB = '78' THEN 'CONFIRMAÇÃO DE RECEBIMENTO DE INSTRUÇÃO DE CANCELAMENTO DE NEGATIVAÇÃO EXPRESSA'
                WHEN FI1_OCORB = '79' THEN 'NEGATIVAÇÃO EXPRESSA INFORMACIONAL (NOTA 20 – TABELA 12)'
                WHEN FI1_OCORB = '80' THEN 'CONFIRMAÇÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA – TARIFA'
                WHEN FI1_OCORB = '82' THEN 'CONFIRMAÇÃO DO CANCELAMENTO DE NEGATIVAÇÃO EXPRESSA – TARIFA'
                WHEN FI1_OCORB = '83' THEN 'CONFIRMAÇÃO DE EXCLUSÃO DE ENTRADA EM NEGATIVAÇÃO EXPRESSA POR LIQUIDAÇÃO – TARIFA'
                WHEN FI1_OCORB = '85' THEN 'TARIFA POR BOLETO (ATÉ 03 ENVIOS) COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '86' THEN 'TARIFA EMAIL COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '87' THEN 'TARIFA SMS COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '88' THEN 'TARIFA MENSAL POR BOLETO (ATÉ 03 ENVIOS) COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '89' THEN 'TARIFA MENSAL EMAIL COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '90' THEN 'TARIFA MENSAL SMS COBRANÇA ATIVA ELETRÔNICA'
                WHEN FI1_OCORB = '91' THEN 'TARIFA MENSAL DE EXCLUSÃO DE ENTRADA DE NEGATIVAÇÃO EXPRESSA'
                WHEN FI1_OCORB = '92' THEN 'TARIFA MENSAL DE CANCELAMENTO DE NEGATIVAÇÃO EXPRESSA'
                WHEN FI1_OCORB = '93' THEN 'TARIFA MENSAL DE EXCLUSÃO DE NEGATIVAÇÃO EXPRESSA POR LIQUIDAÇÃO'
                ELSE 'Desconhecido'
            END
        WHEN FI0_BCO = '422' THEN
            CASE
                WHEN FI1_OCORB = '02' THEN 'ENTRADA CONFIRMADA'
                WHEN FI1_OCORB = '03' THEN 'ENTRADA REJEITADA'
                WHEN FI1_OCORB = '04' THEN 'TRANSFERÊNCIA DE CARTEIRA (ENTRADA)'
                WHEN FI1_OCORB = '05' THEN 'TRANSFERÊNCIA DE CARTEIRA (BAIXA)'
                WHEN FI1_OCORB = '06' THEN 'LIQUIDAÇÃO NORMAL'
                WHEN FI1_OCORB = '09' THEN 'BAIXADO AUTOMATICAMENTE'
                WHEN FI1_OCORB = '10' THEN 'BAIXADO CONFORME INSTRUÇÕES'
                WHEN FI1_OCORB = '11' THEN 'TÍTULOS EM SER (PARA ARQUIVO MENSAL)'
                WHEN FI1_OCORB = '12' THEN 'ABATIMENTO CONCEDIDO'
                WHEN FI1_OCORB = '13' THEN 'ABATIMENTO CANCELADO'
                WHEN FI1_OCORB = '14' THEN 'VENCIMENTO ALTERADO'
                WHEN FI1_OCORB = '15' THEN 'LIQUIDAÇÃO EM CARTÓRIO'
                WHEN FI1_OCORB = '19' THEN 'CONFIRMAÇÃO DE INSTRUÇÃO DE PROTESTO'
                WHEN FI1_OCORB = '20' THEN 'CONFIRMAÇÃO DE SUSTAR PROTESTO'
                WHEN FI1_OCORB = '21' THEN 'TRANSFERÊNCIA DE BENEFICIÁRIO'
                WHEN FI1_OCORB = '23' THEN 'TÍTULO ENVIADO A CARTÓRIO'
                WHEN FI1_OCORB = '40' THEN 'BAIXA DE TÍTULO PROTESTADO'
                WHEN FI1_OCORB = '41' THEN 'LIQUIDAÇÃO DE TÍTULO BAIXADO'
                WHEN FI1_OCORB = '42' THEN 'TÍTULO RETIRADO DO CARTÓRIO'
                WHEN FI1_OCORB = '43' THEN 'DESPESA DE CARTÓRIO'
                WHEN FI1_OCORB = '44' THEN 'ACEITE DO TÍTULO DOA PELO PAGADOR'
                WHEN FI1_OCORB = '45' THEN 'NÃO ACEITE DO TÍTULO DOA PELO PAGADOR'
                WHEN FI1_OCORB = '51' THEN 'VALOR DO TÍTULO ALTERADO'
                WHEN FI1_OCORB = '52' THEN 'ACERTO DE DATA DE EMISSÃO'
                WHEN FI1_OCORB = '53' THEN 'ACERTO DE CÓDIGO ESPÉCIE DO DOCUMENTO'
                WHEN FI1_OCORB = '54' THEN 'ALTERAÇÃO DE SEU NÚMERO'
                WHEN FI1_OCORB = '56' THEN 'INSTRUÇÃO NEGATIVAÇÃO ACEITA'
                WHEN FI1_OCORB = '57' THEN 'INSTRUÇÃO BAIXA DE NEGATIVAÇÃO ACEITA'
                WHEN FI1_OCORB = '58' THEN 'INSTRUÇÃO NÃO NEGATIVAR ACEITA'
                ELSE 'Desconhecido'
            END
        ELSE
            'Banco não identificado'
    END AS Ocorrencia_Arquivo_Retorno,
    FI1_OCORS,
    -- Tipo de Instrução
    CASE 
        WHEN EB_TIPO = 'R' THEN 'Retorno'
        WHEN EB_TIPO = 'P' THEN 'Contas a pagar'
        WHEN EB_TIPO = 'E' THEN 'Envio'
        WHEN EB_TIPO = 'D' THEN 'DDA'
        ELSE 'Desconhecido'
    END AS TIPO_INSTRUCAO
FROM 
    SE1010 SE1 With(Nolock)
    LEFT JOIN SE5010 SE5 With(Nolock) -- Mov. Bancária
        ON E5_FILIAL = E1_FILIAL
            AND E5_CLIFOR = E1_CLIENTE
            AND E5_LOJA = E1_LOJA
            AND E5_TIPO = E1_TIPO 
            AND E5_NUMERO = E1_NUM
            AND E5_PARCELA = E1_PARCELA
            AND E5_PREFIXO = E1_PREFIXO 
            AND SE5.D_E_L_E_T_ = ''
    LEFT JOIN FI0010 FI0 With(Nolock) -- Cabeçalho Log Processamento CNAB
        ON FI0_FILIAL = '01'
            AND FI0_LOTE = E5_LOTE
            AND FI0.D_E_L_E_T_ = ''
    LEFT JOIN FI1010 FI1 With(Nolock) -- Detalhe do Log Processamento
        ON FI1_FILIAL = FI0_FILIAL 
            AND FI1_IDARQ = FI0_IDARQ
            AND FI1_IDTIT = E1_IDCNAB
            AND FI1.D_E_L_E_T_ = ''
    LEFT JOIN FRV010 FRV With(Nolock) -- Situação Cobrança - FINA022
        ON FRV_FILIAL = ''
            AND FRV_CODIGO = E1_SITUACA
            AND FRV.D_E_L_E_T_ = ''
    LEFT JOIN SEE010 SEE With(Nolock) -- Comunicação Bancária 
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
    LEFT JOIN SEB010 SEB With(Nolock) -- Ocorrências da Transmissão Bancária
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

--Existem seis motivos padrões de baixa de títulos a pagar:
--Normal (NOR): títulos de pagamentos normais. Atualiza automaticamente a movimentação bancária, caso tenha sido gerado cheque para o título.
--Devolução (DEV): recebimentos referentes a devoluções. Não atualiza a movimentação bancária.
--Dação (DAC): ocorre quando algo é oferecido como pagamento de outro. Não atualiza a movimentação bancária.
--Vendor (VEND):pagamento de título via empréstimo bancário. O Banco passa a ser o beneficiário, porém, é necessário que a empresa possua um contrato bancário cadastrado para possibilitar este empréstimo. Atualiza automaticamente a movimentação bancária.
--Débito CC: debita automaticamente a movimentação bancária sem a necessidade de gerar cheque sobre o título.
--Mais Prazo (MPR ou conforme parâmetro MV_MBXTECF): Utilizado na Integração com TOTVS Mais Prazo. Utilizado na carteira a pagar. Não movimenta saldo bancário, não considera cálculo

--FI1_OCORB	Ocor.Arq.Ret	Ocorrencia Arq Retorno	
--FI1_OCORS	Ocorr. Sist.	Ocorrencia no sistema



--EB_REFBAN	Ocorr Banco	Codigo Ocorrencia Banco
--EB_TIPO	Tipo	Envio ou Retorno --E=Envio;R=Retorno;P=Contas a Pagar;D=DDA
--EB_OCORR	Ocorr Sist.	Codigo Ocorrencia Sistema	
--EB_DESCRI	Descricao	Descricao da Ocorrencia
