-- VIEW que traz as informações do empreendimento

CREATE VIEW TodasInformacoesEmpreendimento AS
SELECT
    e.*, -- Selecionar todas as colunas da tabela "Empreendimento"
    oe.nome AS OpcaoEntrega,  -- Selecionar o nome da tabela "OpcoesEntrega"
    op.nome AS OpcaoPagamento -- Selecionar o nome da tabela "OpcoesPagamento"
FROM
    projeto.Empreendimento AS e
LEFT JOIN -- Realizar um LEFT JOIN com a tabela "EmpreendimentoOpcoesEntrega" usando a coluna "id" do empreendimento
    projeto.EmpreendimentoOpcoesEntrega AS eoe ON e.id = eoe.empreendimento_id
LEFT JOIN -- Realizar um LEFT JOIN com a tabela "OpcoesEntrega" usando a coluna "opcao_entrega_id" da tabela "EmpreendimentoOpcoesEntrega"
    projeto.OpcoesEntrega AS oe ON eoe.opcao_entrega_id = oe.id
LEFT JOIN -- Realizar um LEFT JOIN com a tabela "EmpreendimentoOpcoesPagamento" usando a coluna "id" do empreendimento
    projeto.EmpreendimentoOpcoesPagamento AS eop ON e.id = eop.empreendimento_id
LEFT JOIN -- Realizar um LEFT JOIN com a tabela "OpcoesPagamento" usando a coluna "opcao_pagamento_id" da tabela "EmpreendimentoOpcoesPagamento"
    projeto.OpcoesPagamento AS op ON eop.opcao_pagamento_id = op.id;

-- excluir uma view
DROP VIEW nomedaview;

-- traz a inforamção da view
select * from TodasInformacoesEmpreendimento



-- informa as view do banco projetotodasinformacoesempreendimento
SHOW FULL TABLES IN projeto WHERE TABLE_TYPE LIKE 'VIEW';