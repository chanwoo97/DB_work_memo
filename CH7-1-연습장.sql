-- 하나의 열에 출력 결과를 담는 다중행 함수 
-- 집계함수, AGGREGATE , 갯수, 평균, 합계, 최대, 최소등.

-- 전체 급여 합계
-- 다중행 함수는 단일 행 함수와 달리 집계처리가 핵심. 
SELECT ENAME  FROM EMP;
SELECT MAX(SAL),MIN(SAL), SUM(SAL) FROM EMP;

-- 갯수 구해보기 
-- 급여가 있는 사원의 수

-- COUNT(SAL) : SAL 컬럼 값이 NULL 이 아닌 
-- 경우만 카운트 함, NULL 이면 제외함 
SELECT COUNT(SAL) FROM EMP;

-- 부서 번호가 30번인 사원의 수 
-- COUNT(*) : NULL  여부 관계없이 해당 조건을 
-- 만족하는 전체 행의 수를 반환 한다는 의미. 
-- SAL이 NULL  이어도 포함함.

SELECT COUNT(*) FROM EMP 
WHERE DEPTNO = 30;



--퀴즈1 
-- 부서번호가 10번인 사원들의 최대, 최소 급여를 출력하시오.  
-- 별칭 : 최대 급여, 최소 급여
SELECT MAX(SAL) AS "최대 급여",
MIN(SAL) AS "최소 급여"
FROM EMP WHERE DEPTNO = 10;

--퀴즈2
-- 부서번호가 20번인 사원의 입사일 중 가장 오래된 날짜를 구하시오.  
-- 별칭 : 가장 오래된 날짜
SELECT MIN(HIREDATE) AS "가장 오래된 날짜" FROM EMP 
WHERE DEPTNO = 20;

--퀴즈3
-- 중복된 급여를 제외한 평균 급여를 출력하시오. 
-- DISTINCT 힌트 
-- 별칭 : 평균 급여
SELECT AVG(DISTINCT SAL) AS "중복 X 평균 급여" FROM EMP;
SELECT TRUNC(AVG(SAL)) AS "중복 O 평균 급여" FROM EMP;