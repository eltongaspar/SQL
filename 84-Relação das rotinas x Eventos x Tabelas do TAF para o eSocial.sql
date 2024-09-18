--Relação das rotinas x Eventos x Tabelas do TAF para o eSocial
--Relação importante para análise de um eventual compartilhamento de tabelas dentro do TAF, antes de uma implantação. Este compartilhamento é indicado dependendo do cenário do cliente e dos movimentos serem compartilhados ou não entre as filiais do mesmo grupo de empresa.



--Importante: Os casos de compartilhamentos são delicados e devem ser avaliados com critério, já que impactam na entrega das obrigações e níveis de isolamento das informações por usuário.



--ROTINA       EVENTO   TABELAS DO BANCO DE DADOS
/*
TAFA050 => S-1000 => C1E, C1F, CR9, CRM, CUW, CZR
TAFA253 => S-1005 => C92, T0Z
TAFA232 => S-1010 => C8R, T5N, C1G
TAFA246 => S-1020 => C99, T03, C1G
TAFA235 => S-1030 => C8V, T10, T11
TAFA467 => S-1035 => T5K
TAFA236 => S-1040 => C8X
TAFA238 => S-1050 => C90, CRL
TAFA389 => S-1060 => T04, T09
TAFA051 => S-1070 => C1G, T5L
TAFA248 => S-1080 => C8W
TAFA250 => S-1200 => C91, T6W, CRN, C1G, T14, C9K, C9L, C9M, T6Y, T6Z, C9N, C9O, C9P, C9Q, C9R, C9V
TAFA413 => S-1202 => C91, C9Y, CRN, C1G, T14, T6C, T6D, C8R, T6E, T6F, T6G, T61, T6H, T6I, T6J, T6K, C9V
TAFA470 => S-1207 => T62, T63, T5T, C8R, T6O
TAFA407 => S-1210 => T3P, T3Q, T3R , LE2, LE3, LE4, T6P, T6Q, T6R, T5V, T5U, T5Y, T5Z, T5X, T5Z, T3Q
TAFA272 => S-1250 => CMR, CMS, CMT, CMU, CMV, T1Z
TAFA414 => S-1260 => T1M, T1N, T1O, T1P, T6B
TAFA408 => S-1270 => T2A, T1Y
TAFA410 => S-1280 => T3V, T3X
TAFA477 => S-1295 => T72
TAFA416 => S-1298 => T1S
TAFA303 => S-1299 => CUO
TAFA412 => S-1300 => T3Z, T2L
TAFA403 => S-2190 => T3A
TAFA278 => S-2200 => C9V, C9Y, CUP, CRQ, T3L, T80, T90
TAFA275 => S-2205 => T1U, T3T
TAFA276 => S-2206 => T1V, T79
TAFA257 => S-2210 => CM0, CM1, CM2, CM7, C9V
TAFA258 => S-2220 => C8B, C9W, CM7, CRP, C9V
TAFA528 => S-2221 => V3B, C9V
TAFA261 => S-2230 => CM6, CM7, T6M, C9V
TAFA264 => S-2240 => CM9, T0Q, CMA, LEA, LEB, CMB, CM9, T3S, V3E, C9V
TAFA404 => S-2241 => T3B, T3C, T3D, T3N, T3O, C9V
TAFA529 => S-2245 => V3C, V3G, C9V, C87
TAFA263 => S-2250 => CM8, C9V
TAFA484 => S-2260 => T87, C9V
TAFA267 => S-2298 => CMF, C9V
TAFA266 => S-2299 => CMD, T06, T05, T15, T16, T3G, T5I, T5J, T3G, T5S, T5Q, T3H, C9J, T88, C9V
TAFA279 => S-2300 => CUU, T2F, C9V
TAFA277 => S-2306 => T0F
TAFA280 => S-2399 => CUU, T92, T3I, T3J, CMK, T15, T16, T3H, C9J, C9V
TAFA469 => S-2400 => T5T
TAFA269 => S-3000 => CMJ
TAFA423 => S-5001 => T2M, T2N, T2O, T2P, T2Q, T2R, T2S
TAFA422 => S-5002 => T2G, T2H, T2I, T2J
TAFA520 => S-5003 => V2P, V2Q, V2R, V2S, V2T, V2U, V2V, V2W, V2X, V2Y
TAFA425 => S-5011 => T2V, T2X, T2Y, T0E, T2Z, T0A, T70, T0B, T0C, T0D
TAFA426 => S-5012 => T0G, T0H
TAFA521 => S-5013 => V2Z, V20, V21, V22, V23, V24, V25


Relação de tabelas auxiliares
TAFST1	Integração	Armazena as informações do sistema de origem que serão integradas no TAF. Esta tabela pertence fisicamente ao banco de dados do sistema origem das informações ( Pode ser o mesmo banco de dados onde se localiza o TAF ).
TAFST2	Integração	Recebe as informações da tabela TAFST1 no processo de integração. Esta tabela pertence fisicamente ao banco de dados do TAF ( Pode ser o mesmo banco onde se localiza o sistema de origem das informações ).
TAFGERCTL	Obrigações Acessórias	Indica o status dos processamentos das obrigações acessórias.
TAFSPED_XX	SPED Fiscal	Armazena as informações que serão geradas no arquivo do SPED Fiscal. Esta tabela é criada com a nomenclatura TAFSPED_XX, onde XX representa o Grupo de Empresas.
TAFECF_XX	ECF	Armazena as informações que serão geradas no arquivo da ECF. Esta tabela é criada com a nomenclatura TAFECF_XX, onde XX representa o Grupo de Empresas.