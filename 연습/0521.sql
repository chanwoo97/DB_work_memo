-- 시간 설정
-- select sysdate from dual;
-- ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI';

---------------------------------------------------------------------------

--퀴즈1 
-- 평균 급여가 2500 이상인 부서의 부서번호와 평균 급여를 출력하시오. 
-- 별칭 : 평균 급여
SELECT DEPTNO, AVG(SAL) AS "평균 급여"
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2500;

--퀴즈2
-- 부서별 사원 수가 4명 이상인 부서만 출력하시오.  
-- 별칭 : 사원수 
SELECT DEPTNO, COUNT(*) AS "사원수"
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;

--퀴즈3
-- `WHERE` 절을 사용해 부서번호가 10, 20번만 필터링하고, 
-- 그 중 평균 급여가 2000 이상인 부서만 출력하시오.  
-- 별칭 : 평균 급여
SELECT DEPTNO, AVG(SAL) AS "평균 급여" FROM EMP
WHERE DEPTNO IN(10, 20)
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

----------------------------------------------------------------------

--다양한 고급 그룹화 함수 기능 소개 

-- (ROLLUP) : 계층적 요약
-- 부서별, 직책별 급여 합계 
-- 기본 문법 
-- SELECT  부서, 직책 , SUM(급여)
-- FROM EMP 
-- GROUP BY ROLLUP(부서, 직책)
-- 상위 항목(부서) -> 하위항목 (직책) 순서로 요약
-- 마지막 행은 전체 총합
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB);

-- CUBE : 모든 조합 분석 
-- 기본 문법 
-- SELECT 부서, 직책, SUM(급여)
-- FROM EMP 
-- GROUP BY CUBE(부서,직책)
-- ROLLUP 보다 더 많은 조합 생성 
-- (부서,직책), (부서), (직책) 모든 집계 조합 가능. 

SELECT DEPTNO, JOB, SUM(SAL) AS "총 급여"
FROM EMP 
GROUP BY CUBE(DEPTNO,JOB);

-- GROUPING 
-- 집계로 인한 NULL 여부 식별에 사용함. 
-- 기본 문법 
-- SELECT 컬럼1, 컬럼2, 집계합수(컬럼3) ,
-- GROUPING(컬럼1) AS 그룹1,
-- GROUPING(컬럼2) AS 그룹2
-- FROM 테이블 명 
-- GROUP BY ROLLUP(컬럼1, 컬럼2);

-- DEPTNO = 1 이면 전체 집계로 생긴 NULL
-- JOB = 1 이면 부서 합계로 생긴 NULL
SELECT DEPTNO, JOB, SUM(SAL) AS "총 급여",
GROUPING(DEPTNO) AS "GROUP_DEPTNO",
GROUPING(JOB) AS "GROUP_JOB"
FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB);

-- PIVOT 
-- 행 -> 열로 전환 하기 
-- 기본 문법 
-- SELECT * 
-- FROM (
-- SELECT 기준 컬럼, 피벗컬럼, 값 컬럼 FROM 테이블명
--)
-- PIVOT (
-- 집계함수(값 컬럼)
-- FOR 피벗컬럼 IN (값1 AS 별칭1, 값2 AS 별칭2,...)
--);

