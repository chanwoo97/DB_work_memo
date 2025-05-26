-- 그룹으로 나눈 대상에, 필터(집계하기), 
-- 평균, 갯수, 최대, 최소, 카운트 
-- 기본 문법
-- SELECT 그룹열, 집계함수
-- FROM 테이블명
-- [WHERE 조건]           -- 행 필터링
-- GROUP BY 그룹열
-- [HAVING 집계조건]      -- 그룹 필터링
-- ORDER BY 정렬조건;

-- 평균 급여가 2000 이상인 부서 출력 해보기 
SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

-- 사원수가 3명 이상인 직책 그룹만 출력 
SELECT JOB, COUNT(*) FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 1;

-- WHERE 절과 HAVING 절 같이 사용해보기. 
SELECT * FROM EMP WHERE JOB = 'SALESMAN';

-- 조건 기반 평균 급여 필터링, 
-- 순서
-- 1. EMP 테이블에서 JOB = 'SALESMAN' 조건 
-- 만족하는 행만 선택 
-- 2 선택된 SALESMAN 들 중 DEPTNO 기준으로 그룹화 
-- 3 각 그룹별로 AVG(SAL) 계산 
-- 4 평균이 1000보다 큰 그룹만 출력. 
SELECT DEPTNO , AVG(SAL) FROM EMP 
WHERE JOB = 'SALESMAN'
GROUP BY DEPTNO 
HAVING AVG(SAL) > 1000;




--퀴즈1 
-- 평균 급여가 2500 이상인 부서의 부서번호와 평균 급여를 출력하시오. 
-- 별칭 : 평균 급여
SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2500;
--퀴즈2
-- 부서별 사원 수가 4명 이상인 부서만 출력하시오.  
-- 별칭 : 사원수 
SELECT DEPTNO, COUNT(*) FROM EMP
GROUP BY DEPTNO 
HAVING COUNT(*) >= 4;
--퀴즈3
-- `WHERE` 절을 사용해 부서번호가 10, 20번만 필터링하고, 
-- 그 중 평균 급여가 2000 이상인 부서만 출력하시오.  
-- 별칭 : 평균 급여
SELECT DEPTNO, AVG(SAL) FROM EMP
WHERE DEPTNO IN (10, 20)
GROUP BY DEPTNO 
HAVING AVG(SAL) >= 2000;



