SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ���� ���̺� ����
DROP TABLE TBL_MEMBERLIST PURGE;
--==>>


--�� �ǽ� ���̺� �ٽ� ����(TBL_MEMBERLIST)
CREATE TABLE TBL_MEMBERLIST07
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT TBLMEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST07��(��) �����Ǿ����ϴ�.

--�� ������ �Է�(TBL_MEMBERLIST07)
INSERT INTO TBL_MEMBERLIST07(ID, PW, NAME, TEL, EMAIL)
VALUES('admin', CRYPTPACK.ENCRYPT('java002$','java002$'), '������', '010-5235-3831', 'admin@test.com');

INSERT INTO TBL_MEMBERLIST07(ID, PW, NAME, TEL, EMAIL) VALUES('admin', CRYPTPACK.ENCRYPT('java002$','java002$'), '������', '010-5235-3831', 'admin@test.com')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
SELECT *
FROM TBL_MEMBERLIST07;
--==>> admin	??{	������	010-5235-3831	admin@test.com

--�� Ŀ��
COMMIT;
--==>Ŀ�� �Ϸ�.

--�� ����Ʈ ��ȸ ������ ����(�н������ ����Ʈ ��ȸ �׸񿡼� ����)
SELECT ID, NAME, TEL, EMAIL
FROM TBL_MEMBERLIST07;
--> �� �� ����
SELECT ID, NAME, TEL, EMAIL FROM TBL_MEMBERLIST07
;
--==>> admin	������	010-5235-3831	admin@test.com

--�� �ο� �� Ȯ�� ������ ����
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST07;
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST07
;
--==>> 1