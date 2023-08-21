DELIMITER $$
CREATE FUNCTION VerificarFuncionamento(id_empreendimento INT, horario_atual TIME)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE horario_inicio TIME;
    DECLARE horario_fim TIME;
    DECLARE horarios VARCHAR(100);
    
    -- Obtém o horário de atendimento da tabela empreendimento
    SELECT horario_atendimento INTO horarios -- com INTO armazena o resultado em horarios
    FROM empreendimento
    WHERE id = id_empreendimento;

    -- Extrai o horário de início e fim
    SET horario_inicio = CAST(SUBSTRING_INDEX(horarios, ' às ', 1) AS TIME);
    SET horario_fim = CAST(SUBSTRING_INDEX(horarios, ' às ', -1) AS TIME);

    -- Verifica se o horário atual está dentro do horário de funcionamento
    IF horario_atual BETWEEN horario_inicio AND horario_fim THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END $$
DELIMITER ;



SELECT nome, endereco, horario_atendimento
FROM empreendimento
WHERE VerificarFuncionamento(id, NOW()) = TRUE;


SHOW COLUMNS FROM empreendimento;

drop function VerificarFuncionamento
