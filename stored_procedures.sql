-- criar procedure
-- Normalmente usado para executar uma série de ações no banco de dados, como atualizações, inserções, exclusões, etc.

-- Procedimento para excluir um emprendimento pelo ID
DELIMITER $$
CREATE PROCEDURE ExcluirEmpreendimentoPorID (
    IN idEmpreendimento INT
)
BEGIN
    DELETE FROM Empreendimento
    WHERE id = idEmpreendimento;
END $$
DELIMITER ;

-- como executar o procedimento
CALL ExcluirEmpreendimentoPorID (numid);

-- apagar um procedimento
DROP PROCEDURE IF EXISTS nomedoprocedimento; 

DELIMITER $$

-- procedimento que traz o nome do empreendimento mais o timpo de pagamento
CREATE PROCEDURE ObterNomeEmpreendimentoETipoPagamento()
BEGIN
    -- Declare as variáveis que serão usadas para armazenar os resultados
    DECLARE done INT DEFAULT FALSE; -- para executar o loop
    DECLARE nomeEmpreendimento VARCHAR(255);
    DECLARE tipoPagamento VARCHAR(50);
    
    -- Declare o cursor para percorrer os registros
/*=== Um cursor é uma estrutura de controle que permite iterar (percorrer) os resultados de uma consulta SQL, como se fosse um loop, 
permitindo o processamento linha por linha dos resultados.
===*/
    DECLARE cur CURSOR FOR -- nome do curso será cur
        SELECT e.nome AS NomeEmpreendimento, op.nome AS TipoPagamento -- cursos fara um join entre as tabelas "emprendimento" e "opcoespagamento" selecionando os nomes
        FROM projeto.Empreendimento AS e --
        LEFT JOIN projeto.EmpreendimentoOpcoesPagamento AS eop ON e.id = eop.empreendimento_id -- realiza a junção da tabela 'empreendimentoopcoespagamento com a tabela empreendimento usando a coluna "e.id" da tabela "empreendimento"
        LEFT JOIN projeto.OpcoesPagamento AS op ON eop.opcao_pagamento_id = op.id; -- realiza a junção da tabela 'OpcoesPagamento' com 'EmpreendimentoOpcoesPagamento' usando a coluna eop.opcao_pagamento_id da tabela 'OpcoesPagamento'
    
    -- Indique que nenhum registro foi processado ainda
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; -- declarando o curso Handler (manipulador), que fará com que o done fique true quando não tiver mais registro para pecorrer e o curso para com as execuções
    
    -- Inicialize o cursor
    OPEN cur; -- cursor declarado, agora será iniciado
    
    -- Inicie um loop para percorrer os registros
    read_loop: LOOP -- read rotula o loop, caso precuse ser futuramente
    
        -- Obtenha os valores do cursor
        FETCH cur INTO nomeEmpreendimento, tipoPagamento; 
        
        -- Verifique se o loop deve ser encerrado
        IF done THEN -- nesse caso o done ja é verdadeiro, o loop parará 
            LEAVE read_loop; -- do contrário continuara
        END IF;
        
        -- Exibe o resultado
        SELECT nomeEmpreendimento, tipoPagamento;
    END LOOP;
    
    -- Fecha o cursor
    CLOSE cur;
END $$
DELIMITER ;

CALL ObterNomeEmpreendimentoETipoPagamento(); -- chama a procedures

-- dando privilégio há um usuário para criar a procedures
GRANT EXECUTE ON PROCEDURE nome_do_procedimento TO 'usuario';




