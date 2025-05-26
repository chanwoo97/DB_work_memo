-- 기본 문법 
-- SELECT 그룹열, 집계함수 
-- FROM 테이블 
-- GROUP BY 그룹열
-- [ORDER BY 정렬열]

-- 기본 예제 확인. 
-- 부서별 , 평균 급여 
SELECT deptno, AVG(sal), SUM(SAL), MAX(SAL), MIN(SAL), COUNT(SAL) FROM emp 
GROUP BY deptno;

-- 직책별 최대 급여 
SELECT JOB, MAX(SAL) FROM EMP
GROUP BY JOB;

-- 부서번호 + 직책 기준 평균 급여 
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP 
GROUP BY DEPTNO, JOB;

-- 부서별 사원의 수 구하기 
SELECT DEPTNO, COUNT(*) FROM EMP 
GROUP BY DEPTNO;

-- 각 부서의 평균 급여를 내림차순으로 정렬해보기. 
SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO 
ORDER BY AVG(SAL) DESC;

--퀴즈1 
-- 부서 번호와 직책별 평균 급여를 출력하고, 
-- 평균 급여 기준 내림차순 정렬하시오.   
-- 별칭 : 평균 급여
SELECT DEPTNO, JOB, AVG(SAL) AS "평균 급여"
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY AVG(SAL) DESC;

--퀴즈2
-- `GROUP BY` 절에 포함되지 않은 `ename`을 
-- `SELECT`에서 사용한 경우의 오류 상황을 만들어 보시오.  
-- 
SELECT DEPTNO, JOB, ENAME, AVG(SAL) AS "평균 급여"
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY AVG(SAL) DESC;

--퀴즈3
-- 각 부서별로 보너스가 있는 사원의 수를 구하시오. 
-- 별칭 : 보너스 받는 직원수
SELECT DEPTNO, COUNT(COMM) AS "보너스 받는 직원수"
FROM EMP 
GROUP BY DEPTNO;


