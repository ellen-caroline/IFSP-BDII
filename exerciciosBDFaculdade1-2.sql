-- criação de banco de dados
-- drop database BD_Faculdade;
create database BD_Faculdade;
use BD_Faculdade;
show tables;


 -- tabelas
create table sala
(predio varchar(15),
nro_sala varchar(7),
capacidade int,
primary key (predio, nro_sala)
);

create table curso(
Cod_curso VARCHAR(6),
nome VARCHAR(20),
predio VARCHAR(15),
orcamento FLOAT,
PRIMARY KEY (Cod_curso));

create table disciplina (
Cod_disciplina varchar(8) ,
nome VARCHAR(50),
Cod_curso VARCHAR(6),
Creditos int,
PRIMARY KEY (Cod_disciplina),
foreign key (Cod_curso) references curso (Cod_curso)
on delete set null );

create table prereq
( Cod_disciplina varchar(8),
Cod_prereq varchar(8),
primary key (Cod_disciplina, Cod_prereq),
foreign key (Cod_disciplina) references disciplina (Cod_disciplina)
on delete cascade,
foreign key (Cod_prereq) references disciplina (Cod_disciplina)
);

create table professor(
Id_Professor INT AUTO_INCREMENT,
nome VARCHAR(100) ,
Cod_curso VARCHAR(6),
salario float,
PRIMARY KEY (Id_Professor),
foreign key (Cod_curso) references curso(Cod_curso)
on delete set null );

create table turma(
Cod_disciplina varchar(8) ,
nro_turma int,
semestre varchar(5),
ano int check (ano > 1701 and ano < 2100),
predio VARCHAR(15),
nro_sala VARCHAR(7),
primary key (Cod_disciplina,nro_turma, semestre, ano),
foreign key (cod_disciplina) references disciplina(cod_disciplina)
on delete cascade,
foreign key (predio, nro_sala) references sala (predio, nro_sala)
on delete set null
);

create table ministra(
Id_Professor INT,
Cod_disciplina varchar(8),
nro_turma int,
semestre varchar(5),
ano int,
primary key (Id_Professor, Cod_disciplina, nro_turma, semestre,ano),
foreign key (Cod_disciplina,nro_turma, semestre, ano) references turma
(Cod_disciplina,nro_turma, semestre, ano)
on delete cascade,
foreign key (Id_Professor) references professor (Id_Professor)
on delete cascade
);

create table aluno
(id_aluno INT AUTO_INCREMENT,
nome varchar(20) not null,
Cod_curso VARCHAR(6),
tot_cred int check (tot_cred >= 0),
primary key (id_aluno),
foreign key (Cod_curso ) references curso (Cod_curso)
on delete set null
);

create table matricula
(id_aluno int,
Cod_disciplina varchar(8),
nro_turma int,
semestre varchar(5),
ano int,
nota float,
primary key (id_aluno, Cod_disciplina, nro_turma, semestre, ano),
foreign key (Cod_disciplina,nro_turma, semestre, ano) references turma
(Cod_disciplina,nro_turma, semestre, ano)
on delete cascade,
foreign key (id_aluno) references aluno (id_aluno)
on delete cascade
);

create table orientador
(id_aluno int,
Id_Professor int,
primary key (id_aluno),
foreign key (Id_Professor) references professor (Id_Professor)
on delete set null,
foreign key (id_aluno) references aluno (id_aluno)
on delete cascade
);