-- 직책별 급여 합계를 부서별로, 가로 형태로 전환
SELECT *
FROM( SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(
SUM(SAL)
FOR JOB IN ('CLERK' AS "사무직", 
'MANAGER' AS "관리자", 'ANALYST' AS "분석가")
);

-- UNPIVOT
-- 열 데이터를 다시 행으로 전환
-- 기본 문법
-- SELECT *
-- FROM ( SELECT 기준컬럼, 열1, 열2,... FROM 테이블명)
-- UNPIVOT (
-- 값 컬럼 FOR 피벗 컬럼 IN (열1, 열2,...)
-- );

-- 위에서 PIVOT 된 결과를 다시 행으로 변환
SELECT DEPTNO, JOB, SUM(SAL) AS "총급여"
FROM ( 
SELECT * 
    FROM ( 
    SELECT DEPTNO, JOB, SAL
    FROM EMP
    )
    PIVOT(
    SUM(SAL) FOR JOB IN 
    ('CLERK' AS "사무직", 'MANAGER' AS "관리자",
    'ANALYST' AS "분석가")
    )
)

-- 위에서 만든, 가로로 변환한 예를 다시, 새로 방향으로 변환.

UNPIVOT (
    SAL FOR JOB IN (
    "사무직" AS 'CLERK', 
    "관리자" AS 'MANAGER',
    "분석가" AS 'ANALYST')
)
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- UNPIVOT 간단한 예시 
-- 열 기준의 급여 데이터를 연도 기준 행으로 전환하기.
-- 실제로 출력이 되는 컬럼은 EMPNO, ENAME, 항목, 금액
SELECT EMPNO, ENAME, 항목, 금액
FROM(
    SELECT EMPNO, ENAME, SAL, COMM FROM EMP
)
-- UNPIVOT : 열 -> 행으로 변환하는 절
UNPIVOT (
-- 실제 값이 들어갈 컬럼명
    금액
-- 어떤 항목인지 구분하는 컬럼명, ( 예시 : 급여, 커미션)
    FOR 항목
    IN
    -- SAL, COMM UNPIVOT의 대상이 되는 열
    -- SAL 컬럼을 급여라는 별칭 전환
    (SAL AS '급여',
    -- COMM 컬럼을 수당이라는 별칭 변환
    COMM AS '수당')
    );
    
-- 퀴즈 1 
-- EMP 테이블에서  SAL, COMM을 UNPIVOT 한 후, 항목별 (급여,커미션) 전체 합계를 구하기
-- 별칭:항목,총합계

SELECT 항목, SUM(금액) AS 총합계
FROM(
    SELECT * FROM EMP
UNPIVOT (
    금액 FOR 항목 IN(SAL AS '급여', COMM AS '커미션')))
WHERE 금액 IS NOT NULL
GROUP BY 항목;

SELECT ENAME, SAL, COMM FROM EMP;
-- 기존 테이블 , 가로로 
-- ENAME  SAL   COMM 
-- KING   5000  NULL

-- UNPIVOT 을 적용하면 데이터, 
-- 변환 후, 
-- ENAME   항목(새로 만든 임의의 컬럼)  금액(임의 만듦)
-- KING    SAL(별칭 : 급여)           5000
-- KING    COMM(별칭 : 수당)           NULL

-- 풀이 1
SELECT 항목, SUM(금액) AS "총합계"
FROM (
-- UNPIVOT이 되는 되상 컬럼
-- 원래 , 가로로 배치된 데이터, 
-- 이 데이터 들을 변환 해서, 세로로 배치할 계획
    SELECT SAL, COMM FROM EMP
)
UNPIVOT (
    금액 FOR 항목 IN (
    SAL AS '급여',
    COMM AS '수당'
    )
)
GROUP BY 항목;

-- 풀이 2 
SELECT ENAME ,항목, SUM(금액) AS "총합계"
FROM (
-- UNPIVOT이 되는 되상 컬럼
-- 원래 , 가로로 배치된 데이터, 
-- 이 데이터 들을 변환 해서, 세로로 배치할 계획
    SELECT ENAME, SAL, COMM FROM EMP
)
UNPIVOT (
    금액 FOR 항목 IN (
    SAL AS '급여',
    COMM AS '수당'
    )
)
GROUP BY ENAME,항목;

-------------------------------------------------------------------------

-- 조인 사용 하기 전에 문제점 제시
-- 카티션 곱,
SELECT * FROM EMP; -- 갯수 : 14개
SELECT * FROM DEPT; -- 갯수 : 4개
-- KING , DEPTNO 10, DNAME : ACCOUNTING,
-- 이거 외에 다른 ㅜ서도 또 출력이 됨. 중복이 됨.
SELECT E.ENAME, D.DNAME -- 갯수 : 140개
FROM EMP E, DEPT D;

-- 테이블 별칭 이용해서, 조인 해보기.
SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO ;

-- EMP와 DEPT 테이블 등가 조인하여  부서번호가 30번인 사원만 출력해보기
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 30;

-- 퀴즈1
-- EMP와 DEPT 테이블 조인하여 관리자(MANAGER)직무를 가진 사원의 이름과 부서명 출력해보기
-- 별칭 : 사원명, 부서명
SELECT E.ENAME AS 사원명, D.DNAME AS 부서명
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER';

SELECT E.ENAME,E.JOB, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO 
AND E.JOB = 'MANAGER';


-- 퀴즈2 / 힌트 : 같은 테이블을 활용해보기
-- 각 사원의 이름과 그 사원의 직속 상관의 이름을 함께 출력해보기
-- 별칭 : 사원명, 직속 상관명
SELECT E.NAME AS 사원명, M.ENAME AS 직속상관명
FROM EMP E;


SELECT 
E.EMPNO AS "EMP 사원번호",
E.ENAME AS "EMP 사원명", 
E.MGR AS "EM 직속 상관번호",
M.ENAME AS "EMP2 직속 상관명"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO;


--------------------------------------------------------------------

-- 비등가 조인, 외부 조인 (오라클 전용), -> 표준 문법도 같이 소개
-- 비등가 조인
SELECT E.ENAME, G.GRADE
FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;


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
SELECT
E.ENAME AS 사원명, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

--퀴즈 2
-- 오른쪽 외부 조인을 사용하여 부서가 있지만, 
-- 사원이 없는 부서를 포함해서 출력하시오. 
SELECT
E.ENAME AS 사원명, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

--퀴즈 3
-- WHERE 절에 추가 조건(`job = 'CLERK'`)을 넣고 부서별 사원 출력 
SELECT
E.ENAME AS 사원명, D.DNAME AS 부서명
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+) AND JOB = 'CLERK';

