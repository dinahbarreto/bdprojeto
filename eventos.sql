-- verifica se o gerador de eventos está ativo
SHOW VARIABLES LIKE 'event%'

-- se tiver off, ativar com o comando abaixo
SET GLOBAL event_scheduler = ON

/*===
SINTAXE BASICA:

CREATE EVENT event_name
    ON SCHEDULE schedule
    [ON COMPLETION [NOT] PRESERVE] -- não guarda os logs do evento
    [ENABLE | DISABLE | DISABLE ON SLAVE] -- replica para outros servidores
    [COMMENT 'string']
    DO event_body;

schedule: {
    AT timestamp [+ INTERVAL interval] ...
  | EVERY interval
    [STARTS timestamp [+ INTERVAL interval] ...] -- dia
    [ENDS timestamp [+ INTERVAL interval] ...] -- hora
}

interval:
    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
              WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
              DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}
===*/

-- ver os eventos  
SHOW EVENTS; 
SHOW EVENTS FROM bancox;

-- um evento que insere um novo empreendimento a cada 24 horas
DELIMITER $$

CREATE EVENT InserirNovoEmpreendimento -- nome do evento
ON SCHEDULE EVERY 1 DAY -- período que será realizado
STARTS CURRENT_TIMESTAMP -- começara a partir de agora
DO
BEGIN
    -- Insira o novo empreendimento na tabela Empreendimento
    INSERT INTO Empreendimento (nome, telefone, endereco, cep, horario_atendimento, aberto_24h) -- onde sera adicionado os valores
    VALUES (
        CONCAT('Novo Empreendimento ', (SELECT COUNT(*) + 1 FROM Empreendimento)), -- string concatenando várias partes e incrementa +1 a cada valores
        '(11) 1234-5678',
        'Novo Endereço',
        '12345-6789',
        '08h - 20h',
        FALSE
    );
END $$

DELIMITER ;

-- Ver os eventos criados no banco
SHOW EVENTS FROM projeto; 

-- desabilitar um evento 
ALTER EVENT nomedoevento
    DISABLE;
    
-- habiliar o evento
ALTER EVENT nomedoevento
   ENABLE;

-- alterar nome de evento
ALTER EVENT nomedoevento
    RENAME TO nomenovo;

-- deletar EVENTOSd
drop  EVENT if exists nomedoevento;

-- Altera a programação do evento para ser executado a cada 48 horas
ALTER EVENT InserirNovoEmpreendimento
ON SCHEDULE EVERY 2 DAY   -- Altera para "EVERY 2 DAY" para executar a cada 48 horas

-- Altera o código interno do evento para uma nova lógica de inserção
ALTER EVENT InserirNovoEmpreendimento
DO
BEGIN
    -- Nova lógica de inserção aqui
    -- Por exemplo:
    -- INSERT INTO Empreendimento (nome, telefone, endereco, cep, horario_atendimento, aberto_24h)
    -- VALUES ('Novo Empreendimento Personalizado', '(11) 1234-5678', 'Novo Endereço Personalizado', '12345-6789', '08h - 20h', FALSE);
END;



