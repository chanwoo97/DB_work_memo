insert into dept ( deptno, dname, loc) values ( 70, '개발부', '서울2' );
select *
from dept;
commit;

-- 퀴즈1, 
-- DEPT 테이블에 (99, ‘AI팀’, ‘JEJU’) 데이터를 추가하시오. 
INSERT INTO DEPT ( DEPTNO, DNAME, LOC) VALUES ( 99, 'AI팀', 'JEJU' );

 
-- 퀴즈2, 
-- EMP 테이블에 사번 1234, 이름 'LEE', 입사일을 SYSDATE로 추가하시오.
INSERT INTO EMP ( EMPNO, ENAME, HIREDATE) VALUES ( 1234, 'LEE', SYSDATE );
  
-- 퀴즈3, 
-- DEPT에 NULL을 포함한 값 삽입
INSERT INTO DEPT ( DEPTNO, DNAME, LOC) VALUES ( 100, NULL, 'SEOUL' );

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