SELECT E.ENAME, D.DNAME, E.JOB
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';

------------------------------------------------------------------------

-- 표준 SQL 99 이용해서, 조인의 표현식 연습

-- 기본 개념 비교  

-- | 문법 | 설명 | 특징 |
--|------|------|------|
-- | `NATURAL JOIN` | 공통 열 이름 자동 조인 | 간결하지만 제어 불가 |
-- | `JOIN ... USING(col)` | 지정 열 기준 조인 | 동일 열 이름만 사용 가능 |
-- | `JOIN ... ON(cond)` | 조건 지정 조인 | 가장 유연하고 범용 |
-- | `LEFT/RIGHT/FULL OUTER JOIN` | 외부 조인 구현 | NULL 포함된 결과도 출력 |

-- 기본 문법 예시
-- NATURAL JOIN
SELECT * FROM EMP NATURAL JOIN DEPT;

-- JOING USING
SELECT ENAME, DNAME
FROM EMP JOIN DEPT USING(DEPTNO);

-- JOIN ON, 가장 많이 사용하는 포맷 형식
SELECT ENAME, DNAME
FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

-- LEFT OUTER JOIN, 왼쪽 외부 조인
SELECT ENAME, DNAME
FROM EMP LEFT OUTER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

-- RIGHT OUTER JOIN, 오른쪽 외부 조인
SELECT ENAME, DNAME
FROM EMP RIGHT OUTER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

-- FULL OUTER JOIN,양쪽 외부 조인
SELECT ENAME, DNAME
FROM EMP FULL OUTER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

-- 3개 이상 테이블 조인
SELECT EMP.ENAME, DEPT.DNAME, LOCATION.LOC_ID
FROM EMP
JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
JOIN LOCATION ON DEPT.DEPTNO = LOCATION.LOC_ID;

--------------------------------------------------------------------
SELECT * FROM DEPT;
SELECT * FROM LOCATION;

-- 임시 테이블 생성
CREATE TABLE LOCATION(
    LOC_ID NUMBER PRIMARY KEY,
    LOC VARCHAR2(50)
);

COMMIT;
-------------------------------------------------------------------

-- 퀴즈1
-- `JOIN ... ON`을 사용하여 EMP와 DEPT를 등가 조인하시오.  
SELECT ENAME, DNAME
FROM EMP
JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT EMP.ENAME, DEPT.DNAME
FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;


