SELECT USER
FROM DUAL;
--==>> SCOTT

--�� MEMBERLIST ���̺� ���� (�θ�)
CREATE TABLE MEMBERLIST
( ID VARCHAR2(20)
, PW VARCHAR2(20)
, NAME VARCHAR2(50)
, TEL  VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT MEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==Table MEMBERLIST��(��) �����Ǿ����ϴ�.

--�� MEMBERLIST ������ �Է�
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES ('superman', CRYPTPACK.ENCRYPT('1234567', '1234567'),'���¹�','010-1111-1111','ktm@test.com');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.



-- MEMBERLIST �Է�(�߰�)�� ������ ����
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL, GRADE)
VALUES ('super', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'���̰�','010-2222-2222','jmk@test.com', 1);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.

ROLLBACK;


INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL, GRADE) VALUES ('super', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'���̰�','010-2222-2222','jmk@test.com', 1)
;

SELECT *
FROM MEMBERLIST;









--�� MEMBERRECODE ���̺� ���� (�ĺ� ����, �ڽ�)
CREATE TABLE MEMBERRECODE
( SCOREID   NUMBER
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, ID        VARCHAR2(20)
, CONSTRAINT MEMBERRECORD_SCOREID_PK PRIMARY KEY(ID)
, CONSTRAINT MEMBERRECORD_KOR_CK CHECK(KOR>=0 AND KOR<=100)
, CONSTRAINT MEMBERRECORD_ENG_CK CHECK(ENG>=0 AND ENG<=100)
, CONSTRAINT MEMBERRECORD_MAT_CK CHECK(MAT>=0 AND MAT<=100)
, CONSTRAINT MEMBERRECORD_ID_FK FOREIGN KEY(ID)
            REFERENCES MEMBERLIST(ID)
);
--==>>Table MEMBERRECODE��(��) �����Ǿ����ϴ�.


--�� MEMBERRECOREDSEQ ������ ����
CREATE SEQUENCE MEMBERRECOREDSEQ
NOCACHE;
--==>> Sequence MEMBERRECOREDSEQ��(��) �����Ǿ����ϴ�.


--�� MEMBERRECORED ������ �Է�
INSERT INTO MEMBERRECODE(SCOREID, KOR, ENG, MAT, ID)
VALUES(MEMBERRECOREDSEQ.NEXTVAL, 90, 80, 70, 'superman');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.


