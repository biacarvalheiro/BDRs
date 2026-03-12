-- Criação do esquema para a Clínica Médica
CREATE DATABASE IF NOT EXISTS ClinicaMedica;
USE ClinicaMedica;

-- Tabela Paciente
CREATE TABLE Paciente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    PlanoSaude VARCHAR(100)
);

-- Tabela Dependente (subtipo de Paciente)
CREATE TABLE Dependente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    RelacaoComTitular VARCHAR(50) NOT NULL,
    TitularID INT NOT NULL,
    FOREIGN KEY (TitularID) REFERENCES Paciente(ID) ON DELETE CASCADE
);

-- Tabela Medico
CREATE TABLE Medico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CRM VARCHAR(20) NOT NULL UNIQUE
);

-- Tabela Especialidade
CREATE TABLE Especialidade (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela MedicoEspecialidade (1:N entre Médico e Especialidade)
CREATE TABLE MedicoEspecialidade (
    MedicoID INT NOT NULL,
    EspecialidadeID INT NOT NULL,
    PRIMARY KEY (MedicoID, EspecialidadeID),
    FOREIGN KEY (MedicoID) REFERENCES Medico(ID) ON DELETE CASCADE,
    FOREIGN KEY (EspecialidadeID) REFERENCES Especialidade(ID) ON DELETE CASCADE
);

-- Tabela Consulta
CREATE TABLE Consulta (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Data DATE NOT NULL,
    Hora TIME NOT NULL,
    Diagnostico TEXT,
    PacienteID INT NOT NULL,
    MedicoID INT NOT NULL,
    FOREIGN KEY (PacienteID) REFERENCES Paciente(ID) ON DELETE RESTRICT,
    FOREIGN KEY (MedicoID) REFERENCES Medico(ID) ON DELETE RESTRICT
);

-- Tabela Medicamento
CREATE TABLE Medicamento (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela Prescricao
CREATE TABLE Prescricao (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Dosagem VARCHAR(100) NOT NULL,
    Duracao VARCHAR(100) NOT NULL,
    ConsultaID INT NOT NULL,
    MedicamentoID INT NOT NULL,
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ID) ON DELETE CASCADE,
    FOREIGN KEY (MedicamentoID) REFERENCES Medicamento(ID) ON DELETE RESTRICT
);

-- Tabela Exame
CREATE TABLE Exame (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(100) NOT NULL,
    Resultado TEXT,
    ConsultaID INT NOT NULL,
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ID) ON DELETE CASCADE
);

-- Tabela Alergia (N:M entre Paciente e Medicamento)
CREATE TABLE Alergia (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Descricao TEXT,
    PacienteID INT NOT NULL,
    MedicamentoID INT NOT NULL,
    FOREIGN KEY (PacienteID) REFERENCES Paciente(ID) ON DELETE CASCADE,
    FOREIGN KEY (MedicamentoID) REFERENCES Medicamento(ID) ON DELETE RESTRICT
);


INSERT INTO Paciente (Nome, DataNascimento, PlanoSaude) VALUES
('Joao Silva','1985-03-12','Unimed'),
('Maria Souza','1990-07-22','Amil'),
('Carlos Pereira','1978-11-02','Bradesco'),
('Ana Martins','1995-09-15','SulAmerica'),
('Lucas Rocha','1988-01-20','Unimed'),
('Fernanda Lima','1992-04-30','Amil'),
('Ricardo Alves','1980-12-05','Bradesco'),
('Juliana Costa','1998-06-18','SulAmerica'),
('Pedro Gomes','1975-02-28','Unimed'),
('Patricia Dias','1983-10-11','Amil');

INSERT INTO Dependente (Nome, DataNascimento, RelacaoComTitular, TitularID) VALUES
('Ana Silva','2010-05-10','Filha',1),
('Pedro Silva','2012-08-15','Filho',1),
('Marina Souza','2015-03-22','Filha',2),
('Lucas Pereira','2014-07-09','Filho',3),
('Bruna Martins','2016-12-01','Filha',4),
('Joao Rocha','2013-02-14','Filho',5),
('Camila Lima','2011-11-30','Filha',6),
('Rafael Alves','2017-09-25','Filho',7),
('Julia Costa','2018-04-12','Filha',8),
('Gabriel Gomes','2016-06-06','Filho',9);

INSERT INTO Medico (Nome, CRM) VALUES
('Dr Roberto Lima','CRM1001'),
('Dra Fernanda Alves','CRM1002'),
('Dr Ricardo Gomes','CRM1003'),
('Dra Carla Mendes','CRM1004'),
('Dr Paulo Barros','CRM1005'),
('Dra Luciana Freitas','CRM1006'),
('Dr Marcos Teixeira','CRM1007'),
('Dra Renata Duarte','CRM1008'),
('Dr Eduardo Nunes','CRM1009'),
('Dra Patricia Ramos','CRM1010');

INSERT INTO Especialidade (Nome) VALUES
('Cardiologia'),
('Pediatria'),
('Ortopedia'),
('Dermatologia'),
('Neurologia'),
('Ginecologia'),
('Oftalmologia'),
('Psiquiatria'),
('Endocrinologia'),
('Urologia');

