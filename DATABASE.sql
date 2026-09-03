CREATE DATABASE MONITORAMENTO;

CREATE TABLE Empresa (
nome_completo VARCHAR(50), 
telefone CHAR(11)UNIQUE, 
empresa VARCHAR(40), 
CNPJ CHAR(14)NOT NULL UNIQUE,  
email VARCHAR(255), 
senha VARCHAR(255)NOT NULL);

CREATE TABLE Usuario_Empresa (
CNPJ CHAR(14) NOT NULL UNIQUE,
containerID VARCHAR(40) NOT NULL UNIQUE,
empresa VARCHAR(40));

CREATE TABLE Container(
origem VARCHAR(50) NOT NULL,
destino VARCHAR(50) NOT NULL,
dtSaida DATE NOT NULL,
dtChegada DATE NOT NULL,
tempIdeal DECIMAL (5,2),
tempSensor DECIMAL (5,2),
tpCarga VARCHAR(10) NOT NULL,
CONSTRAINT chkTpCarga CHECK(tpCarga IN('Frango', 'Carne', 'Peixe')),
distancia DECIMAL(6,2),
status VARCHAR(20) NOT NULL,
CONSTRAINT chkStatus CHECK(status IN('Em andamento', 'Em trafego', 'Finalizado', 'Descarregando')),
hora DATETIME NOT NULL DEFAULT NOW());
