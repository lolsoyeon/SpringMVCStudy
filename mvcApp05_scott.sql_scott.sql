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



-- MEMBERLIST 입력(추가)★ 쿼리문 구성
INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL, GRADE)
VALUES ('super', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'정미경','010-2222-2222','jmk@test.com', 1);
--==>>1 행 이(가) 삽입되었습니다.

ROLLBACK;


INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL, GRADE) VALUES ('super', CRYPTPACK.ENCRYPT('java002$', 'java002$'),'정미경','010-2222-2222','jmk@test.com', 1)
;

SELECT *
FROM MEMBERLIST;









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
superman	=o???	김태민	010-1111-1111	ktm@test.com	0
superwoman	??{	정미경	010-2222-2222	jmk@test.com	1
*/

DESC MEMBERRECODE;

SELECT *
FROM MEMBERRECODE;
/*
2	50	50	50	superwoman
7	90	80	70	superman
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.

--관리자가 조회하는  MEMBERLSIT 조회 쿼리문
SELECT ID, PW, NAME, TEL, EMAIL, GRADE
FROM MEMBERLISTVIEW
ORDER BY NAME;

-->한 줄 구성
SELECT ID, PW, NAME, TEL, EMAIL, GRADE FROM MEMBERLISTVIEW ORDER BY NAME
;

SELECT *
FROM MEMBERLIST;

-- MEMBERRECODE 전체★ 조회 쿼리문
SELECT SCOREID, KOR, ENG, MAT, ID
FROM MEMBERRECODE 
ORDER BY SCOREID;

--> 한 줄 구성
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


-- 학생 정보 조회 뷰 생성
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
--==>> View MEMBERVIEW이(가) 생성되었습니다.


-- 관리자가 조회하는 전체 ★ 리스트 출력 쿼리문 
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE
FROM MEMBERLISTVIEW;
/*
NAME    ID          PW      TEL             EMAIL         GRADE 국 영 수 DEL  GRADE
superman	=o???	김태민	010-1111-1111	ktm@test.com	7	90	80	70	1	0
superwoman	??{	정미경	010-2222-2222	jmk@test.com	2	50	50	50	1	1
*/


SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE FROM MEMBERLISTVIEW
;


select id, pw, name, tel, email, scoreid, kor, eng, mat, delcheck, grade from memberlistview
;
-- 학생이 조회하는 전체 정보 조회 ★ 쿼리문 구성
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, GRADE
FROM MEMBERLISTVIEW;


DESC MEMBERLISTVIEW;

-- 학생 정보 수정 쿼리문


UPDATE MEMBERLIST
SET PW = CRYPTPACK.ENCRYPT('2345678','2345678'), NAME = '박태민', TEL='010-0000-0000', EMAIL = 'KTM@test.com'
WHERE ID = 'superman';

-- 학생 정보 수정★ 쿼리문 한줄 구성
UPDATE MEMBERLIST SET PW = CRYPTPACK.ENCRYPT('2345678','2345678'), NAME = '박태민', TEL='010-0000-0000', EMAIL = 'KTM@test.com' WHERE ID = 'superman'
;


SELECT *
FROM MEMBERLIST;


SELECT *
FROM MEMBERLIST
WHERE ID = 'superman';

-- 학생 정보 삭제★ 쿼리문
DELETE FROM MEMBERLIST WHERE ID = 'superman'
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



, ( SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE REGIONID = R.REGIONID) AS DELCHECK



--○ 학생 정보 완전 전체 조회 퀴리문 구성 ★
--  (특정 학생 데이터 삭제 가능여부 확인) 6개의 PROPERTY
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
--> 『김태민, 정미경』의 학생 정보는 삭제가 불가능한 데이터이며,
-- 그 외 나머지 학생 정보는 삭제가 가능한 데이터임을 판별할 수 있또록 구성한 쿼리문
/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	1
superwoman	??{	정미경	010-2222-2222	jmk@test.com	1
*/



--- DELCHECK 하기위한 테스트 쿼리문
SELECT COUNT(*)
    FROM MEMBERRECODE
    WHERE ID='superman';
    

--○ 학생 정보 완전 전체 조회 퀴리문 구성 ★
--  (특정 학생 데이터 삭제 가능여부 확인) 11개의 PROPERTY
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

--> 한 줄 구성
SELECT ID, PW, NAME, TEL, EMAIL, SCOREID, KOR, ENG, MAT, DELCHECK, GRADE FROM MEMBERLISTVIEW ORDER BY NAME
;

/*
superman	=o???	김태민	010-1111-1111	ktm@test.com	4	90	80	70	1	0
superwoman	??{	정미경	010-2222-2222	jmk@test.com	2	50	50	50	1	1
*/


SELECT *
FROM MEMBERRECODE;
    
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



-- GRADE 컬럼추가

--  GRADE 컬럼 추가 → 기본값을 1(일반사원)로 구성 ★★
ALTER TABLE MEMBERLIST
MODIFY GRADE NUMBER(1) DEFAULT 1;
--==>> Table EMPLOYEE이(가) 변경되었습니다.

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


-- 학생 성적 정보 전체 ★조회 쿼리문
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

--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567');
--==>> 김태민
--> 일반사원으로 로그인 성공~!!

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('2234567', '2234567');
--==>> 조회 결과 없음
--> 일반사원으로 로그인 실패 ~!!! 비번 틀림



-- 일반사원 로그인 퀴리문 한 줄 구성
SELECT NAME FROM MEMBERLIST WHERE ID = '문자열ID' AND PW = CRYPTPACK.ENCRYPT('문자열PW', '문자열PW')
;




-- 관리자 로그인 쿼리문 구성(아이디, 패스워드, 등급)
-- 사원번호, 주민번호뒷자리, 등급
SELECT NAME
FROM MEMBERLIST
WHERE ID = 아이디
 AND pW = 패스워드
 AND GRADE = 0;

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('2345678', '2345678')
 AND GRADE = 0;
--==>> 조회결과 없음
--> 관리자로 로그인 실패~!!

SELECT NAME
FROM MEMBERLIST
WHERE ID = 'superman'
 AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567')
 AND GRADE = 0;
--=>> 김태민
--> 관리자로 로그인 성공~!!


-->관리자 로그인 쿼리문 한 줄 구성
SELECT NAME FROM MEMBERLIST WHERE ID = 'superman' AND PW = CRYPTPACK.ENCRYPT('1234567', '1234567') AND GRADE = 0
 ;



DELETE
FROM MEMBERRECODEVIEW
WHERE SCOREID = 2;


SELECT *
FROM MEMBERRECODE;


ROLLBACK;