-- 퀴즈2
-- `NATURAL JOIN`으로 EMP와 DEPT를 연결하시오.  
SELECT ENAME, DNAME FROM EMP NATURAL JOIN DEPT;

SELECT * FROM EMP NATURAL JOIN DEPT;

-- 퀴즈3
-- `USING`을 사용해 조인하되, 부서명이 있는 사원만 출력하시오.
SELECT  ENAME, DNAME
FROM EMP
JOIN DEPT 
USING(DEPTNO);

SELECT EMP.ENAME, DEPT.DNAME
FROM EMP JOIN DEPT USING (DEPTNO);

-- 퀴즈4
--`LEFT OUTER JOIN`을 사용하여 부서가 없는 사원도 포함한 결과를 출력하시오.  
SELECT ENAME, DNAME
FROM EMP LEFT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT EMP.ENAME, DEPT.DNAME
FROM EMP LEFT OUTER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

-- 퀴즈5
-- EMP, DEPT, LOCATION 테이블을 SQL-99 방식으로 연결하여 
-- 사원이름, 부서명, 지역명을 출력하시오.  
SELECT EMP.ENAME, DEPT.DNAME, LOCATION.LOC_ID
FROM EMP
JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
JOIN LOCATION ON DEPT.DEPTNO = LOCATION.LOC_ID;

SELECT EMP.ENAME, DEPT.DNAME, LOCATION.LOC
FROM EMP
JOIN DEPT ON EMP.DEPTNO - DEPT.DEPTNO
JOIN LOCATION ON DEPT.DEPTNO = LOCATION.LOC_ID;

-- 퀴즈6
-- `FULL OUTER JOIN`으로 사원이 없는 부서와 
-- 부서가 없는 사원을 모두 출력하시오. 
SELECT ENAME, DNAME
FROM EMP ULL OUTER JOIN DEPT
ON EXP.DEPTNO = DEPT.DEPTNO;

SELECT EMP.ENAME, DEPT.DNAME
FROM EMP FULL OUTER JOIN DEPT ON EMP.DEPTNO
ON EMP.DEPTNO = DEPT.DEPTNO;

--------------------------------------------------------------------------

-- 서브 쿼리, 쿼리 안에 쿼리
-- 기본 문법 정의
-- WHERE 절 안에 사용하는 서브쿼리
-- 사원이름 : JONES의 급여보다 많이 받는 사원 출력
-- JONES의 급여를 물라요.
SELECT SAL FROM EMP WHERE ENAME = 'JONES';
-- 밖의 쿼리 메인
SELECT * FROM EMP
WHERE SAL > 
-- 서브 쿼리
(SELECT SAL FROM EMP WHERE ENAME = 'JONES');


-- SELECT 절에 사용하는 서브쿼리
SELECT ENAME,
(SELECT DNAME FROM DEPT WHERE DEPTNO = EMP.DEPTNO)
AS "부서명"
FROM EMP;

-- FROM 절에 사용하는 인라인 뷰
SELECT JOB, AVG(SAL) AS "평균 급여"
FROM (
SELECT * FROM EMP WHERE DEPTNO = 30
)
GROUP BY JOB;

-- 퀴즈1 / 그냥 하기.
-- 급여가 2975보다 높은 사원의 이름과 급여를 출력하시오
 SELECT ENAME, SAL 
 FROM EMP
 WHERE SAL > 2975;
 
-- 퀴즈2 / WHERE 조건절에 서브쿼리 이용
-- JONES보다 급여가 높은 사원의 이름과 급여를 출력하시오. 
 SELECT ENAME, SAL
 FROM EMP
 WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');
  
-- 퀴즈3 / 메인 쿼리에 서브 쿼리 이용해서, 부서명 출력 
-- 힌트 : SELECT 구문에 서브 쿼리 이용하기. 부서번호 일치 해보기
-- DEPT 테이블의 부서명 표시
SELECT ENAME,
(SELECT DNAME FROM DEPT WHERE DEPT.DEPTNO = EMP.DEPTNO)
AS "부서명"
FROM EMP;



















