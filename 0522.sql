-- 실행 결과가 하나인 단일행 서브 쿼리
-- 기본 문법 형식
-- SELECT 컬럼 FROM 테이블
-- WHERE 컬럼 비교연산자
-- (SELECT 단일값 FROM 서브쿼리);

-- 함수와 함께 사용하는 예
-- 부서 30의 평균 급여보다 높은 사원 출력
SELECT ENAME, SAL FROM EMP
WHERE SAL > (
    SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30
);

-- 가장 최근(시간의 값이 큰 값일수록 최신) 입사자 출력
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE = (
SELECT MAX(HIREDATE) FROM EMP
);

-- 오늘 입사한 사원 출력
SELECT * FROM EMP
WHERE HIREDATE = TRUNC(SYSDATE);

-- 퀴즈1, 
-- 부서번호 10번 사원의 최대 급여보다 높은 급여를 가진 사원을 출력하시오. 
SELECT ENAME, SAL FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10);
 
-- 퀴즈2, 
-- 오늘 날짜보다 이전에 입사한 사원을 출력하시오. 
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE < TRUNC(SYSDATE);
  
-- 퀴즈3, 
-- 평균 급여보다 낮은 급여를 받는 사원을 출력하시오. 
SELECT ENAME, SAL FROM EMP
WHERE SAL < (
    SELECT AVG(SAL) FROM EMP);

--------------------------------------------------------------------------

