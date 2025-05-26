-- FROM 절에 사용하는 서브쿼리와 
-- WITH 절(재사용, 변수와 비슷)

-- 기본 문법 
-- 인라인 뷰 방식 
-- 부서번호가 30번인 사원들만 추출한 뒤 
-- 그 결과에서 직무별 평균 급여를 계산. 
SELECT JOB, AVG(SAL) AS "평균급여" FROM 
(    SELECT * FROM EMP WHERE DEPTNO = 30 )
GROUP BY JOB;

-- WITH절 방식 
-- WITH (변수명) AS (쿼리 정의)
WITH DEPT30_EMP AS (
SELECT * FROM EMP WHERE DEPTNO = 30
)
SELECT JOB, AVG(SAL) AS "평균급여"
-- FROM (서브쿼리 통문자 들어 왔음, 인라인뷰)
FROM DEPT30_EMP
GROUP BY JOB;

-- WITH 절을 이용해서, 평균 급여 구해보기.
WITH DEPT30_EMP AS (
SELECT * FROM EMP WHERE DEPTNO = 30
)
SELECT JOB, AVG(SAL) FROM DEPT30_EMP 
GROUP BY JOB;

--WITH 절에서 필터링한 데이터를 메인 쿼리에서 조인 
WITH EMP30 AS (
SELECT * FROM EMP WHERE DEPTNO = (
    SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS'
)
)
SELECT ENAME,JOB FROM EMP30;

-- 퀴즈1, 
-- 부서별 평균 급여가 2000 이상인 부서의 
-- 직책별 사원 수 출력 (WITH절 + GROUP BY)  
WITH DEPT_AVG AS (
    SELECT DEPTNO, AVG(SAL) AS "평균급여" FROM EMP 
    GROUP BY DEPTNO 
    HAVING AVG(SAL) >= 2000
)
SELECT E.DEPTNO , E.JOB, COUNT(*) AS "직책별 사원 수"
FROM EMP E 
JOIN DEPT_AVG D ON E.DEPTNO = D.DEPTNO 
GROUP BY E.DEPTNO, E.JOB;
 
-- 퀴즈2, 
-- 부서별 최고 급여자를 인라인 뷰로 추출하고, 
-- 사원명과 급여 출력  
SELECT ENAME, SAL FROM EMP 
WHERE (SAL, DEPTNO) IN (
    SELECT MAX(SAL), DEPTNO FROM EMP 
    GROUP BY DEPTNO
);
  
-- 퀴즈3, 
-- WITH절로 정의된 사원 리스트에서, 
-- 급여가 평균 이상인 사원만 출력  
WITH EMP20 AS (
SELECT * FROM EMP WHERE DEPTNO = 20
)
SELECT ENAME ,SAL FROM EMP20 
WHERE SAL >= (SELECT AVG(SAL) FROM EMP20);