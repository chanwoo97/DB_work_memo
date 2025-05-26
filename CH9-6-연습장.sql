-- SELECT 절에 사용하는 서브쿼리 

-- 기본문법 
-- 사원 이름, 급영 
-- 그리고 해당 사원이 속한 부서의 평균 급여를 같이 출력 
SELECT ENAME, SAL, (
SELECT AVG(SAL) FROM EMP 
WHERE DEPTNO = E.DEPTNO) AS "평균급여"
FROM EMP E;

-- 각 사원 옆에 부서 평균 표시 
SELECT ENAME, DEPTNO, SAL, 
(SELECT AVG(SAL)FROM EMP WHERE DEPTNO = E.DEPTNO)
AS "평균급여"
FROM E;

-- 사원명 옆에 전체 사원 수 표시 
SELECT ENAME, 
(SELECT COUNT(*) FROM EMP) AS "총 사원수"
FROM EMP;

-- 사원 명 옆에 관리자 이름 표시 (자체 서브쿼리)
SELECT E.ENAME ,
(SELECT M.ENAME FROM EMP M 
WHERE M.EMPNO = E.MGR) AS "직속상관 이름"
FROM EMP E;

-- 성능 부분 고려해서, 그나마 차선책으로 쿼리 작업.
-- 부서별 평균 급여를 미리 구한 후,
-- EMP 테이블과 조인해서 출력
-- 메인 쿼리 실행 때 마다, 서브쿼리 매번 실행 안되서 좋다. 
SELECT E.ENAME, E.SAL, D.DEPT_AVG FROM EMP E
JOIN (
 SELECT DEPTNO, AVG(SAL) AS DEPT_AVG FROM EMP 
 GROUP BY DEPTNO 
 ) D 
 ON E.DEPTNO = D.DEPTNO ;

-- 지금은 성능 고려하지 말고, 서브 쿼리 연습으로 접근하기
-- 퀴즈1, 
-- 각 사원의 급여, 부서 평균 급여, 전체 평균 급여를 함께 출력하시오.
SELECT ENAME, SAL, DEPTNO , 
(SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "부서평균",
(SELECT AVG(SAL) FROM EMP ) AS "전체 평균"
FROM EMP E;
-- 퀴즈2, 
-- 각 사원의 이름, 직책, 부서 위치를 함께 출력하시오.  
SELECT E.ENAME, E.JOB, 
(SELECT D.LOC FROM DEPT D WHERE D.DEPTNO = E.DEPTNO) AS LOCATION
FROM EMP E;
  
-- 퀴즈3, 
-- 각 사원의 이름, 급여, 같은 부서의 최대 급여를 함께 출력하시오.  
SELECT ENAME, SAL, DEPTNO,
(SELECT MAX(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "최대급여"
FROM EMP E;
