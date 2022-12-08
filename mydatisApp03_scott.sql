SELECT USER
FROM DUAL;
--==>> SCOTT
/*
  - ���̺� :TBL_STUDENT
  �� ���̺� ���� : SID		 NUMBER		-- PK
  		 , NAME  	 VARCHAR2(30)
  		 , TELEPHONE  	 VARCHAR2(40)
  - ���̺� :TBL_GRADE
  �� ���̺� ���� : SID		 NUMBER		-- PK
  		 , SUB1  	 VARCHAR2(3)
  		 , SUB2  	 VARCHAR2(3)
  		 , SUB3  	 VARCHAR2(3)
  - �� : STUDENTVIEW
  �� �� ���� : SID, NAME, TEL, SUB
                                ---   ���� ���ڵ� ��
  - �� : GRADEVIEW
  �� �� ���� : SID, NAME, SUB1, SUB2 , SUB3, TOT, AVG, CH
                                            ---  ---  ---
                                            ���� ���  ���(�հ�, ����, ���հ�)

*/
-- �ǽ� ���̺� ����
CREATE TABLE TBL_STUDENT
( SID       NUMBER
, NAME      VARCHAR2(30)
, TEL       VARCHAR2(40)
, CONSTRAINT STUDENT_SID_PK PRIMARY KEY(SID)
);
--==>Table TBL_STUDENT��(��) �����Ǿ����ϴ�.