-- inserts
insert into sala values ('A', '101', '20');
insert into sala values ('A', '102', '25');
insert into sala values ('B', '101', '30');
insert into sala values ('B', '102', '10');
insert into sala values ('C', '101', '50');
insert into sala values ('C', '102', '50');
insert into sala values ('Auditorio', '101', '100');
insert into curso values ('BIO','Biologia', 'A', '90000');
insert into curso values ('CS','Computacao', 'B', '100000');
insert into curso values ('EE','Engenharia Electrica', 'B', '85000');
insert into curso values ('HI','Historia', 'C', '50000');
insert into curso values ('MU','Musica', 'C', '80000');
insert into curso values ('FI','Fisica', 'A', '70000');
insert into disciplina values ('BIO101', 'Principios da Biologia', 'BIO', 4);
insert into disciplina values ('BIO301', 'Genetica', 'BIO', 4);
insert into disciplina values ('BIO399', 'Biologia Computacional', 'BIO', 3);
insert into disciplina values ('CSLP1', 'Linguagem de Programacao I', 'CS', 4);
insert into disciplina values ('CS190', 'Projeto de Jogos', 'CS', 4);
insert into disciplina values ('CS315', 'Robotica', 'CS', 3);
insert into disciplina values ('CSBD1', 'Banco de dados', 'CS' , 4);
insert into disciplina values ('EE181', 'Sistemas Digitais', 'EE', 3);
insert into disciplina values ('HIS351', 'Historia Mundial', 'HI', 3);
insert into disciplina values ('MU199', 'Producao de Musica', 'MU' , 3);
insert into disciplina values ('FI101', 'Pricipios de Fisica I', 'FI', 4);
insert into prereq values ('BIO301', 'BIO101');
insert into prereq values ('BIO399', 'BIO101');
insert into prereq values ('CS190', 'CSLP1');
insert into prereq values ('CS190', 'CS315');
insert into professor values (default, 'Curie', 'BIO', '80000');
insert into professor values (default, 'Darwin', 'BIO', '72000');
insert into professor values (default, 'Job', 'CS', '60000');
insert into professor values (default, 'Lovelace', 'CS', '92000');
insert into professor values (default, 'Turing', 'CS', '75000');
insert into professor values (default, 'Maria', 'HI', '62000');
insert into professor values (default, 'Newton', 'EE', '80000');
insert into professor values (default, 'Mozart', 'MU', '40000');
insert into professor values (default, 'Einstein', 'FI', '95000');
insert into professor values (default, 'Gauss', 'FI', '87000');
insert into turma values ('BIO101', 1, '1S', 2020, 'B', '101');
insert into turma values ('BIO101', 2, '1S', 2020, 'B', '102');
insert into turma values ('CSBD1', 1, '1S', 2022, 'A', '101');
insert into turma values ('EE181', 1, '1S', 2021, 'C', '102');
insert into ministra values (1,'BIO101', 1, '1S', 2020);
insert into ministra values (2,'BIO101', 2, '1S', 2020);
insert into ministra values (3, 'CSBD1', 1, '1S', 2022);
insert into ministra values (8, 'EE181', 1, '1S', 2021);
insert into aluno values (default, 'Giovana', 'BIO', 20);
insert into aluno values (default, 'Diego', 'BIO', 100);
insert into aluno values (default, 'Valeria', 'CS', 100);
insert into aluno values (default, 'Tito', 'CS', 150);
insert into aluno values (default, 'Eduardo', 'CS', 300);
insert into aluno values (default, 'Julio', 'MU', 100 );
insert into aluno values (default, 'Ester', 'FI', 50);
insert into aluno values (default, 'Gloria', 'FI', 50);
insert into matricula values (1, 'BIO101', 1, '1S', 2020, 5);
insert into matricula values (2, 'BIO101', 1, '1S', 2020, 5);
insert into matricula values (4, 'CSBD1', 1, '1S', 2022,8);
insert into orientador values (1,1);
insert into orientador values (5,1);
insert into orientador values (3,5);


-- exercícios 
-- 1A
DELIMITER |
CREATE FUNCTION prof_maior_salario ()
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
DECLARE nome_prof VARCHAR(25);
SELECT nome AS `Nome` INTO nome_prof FROM professor
WHERE salario = (SELECT MAX(salario) FROM professor);
RETURN (nome_prof);
END |
DELIMITER ;

SELECT prof_maior_salario () AS `Professor com maior salário`;


