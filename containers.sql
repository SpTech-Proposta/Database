	CREATE DATABASE MONITORAMENTO;
	use MONITORAMENTO;
	-- Tabela de dados da empresa dona de container: 
	CREATE TABLE Empresa(
	id_empresa int auto_increment primary key,
	nome_completo VARCHAR(50), 
	telefone CHAR(11)UNIQUE, 
	empresa VARCHAR(40), 
	CNPJ CHAR(14)NOT NULL UNIQUE,  
	email VARCHAR(255), 
	senha VARCHAR(255)NOT NULL);


	-- tabela de dados da empresa dona da carga 
	CREATE TABLE  Cliente_da_Empresa (
	id_usuario_empresa int primary key auto_increment,
	CNPJ CHAR(14) NOT NULL UNIQUE,
	empresa VARCHAR(40));

	-- tabela de dados da carga
	CREATE TABLE Container(
	id_container int primary key auto_increment,
	origem VARCHAR(50) NOT NULL,
	destino VARCHAR(50) NOT NULL,
	dtSaida DATETIME NOT NULL,
	dtChegada DATETIME,
	tipo_carga VARCHAR(10) NOT NULL,
	CONSTRAINT chkTpCarga CHECK(tipo_carga IN('Frango', 'Carne', 'Peixe')),
	distancia DECIMAL(6,2),
	status_carga VARCHAR(20) NOT NULL,
	CONSTRAINT chkStatus CHECK(status_carga IN('Em andamento', 'Em trafego', 'Finalizado', 'Descarregando'))
	);



	create table sensor(
	id_sensor int primary key auto_increment,
	temperatura_Ideal DECIMAL (5,2),
	temperatura_Sensor DECIMAL (5,2),
	hora DATETIME NOT NULL DEFAULT NOW());

	INSERT INTO Container (origem, destino, dtSaida, dtChegada, temperatura_Ideal, temperatura_Sensor, tipo_carga, distancia, status_carga) VALUES
	('Porto de Santos', 'Porto de Paranaguá', '2026-03-01 14:14:00', '2026-03-03 14:11:00', -18.00, -17.50, 'Carne', 450.50, 'Finalizado'),
	('Porto de Salvador', 'Porto de Suape', '2026-03-02', '2026-4-20', -12.00, -11.80, 'Frango', 680.00, 'Em andamento'),
	('Porto de Itajaí', 'Porto de Rio Grande', '2026-03-03', NULL, -22.00, -21.20, 'Peixe', 520.30, 'Em trafego'),
	('Porto de Vitória', 'Porto de Santos', '2026-03-04', NULL, -18.00, -18.10, 'Carne', 510.00, 'Descarregando');

	INSERT INTO Cliente_da_Empresa (CNPJ, empresa) VALUES
	('12345678000195', 'Alimentos do Brasil Ltda'),
	('98765432000110', 'Frigorífico Central S.A.'),
	('45678912000133', 'Pescados do Mar EIRELI');

	RENAME TABLE Usuario_empresa TO Cliente_da_Empresa;

INSERT INTO Empresa (nome_completo, telefone, empresa, CNPJ, email, senha) VALUES
('João Silva Santos', '11987654321', 'Transportes Frigorificados Ltda', '11222333000181', 'joao.silva@transpfrig.com.br', 'senha123'),
('Maria Oliveira Costa', '21976543210', 'Log Fresh Transportes S.A.', '22333444000192', 'maria.costa@logfresh.com.br', 'senha456'),
('Carlos Eduardo Lima', '31965432109', 'Congelados Express', '33444555000103', 'carlos.lima@congelex.com.br', 'senha789');


INSERT INTO sensor (temperatura_Ideal, temperatura_Sensor, hora) VALUES
(-18.00, -17.50, '2026-03-01 14:20:00'),
(-12.00, -11.80, '2026-03-02 09:15:00'),
(-22.00, -21.20, '2026-03-03 18:45:00'),
(-18.00, -18.10, '2026-03-04 11:30:00');


SELECT * FROM Empresa;
SELECT * FROM sensor;



SELECT  email, nome_completo, telefone,
CASE
	WHEN email IS NULL THEN 'Informe o email'
    WHEN nome_completo IS NULL THEN 'Informe o seu nome completo'
	WHEN telefone IS NULL THEN 'Informe o número do telefone'
    ELSE 'Cadastro completo'
    END AS 'status do cadastro'
FROM empresa;

	
SELECT *,
	CASE 
			WHEN dtChegada IS NULL THEN 'Ainda não chegou'
			WHEN dtChegada <= NOW() THEN 'Chegou'
			ELSE 'Previsão sem entrega'
		END AS 'Pevisão de entrega'
FROM container;

select datediff(now(), dtChegada) as 'tempo de deslocamento(dias)' from Container;

select timestampdiff(hour, dtChegada, now()) as 'Horas de deslocamento' from Container;


SELECT id_container, tipo_carga,
	CASE tipo_carga
		WHEN 'Frango' THEN 'Ideal: -12°C a -18°C'
        WHEN 'Carne' THEN 'Ideal: -18°C a -22°C'
        WHEN 'Peixe' THEN 'Ideal:  -20°C a -25°C'
	ELSE 'Não definifo'
    END 
FROM container;


SELECT id_container, origem, destino, dtSaida, dtChegada,
    CASE 
        WHEN DATEDIFF(NOW(), dtSaida) < 2 THEN 'Saído recentemente'
        WHEN DATEDIFF(NOW(), dtSaida) < 5 THEN 'Dentro do esperado'
        WHEN DATEDIFF(NOW(), dtSaida) < 10 THEN 'Verificar produtos'
        WHEN dtChegada IS NOT NULL 	THEN 'O produto chegou'
        ELSE 'Viagem muito longa - verificar'
    END AS 'Status da Viagem'
FROM Container;
    
SELECT id_sensor, temperatura_Sensor,
    CASE 
        WHEN temperatura_Sensor <= -30 THEN 'Crítico - Muito Baixa'
        WHEN temperatura_Sensor BETWEEN -29.99 AND -20 THEN 'Baixa'
        WHEN temperatura_Sensor BETWEEN -19.99 AND -10 THEN 'Normal'
        WHEN temperatura_Sensor > -10 THEN 'Alerta - Alta'
    END AS 'Nível de Risco'
FROM sensor;

	DESC sensor;

	DESC Container;
    
    DESC empresa;
    
    DESC cliente_da_empresa;
