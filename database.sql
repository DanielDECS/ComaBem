-- Criacao do banco
CREATE DATABASE coma_bem;
USE coma_bem;

-- Tabela Restaurante
CREATE TABLE restaurante (
    id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    tipo_culinaria VARCHAR(50)
);

-- Tabela Prato
CREATE TABLE prato (
    id_prato INT AUTO_INCREMENT PRIMARY KEY,
    nome_prato VARCHAR(100) NOT NULL,
    foto_prato VARCHAR(255),
    id_restaurante INT,
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
        ON DELETE CASCADE
);

-- Tabela Avaliacao
CREATE TABLE avaliacao_prato (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_prato INT,
    ranking INT CHECK (ranking BETWEEN 1 AND 5),
    recomendacao TEXT,
    FOREIGN KEY (id_prato) REFERENCES prato(id_prato)
        ON DELETE CASCADE
);

-- INSERTs
INSERT INTO restaurante (nome, latitude, longitude, tipo_culinaria)
VALUES ('Coma Bem Centro', -25.4284, -49.2733, 'Italiana');

INSERT INTO prato (nome_prato, foto_prato, id_restaurante)
VALUES ('Lasanha', 'lasanha.jpg', 1);

INSERT INTO avaliacao_prato (id_prato, ranking, recomendacao)
VALUES (1, 5, 'Excelente prato!');

-- SELECTs
SELECT * FROM restaurante;

SELECT p.nome_prato, r.nome
FROM prato p
JOIN restaurante r ON p.id_restaurante = r.id_restaurante;

SELECT * FROM avaliacao_prato;

-- UPDATEs
UPDATE restaurante
SET nome = 'Coma Bem Premium'
WHERE id_restaurante = 1;

UPDATE avaliacao_prato
SET ranking = 4
WHERE id_avaliacao = 1;

-- DELETEs
DELETE FROM avaliacao_prato WHERE id_avaliacao = 1;

DELETE FROM restaurante WHERE id_restaurante = 1;

-- Usuarios e permissoes
CREATE USER 'admin_coma_bem'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON coma_bem.* TO 'admin_coma_bem'@'localhost';

CREATE USER 'leitura_coma_bem'@'localhost' IDENTIFIED BY '123456';
GRANT SELECT ON coma_bem.* TO 'leitura_coma_bem'@'localhost';

FLUSH PRIVILEGES;
