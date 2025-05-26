-- 비등가 조인,  
-- 외부 조인 (오라클 전용),-> 표준 문법도  같이 소개

-- 비등가 조인 
SELECT E.ENAME,E.SAL, G.GRADE , G.LOSAL, G.HISAL
FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;

-- 외부 조인 (오라클 전용)
-- 오른쪽 외부 조인, 
-- 오른쪽 기준으로, 왼쪽에 값이 없어도 표기하겠다. 
-- 값이 NULL 이어도 표기 하겠다. 
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

--원본, 자체 조인 = 등가 조인, MGR = EMPNO
-- NULL  인 경우  , 데이터가 누락이됨.
SELECT * FROM EMP;
SELECT 
E.EMPNO AS "EMP 사원번호", 
E.ENAME AS "EMP 사원명", 
E.MGR AS "EMP직속 상관번호",
M.EMPNO AS "EMP2 상관의 번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;

-- 외부 조인 버전으로 변경해서 누락 없이 
-- 왼쪽 컬럼을 기준으로 표기하기. 
-- 왼쪽 외부 조인

SELECT 
E.EMPNO AS "EMP 사원번호", 
E.ENAME AS "EMP 사원명", 
E.MGR AS "EMP직속 상관번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);



-- 외부 조인 버전으로 변경해서 누락 없이 
-- 오른쪽 컬럼을 기준으로 표기하기. 
-- 오른쪽 외부 조인

SELECT 
E.EMPNO AS "EMP 사원번호", 
E.ENAME AS "EMP 사원명", 
E.MGR AS "EMP직속 상관번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M
WHERE E.MGR(+) = M.EMPNO;


--퀴즈 1,
-- EMP와 DEPT 테이블에서 부서가 없는 사원도 포함해 
-- 사원명과 부서명을 출력하시오 (왼쪽 외부 조인)
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+) ;

--퀴즈 2
-- 오른쪽 외부 조인을 사용하여 부서가 있지만, 
-- 사원이 없는 부서를 포함해서 출력하시오. 
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO ;

--퀴즈 3
-- WHERE 절에 추가 조건(`job = 'CLERK'`)을 넣고 부서별 사원 출력  
SELECT E.ENAME,E.JOB, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO 
AND E.JOB = 'CLERK';


