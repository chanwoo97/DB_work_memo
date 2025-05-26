-- 실행 결과가 하나인 단일행 서브 쿼리 

-- 기본 문법 형식 
-- SELECT 컬럼 FROM 테이블 
-- WHERE 컬럼 비교연산자 
--(SELECT 단일값 FROM 서브쿼리 );

-- 함수와 함께 사용하는 예
SELECT ENAME, SAL FROM EMP 
WHERE SAL > (
    SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30
);

-- 부서 30의 평균 급여보다 높은 사원 출력 
SELECT ENAME, SAL FROM EMP 
WHERE SAL > (
    SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30
);

-- 가장 최근(시간의 값이 큰 값 일수록 최신 입사자 출력 )
SELECT ENAME, HIREDATE FROM EMP 
WHERE HIREDATE = (
SELECT MAX(HIREDATE) FROM EMP
);

-- 오늘 입사한 사원 출력 
SELECT * FROM EMP 
WHERE HIREDATE = TRUNC(SYSDATE);

-- 퀴즈1, 
-- 부서번호 10번 사원의 최대 급여보다 높은 급여를 가진 사원을 출력하시오. 
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10;
SELECT ENAME, SAL FROM EMP 
WHERE SAL >=
(SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10);


-- 퀴즈2, 
-- 오늘 날짜보다 이전에 입사한 사원을 출력하시오. 
SELECT ENAME, HIREDATE FROM EMP 
WHERE HIREDATE < TRUNC(SYSDATE);
  
-- 퀴즈3, 
-- 평균 급여보다 낮은 급여를 받는 사원을 출력하시오.  
SELECT ENAME, SAL FROM EMP 
WHERE SAL < (
    SELECT AVG(SAL) FROM EMP
);