INSERT INTO MedicoEspecialidade VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO Medicamento (Nome) VALUES
('Paracetamol'),
('Ibuprofeno'),
('Amoxicilina'),
('Dipirona'),
('Aspirina'),
('Omeprazol'),
('Losartana'),
('Azitromicina'),
('Metformina'),
('Cetirizina');

INSERT INTO Consulta (Data,Hora,Diagnostico,PacienteID,MedicoID) VALUES
('2025-06-01','09:00','Dor de cabeça',1,1),
('2025-06-02','10:30','Febre alta',2,2),
('2025-06-03','11:15','Dor no joelho',3,3),
('2025-06-04','14:00','Alergia na pele',4,4),
('2025-06-05','15:30','Enxaqueca',5,5),
('2025-06-06','08:45','Consulta rotina',6,6),
('2025-06-07','13:20','Problema visão',7,7),
('2025-06-08','16:10','Ansiedade',8,8),
('2025-06-09','10:00','Diabetes controle',9,9),
('2025-06-10','11:40','Infecção urinária',10,10);

INSERT INTO Prescricao (Dosagem, Duracao, ConsultaID, MedicamentoID) VALUES
('500mg','5 dias',1,1),
('200mg','7 dias',2,2),
('500mg','10 dias',3,3),
('1 comprimido','3 dias',4,4),
('500mg','5 dias',5,5),
('20mg','15 dias',6,6),
('50mg','30 dias',7,7),
('500mg','3 dias',8,8),
('850mg','30 dias',9,9),
('10mg','7 dias',10,10);

INSERT INTO Exame (Tipo, Resultado, ConsultaID) VALUES
('Exame de sangue','Normal',1),
('Raio-X','Inflamacao leve',2),
('Ressonancia','Sem alteracoes',3),
('Exame alergico','Alergia detectada',4),
('Tomografia','Normal',5),
('Ultrassom','Normal',6),
('Exame de vista','Miopia leve',7),
('Avaliação psicologica','Ansiedade moderada',8),
('Glicemia','Alta',9),
('Urina','Infecção detectada',10);

INSERT INTO Alergia (Descricao, PacienteID, MedicamentoID) VALUES
('Alergia leve',1,2),
('Reação cutanea',2,3),
('Coceira',3,4),
('Inchaço',4,5),
('Nausea',5,6),
('Dor estomacal',6,7),
('Tontura',7,8),
('Erupção',8,9),
('Vermelhidão',9,10),
('Irritação',10,1);

SELECT e.tipo, e.resultado, c.hora, c.diagnostico
-- e é um alias (apelido) para simplificar a escrita
FROM Exame e -- define a tabela principal Alergia
-- INNER JOIN entre a tabela Exame e a tabela Consulta, ou seja,
-- só serão retornados os registros que têm correspondência nas duas tabelas
JOIN Consulta c
-- define a condição de junção: o campo ConsultaID deve ser igual
-- ao campo ID (cada exame está ligado a uma consulta específica 
-- e o banco só retorna os pares que batem 
on (e.ConsultaID) = (c.ID);

-- renomeia as colunas como Paciente, tipoAlergia e Medicamento
SELECT  p.Nome as Paciente, a.Descricao as tipoAlergia, m.Nome as Medicamento
FROM Alergia a
-- INNER JOIN entre a tabela Alergia e Paciente 
JOIN Paciente p 
ON (a.PacienteID) = (p.ID)
-- INNER JOIN entre a tabela Alergia e Medicamento
JOIN Medicamento m
ON  (a.MedicamentoID) = (m.ID);

-- FAZER MAIS DOIS JOIN's
SELECT m.Nome as Medico, e.Nome as Especialidade
FROM MedicoEspecialidade me -- tabela principal
INNER JOIN Medico m 
ON (me.MedicoID) = (m.ID)
INNER JOIN Especialidade e
ON (me.EspecialidadeID) = (e.ID)
-- filtro: só retorna especialidades cujo nome começa com a letra O ou P
-- pega apenas o primeiro caractere da coluna Nome da tabela Especialidade
-- LEFT(campo, quantidade) é uma função de string no SQL
-- pega os n primeiros caracteres de um texto, começando pela esquerda
-- (o início da palavra)
WHERE LEFT(e.Nome, 1 ) = 'O' OR LEFT(e.Nome, 1 ) = 'P';

-- INNER JOIN VS LEFT JOIN 
-- INNER só retorna registros que têm correspondência nas duas tabelas
-- só aparecerão médicos que realmente têm especialidades cadastradas
-- se não houver correspondência, a linha é descartada
-- LEFT retorna todos os registros da tabela da esquerda, mesmo que 
-- não haja correspondência na tabela da direita, aí fica como NULL
-- podemos ver linhas de MedicoEspecialidade mesmo que não exista um 
-- médico ou especialidade correspondente 

SELECT m.nome, e.Nome
FROM MedicoEspecialidade me
LEFT JOIN Medico m 
ON (me.MedicoID) = (m.ID)
LEFT JOIN Especialidade e
ON (me.EspecialidadeID) = (e.ID)
WHERE LEFT(e.Nome, 1 ) = 'O' OR LEFT(e.Nome, 1 ) = 'P'; 

