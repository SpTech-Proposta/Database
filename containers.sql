CREATE DATABASE MONITORAMENTO;

USE MONITORAMENTO;

-- Tabela de dados da empresa dona do container
CREATE TABLE Empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(50),
    telefone CHAR(11) UNIQUE,
    empresa VARCHAR(40),
    CNPJ CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(255),
    senha VARCHAR(255) NOT NULL
);

-- Tabela de dados da empresa dona da carga
CREATE TABLE Cliente_da_Empresa (
    id_usuario_empresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    empresa VARCHAR(40)
);

-- Tabela de dados da carga
CREATE TABLE Container (
    id_container INT PRIMARY KEY AUTO_INCREMENT,
    origem VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    dtSaida DATETIME NOT NULL,
    dtChegada DATETIME,
    tipo_carga VARCHAR(10) NOT NULL,

    CONSTRAINT chkTpCarga
        CHECK (tipo_carga IN ('Frango', 'Carne', 'Peixe')),

    distancia DECIMAL(6,2),

    status_carga VARCHAR(20) NOT NULL,

    CONSTRAINT chkStatus
        CHECK (
            status_carga IN (
                'Em andamento',
                'Em trafego',
                'Finalizado',
                'Descarregando'
            )
        )
);

-- Tabela de sensores
CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_Ideal DECIMAL(5,2),
    temperatura_Sensor DECIMAL(5,2),
    hora DATETIME NOT NULL DEFAULT NOW()
);

-- Inserindo dados na tabela Container
INSERT INTO Container (
    origem,
    destino,
    dtSaida,
    dtChegada,
    tipo_carga,
    distancia,
    status_carga
) VALUES
(
    'Porto de Santos',
    'Porto de Paranaguá',
    '2026-03-01 14:14:00',
    '2026-03-03 14:11:00',
    'Carne',
    450.50,
    'Finalizado'
),
(
    'Porto de Salvador',
    'Porto de Suape',
    '2026-03-02',
    '2026-04-20',
    'Frango',
    680.00,
    'Em andamento'
),
(
    'Porto de Itajaí',
    'Porto de Rio Grande',
    '2026-03-03',
    NULL,
    'Peixe',
    520.30,
    'Em trafego'
),
(
    'Porto de Vitória',
    'Porto de Santos',
    '2026-03-04',
    NULL,
    'Carne',
    510.00,
    'Descarregando'
);

-- Inserindo dados na tabela Cliente_da_Empresa
INSERT INTO Cliente_da_Empresa (
    CNPJ,
    empresa
) VALUES
(
    '12345678000195',
    'Alimentos do Brasil Ltda'
),
(
    '98765432000110',
    'Frigorífico Central S.A.'
),
(
    '45678912000133',
    'Pescados do Mar EIRELI'
);

-- Renomeando a tabela
RENAME TABLE Usuario_empresa TO Cliente_da_Empresa;

-- Inserindo dados na tabela Empresa
INSERT INTO Empresa (
    nome_completo,
    telefone,
    empresa,
    CNPJ,
    email,
    senha
) VALUES
(
    'João Silva Santos',
    '11987654321',
    'Transportes Frigorificados Ltda',
    '11222333000181',
    'joao.silva@transpfrig.com.br',
    'senha123'
),
(
    'Maria Oliveira Costa',
    '21976543210',
    'Log Fresh Transportes S.A.',
    '22333444000192',
    'maria.costa@logfresh.com.br',
    'senha456'
),
(
    'Carlos Eduardo Lima',
    '31965432109',
    'Congelados Express',
    '33444555000103',
    'carlos.lima@congelex.com.br',
    'senha789'
);

-- Inserindo dados na tabela sensor
INSERT INTO sensor (
    temperatura_Ideal,
    temperatura_Sensor,
    hora
) VALUES
(
    -18.00,
    -17.50,
    '2026-03-01 14:20:00'
),
(
    -12.00,
    -11.80,
    '2026-03-02 09:15:00'
),
(
    -22.00,
    -21.20,
    '2026-03-03 18:45:00'
),
(
    -18.00,
    -18.10,
    '2026-03-04 11:30:00'
);

-- Consultando empresas
SELECT * FROM Empresa;

-- Consultando sensores
SELECT * FROM sensor;

-- Verificando previsão de entrega
SELECT *,
    CASE
        WHEN dtChegada IS NULL THEN 'Ainda não chegou'
        WHEN dtChegada <= NOW() THEN 'Chegou'
        ELSE 'Previsão sem entrega'
    END AS 'Previsão de entrega'
FROM Container;

-- Calculando o tempo de deslocamento em dias
SELECT
    DATEDIFF(NOW(), dtChegada) AS 'Tempo de deslocamento (dias)'
FROM Container;

-- Calculando o tempo de deslocamento em horas
SELECT
    TIMESTAMPDIFF(HOUR, dtChegada, NOW()) AS 'Horas de deslocamento'
FROM Container;

-- Atualizando uma empresa
UPDATE Empresa
SET empresa = 'Atum do Brasil'
WHERE id_empresa = 3;

-- Descrevendo as tabelas
DESC sensor;

DESC Container;

DESC Empresa;

DESC Cliente_da_Empresa;

-- Consultando os containers
SELECT * FROM Container;