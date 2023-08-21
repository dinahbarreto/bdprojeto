-- trigger usada para update na tabela empreendimento
DELIMITER $$

-- Criação da tabela de auditoria
CREATE TABLE TabelaAuditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME,
    usuario VARCHAR(255),
    acao VARCHAR(255)
);

INSERT INTO TabelaAuditoria (usuario, acao, data)
VALUES ('dinah', 'Atualização', NOW()), 
       ('lais', 'Atualização', NOW()), 
       ('lucas', 'Atualização', NOW()), 
       ('renato', 'Atualização', NOW()), 
       ('lupita', 'Atualização', NOW());

INSERT INTO TabelaAuditoria (usuario, acao, data)
VALUES ('root', 'Atualização', NOW());


DELIMITER $$

-- Criação do gatilho
CREATE TRIGGER audit_update_trigger
AFTER UPDATE ON empreendimento
FOR EACH ROW
BEGIN
    -- Verifica se o nome de usuário foi fornecido na atualização
    IF NEW.usuario IS NOT NULL THEN
        -- Registra a ação na tabela de auditoria com o nome de usuário fornecido
        INSERT INTO TabelaAuditoria (acao, usuario, data)
        VALUES ('Atualização realizada', NEW.usuario, NOW());
    END IF;
END $$

DELIMITER ;

-- verifica trigger criada
show triggers;

-- para validar a trigger
UPDATE empreendimento
SET numero_endereco = 40
WHERE id = 1;

select * from empreendimento;

SELECT * FROM TabelaAuditoria;


