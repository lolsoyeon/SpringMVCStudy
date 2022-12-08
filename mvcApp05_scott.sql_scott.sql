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

INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES ('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'���̰�','010-2222-2222','jmk@test.com');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.


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
superman	=o???	���¹�	010-1111-1111	ktm@test.com
superwoman	??{	���̰�	010-2222-2222	jmk@test.com
*/


SELECT *
FROM MEMBERRECODE;
/*
1	90	80	70	superman
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- MEMBERLSIT ��ü ��ȸ ������
SELECT ID, PW, NAME, TEL, EMAIL, GRADE
FROM MEMBERLIST
ORDER BY NAME;

-->�� �� ����
SELECT ID, PW, NAME, TEL, EMAIL, GRADE FROM MEMBERLIST ORDER BY NAME
;

SELECT *
FROM MEMBERLIST;

-- MEMBERRECODE ��ü ��ȸ ������
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECODE
ORDER BY SCOREID;

--> �� �� ����
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECODE ORDER BY SCOREID
;




-- �л� ���� ��ȸ ������ ����
SELECT M.NAME AS NAME
    , ( SELECT M.ID
        FROM MEMBERRECODE
        WHERE ID = M.ID)AS ID
    , M.PW AS PW
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    , M.GRADE AS GRADE
FROM MEMBERLIST M;


-- �л� ���� ��ȸ �� ���� (�� �̸� : MEMBERLISTVIEW)
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
--==>> View MEMBERLISTVIEW��(��) �����Ǿ����ϴ�.

SELECT *
FROM MEMBERLISTVIEW;
/*
NAME    ID          PW      TEL             EMAIL
���¹�	superman	=o???	010-1111-1111	ktm@test.com
���̰�	superwoman	??{	010-2222-2222	jmk@test.com
*/

CREATE OR REPLACE VIEW MEMBERRECODEVIEW
AS 
SELECT R.SCOREID 
    , R.KOR AS KOR
    , R.ENG AS ENG
    , R.MAT AS MAT
    , ( SELECT R.ID
        FROM MEMBERLIST 
        WHERE ID=R.ID) AS ID
FROM MEMBERRECODE R;


SELECT *
FROM MEMBERRECODEVIEW;
/*
SCOREID   KOR   ENG MAT  ID
1	      90	    80	70	superman
2	      50    	50	50	superwoman
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.



-- �л� ���� ���� ������

DELETE
FROM MEMBERLIST
WHERE ID = 'superwoman';


DELETE FROM MEMBERLIST WHERE ID = 'superwoman'
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



SELECT *
FROM LISTVIEW;

, ( SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE REGIONID = R.REGIONID) AS DELCHECK



--�� �л� ���� ���� ��ü ��ȸ ������ ����
--  (Ư�� �л� ������ ���� ���ɿ��� Ȯ��) 10���� PROPERTY
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
FROM MEMBERLIST M;
--> �����¹�, ���̰桻�� �л� ������ ������ �Ұ����� �������̸�,
-- �� �� ������ �л� ������ ������ ������ ���������� �Ǻ��� �� �ֵ��� ������ ������
/*
superman	=o???	���¹�	010-1111-1111	ktm@test.com	1
superwoman	??{	���̰�	010-2222-2222	jmk@test.com	1
*/



--- DELCHECK �ϱ����� �׽�Ʈ ������
SELECT COUNT(*)
    FROM MEMBERRECODE
    WHERE ID='superman';
    
    
    
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

--
SELECT * 
FROM MEMBERRECODE;


-- MEMBERRECODE ���� GRADE �÷� ����
ALTER TABLE MEMBERRECODE
DROP COLUMN GRADE;


SELECT *
FROM MEMBERRECODE;




SELECT *
FROM MEMBERLIST;


ALTER TABLE MEMBERLIST
ADD GRADE NUMBER(1) DEFAULT 1;
--==>> Table MEMBERLIST��(��) ����Ǿ����ϴ�.

-- �����ڷ� id superman �� �����ϴ� ������ ����
UPDATE MEMBERLIST
SET GRADE = 0
WHERE ID = 'superman';




-- ������ �α��� ������ ����(���̵�, �н�����, ���)
-- �����ȣ, �ֹι�ȣ���ڸ�, ���
SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW =CRYPTPACK.ENCRYPT('1234567', '1234567')
 AND GRADE = 0;
--==>> �����ڷ� �α��� ����~!!!
 
SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW =CRYPTPACK.ENCRYPT('JAVA002', 'JAVA002')
 AND GRADE = 0; 
--==>> ��ȸ ��� ����
--> �����ڷ� �α��� ����~!!!


SELECT NAME FROM MEMBERLIST WHERE ID = '���ڿ�ID' AND PW =CRYPTPACK.ENCRYPT('���ڿ� PW', '���ڿ� PW') AND GRADE = 0
; 

-- ��й�ȣ�� �������1 �ƴϸ� 0 
SELECT COUNT(*)AS COUNT
FROM MEMBERLIST
WHERE ID = 'superman'
AND PW = CRYPTPACK.ENCRYPT('2234565', '2234565');
--==>> 0

--> �� �� ����
SELECT COUNT(*)AS COUNT FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('2234565', '2234565')
;


SELECT COUNT(*)AS COUNT
FROM MEMBERLIST
WHERE ID = 'superman'
AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> 1
--> �� �� ����
SELECT COUNT(*)AS COUNT FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
;












