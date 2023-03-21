-- criação banco de dados
-- DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;

-- tabelas
CREATE TABLE livro (
	`id_livro` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `titulo_livro` VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
	`id_usuario` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`nome_usuario` VARCHAR(100) NOT NULL,
    `email_usuario` VARCHAR(250),
    `data_nasc_usuario` DATE,
    `quant_emprest_usuario` INT NOT NULL DEFAULT(0)
);

CREATE TABLE emprestimo (
	`id_emprestimo` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    `usuario_id_usuario` INT NOT NULL,
    `livro_id_livro` INT NOT NULL,
    `data_emprestimo` DATE NOT NULL,
    `data_devolucao` DATE NOT NULL,
    `data_entrega` DATE,
    FOREIGN KEY(`usuario_id_usuario`) REFERENCES usuario(`id_usuario`),
    FOREIGN KEY(`livro_id_livro`) REFERENCES livro(`id_livro`)
    );
    
-- inserção de dados
INSERT INTO livro (`titulo_livro`) VALUES
("Bagagem"),
("O Cortiço"),
("Lira dos Vinte Anos"),
("Quarup"),
("O Tronco"),
("A escrava Isaura"),
("O Pagador de Promessas"),
("O que é isso, Companheiro?"),
("Vidas Secas"),
("Grande Sertão Veredas");

INSERT INTO usuario (`nome_usuario`, `email_usuario`, `data_nasc_usuario`) VALUES
("João Silva", "joao@email.com", "1992-08-09"),
("Maria Mota", "maria@provedor.net", "1984-05-17"),
("Eduardo Cançado", "edu@email.com", "1996-02-23"),
("Silvia Alencar", "silvia@provedor.net", "1973-09-20"),
("Gabriela Medeiros", "gabi@email.com", "1993-01-10"),
("Karina Silva", "karin@email.com", "1995-03-25");

INSERT INTO `emprestimo` VALUES
(1,1,4,'2020-08-22','2020-09-21','2020-09-21'),
(2,3,2,'2020-08-22','2020-09-21','2020-09-21'),
(3,2,6,'2020-08-22','2020-09-21','2020-09-21'),
(4,2,8,'2020-08-22','2020-09-21','2020-09-22'),
(5,1,10,'2020-08-22','2020-09-21','2020-09-20'),
(6,4,3,'2020-08-22','2020-09-21','2020-09-21'),
(7,4,7,'2020-08-22','2020-09-21',NULL),
(8,5,9,'2020-08-22','2020-09-21',NULL),
(9,6,1,'2020-08-22','2020-09-21',NULL),
(10,1,1,'2020-09-05','2020-10-05',NULL),
(11,1,4,'2020-09-05','2020-10-05','2020-09-30'),
(12,1,4,'2020-10-01','2020-11-01',NULL);

-- exercícios
-- 3
CREATE VIEW emprestimos_realizados(`Nome do Usuário`, `Título do Livro`, `Data de Empréstimo`, `Data de Devolução`, `Data de Entrega`) AS
SELECT U.nome_usuario, L.titulo_livro, DATE_FORMAT(E.data_emprestimo, '%d/%m/%Y'), DATE_FORMAT(E.data_devolucao, '%d/%m/%Y'), DATE_FORMAT(E.data_entrega, '%d/%m/%Y') FROM usuario AS U
INNER JOIN emprestimo AS E
ON E.usuario_id_usuario = U.id_usuario
INNER JOIN livro AS L
ON L.id_livro = E.livro_id_livro;

SELECT * FROM emprestimos_realizados;

-- 4
CREATE VIEW emprestimos_atrasados AS
SELECT * FROM emprestimos_realizados 
WHERE DATEDIFF(`Data de Entrega`, `Data de Devolução`) > 0;

SELECT * FROM emprestimos_atrasados;

-- 5
CREATE VIEW quantidade_emprestimos_usuario AS
SELECT U.nome_usuario AS `Nome do Usuário`, COUNT(E.id_emprestimo) AS `Quantidade de Empréstimos` FROM emprestimo AS E
INNER JOIN usuario AS U
ON U.id_usuario = E.usuario_id_usuario
GROUP BY U.id_usuario
ORDER BY COUNT(E.id_emprestimo) DESC;

SELECT * FROM quantidade_emprestimos_usuario;

-- 6
SELECT titulo_livro AS `Livros Nunca Emprestados` FROM livro AS L
LEFT JOIN emprestimo AS E
ON L.id_livro = E.livro_id_livro
WHERE E.livro_id_livro IS NULL;