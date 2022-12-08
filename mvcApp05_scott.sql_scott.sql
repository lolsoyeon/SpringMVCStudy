SELECT USER
FROM DUAL;
--==>> SCOTT

--○ MEMBERLIST 테이블 생성 (부모)
CREATE TABLE MEMBERLIST
( ID VARCHAR2(20)
, PW VARCHAR2(20)
, NAME VARCHAR2(50)
, TEL  VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT MEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==Table MEMBERLIST이(가) 생성되었습니다.

--○ MEMBERLIST 데이터 입력
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES ('superman', CRYPTPACK.ENCRYPT('1234567', '1234567'),'김태민','010-1111-1111','ktm@test.com');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)
VALUES ('superwoman', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'정미경','010-2222-2222','jmk@test.com');
--==>>1 행 이(가) 삽입되었습니다.


--○ MEMBERRECODE 테이블 생성 (식별 관계, 자식)
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
--==>>Table MEMBERRECODE이(가) 생성되었습니다.


--○ MEMBERRECOREDSEQ 시퀀스 생성
CREATE SEQUENCE MEMBERRECOREDSEQ
NOCACHE;
--==>> Sequence MEMBERRECOREDSEQ이(가) 생성되었습니다.


--○ MEMBERRECORED 데이터 입력
INSERT INTO MEMBERRECODE(SCOREID, KOR, ENG, MAT, ID)
VALUES(MEMBERRECOREDSEQ.NEXTVAL, 90, 80, 70, 'superman');
--==>>1 행 이(가) 삽입되었습니다.


-- 학생 성적 정보 ★입력 쿼리문 한줄 구성
INSERT INTO MEMBERRECODE(SCOREID, KOR, ENG, MAT, ID) VALUES(MEMBERRECOREDSEQ.NEXTVAL, 50, 50, 50, 'superwoman')
;
--==>> 1 행 이(가) 삽입되었습니다.


SELECT *
FROM MEMBERLIST;
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com
superwoman	??{	정미경	010-2222-2222	jmk@test.com
*/


SELECT *
FROM MEMBERRECODE;
/*
1	90	80	70	superman
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.

-- MEMBERLSIT 전체 조회 쿼리문
SELECT ID, PW, NAME, TEL, EMAIL, GRADE
FROM MEMBERLIST
ORDER BY NAME;

-->한 줄 구성
SELECT ID, PW, NAME, TEL, EMAIL, GRADE FROM MEMBERLIST ORDER BY NAME
;

SELECT *
FROM MEMBERLIST;

-- MEMBERRECODE 전체 조회 쿼리문
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECODE
ORDER BY SCOREID;

--> 한 줄 구성
SELECT SCOREID, KOR, ENG, MAT, ID FROM MEMBERRECODE ORDER BY SCOREID
;




-- 학생 정보 조회 쿼리문 구성
SELECT M.NAME AS NAME
    , ( SELECT M.ID
        FROM MEMBERRECODE
        WHERE ID = M.ID)AS ID
    , M.PW AS PW
    , M.TEL AS TEL
    , M.EMAIL AS EMAIL
    , M.GRADE AS GRADE
FROM MEMBERLIST M;


-- 학생 정보 조회 뷰 생성 (뷰 이름 : MEMBERLISTVIEW)
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
--==>> View MEMBERLISTVIEW이(가) 생성되었습니다.

SELECT *
FROM MEMBERLISTVIEW;
/*
NAME    ID          PW      TEL             EMAIL
김태민	superman	=o???	010-1111-1111	ktm@test.com
정미경	superwoman	??{	010-2222-2222	jmk@test.com
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

--○ 커밋
COMMIT;
--==>> 커밋 완료.



-- 학생 정보 삭제 쿼리문

DELETE
FROM MEMBERLIST
WHERE ID = 'superwoman';


DELETE FROM MEMBERLIST WHERE ID = 'superwoman'
;


-- 관리자가 조회하는 직원 정보 전체 쿼리문 
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



--○ 학생 정보 완전 전체 조회 퀴리문 구성
--  (특정 학생 데이터 삭제 가능여부 확인) 10개의 PROPERTY
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
--> 『김태민, 정미경』의 학생 정보는 삭제가 불가능한 데이터이며,
-- 그 외 나머지 학생 정보는 삭제가 가능한 데이터임을 판별할 수 있도록 구성한 쿼리문
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	1
superwoman	??{	정미경	010-2222-2222	jmk@test.com	1
*/



--- DELCHECK 하기위한 테스트 쿼리문
SELECT COUNT(*)
    FROM MEMBERRECODE
    WHERE ID='superman';
    
    
    
-- 학생 성적 정보 ★삭제 쿼리문
DELETE
FROM MEMBERRECODE
WHERE ID = 'superman';
--==>> 1 행 이(가) 삭제되었습니다.

-->> 한 줄 구성
DELETE FROM MEMBERRECODE WHERE ID = 'superman'
;

COMMIT;

-- 학생 성적 정보 ★수정 쿼리문 구성
UPDATE MEMBERRECODE
SET KOR=60, ENG=60, MAT=60
WHERE ID='superman';


UPDATE MEMBERRECODE SET KOR=60, ENG=60, MAT=60 WHERE ID='superman'
;


ROLLBACK;

--
SELECT * 
FROM MEMBERRECODE;


-- MEMBERRECODE 에서 GRADE 컬럼 삭제
ALTER TABLE MEMBERRECODE
DROP COLUMN GRADE;


SELECT *
FROM MEMBERRECODE;




SELECT *
FROM MEMBERLIST;


ALTER TABLE MEMBERLIST
ADD GRADE NUMBER(1) DEFAULT 1;
--==>> Table MEMBERLIST이(가) 변경되었습니다.

-- 관리자로 id superman 을 수정하는 쿼리문 구성
UPDATE MEMBERLIST
SET GRADE = 0
WHERE ID = 'superman';




-- 관리자 로그인 쿼리문 구성(아이디, 패스워드, 등급)
-- 사원번호, 주민번호뒷자리, 등급
SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW =CRYPTPACK.ENCRYPT('1234567', '1234567')
 AND GRADE = 0;
--==>> 관리자로 로그인 성공~!!!
 
SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW =CRYPTPACK.ENCRYPT('JAVA002', 'JAVA002')
 AND GRADE = 0; 
--==>> 조회 결과 없음
--> 관리자로 로그인 실패~!!!


SELECT NAME FROM MEMBERLIST WHERE ID = '문자열ID' AND PW =CRYPTPACK.ENCRYPT('문자열 PW', '문자열 PW') AND GRADE = 0
; 

-- 비밀번호가 맞을경우1 아니면 0 
SELECT COUNT(*)AS COUNT
FROM MEMBERLIST
WHERE ID = 'superman'
AND PW = CRYPTPACK.ENCRYPT('2234565', '2234565');
--==>> 0

--> 한 줄 구성
SELECT COUNT(*)AS COUNT FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('2234565', '2234565')
;


SELECT COUNT(*)AS COUNT
FROM MEMBERLIST
WHERE ID = 'superman'
AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> 1
--> 한 줄 구성
SELECT COUNT(*)AS COUNT FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
;