-- 1B
DELIMITER |
CREATE FUNCTION media_salario_profs (entrada VARCHAR(6))
RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE media FLOAT;
DECLARE texto VARCHAR(6);
SELECT entrada INTO texto;
SELECT AVG(salario) AS `Média` INTO media FROM professor
WHERE texto = cod_curso;
RETURN (media);
END |
DELIMITER ;

SELECT media_salario_profs('BIO') AS `Média dos salários dos professores`;


-- 1C
DELIMITER |
CREATE FUNCTION aluno_mais_creditos (entrada VARCHAR(50))
RETURNS VARCHAR(60) DETERMINISTIC
BEGIN
DECLARE nome_aluno_mais_creditos VARCHAR(60);
DECLARE texto VARCHAR(50);
SELECT entrada INTO texto;
SELECT nome INTO nome_aluno_mais_creditos FROM aluno 
WHERE tot_cred = (SELECT MAX(A.tot_cred) FROM aluno AS A
					INNER JOIN curso AS C
					USING (cod_curso)
					WHERE texto = C.nome)
                    LIMIT 1;
RETURN (nome_aluno_mais_creditos);
END |
DELIMITER ;

SELECT aluno_mais_creditos('Biologia') AS `Total de Créditos`;


-- 1D
DELIMITER |
CREATE FUNCTION salas_ocupadas_no_semestre (predio VARCHAR(15), semestre VARCHAR(7))
RETURNS INT DETERMINISTIC
BEGIN
DECLARE qntd_salas INT;
DECLARE ent_predio VARCHAR(15);
DECLARE ent_semestre VARCHAR(7);
SELECT predio INTO ent_predio;
SELECT semestre INTO ent_semestre;
SELECT count(nro_sala) INTO qntd_salas FROM turma AS T
WHERE ent_predio = T.predio AND ent_semestre =  T.semestre;
RETURN (qntd_salas);
END |
DELIMITER ;

SELECT salas_ocupadas_no_semestre('B', '1S') AS `Salas Ocupadas`;


-- 1E
-- alternativa 1
CREATE PROCEDURE capacidade_cada_predio (predio_entrada VARCHAR(15), sala_entrada varchar(7))
SELECT capacidade FROM sala
WHERE predio = predio_entrada AND nro_sala = sala_entrada;

CALL capacidade_cada_predio('A','101');
 -- alternativa 2
CREATE PROCEDURE capacidade_cada_predio_2 ()
SELECT capacidade FROM sala;

CALL capacidade_cada_predio_2();


-- 1F
CREATE PROCEDURE nome_orientandos(nome_prof VARCHAR(60))
SELECT A.nome, P.nome FROM aluno AS A
INNER JOIN orientador AS O
ON O.id_aluno = A.id_aluno
INNER JOIN professor AS P
ON O.id_professor = P.id_professor
WHERE P.nome = nome_prof;

CALL nome_orientandos('Curie');


-- 1G
CREATE PROCEDURE disciplinas_cursadas_pelo_aluno(ent_id_aluno INT)
SELECT nome FROM disciplina
INNER JOIN matricula AS M
USING (Cod_disciplina)
WHERE M.id_aluno = ent_id_aluno;

CALL disciplinas_cursadas_pelo_aluno(2);


-- 1H
CREATE PROCEDURE disciplinas_ministradas_(ent_id_professor INT, ent_semestre VARCHAR(7))
SELECT nome FROM disciplina
INNER JOIN ministra
USING (Cod_disciplina)
WHERE id_professor = ent_id_professor AND semestre = ent_semestre;

CALL disciplinas_ministradas_(1, '1S');


-- 2
DELIMITER |
CREATE PROCEDURE fatorial_numero(num INT)
    BEGIN
    DECLARE resultado INT;
    DECLARE numero INT;
	SET resultado = 1;
    SET numero = 1;
    WHILE numero <= num DO
    SET resultado = resultado * numero;
    SET numero = numero + 1;
    END WHILE;
    SELECT num AS `número inserido`, resultado as fatorial;
    END |
DELIMITER ;

CALL fatorial_numero(8);