-- 실행 결과가 여러 객인 다중행 서브쿼리
-- 기본 문법 / IN연산자 사용 / IN : 복수의 값 중 하나와 일치하는 경우
-- DALLAS에 위치한 부서의 부서번호 중 하나에 속한 사원의 이름을 출력 예시
SELECT ENAME FROM EMP
WHERE DEPTNO IN (
    SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

-- ANY
-- 부서 번호가 30번에 속한 사원들 중 적어도 한명보다 급여가 적은 사원의 이름을 출력
-- 부서 30번의 급여 중 하나라도 큰 값이 있다면 해당 사원보다 적은 급여를 가진 사원을 모두 출력
-- ANY는 최소 하나의 조건만 만족해도 참이 되는 경우
-- >, 또는 < 와 같이 비교 연산자와 함께 사용되고 최소/최대 비교를 하는 경우도 유연하게 사용이 됨
SELECT ENAME FROM EMP
WHERE SAL < ANY(
    SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- ALL
-- 부서 번호 30번의 모든 사원보다 급여가 많은 사원의 이름 출력
-- ALL은 전부 만족해야 참이 되는 조건
-- 가장 큰 값보다 더 커여함.
-- MAX()와 비슷한 조건으로 사용한다.
SELECT ENAME FROM EMP
WHERE SAL > ALL(
    SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- EXISTS 연산자
-- 사원이 소속하는 부서의 이름을 출력
-- 하나라도 존재하면 참(TURE) -> 매우 빠른 조건에 존재 확인에 유리
-- 서브쿼리의 실제 데이터가 아니라 존재 유무만 확인함.
-- 반환값이 있으면 무조건 TURE
SELECT DNAME FROM DEPT D
WHERE EXISTS (
    SELECT * FROM EMP E
    WHERE E.DEPTNO = D.DEPTNO
    );

-- 30번 부서 사원들과 동일한 급여를 받는 사원
SELECT ENAME, SAL FROM EMP
WHERE SAL IN(
    SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- 30번 부서 중 가장 높은 급여보다 작게 급여를 받는 직원
SELECT ENAME, SAL FROM EMP
WHERE SAL < ALL (
    SELECT SAL FROM EMP WHERE DEPTNO = 30);
    
-- 부서별 최대 급여 출력
SELECT DEPTNO, MAX(SAL) FROM EMP
GROUP BY DEPTNO;

-- 퀴즈1, 
-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 출력  
SELECT ENAME, SAL FROM EMP
WHERE SAL < (
    SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);
 
 SELECT ENAME, SAL FROM EMP
 WHERE SAL > ALL(
    SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);
 
 
-- 퀴즈2, 
-- 30번 부서의 최대 급여보다 낮은 급여를 받는 사원 출력  
SELECT ENAME, SAL FROM EMP
WHERE SAL > (
    SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);
    
SELECT ENAME, SAL FROM EMP
WHERE SAL < (
    SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);

-- 퀴즈3, 
-- EMP 테이블에 소속된 사원이 있는 부서의 이름을 출력 (`EXISTS`) 
SELECT D.DNAME FROM DEPT D
WHERE EXISTS (
    SELECT ENAME FROM EMP E WHERE E.DEPTNO = D.DEPTNO);

SELECT DNAME, FROM DEPT; -- 순서1, 5개의 부서명 중 1개만 이용
SELECT DNAME FROM DEPT D
WHERE EXISTS( --순서 2, ACCOUNTING 한개의 데이터에 대해서 
    SELECT * FROM EMP E -- 순서3, EMP, DEPT 조인한 테이블
    WHERE D.DEPTNO = E.DEPTNO); -- 순서 4, 조인한 테이블의 결과 14개
-- 순서 5, ACCOUNTING 데이터 하나에, 서브쿼리의 16개의 데이터를 비교
-- 결론, 총 몇번을 비교하나요? 80번 비교.
-- 서브쿼리의 빈번한 사용은 성능상 좋은 선택은 아니다.
-- 방법) 인덱스 많이 사용하고, 조인을 사용하기.
-- 쿼리 조회시, 외주, GPT 작업하면, 반드시 해당 쿼리의 성능 체크도 같이해야함. 중요함!

------------------------------------------------------------------------------

-- 비교할 열이 여러 개인 다중열 서브쿼리
-- 기본문법
-- 부서번호 10번인 사원들의 (직무, 부서번호) 조합과 동일한 (직무, 부서번호)를 가진 사원을
-- EMP 테이블에서 조회
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE (JOB, DEPTNO) IN (
    SELECT JOB, DEPTNO FROM EMP
    WHERE DEPTNO = 10);
    
-- 직책과 부서 (직책, 부서번호) 튜플 과 일치하는 사원 출력 
SELECT ENAME, JOB, DEPTNO FROM EMP 
WHERE (JOB,DEPTNO) IN (
    SELECT JOB, DEPTNO FROM EMP 
    WHERE DEPTNO = 20
);

-- (사원번호, 부서번호) 특정 목록과 일치하는 데이터 출력 
SELECT EMPNO, ENAME FROM EMP 
WHERE (EMPNO, DEPTNO) IN (
    SELECT EMPNO,DEPTNO FROM EMP 
    WHERE SAL > 2000
);

-- (급여, 부서번호) 기준으로 특정 조건과 일치하는 
-- 사원 추출 
SELECT ENAME, SAL, DEPTNO FROM EMP 
WHERE (SAL, DEPTNO ) IN (
 SELECT MAX(SAL), DEPTNO FROM EMP 
 GROUP BY DEPTNO
);

-- 퀴즈1, WHERE(JOB, DEPTNO)
-- 20번과 30번 부서에 있는 ‘MANAGER’ 
-- 직책 사원과 동일한 (직책, 부서번호) 조합을 가진 사원 출력  
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE (JOB, DEPTNO) IN (
    SELECT JOB, DEPTNO FROM EMP
    WHERE DEPTNO IN(20, 30));
 
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE (JOB, DEPTNO) IN (
    SELECT JOB, DEPTNO FROM EMP
    WHERE JOB ='MANAGER' AND DEPTNO IN (20, 30));
 
-- 퀴즈2, WHERE(SAL, DEPTNO)
-- 각 부서별 최저 급여를 받는 사원 출력  
SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE (SAL, DEPTNO) IN (
    SELECT MIN(SAL), DEPTNO FROM EMP GROUP BY DEPTNO); 

SELECT ENAME, SAL , DEPTNO FROM EMP
WHERE (SAL, DEPTNO) IN (
    SELECT MIN(SAL), DEPTNO FROM EMP
    GROUP BY DEPTNO);
    
-- 퀴즈3, WHERE(EMPNO, DEPTNO)
-- 특정 기준 사원들과 동일한 (사원번호, 부서번호) 조합을 
-- 가진 사원을 출력하되, 급여는 2000 이상인 경우만 표시 
SELECT ENAME, DEPTNO, MGR, SAL FROM EMP
WHERE (DEPTNO, MGR) IN(
    SELECT DEPTNO, MGR FROM EMP WHERE SAL >= 2000);

SELECT ENAME, EMPNO, DEPTNO FROM EMP
WHERE (EMPNO, DEPTNO) IN (
    SELECT EMPNO, DEPTNO FROM EMP
    WHERE SAL >=  2000);

--------------------------------------------------------------------------

-- FROM 절에 사용하는 서브쿼리와 WITH 절 (재사용, 변수와 비슷)
-- 기본 문법
-- 인라인 뷰 방식
-- 부서번호가 30번인 사원들만 추출한 뒤 그 결과에서 직무별 평균 급여를 계산
SELECT JOB, AVG(SAL) AS "평균급여" FROM (
    SELECT * FROM EMP WHERE DEPTNO = 30)
GROUP BY JOB;

-- WITH절 방식
-- WITH (변수명) AS (쿼리 정의)
WITH DEPT30_EMP AS ( SELECT * FROM EMP WHERE DEPTNO = 30)
SELECT JOB, AVG(SAL) AS "평균급여" 
--FROM (서브쿼리 통문자 들어 있음. 인라인뷰)
FROM  DEPT30_EMP
GROUP BY JOB;

-- WITH 절을 이용해서, 평균 급여 구해보기.
WITH DEPT30_EMP AS ( SELECT * FROM EMP WHERE DEPTNO = 30)
SELECT JOB, AVG(SAL) FROM DEPT30_EMP
GROUP BY JOB;

-- WITH 절에서 필터링한 데이터를 메인 쿼리에서 조인
WITH EMP30 AS ( SELECT * FROM EMP WHERE DEPTNO = 
    ( SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS'))
SELECT ENAME, JOB FROM EMP30;

-- 퀴즈1, 
-- 부서별 평균 급여가 2000 이상인 부서의 
-- 직책별 사원 수 출력 (WITH절 + GROUP BY)  
WITH DEPT_AVG AS (
    SELECT DEPTNO, AVG(SAL) AS "평균급여" FROM EMP
    GROUP BY DEPTNO
    HAVING AVG(SAL) >= 2000)
SELECT E.DEPTNO, E.JOB, COUNT(*) AS "직무 갯수"
FROM EMP E
JOIN DEPT_AVG D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, E.JOB;

-- 퀴즈2, 
-- 부서별 최고 급여자를 인라인 뷰로 추출하고, 사원명과 급여 출력  
SELECT ENAME, SAL FROM EMP 
WHERE (SAL, DEPTNO) IN (
    SELECT MAX(SAL), DEPTNO FROM EMP 
    GROUP BY DEPTNO
);
  
-- 퀴즈3, 
-- WITH절로 정의된 사원 리스트에서, 급여가 평균 이상인 사원만 출력  
WITH EMP20 AS (
SELECT * FROM EMP WHERE DEPTNO = 20
)
SELECT ENAME ,SAL FROM EMP20 
WHERE SAL >= (SELECT AVG(SAL) FROM EMP20);

---------------------------------------------------------------------

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
SELECT 
E.ENAME, E.SAL AS "사원 급여", 
(SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "부서평균급여",
(SELECT AVG(SAL) FROM EMP) AS "전체평균급여" FROM EMP E;

SELECT ENAME, SAL, DEPTNO , 
(SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "부서평균",
(SELECT AVG(SAL) FROM EMP ) AS "전체 평균"
FROM EMP E;

-- 퀴즈2, 
-- 각 사원의 이름, 직책, 부서 위치를 함께 출력하시오.  
SELECT
E.ENAME AS "사원명",
E.JOB AS "직책",
D.LOC AS "부서위치"
FROM EMP E 
JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, E.JOB, 
(SELECT D.LOC FROM DEPT D WHERE D.DEPTNO = E.DEPTNO) AS LOCATION
FROM EMP E;

-- 퀴즈3, 
-- 각 사원의 이름, 급여, 같은 부서의 최대 급여를 함께 출력하시오.  
SELECT
E.ENAME AS "사원명",
E.SAL AS "급여",
(SELECT MAX(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "같은부서의 최대급여"
FROM EMP E;

SELECT ENAME, SAL, DEPTNO,
(SELECT MAX(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO) AS "최대급여"
FROM EMP E;

------------------------------------------------------------------------------
-- 테이블에 데이터 추가하기
-- 기본 문법, 열의 순서에는 상관없음
-- INSERT INTO 테이블명(열1,열2....) VALUES (값1,값2...);

-- 열 이름 생략, 테이블에 정의된 열의 순서대로 작성하기
-- INSERT INTO 테이블명 VALUES (값1,값2...)

-- NULL 삽입
-- INSERT INTO 테이블명 VALUES (101,NULL,'2025/05/22', SYSDATE)

-- 서브쿼리 삽입
-- INSERT INTO 테이블명 (열1,열2)
-- SELECT 열1, 열2 FROM 다른 테이블 WHERE 조건;

-- 예시
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (60, '개발부', '서울');
SELECT * FROM DEPT
commit

-- 퀴즈1, 
-- DEPT 테이블에 (99, ‘AI팀’, ‘JEJU’) 데이터를 추가하시오. 
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (99, 'AI팀', 'JEJU');
SELECT * FROM DEPT;

-- 퀴즈2, 
-- EMP 테이블에 사번 1234, 이름 'LEE', 입사일을 SYSDATE로 추가하시오.
INSERT INTO EMP ( EMPNO, ENAME, HIREDATE) VALUES ( 1234, 'LEE', SYSDATE);
  
  
-- 퀴즈3, 
-- DEPT에 NULL을 포함한 값 삽입 
INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (100, NULL, 'SEOUL');
