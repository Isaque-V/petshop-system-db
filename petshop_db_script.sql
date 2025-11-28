-- DDL: Data Definition Language (Criação de Tabelas)

-- Tabela 1: CLIENTES
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela 2: ANIMAIS (Relacionamento N:1 com Clientes)
CREATE TABLE Animais (
    id_animal INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL, -- Chave Estrangeira
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(50),
    data_nasc DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

-- Tabela 3: SERVICOS (Relacionamento N:1 com Animais)
CREATE TABLE Servicos (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    id_animal INT NOT NULL, -- Chave Estrangeira
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(8, 2) NOT NULL,
    data_servico DATETIME NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES Animais(id_animal) ON DELETE RESTRICT
);
-- DML: Data Manipulation Language (Inserção, Atualização, Remoção, Consulta)

-- 1. INSERÇÃO (CREATE)

-- Inserir 3 Clientes
INSERT INTO Clientes (nome, telefone, email) VALUES
('Ana Silva', '991234567', 'ana.silva@email.com'),
('Bruno Costa', '998765432', 'bruno.costa@email.com'),
('Carla Souza', '995551111', 'carla.souza@email.com');

-- Inserir 3 Animais
INSERT INTO Animais (id_cliente, nome, especie, raca, data_nasc) VALUES
(1, 'Fido', 'Cachorro', 'Golden Retriever', '2023-05-10'),
(2, 'Mia', 'Gato', 'Siamês', '2024-01-20'),
(1, 'Rex', 'Cachorro', 'Poodle', '2022-09-01');

-- Inserir 3 Serviços
INSERT INTO Servicos (id_animal, descricao, preco, data_servico) VALUES
(1, 'Banho e Tosa Completa', 85.00, '2025-11-28 10:00:00'),
(2, 'Consulta Veterinária', 120.00, '2025-11-28 14:30:00'),
(1, 'Corte de Unhas', 20.00, '2025-11-28 10:45:00');


-- 2. CONSULTAS (READ)

-- Consulta 1: Todos os clientes
SELECT * FROM Clientes;

-- Consulta 2: Animais do cliente 'Ana Silva' (usando JOIN)
SELECT A.nome AS Nome_Pet, A.especie, C.nome AS Nome_Dono
FROM Animais A
JOIN Clientes C ON A.id_cliente = C.id_cliente
WHERE C.nome = 'Ana Silva';


-- 3. ATUALIZAÇÃO (UPDATE)

-- Aumentar o preço do serviço 'Banho e Tosa Completa' em 5.00
UPDATE Servicos
SET preco = preco + 5.00
WHERE descricao = 'Banho e Tosa Completa';


-- 4. REMOÇÃO (DELETE)

-- Remover o cliente 'Carla Souza' (e todos os seus pets, se houver, dependendo da restrição ON DELETE)
DELETE FROM Clientes
WHERE nome = 'Carla Souza';
