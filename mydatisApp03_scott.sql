SELECT USER
FROM DUAL;
--==>> SCOTT
/*
  - 테이블 :TBL_STUDENT
  · 테이블 구조 : SID		 NUMBER		-- PK
  		 , NAME  	 VARCHAR2(30)
  		 , TELEPHONE  	 VARCHAR2(40)
  - 테이블 :TBL_GRADE
  · 테이블 구조 : SID		 NUMBER		-- PK
  		 , SUB1  	 VARCHAR2(3)
  		 , SUB2  	 VARCHAR2(3)
  		 , SUB3  	 VARCHAR2(3)
  - 뷰 : STUDENTVIEW
  · 뷰 구조 : SID, NAME, TEL, SUB
                                ---   참조 레코드 수
  - 뷰 : GRADEVIEW
  · 뷰 구조 : SID, NAME, SUB1, SUB2 , SUB3, TOT, AVG, CH
                                            ---  ---  ---
                                            총점 평균  등급(합격, 과락, 불합격)

*/
-- 실습 테이블 생성
CREATE TABLE TBL_STUDENT
( SID       NUMBER
, NAME      VARCHAR2(30)
, TEL       VARCHAR2(40)
, CONSTRAINT STUDENT_SID_PK PRIMARY KEY(SID)
);
--==>Table TBL_STUDENT이(가) 생성되었습니다.

-- 샘플 데이터 입력
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(1, '최나윤', '010-1111-1111');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(2, '박원석', '010-2222-2222');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(3, '한은영', '010-3333-3333');
INSERT INTO TBL_STUDENT(SID, NAME, TEL)
VALUES(4, '조현하', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다. * 4

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
-- Table TBL_GRADE이(가) 생성되었습니다.



INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(1, 90, 80, 70);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(2, 70, 60, 50);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(3, 50, 80, 30);
INSERT INTO TBL_GRADE(SID, SUB1, SUB2, SUB3)
VALUES(4, 90, 90, 30);
--==>> 1 행 이(가) 삽입되었습니다. * 4

-- 확인
SELECT *
FROM TBL_GRADE;


COMMIT;
--==>> 커밋 완료.


/* DO
 - 뷰 : STUDENTVIEW
  · 뷰 구조 : SID, NAME, TEL, SUB
                                ---   참조 레코드 수
*/

CREATE OR REPLACE VIEW STUDENTVIEW
AS
SELECT SID, NAME, TEL
    , (SELECT COUNT(*) 
       FROM TBL_GRADE
       WHERE SID = S.SID) AS SUB
FROM TBL_STUDENT S;
/*
1	최나윤	010-1111-1111	1
2	박원석	010-2222-2222	1
3	한은영	010-3333-3333	1
4	조현하	010-4444-4444	1
*/

-- 확인
SELECT *
FROM STUDENTVIEW;



/*
  - 뷰 : GRADEVIEW
  · 뷰 구조 : SID, NAME, SUB1, SUB2 , SUB3, TOT, AVG, CH
                                            ---  ---  ---
                                            총점 평균  등급(합격, 과락, 불합격)
                                                        40 ~ 60          평균 60점 미만  
CREATE OR REPLACE VIEW GRADEVIEW

*/


-- 내가 한 것
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
    , (CASE WHEN (G.SUB1 + G.SUB2 + G.SUB3 )/3 < 60 THEN '불합격'
        WHEN (G.SUB1<=40) OR (G.SUB2<=40) OR (G.SUB3<=40) THEN '과락'
        ELSE '합격'
        END) AS CH
FROM TBL_STUDENT S JOIN TBL_GRADE G
ON S.SID = G.SID;


--○ 뷰 조회
SELECT SID, NAME, TEL, SUB
FROM STUDENTVIEW
ORDER BY SID;


/*
1	최나윤	010-1111-1111	1
2	박원석	010-2222-2222	1
3	한은영	010-3333-3333	1
4	조현하	010-4444-4444	1
*/
--○ 뷰 조회
SELECT SID, NAME, SUB1, SUB2,SUB3, TOT, AVG, CH
FROM GRADEVIEW;
/*
2	박원석	70	60	50	180	60	합격
3	한은영	50	80	30	160	53.33333333333333333333333333333333333333	과락
4	조현하	90	90	30	210	70	과락
1	최나윤	90	80	70	240	80	합격
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

-- SID 를 활용하여 학생정보 검색
SELECT SID, NAME, TEL 
FROM STUDENTVIEW
WHERE SID = 1 ;


SELECT *
FROM GRADEVIEW;

SELECT *
FROM TBL_STUDENT;

-- 성적 수정해보기
UPDATE TBL_GRADE
SET SUB1=10, SUB2=50, SUB3=60
WHERE SID = 3;

-- 학생 정보 수정해보기
UPDATE TBL_STUDENT
SET NAME = '최동현', TEL='010-1111-1110'
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
--==>> 1 행 이(가) 삭제되었습니다.

-- 반드시 커밋해야함
COMMIT;
--==>> 커밋 완료.