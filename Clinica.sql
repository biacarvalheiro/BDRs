-- Criação do banco de dados 
CREATE DATABASE Clinica;
USE Clinica;

-- Tabelas
	CREATE TABLE Ambulatorios (
	nroa INT PRIMARY KEY,
	andar NUMERIC(3) NOT NULL,
	capacidade SMALLINT
	);

CREATE TABLE Medicos (
codm INT PRIMARY KEY,
nome VARCHAR(40) NOT NULL,
idade SMALLINT NOT NULL,
especialidade CHAR(20),
CPF NUMERIC(11) UNIQUE, -- automaticamente cria um indice unico 
cidade VARCHAR(30),
nroa INT, -- mesmo que nroa seja uma primary key de Ambulatorios,
-- para ser foreign key em Medicos, essa tabela deve ter uma coluna
-- propria com o valor correspondente, pois o banco nao consegue apontar
-- direto p primary key de outra tabela 
FOREIGN KEY  (nroa) REFERENCES Ambulatorios(nroa)
);

CREATE TABLE Pacientes(
codp INT PRIMARY KEY,
nome VARCHAR(40) NOT NULL,
idade SMALLINT NOT NULL,
cidade CHAR(30),
CPF NUMERIC(11) UNIQUE,
doenca VARCHAR(40) NOT NULL
);

CREATE TABLE Funcionarios(
codf INT PRIMARY KEY,
nome VARCHAR(40) NOT NULL,
idade SMALLINT,
CPF NUMERIC(11) UNIQUE,
cidade VARCHAR(30),
salario NUMERIC(10),
cargo VARCHAR(20)
);

CREATE TABLE Consultas(
codm INT,
codp INT,
data DATE,
hora TIME,
PRIMARY KEY (codm, data, hora)
-- So pode haver uma primary key por tabela 
-- Quando houver multiplas colunas, escrevemos
-- desta maneira, declarando a primary key somente no final
-- esta forma´e mais flexivel, pois se for necessaria
-- alterações posteriores nas colunas da chave primaria, e possivel
);

-- Criando uma coluna na tabela funcionarios
ALTER TABLE Funcionarios ADD COLUMN nroa INT; -- ADD deve estar na msm linha

-- Criando índices nas tabelas medicos e pacientes 
CREATE UNIQUE INDEX CPF ON Medicos(CPF); -- isso deu errado pq 
-- o indice CPF já existe em Medicos e é unico 

CREATE INDEX doenca ON Pacientes(doenca);
-- isso funcionou pq em pacientes só existia a coluna doenca
-- e nao com o indice, que é criado automaticamente com 
-- o uso de UNIQUE e a criacao de primary keys

-- Removendo o índice doenca de Pacientes
DROP INDEX doenca ON Pacientes;

-- Removendo colunas cargo e nroa da tabela de Funcionarios
ALTER TABLE Funcionarios DROP COLUMN cargo, DROP COLUMN nroa;

-- Populando as tabelas 
INSERT INTO Ambulatorios (nroa, andar, capacidade)
VALUES (1, 1, 30),
	   (2, 1, 50),
	   (3, 2, 40),
       (4, 2, 25),
       (5, 2, 55);
       
INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca)
VALUES (1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe'),
	   (2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura'),
       (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
       (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');

INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF)
VALUES (1, 'Rita', 32, 'Sao Jose', 1200, 20000100000),
	   (2, 'Maria', 55, 'Palhoca', 1220, 30000110000),
       (3, 'Caio', 45, 'Florianopolis', 1100, 41000100000),
       (4, 'Carlos', 44, 'Florianopolis', 1200, 51000110000),
       (5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);

INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa)
VALUES (1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1),
	   (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
       (3, 'Pedro', 51, 'pediatria', 11000100000, 'São José', 2),
       (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', 3), -- column count must match value count
       (5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);
       
INSERT INTO Consultas (codm, codp, data, hora)
VALUES
  (1, 1, '2006-06-12', '14:00:00'),
  (1, 4, '2006-06-13', '10:00:00'),
  (2, 1, '2006-06-13', '09:00:00'),
  (2, 2, '2006-06-13', '11:00:00'),
  (2, 3, '2006-06-14', '14:00:00'),
  (2, 4, '2006-06-14', '17:00:00'),
  (3, 1, '2006-06-19', '18:00:00'),
  (3, 3, '2006-06-12', '10:00:00'),
  (3, 4, '2006-06-19', '13:00:00'),
  (4, 4, '2006-06-20', '13:00:00'),
  (4, 4, '2006-06-22', '19:30:00');

-- Atualizações no BD
-- O paciente Paulo se mudou para Ilhota
UPDATE Pacientes SET cidade = 'ILhota' WHERE codp = 2;
-- UPDATE Pacientes SET cidade = 'Ilhota' WHERE nome = 'Paulo'; 
-- sempre use WHERE emum update se não todos os registros da tabela
-- serao alterados. se tiver mais de um paulo, todos vao mudar
-- por isso e melhor usar a primarykey codp 

-- consulta do medico 1 com paciente 4 passou p 12h de 4 de julho de 2006
UPDATE Consultas 
SET data = '2006-07-04', hora = '12:00:00'
WHERE codm = 1 AND codp = 4;
-- so pode usar um SET no UPDATE
-- se houver mais de um codm=1 e codp=4, vai mudar ambos
-- forma alternativa seria: 
-- UPDATE Consultas 
-- SET data = '2006-07-04', hora = '12:00:00'
-- WHERE codm = 1 AND codp = 4 AND data = '2006-06-13' AND hora = '10:00:00';

-- a paciente ana fez aniversario e a sua doenca agora e cancer
UPDATE Pacientes
SET idade = 21, doenca = 'cancer'
WHERE codp = 1 AND nome = 'Ana';

-- a consulta do medico pedro(codf=3) com o paciente Carlos(codf=4)
-- passou p uma hora e meia depois
UPDATE Consultas 
SET hora = '14:30:00'
WHERE codm = 3 AND codp = 4; 

-- o funcionario Carlos deixou a clinica
DELETE FROM Funcionarios
WHERE codf = 4;

-- consultas marcadas após as 19h foram canceladas
DELETE FROM Consultas
WHERE hora > '19:00:00';

SET SQL_SAFE_UPDATES = 0;
-- como esta no safe mode, o banco nao permite que eu faça
-- o update/delete de um where sem uma primary key ou indice unico
-- aqui eu desativo o safe mode so para a sessao atual

DELETE FROM Pacientes
WHERE doenca = 'cancer' 
OR idade < 10;

DELETE FROM Medicos
WHERE cidade IN ('Biguacu','Palhoca');






