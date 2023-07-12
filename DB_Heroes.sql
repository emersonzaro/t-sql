
CREATE DATABASE HEROES;
USE HEROES

CREATE TABLE CLASSE (
	ID_CLASSE INT PRIMARY KEY,
	NOME_CLASSE CHAR(20)
)
go

CREATE TABLE COMICS (
	ID INT PRIMARY KEY,
	NOME CHAR(20),
	EDITORA CHAR(20),
	ID_CLASSE INT,
	TAMANHO CHAR(1) null,
	FOREIGN KEY(ID_CLASSE) REFERENCES CLASSE(ID_CLASSE)
)
go

INSERT INTO CLASSE VALUES (1, 'HEROI');
INSERT INTO CLASSE VALUES (2, 'VILAO');
go

INSERT INTO COMICS VALUES (1, 'Superman', 'DC', 1, 'M');
INSERT INTO COMICS VALUES (2, 'Batman', 'DC', 1, null);
INSERT INTO COMICS VALUES (3, 'Wonder Women', 'DC', 1, null);
INSERT INTO COMICS VALUES (4, 'Green Lantern', 'DC', 1, null);
INSERT INTO COMICS VALUES (5, 'Flash', 'DC', 1, null);
INSERT INTO COMICS VALUES (6, 'Iron Man', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (7, 'Black Widow', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (8, 'Joker', 'DC', 2, null);
INSERT INTO COMICS VALUES (9, 'Green Globin', 'MARVEL', 2, null);
INSERT INTO COMICS VALUES (10, 'Captain America', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (11, 'Daredevil', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (12, 'Silver Surfer', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (13, 'Human Torch', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (14, 'Lex Luthor', 'DC', 2, null);
INSERT INTO COMICS VALUES (15, 'Thor', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (16, 'Hulk', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (17, 'Aquaman', 'DC', 1, null);
INSERT INTO COMICS VALUES (18, 'Loki', 'MARVEL', 2, null);
INSERT INTO COMICS VALUES (19, 'Wolverine', 'MARVEL', 1, null);
INSERT INTO COMICS VALUES (20, 'Magneto', 'MARVEL', 2, null);
go
 
SELECT * FROM CLASSE
SELECT * FROM COMICS


-- 1) Escreva uma rotina para exibir os nomes dos herois que possuam 10 ou menos caracteres.
-- Liste os mesmos em ordem alfabética.

select NOME from COMICS 
where LEN(NOME) <= 10
order by 1;


-- 2) Escreva uma rotina para "batizar" o atributo TAMANHO de acordo com o tamanho do nome do personagem da seguinte forma:
//* 'P' - Nomes até 5 caracteres
    'M' - Nomes de 6 até 10 caracteres
    'G' - Nomes acima de 10 caracteres
  Atualmente, somente 'Superman' está "batizado".*//

--INSERT INTO COMICS (ID, NOME, EDITORA, ID_CLASSE, TAMANHO)
SELECT
		ID, NOME, EDITORA, ID_CLASSE,
		CASE 
			WHEN LEN(NOME) <= 5 THEN 'P'
			WHEN LEN(NOME) >= 6 AND LEN(NOME) <= 10 THEN 'M'
			ELSE 'G'
		END	AS TAMANHO	
FROM COMICS 
ORDER BY NOME


-- 3) Implemente uma solução para evitar o cadastro de uma EDITORA diferente de MARVEL/DC

GO
CREATE TRIGGER TRG_BLOCK_CADASTRO
ON COMICS
FOR INSERT
AS BEGIN
--DECLARE @ID INT,@NOME CHAR, @EDITORA CHAR, @ID_CLASSE INT, @TAMANHO CHAR

	SELECT EDITORA  FROM COMICS
		WHERE EDITORA NOT LIKE 'DC' AND EDITORA NOT LIKE 'MARVEL'
		BEGIN
			--INSERT INTO COMICS (ID, NOME, EDITORA, ID_CLASSE, TAMANHO)
			--VALUES (@ID, @NOME, @EDITORA, @ID_CLASSE, @TAMANHO)
			RAISERROR ('Operações de Cadastro da Editora não conferem na tabela.',16, 1);
			ROLLBACK;
		END
END

DROP TRIGGER TRG_BLOCK_CADASTRO

SELECT EDITORA FROM COMICS
WHERE EDITORA NOT LIKE 'DC' AND EDITORA NOT LIKE '%MARVEL'

INSERT INTO COMICS VALUES (35, 'ROBIN NULL', 'DC', 1, null);


-- 4) Implemente uma solução uƟlizando uma stored procedure para listar o nome de um personagem, e se o mesmo é HEROI ou VILAO.

GO
CREATE PROCEDURE sp_heroi_vilao @CLASSE AS varchar(50) = '%'
AS
BEGIN

SELECT 
		NOME,
		NOME_CLASSE
		FROM COMICS  C
		JOIN CLASSE CL 
		ON C.ID_CLASSE = CL.ID_CLASSE	
	WHERE NOME LIKE @CLASSE
		
END

DROP PROCEDURE sp_heroi_vilao

SELECT * FROM COMICS

EXEC sp_heroi_vilao @CLASSE = 'Joker'


/** 5) Com os dados fornecidos, é possível garantir que somente sejam cadastrados HEROIS e
VILOES na tabela COMICS?
Se sim, explique como. Se não, o que deveria ser feito para garanƟr isso?

Creio que não, pois você pode fazer um insert de nome qualquer na tabela CLASSE se ela não
for tratada.

O que pode ser feito seria a trigger que implementei na questão de número 3 ou revogar os
acessos de determinado usuário para não poder inserir mais dados nela (DCL : GRANT,
REVOKE E DENY.) **/


-- 6) Utilizando as tabelas do item 2, como também objetos de banco de dados que julgar necessários
-- (Funções/Procedures/Check Constraints/Foreign Keys/Tabelas/Triggers/etc):

--a. Liste a quantidade de personagens agrupando por editora e tamanho (campo “batizado” no
--exercicio 2). Liste em ordem crescente de nome de editora e decrescente da quanƟdade.


SELECT DISTINCT COUNT(NOME) NOME, EDITORA, COUNT(TAMANHO)
FROM COMICS
GROUP BY EDITORA, TAMANHO
ORDER BY EDITORA ASC, COUNT(NOME) DESC




--b. Qual Editora possui o personagem com número maior de caracteres? Qual a quanƟdade de caracteres deste personagem?


--A Marvel com o Capitão América. Ele tem 15 caracteres

--11	15	Captain America     	MARVEL              


Select len(NOME) AS TOTAL_CHAR, NOME, EDITORA from COMICS
ORDER BY LEN(NOME) DESC


