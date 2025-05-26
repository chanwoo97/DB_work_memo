-- 테이블에 있는 데이터 수정하기

-- 기본 문법 
-- UPDATE 테이블명 SET 수정할컬럼명 = 수정할값 WHERE 조건절;

-- 복사한 테이블에서 연습하기. 
-- EMP -> EMP_COPY 테이블 복사 
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

--전체 수정 
UPDATE EMP_COPY SET SAL = 1000;
-- 반영, 저장
COMMIT;

-- 조건 수정
UPDATE EMP_COPY SET SAL = 2000 WHERE DEPTNO = 10;
-- 되돌리기
ROLLBACK;

-- 서브쿼리 활용 
SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN'; -- 30
UPDATE EMP_COPY SET SAL = 2000 
WHERE DEPTNO = (
    SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN'
);

-- 먼저는 연습용, 
-- DEPT -> DEPT_TEMP2 테이블 복사해보기
CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP2;
-- 퀴즈1, 
-- DEPT_TEMP2 테이블에서 부서번호가 20인 행의 지역을 'JEJU'로 수정하시오.  
 UPDATE DEPT_TEMP2 SET LOC = 'JEJU' WHERE DEPTNO = 20;
-- 퀴즈2, 
-- DEPT_TEMP2 테이블의 전체 지역을 'SEOUL'로 변경하시오.  
  UPDATE DEPT_TEMP2 SET LOC = 'SEOUL';

-- EMP_COPY 테이블에서 연습하기
-- 퀴즈3, 
-- 직책이 'MANAGER'인 사원의 급여를 5000으로 일괄 수정하시오.  
UPDATE EMP_COPY SET SAL = 5000 WHERE JOB = 'MANAGER';
SELECT * FROM EMP_COPY ;