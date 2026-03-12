CREATE DATABASE LojaOnlineNova;
USE LojaOnlineNova;

CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    NomeCliente VARCHAR(100) NOT NULL,
    EmailCliente VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Endereco (
    EnderecoID INT IDENTITY(1,1) PRIMARY KEY,
    RuaEndereco VARCHAR(200) NOT NULL,
    CidadeEndereco VARCHAR(100) NOT NULL,
    CEPEndereco VARCHAR(10) NOT NULL,
    ClienteID INT NOT NULL,
    
    CONSTRAINT FK_Endereco_Cliente 
        FOREIGN KEY (ClienteID) 
        REFERENCES Cliente(ClienteID) 
        ON DELETE CASCADE,

    CONSTRAINT UQ_Endereco_Cliente UNIQUE (ClienteID)
);

CREATE TABLE Produto (
    ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
    NomeProduto VARCHAR(200) NOT NULL,
    PrecoProduto DECIMAL(10,2) NOT NULL,
    EstoqueProduto INT NOT NULL
);

CREATE TABLE Categoria (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    NomeCategoria VARCHAR(100) NOT NULL
);

CREATE TABLE ProdutoCategoria (
    ProdutoID INT NOT NULL,
    CategoriaID INT NOT NULL,

    CONSTRAINT PK_ProdutoCategoria 
        PRIMARY KEY (ProdutoID, CategoriaID),

    CONSTRAINT FK_PC_Produto 
        FOREIGN KEY (ProdutoID) 
        REFERENCES Produto(ProdutoID) 
        ON DELETE CASCADE,

    CONSTRAINT FK_PC_Categoria 
        FOREIGN KEY (CategoriaID) 
        REFERENCES Categoria(CategoriaID) 
        ON DELETE CASCADE
);

CREATE TABLE Pedido (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    DataPedido DATE NOT NULL,
    StatusPedido VARCHAR(20) NOT NULL,
    TotalPedido DECIMAL(10,2) NOT NULL,
    ClienteID INT NOT NULL,

    CONSTRAINT FK_Pedido_Cliente 
        FOREIGN KEY (ClienteID) 
        REFERENCES Cliente(ClienteID) 
        ON DELETE NO ACTION,

    CONSTRAINT CK_Status_Pedido 
        CHECK (StatusPedido IN ('Pendente', 'Enviado', 'Entregue'))
);


CREATE TABLE ItemPedido (
    ItemPedidoID INT IDENTITY(1,1) PRIMARY KEY,
    QuantidadeItem INT NOT NULL,
    PrecoUnitarioItem DECIMAL(10,2) NOT NULL,
    PedidoID INT NOT NULL,
    ProdutoID INT NOT NULL,

    CONSTRAINT FK_ItemPedido_Pedido 
        FOREIGN KEY (PedidoID) 
        REFERENCES Pedido(PedidoID) 
        ON DELETE CASCADE,

    CONSTRAINT FK_ItemPedido_Produto 
        FOREIGN KEY (ProdutoID) 
        REFERENCES Produto(ProdutoID) 
        ON DELETE NO ACTION
);


-- CLIENTES
INSERT INTO Cliente (NomeCliente, EmailCliente) VALUES
('Ana Souza', 'ana@email.com'),
('Carlos Lima', 'carlos@email.com'),
('Mariana Alves', 'mariana@email.com'),
('Bruno Martins', 'bruno@email.com'),
('Juliana Costa', 'juliana@email.com'),
('Ricardo Mendes', 'ricardo@email.com'),
('Fernanda Rocha', 'fernanda@email.com');


-- ENDEREÇOS
INSERT INTO Endereco (RuaEndereco, CidadeEndereco, CEPEndereco, ClienteID) VALUES
('Rua das Flores, 123', 'São Paulo', '01000-000', 1),
('Av. Brasil, 456', 'Campinas', '13000-000', 2),
('Rua Central, 789', 'Santos', '11000-000', 3),
('Rua Azul, 45', 'Sorocaba', '18000-000', 4),
('Av. Paulista, 1500', 'São Paulo', '01310-000', 5),
('Rua das Palmeiras, 77', 'Ribeirão Preto', '14000-000', 6),
('Av. Atlântica, 200', 'Rio de Janeiro', '22000-000', 7);


-- PRODUTOS
INSERT INTO Produto (NomeProduto, PrecoProduto, EstoqueProduto) VALUES
('Notebook Dell', 3500.00, 10),
('Mouse Gamer', 150.00, 50),
('Teclado Mecânico', 400.00, 30),
('Monitor 24 Polegadas', 900.00, 20);


