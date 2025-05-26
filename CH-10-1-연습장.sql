-- 테이블에 테이터 추가하기 
-- 기본 문법 , 열의 순서에는 상관없음
-- INSERT INTO 테이블명 (열1,열2,...) VALUES (값1,값2,...);

-- 열 이름 생략 , 테이블에 정의된 열의 순서대로 작성하기. 
-- INSERT INTO 테이블명 VALUES (값1,값2,...);

-- NULL 삽입 , 날짜 입력
-- INSER INTO 테이블명 VALUES (101,NULL,'2025/05/22', SYSDATE)

-- 서브쿼리 삽입
-- INSERT INTO 테이블명 (열1,열2)
-- SELECT 열1, 열2 FROM 다른 테이블 WHERE 조건;

-- 예시
-- 열 지정 INSERT 
DESC DEPT;
insert into dept (dname, deptno, loc) values ('개발부2', 70, '서울2' );
select *  from dept;
-- 10, ACCOUNTING, NEW YORK
-- 열 생략 INSERT
insert into dept values ( 80,'개발부3','서울3' );
commit;

-- SYSDATE 삽입
-- 테이블에 모든 데이터를 추가 할 필요는 없다. 
-- 단, PK (제약조건 , NOT NULL + UNIQUE) 제약조건이 있는 열은 반드시 입력해야 한다.
-- 또는 NOT NULL 항목은 반드시 입력해야 한다.
-- empno : PK임. 
INSERT INTO EMP (empno, ename, hiredate) VALUES ( 1000, '홍길동', SYSDATE );
SELECT * FROM EMP;

-- 퀴즈1, 
-- DEPT 테이블에 (99, ‘AI팀’, ‘JEJU’) 데이터를 추가하시오. 
 INSERT INTO dept (deptno, dname, loc) VALUES (99, 'AI팀', 'JEJU');
 SELECT * FROM dept;
-- 퀴즈2, 
-- EMP 테이블에 사번 1234, 이름 'LEE', 입사일을 SYSDATE로 추가하시오.
  INSERT  INTO emp (empno, ename, hiredate) VALUES (1234, 'LEE', SYSDATE);
  SELECT * FROM emp;
-- 퀴즈3, 
-- DEPT에 NULL을 포함한 값 삽입 
-- 테이블에 PK 값 의무적으로 입력하기, 
-- PK : NOT NULL, UNIQUE 제약조건이 있는 열
INSERT INTO dept (deptno, dname, loc) VALUES (NULL, 'AI팀', NULL);
SELECT * FROM dept;

-- 데이터 사전에서 테이블의 제약조건 확인해보기 DEPT 테이블
SELECT * FROM user_constraints WHERE table_name = 'DEPT';
-- 제약조건 확인하기

-- 테이블 복사하는 방법 
-- EMP 테이블에서 부서번호가 30인 사원 데이터를 
-- EMP_TEMP_30 테이블에 복사하기
-- 새로운 테이블을 생성하는 기본 문법 
-- CREATE TABLE 테이블명 AS SELECT * FROM 테이블명 WHERE 조건;
-- EMP_TEMP_30 테이블 생성 , 단순 빈테이블 생성
CREATE TABLE EMP_TEMP_30 AS SELECT * FROM EMP WHERE 1=0;
-- 실제 데이터 삽입
CREATE TABLE EMP_TEMP_40 AS SELECT * FROM EMP WHERE 1=1;

INSERT INTO EMP_TEMP_30
SELECT * FROM EMP WHERE deptno = 30;

-- EMP_TEMP_30 테이블 확인
SELECT * FROM EMP_TEMP_30;
-- EMP_TEMP_40 테이블 확인
SELECT * FROM EMP_TEMP_40;
COMMIT;
-- 기본은 DML : INSERT, UPDATE, DELETE 후, 반드시 적용하기. COMMIT;

