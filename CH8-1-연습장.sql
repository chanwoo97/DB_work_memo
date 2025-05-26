-- 조인 사용 하기 전에 문제점 제시, 
-- 카티션 곱 , 
SELECT * FROM EMP; -- 몇개 : 14개
SELECT * FROM DEPT; -- 몇개 : 10개
-- KING , DEPTNO 10, DNAME : ACCOUNTING , 
-- 이거 외에 다른 부서도 또 출력이됨. 중복이됨. 
SELECT E.ENAME, D.DNAME  -- 총: 140개 
FROM EMP E, DEPT D;
SELECT * FROM DEPT;
SELECT * FROM EMP;
-- 테이블 별칭 이용해서, 조인 해보기. 
SELECT E.EMPNO, E.SAL, E.HIREDATE,E.ENAME,E.DEPTNO AS "EMP의 부서번호",D.DEPTNO AS "DEPT의 부서번호", D.DNAME , D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO ;

-- EMP와 DEPT 테이블 등가 조인하여 부서번호가 30번인
-- 사원만 출력해보기. 
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT 
E.ENAME,E.DEPTNO,E.SAL,E.HIREDATE, 
D.DNAME ,D.DEPTNO,D.LOC
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO 
 AND E.DEPTNO = 30;


--퀴즈 1
-- EMP 와 DEPT 테이블 조인하여 
-- 관리자(MANAGER)직무를 가진 사원의 이름과 
-- 부서명 출력 해보기.
-- 별칭 : 사원명, 부서명 
SELECT E.ENAME,E.JOB, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO 
AND E.JOB = 'MANAGER';


--퀴즈 2, 힌트 : 같은 테이블을 활용해보기.
-- 각 사원의 이름과 그 사원의 직속 상관의 이름을 함께 출력해보기. 
-- 별칭 : 사원명, 직속 상관명
SELECT * FROM EMP;
SELECT 
E.EMPNO AS "EMP 사원번호", 
E.ENAME AS "EMP 사원명", 
E.MGR AS "EMP직속 상관번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;

