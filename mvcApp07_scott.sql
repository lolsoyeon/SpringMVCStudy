SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 기존 테이블 제거
DROP TABLE TBL_MEMBERLIST PURGE;
--==>>


--○ 실습 테이블 다시 생성(TBL_MEMBERLIST)
CREATE TABLE TBL_MEMBERLIST07
( ID    VARCHAR2(30)
, PW    VARCHAR2(20)
, NAME  VARCHAR2(50)
, TEL   VARCHAR2(50)
, EMAIL VARCHAR2(100)
, CONSTRAINT TBLMEMBERLIST_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_MEMBERLIST07이(가) 생성되었습니다.

--○ 데이터 입력(TBL_MEMBERLIST07)
INSERT INTO TBL_MEMBERLIST07(ID, PW, NAME, TEL, EMAIL)
VALUES('admin', CRYPTPACK.ENCRYPT('java002$','java002$'), '장현성', '010-5235-3831', 'admin@test.com');

INSERT INTO TBL_MEMBERLIST07(ID, PW, NAME, TEL, EMAIL) VALUES('admin', CRYPTPACK.ENCRYPT('java002$','java002$'), '장현성', '010-5235-3831', 'admin@test.com')
;
--==>> 1 행 이(가) 삽입되었습니다.
SELECT *
FROM TBL_MEMBERLIST07;
--==>> admin	??{	장현성	010-5235-3831	admin@test.com

--○ 커밋
COMMIT;
--==>커밋 완료.

--○ 리스트 조회 쿼리문 구성(패스워드는 리스트 조회 항목에서 제외)
SELECT ID, NAME, TEL, EMAIL
FROM TBL_MEMBERLIST07;
--> 한 줄 구성
SELECT ID, NAME, TEL, EMAIL FROM TBL_MEMBERLIST07
;
--==>> admin	장현성	010-5235-3831	admin@test.com

--○ 인원 수 확인 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST07;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST07
;
--==>> 1