-- CATEGORIAS
INSERT INTO Categoria (NomeCategoria) VALUES
('Informática'),
('Periféricos'),
('Promoção');



-- PRODUTO_CATEGORIA
INSERT INTO ProdutoCategoria (ProdutoID, CategoriaID) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 1),
(2, 3);


-- PEDIDOS
INSERT INTO Pedido (DataPedido, StatusPedido, TotalPedido, ClienteID) VALUES
('2026-03-01', 'Pendente', 3650.00, 1),
('2026-03-02', 'Enviado', 550.00, 2),
('2026-03-03', 'Entregue', 900.00, 3),
('2026-03-04', 'Pendente', 800.00, 4),
('2026-03-04', 'Enviado', 4650.00, 5),
('2026-03-05', 'Entregue', 1200.00, 6),
('2026-03-05', 'Pendente', 1800.00, 7),
('2026-03-06', 'Enviado', 700.00, 1);


-- ITENS
INSERT INTO ItemPedido (QuantidadeItem, PrecoUnitarioItem, PedidoID, ProdutoID) VALUES
(1, 3500.00, 1, 1),
(4, 150.00, 1, 2),
(2, 400.00, 2, 3),
(6, 150.00, 2, 2),
(7, 900.00, 3, 4),
(2, 400.00, 4, 3),
(1, 3500.00, 5, 1),
(9, 900.00, 5, 4),
(1, 150.00, 5, 2),
(3, 400.00, 6, 3),
(2, 900.00, 7, 4),
(2, 150.00, 8, 2),
(1, 400.00, 8, 3);


SELECT * FROM Cliente;
SELECT * FROM Endereco;
SELECT * FROM Produto;
SELECT * FROM Categoria;
SELECT * FROM ProdutoCategoria;
SELECT * FROM Pedido;
SELECT * FROM ItemPedido;


SELECT MIN(PrecoProduto) AS maisBarato
FROM Produto;

SELECT MAX(PrecoProduto) AS maisCaro
FROM Produto;

SELECT MIN(QuantidadeItem)
FROM ItemPedido;

SELECT MAX(QuantidadeItem)
FROM ItemPedido;

SELECT COUNT(QuantidadeItem)
FROM ItemPedido
WHERE QuantidadeItem > 1;

SELECT COUNT(PedidoID)
FROM Pedido
WHERE MONTH(DataPedido) = 3;

SELECT AVG(PrecoProduto) AS mediaPreco
FROM Produto;

SELECT SUM(PrecoProduto) AS somaPrecos
FROM Produto;

SELECT COUNT(*) AS totalProdutos
FROM Produto;

SELECT COUNT(*) AS totalPedidos
FROM Pedido;

SELECT SUM(QuantidadeItem) AS totalItensVendidos
FROM ItemPedido;

SELECT AVG(QuantidadeItem) AS mediaQuantidade
FROM ItemPedido;

SELECT p.ProdutoID, p.PrecoProduto, SUM(i.QuantidadeItem) AS totalVendido
FROM Produto p
JOIN ItemPedido i ON p.ProdutoID = i.ProdutoID
GROUP BY p.ProdutoID, p.PrecoProduto;

SELECT pe.PedidoID, COUNT(i.ProdutoID) AS totalItens
FROM Pedido pe
JOIN ItemPedido i ON pe.PedidoID = i.PedidoID
GROUP BY pe.PedidoID;

SELECT MONTH(DataPedido) AS mes, COUNT(*) AS totalPedidos
FROM Pedido
GROUP BY MONTH(DataPedido);

SELECT ProdutoID, COUNT(*) AS totalItens
FROM ItemPedido
GROUP BY ProdutoID;


SELECT p.NomeProduto,
       p.PrecoProduto,
       c.NomeCliente,
       itp.QuantidadeItem
FROM ItemPedido itp
JOIN Produto p
     ON itp.ProdutoID = p.ProdutoID
JOIN Pedido pe
     ON itp.PedidoID = pe.PedidoID
JOIN Cliente c
     ON pe.ClienteID = c.ClienteID
	 where QuantidadeItem > 3;



	 SELECT c.NomeCliente as Nome,
			e.RuaEndereco as Rua,
			e.CidadeEndereco as Cidade
	 FROM Endereco e
	 Join Cliente c on
	e.ClienteID = c.ClienteID;



SELECT MIN(DataPedido) AS primeiroPedido
FROM Pedido;

SELECT MAX(DataPedido) AS ultimoPedido
FROM Pedido;

SELECT COUNT(PedidoID)
FROM Pedido
WHERE MONTH(DataPedido) = 3
AND YEAR(DataPedido) = 2026;