CREATE DATABASE projeto;

USE  projeto;

CREATE TABLE Empreendimento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    numero_endereco INT,
    complemento_endereco VARCHAR(20),
    cep VARCHAR(10),
    horario_atendimento VARCHAR(100),
    aberto_24h BOOLEAN
);

CREATE TABLE OpcoesEntrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL -- Nome da opção de entrega (não pode ser nulo).
);

CREATE TABLE EmpreendimentoOpcoesEntrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empreendimento_id INT NOT NULL, -- ID do empreendimento.
    opcao_entrega_id INT NOT NULL, -- ID da opção de entrega.
    FOREIGN KEY (empreendimento_id) REFERENCES Empreendimento(id),
    FOREIGN KEY (opcao_entrega_id) REFERENCES OpcoesEntrega(id)
);
/* FOREIGN KEY (empreendimento_id) REFERENCES Empreendimento(id):
FOREIGN KEY (empreendimento_id): Isso indica que a coluna empreendimento_id na tabela atual (no exemplo, "EmpreendimentoOpcoesEntrega") é uma chave estrangeira que está relacionada a outra tabela.
REFERENCES Empreendimento(id): Isso especifica a tabela de destino da relação. Neste caso, a coluna empreendimento_id na tabela atual faz referência à coluna id na tabela "Empreendimento".*/

/* FOREIGN KEY (opcao_entrega_id) REFERENCES OpcoesEntrega(id)
FOREIGN KEY (opcao_entrega_id): Similar à explicação anterior, isso indica que a coluna opcao_entrega_id na tabela atual (no exemplo, "EmpreendimentoOpcoesEntrega") é uma chave estrangeira que está relacionada a outra tabela.
REFERENCES OpcoesEntrega(id): Isso especifica a tabela de destino da relação. Neste caso, a coluna opcao_entrega_id na tabela atual faz referência à coluna id na tabela "OpcoesEntrega"
*/

CREATE TABLE OpcoesPagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL -- Nome da opção de pagamento (não pode ser nulo).
);

CREATE TABLE EmpreendimentoOpcoesPagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empreendimento_id INT NOT NULL, -- ID do empreendimento.
    opcao_pagamento_id INT NOT NULL, -- ID da opção de pagamento.
    FOREIGN KEY (empreendimento_id) REFERENCES Empreendimento(id),
    FOREIGN KEY (opcao_pagamento_id) REFERENCES OpcoesPagamento(id)
);
/*FOREIGN KEY (empreendimento_id) REFERENCES Empreendimento(id),
FOREIGN KEY (empreendimento_id): Isso indica que a coluna empreendimento_id na tabela atual (no exemplo, "EmpreendimentoOpcoesPagamento") é uma chave estrangeira que está relacionada a outra tabela.
REFERENCES Empreendimento(id): Isso especifica a tabela de destino da relação. Neste caso, a coluna empreendimento_id na tabela atual faz referência à coluna id na tabela "Empreendimento".
Isso cria uma relação entre essas duas tabelas, onde você pode associar um empreendimento a uma opção de pagamento por meio do empreendimento_id
*/

ALTER table Empreendimento
MODIFY telefone VARCHAR (14);

-- Adicionando a restrição UNIQUE à coluna "nome" na tabela "OpcoesEntrega"
ALTER TABLE OpcoesEntrega
ADD CONSTRAINT nome_unico UNIQUE (nome);

-- Adicionando a restrição UNIQUE à coluna "nome" na tabela "OpcoesPagamento"
ALTER TABLE OpcoesPagamento
ADD CONSTRAINT nome_unico UNIQUE (nome);

/*== açõe abaixo será para criar uma auditoria ==*/

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(255) NOT NULL
);

-- ver todos os usuarios
SELECT user, host FROM mysql.user;

INSERT INTO usuarios (nome_usuario)
VALUES ('dinah'), ('lais'), ('renato'), ('lucas'), ('lupita');

INSERT INTO usuarios (nome_usuario)
VALUES ('root');

-- criando uma tabela para auditoria
CREATE TABLE TabelaAuditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATETIME,
    usuario VARCHAR(255),
    acao VARCHAR(255)
);

insert into tabelaauditoria (usario)
values (


ALTER TABLE empreendimento
ADD COLUMN usuario VARCHAR(255);

