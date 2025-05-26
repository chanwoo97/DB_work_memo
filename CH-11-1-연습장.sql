-- 하나의 단위로 데이터를 처리하는 트랜잭션 

-- 기본문법 
-- 데이터 변경 
select * from emp_copy;
-- EMP_COPY 테이블에 원본 EMP 테이블 복사
INSERT INTO emp_copy
SELECT * FROM emp;
COMMIT;

-- EMP_COPY 순서1, 테이블 테이터 변경 
UPDATE emp_copy SET sal = sal + 10000
WHERE deptno = 10;

-- 순서2, 트랜잭션 저장 
COMMIT;

-- 순서3, 트랜잭션 취소 
ROLLBACK;

-- 순서4, 특정 지점으로 설정
SAVEPOINT SP1;

-- 순서5, 특정 지점으로 롤백 
ROLLBACK TO SP1;
SELECT * FROM emp_copy2;
CREATE TABLE emp_copy2 AS SELECT * FROM emp;
-- EMP -> EMP_COPY2 테이블 복사를 먼저 진행 후, 
-- 퀴즈1, 
-- 부서번호가 20인 사원들의 급여를 10% 인상 후, 
-- 조건에 따라 되돌릴 수 있도록 SAVEPOINT (SP2)를 설정하시오. 
 UPDATE emp_copy2 SET sal = sal * 1.1 WHERE deptno = 20;
 COMMIT;
-- 퀴즈2, 
-- 사번이 7839인 사원의 급여를 8000으로 변경하고, 
-- 이 작업만 ROLLBACK하시오.
  SAVEPOINT SP2;
  SELECT * FROM emp_copy2 WHERE empno = 7839;
  UPDATE emp_copy2 SET sal = 8000 WHERE empno = 7839;
  ROLLBACK TO SP2;
  COMMIT;

-- 퀴즈3, 
-- 여러 UPDATE 작업 수행 후 COMMIT하지 않고
-- 전체를 ROLLBACK 하시오.
UPDATE emp_copy2 SET sal = sal * 1.1 WHERE deptno = 10;
UPDATE emp_copy2 SET sal = sal * 1.1 WHERE deptno = 20;
UPDATE emp_copy2 SET sal = sal * 1.1 WHERE deptno = 30;
-- COMMIT OR ROLLBACK;
ROLLBACK;