-- �л� ���� ���� ���Է� ������ ���� ����
INSERT INTO MEMBERRECODE(SCOREID, KOR, ENG, MAT, ID) VALUES(MEMBERRECOREDSEQ.NEXTVAL, 50, 50, 50, 'superwoman')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT *
FROM MEMBERLIST;
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	0
superwoman	??{	���̰�	010-2222-2222	jmk@test.com	1
*/

DESC MEMBERRECODE;

SELECT *
FROM MEMBERRECODE;
/*
2	50	50	50	superwoman
7	90	80	70	superman
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�����ڰ� ��ȸ�ϴ�  MEMBERLSIT ��ȸ ������
SELECT ID, PW, NAME, TEL, EMAIL, GRADE
FROM MEMBERLISTVIEW
ORDER BY NAME;

-->�� �� ����
SELECT ID, PW, NAME, TEL, EMAIL, GRADE FROM MEMBERLISTVIEW ORDER BY NAME
;

SELECT *
FROM MEMBERLIST;

-- MEMBERRECODE ��ü�� ��ȸ ������
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECODE 
ORDER BY SCOREID;

--> �� �� ����
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECODE ORDER BY SCOREID
;



SELECT M.NAME AS NAME
    , ( SELECT M.ID
        FROM MEMBERRECODE
        WHERE ID = M.ID)AS ID
    , M.PW AS PW
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    , M.GRADE AS GRADE
FROM MEMBERLIST M;


-- �л� ���� ��ȸ �� ����
CREATE OR REPLACE VIEW MEMBERLISTVIEW
AS 
SELECT M.NAME AS NAME
    , ( SELECT M.ID
        FROM MEMBERRECODE
        WHERE ID = M.ID)AS ID
    , M.PW AS PW
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    , M.GRADE AS GRADE
FROM MEMBERLIST M;
--==>> View MEMBERVIEW��(��) �����Ǿ����ϴ�.


-- �����ڰ� ��ȸ�ϴ� ��ü �� ����Ʈ ��� ������ 
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE
FROM MEMBERLISTVIEW;
/*
NAME    ID          PW      TEL             EMAIL         GRADE �� �� �� DEL  GRADE
superman	=o???	���¹�	010-1111-1111	ktm@test.com	7	90	80	70	1	0
superwoman	??{	���̰�	010-2222-2222	jmk@test.com	2	50	50	50	1	1
*/


SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE FROM MEMBERLISTVIEW
;


select id, pw, name, tel, email, scoreid, kor, eng, mat, delcheck, grade from memberlistview
;
-- �л��� ��ȸ�ϴ� ��ü ���� ��ȸ �� ������ ����
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, GRADE
FROM MEMBERLISTVIEW;


DESC MEMBERLISTVIEW;

-- �л� ���� ���� ������


UPDATE MEMBERLIST
SET PW = CRYPTPACK.ENCRYPT('2345678','2345678'), NAME = '���¹�', TEL='010-0000-0000', EMAIL = 'KTM@test.com'
WHERE ID = 'superman';

-- �л� ���� ������ ������ ���� ����
UPDATE MEMBERLIST SET PW = CRYPTPACK.ENCRYPT('2345678','2345678'), NAME = '���¹�', TEL='010-0000-0000', EMAIL = 'KTM@test.com' WHERE ID = 'superman'
;


SELECT *
FROM MEMBERLIST;


SELECT *
FROM MEMBERLIST
WHERE ID = 'superman';

-- �л� ���� ������ ������
DELETE FROM MEMBERLIST WHERE ID = 'superman'
;


-- �����ڰ� ��ȸ�ϴ� ���� ���� ��ü ������  
SELECT M.ID, M.PW, M.NAME, M.TEL, M.EMAIL,R.SCOREID, R.KOR, R.ENG, R.MAT
FROM MEMBERLIST M JOIN MEMBERRECODE R
ON M.ID=R.ID;


CREATE OR REPLACE VIEW LISTVIEW
AS 
SELECT M.ID, M.PW, M.NAME, M.TEL, M.EMAIL,R.SCOREID, R.KOR, R.ENG, R.MAT
FROM MEMBERLIST M JOIN MEMBERRECODE R
ON M.ID=R.ID;



, ( SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE REGIONID = R.REGIONID) AS DELCHECK



--�� �л� ���� ���� ��ü ��ȸ ������ ���� ��
--  (Ư�� �л� ������ ���� ���ɿ��� Ȯ��) 6���� PROPERTY
SELECT M.ID AS ID 
    , M.PW AS PW
    , M.NAME AS NAME
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    ,(SELECT SCOREID
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS SCOREID
    ,(SELECT KOR
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS KOR
    ,(SELECT ENG
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS ENG
    ,(SELECT MAT
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS MAT
    ,( SELECT COUNT(*)
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS DELCHECK
    , M.GRADE AS GRADE
FROM MEMBERLIST M;
--> �����¹�, ���̰桻�� �л� ������ ������ �Ұ����� �������̸�,
-- �� �� ������ �л� ������ ������ ������ ���������� �Ǻ��� �� �ֶǷ� ������ ������
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	1
superwoman	??{	���̰�	010-2222-2222	jmk@test.com	1
*/



--- DELCHECK �ϱ����� �׽�Ʈ ������
SELECT COUNT(*)
    FROM MEMBERRECODE
    WHERE ID='superman';
    

--�� �л� ���� ���� ��ü ��ȸ ������ ���� ��
--  (Ư�� �л� ������ ���� ���ɿ��� Ȯ��) 11���� PROPERTY
CREATE OR REPLACE VIEW MEMBERLISTVIEW
AS 
SELECT M.ID AS ID 
    , M.PW AS PW
    , M.NAME AS NAME
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    ,(SELECT SCOREID
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS SCOREID
    ,(SELECT KOR
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS KOR
    ,(SELECT ENG
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS ENG
    ,(SELECT MAT
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS MAT
    ,( SELECT COUNT(*)
        FROM MEMBERRECODE
        WHERE ID=M.ID) AS DELCHECK
    , M.GRADE AS GRADE
FROM MEMBERLIST M;


SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE
FROM MEMBERLISTVIEW
ORDER BY NAME;

--> �� �� ����
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE FROM MEMBERLISTVIEW ORDER BY NAME
;

/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	4	90	80	70	1	0
superwoman	??{	���̰�	010-2222-2222	jmk@test.com	2	50	50	50	1	1
*/


SELECT *
FROM MEMBERRECODE;
    
-- �л� ���� ���� �ڻ��� ������
DELETE
FROM MEMBERRECODE
WHERE ID = 'superman';
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-->> �� �� ����
DELETE FROM MEMBERRECODE WHERE ID = 'superman'
;

COMMIT;

-- �л� ���� ���� �ڼ��� ������ ����
UPDATE MEMBERRECODE
SET KOR=60, ENG=60, MAT=60
WHERE ID='superman';


UPDATE MEMBERRECODE SET KOR=60, ENG=60, MAT=60 WHERE ID='superman'
;

ROLLBACK;



-- GRADE �÷��߰�

--  GRADE �÷� �߰� �� �⺻���� 1(�Ϲݻ��)�� ���� �ڡ�
ALTER TABLE MEMBERLIST
MODIFY GRADE NUMBER(1) DEFAULT 1;
--==>> Table EMPLOYEE��(��) ����Ǿ����ϴ�.

SELECT *
FROM MEMBERLISTVIEW;

DESC MEMBERLIST;

CREATE OR REPLACE VIEW MEMBERRECODEVIEW
AS 
SELECT R.SCOREID 
    , R.KOR AS KOR
    , R.ENG AS ENG
    , R.MAT AS MAT
    , ( SELECT R.ID
        FROM MEMBERLIST 
        WHERE ID=R.ID) AS ID
    , ( SELECT NAME
        FROM MEMBERLIST
        WHERE ID=R.ID) AS NAME
FROM MEMBERRECODE R;


-- �л� ���� ���� ��ü ����ȸ ������
SELECT NAME, ID, SCOREID, KOR, ENG, MAT
FROM MEMBERRECODEVIEW
ORDER BY NAME;
/*
SCOREID   KOR   ENG MAT  ID
1	      90	80	70	superman
2	      50	50	50	superwoman
*/


SELECT NAME, ID, SCOREID, KOR, ENG, MAT FROM MEMBERRECODEVIEW ORDER BY NAME
;

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> ���¹�
--> �Ϲݻ������ �α��� ����~!!

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('2234567', '2234567');
--==>> ��ȸ ��� ����
--> �Ϲݻ������ �α��� ���� ~!!! ��� Ʋ��



-- �Ϲݻ�� �α��� ������ �� �� ����
SELECT NAME FROM MEMBERLIST WHERE ID = '���ڿ�ID' AND PW = CRYPTPACK.ENCRYPT('���ڿ�PW', '���ڿ�PW')
;




-- ������ �α��� ������ ����(���̵�, �н�����, ���)
-- �����ȣ, �ֹι�ȣ���ڸ�, ���
SELECT NAME
FROM MEMBERLIST
WHERE ID = ���̵�
 AND pW = �н�����
 AND GRADE = 0;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('2345678', '2345678')
 AND GRADE = 0;
--==>> ��ȸ��� ����
--> �����ڷ� �α��� ����~!!

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
 AND GRADE = 0;
--=>> ���¹�
--> �����ڷ� �α��� ����~!!


-->������ �α��� ������ �� �� ����
SELECT NAME FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567') AND GRADE = 0
 ;



DELETE
FROM MEMBERRECODEVIEW
WHERE SCOREID = 2;


SELECT *
FROM MEMBERRECODE;


ROLLBACK;