-- ���� ������ �Է�
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(1, '�ֳ���', '010-1111-1111');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(2, '�ڿ���', '010-2222-2222');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(3, '������', '010-3333-3333');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(4, '������', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

SELECT SID, NAME, TEL
FROM TBL_STUDENT;

SELECT COUNT(*) AS COUNT 
FROM GRADEVIEW;


CREATE TABLE TBL_GRADE
( SID NUMBER
, SUB1  NUMBER(3)
, SUB2  NUMBER(3)
, SUB3  NUMBER(3)
, CONSTRAINT GRADE_SID_PK PRIMARY KEY(SID)
, CONSTRAINT GRADE_SID_FK FOREIGN KEY(SID)
            REFERENCES TBL_STUDENT(SID)
, CONSTRAINT GRADE_SUB1_CK CHECK(SUB1 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB2_CK CHECK(SUB2 BETWEEN 0 AND 100)
, CONSTRAINT GRADE_SUB3_CK CHECK(SUB3 BETWEEN 0 AND 100)
);
-- Table TBL_GRADE��(��) �����Ǿ����ϴ�.



INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(1, 90, 80, 70);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(2, 70, 60, 50);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(3, 50, 80, 30);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(4, 90, 90, 30);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

-- Ȯ��
SELECT *
FROM TBL_GRADE;


COMMIT;
--==>> Ŀ�� �Ϸ�.


/* DO
 - �� : STUDENTVIEW
  �� �� ���� : SID, NAME, TEL, SUB
                                ---   ���� ���ڵ� ��
*/

CREATE OR REPLACE VIEW STUDENTVIEW
AS
SELECT SID, NAME, TEL
    , (SELECT COUNT(*) 
       FROM TBL_GRADE
       WHERE SID = S.SID) AS SUB
FROM TBL_STUDENT S;
/*
1	�ֳ���	010-1111-1111	1
2	�ڿ���	010-2222-2222	1
3	������	010-3333-3333	1
4	������	010-4444-4444	1
*/

-- Ȯ��
SELECT *
FROM STUDENTVIEW;



/*
  - �� : GRADEVIEW
  �� �� ���� : SID, NAME, SUB1, SUB2 , SUB3, TOT, AVG, CH
                                            ---  ---  ---
                                            ���� ���  ���(�հ�, ����, ���հ�)
                                                        40 ~ 60          ��� 60�� �̸�  
CREATE OR REPLACE VIEW GRADEVIEW

*/


-- ���� �� ��
CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT SID
, ( SELECT NAME
    FROM TBL_STUDENT
    WHERE SID = G.SID ) AS NAME
, SUB1, SUB2, SUB3
, ( SELECT SUM(SUB1 + SUB2 + SUB3)
    FROM TBL_STUDENT
    WHERE SID = G.SID ) AS TOT
, ( SELECT SUM(SUB1 + SUB2 + SUB3)/3
    FROM TBL_STUDENT
    WHERE SID = G.SID ) AS AVG
, ( SELECT CASE 
  ( SELECT SUM(SUB1 + SUB2 + SUB3)/3
    FROM TBL_STUDENT
    WHERE SID = G.SID ) AS AVG WHEN > 60 THEN 'IN' ELSE 'OUT' END 
    FROM TBL_STUDENT
    WHERE SID = G.SID ) AS CH
FROM TBL_GRADE G;







CREATE OR REPLACE VIEW GRADEVIEW
AS
SELECT S.SID AS SID
    , S.NAME AS NAME
    , G.SUB1 AS SUB1
    , G.SUB2 AS SUB2
    , G.SUB3 AS SUB3
    , (G.SUB1 + G.SUB2 + G.SUB3 ) AS TOT
    , (G.SUB1 + G.SUB2 + G.SUB3 )/3 AS AVG
    , (CASE WHEN (G.SUB1 + G.SUB2 + G.SUB3 )/3 < 60 THEN '���հ�'
        WHEN (G.SUB1<=40) OR (G.SUB2<=40) OR (G.SUB3<=40) THEN '����'
        ELSE '�հ�'
        END) AS CH
FROM TBL_STUDENT S JOIN TBL_GRADE G
ON S.SID = G.SID;


--�� �� ��ȸ
SELECT SID, NAME, TEL, SUB
FROM STUDENTVIEW
ORDER BY SID;


/*
1	�ֳ���	010-1111-1111	1
2	�ڿ���	010-2222-2222	1
3	������	010-3333-3333	1
4	������	010-4444-4444	1
*/
--�� �� ��ȸ
SELECT SID, NAME, SUB1, SUB2,SUB3, TOT, AVG, CH
FROM GRADEVIEW;
/*
2	�ڿ���	70	60	50	180	60	�հ�
3	������	50	80	30	160	53.33333333333333333333333333333333333333	����
4	������	90	90	30	210	70	����
1	�ֳ���	90	80	70	240	80	�հ�
*/

DESC GRADEVIEW;


SID  NOT NULL NUMBER       
NAME          VARCHAR2(30) 
SUB1          NUMBER(3)    
SUB2          NUMBER(3)    
SUB3, TOT, AVG, CH


sid, name, sub1, sub2,sub3, tot, avg, ch


SELECT COUNT(*) AS COUNT
FROM STUDENTVIEW;

SELECT COUNT(*) AS COUNT
FROM TBL_STUDENT;

-- SID �� Ȱ���Ͽ� �л����� �˻�
SELECT SID, NAME, TEL 
FROM STUDENTVIEW
WHERE SID = 1 ;


SELECT *
FROM GRADEVIEW;

SELECT *
FROM TBL_STUDENT;

-- ���� �����غ���
UPDATE TBL_GRADE
SET SUB1=10, SUB2=50, SUB3=60
WHERE SID = 3;

-- �л� ���� �����غ���
UPDATE TBL_STUDENT
SET NAME = '�ֵ���', TEL='010-1111-1110'
WHERE SID = 1;



SELECT *
FROM GRADEVIEW;


COMMIT;


ROLLBACK;

SELECT COUNT(*) AS COUNT 
FROM TBL_GRADE;


SELECT SID, NAME, TEL, SUB
FROM STUDENTVIEW ORDER BY SID;



DELETE
FROM TBL_STUDENT
WHERE SID=4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- �ݵ�� Ŀ���ؾ���
COMMIT;
--==>> Ŀ�� �Ϸ�.