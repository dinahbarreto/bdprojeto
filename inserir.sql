-- Inserir registros na tabela "Empreendimento"
INSERT INTO Empreendimento (nome, telefone, endereco, numero_endereco, complemento_endereco, cep, horario_atendimento, aberto_24h) VALUES
    ('Restaurante A', '(81) 9999-0000', 'Rua Principal', 123, 'Apto 456', '12345-678', '08:00 às 20:00', 0),
    ('Supermercado B', '(81) 3468-3210', 'Avenida Secundária', 456, NULL, '98765-432', '10:00 às 22:00', 1);

select * from empreendimento;

INSERT INTO OpcoesEntrega (nome)
VALUES 
    ('Entrega em domicílio'),
    ('Retirada pessoalmente'),
    ('Retirada por aplicativo');
    
select * from OpcoesEntrega;

INSERT INTO OpcoesPagamento (nome)
VALUES 
    ('pix'),
    ('dinheiro'),
    ('débito'),
    ('crédito');

select * from OpcoesPagamento;
