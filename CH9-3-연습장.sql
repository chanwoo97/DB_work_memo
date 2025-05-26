-- 실행 결과가 여러개인 다중행 서브쿼리 

-- 기본 문법 
-- IN 
-- : 복수의 값 중 하나와 일치하는 경우 
-- DALLAS 에 위치한 부서의 부서번호 중 
-- 하나에 속한 사원의 이름을 출력 예시, 
SELECT * FROM DEPT ;
SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS';
SELECT ENAME FROM EMP 
WHERE DEPTNO IN (
    SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS'
);

-- ANY 
-- 부서 번호 30번에 속한 사원들 중 적어도 한 명보다 
-- 급여가 적은 사원의 이름을 출력 예시 
-- 부서 30번의 급여 중 하나라도 큰 값이 있다면 
-- 해당 사원보다 적은 급여를 가진 사원을 모두 출력.

-- ANY 는 최소 하나의 조건만 만족해도 참이 되는 경우 
-- > , 또는 < 와 같이 비교 연산자와 함께 사용되고 
-- 최소/최대 비교를 하는 경우도 유연하게 사용이됨.
  SELECT SAL FROM EMP WHERE DEPTNO = 30;
SELECT ENAME FROM EMP 
WHERE SAL < ANY (
    -- 서브쿼리 결과 6개, 최소 950 부터, 2850 까지
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);


-- ALL 
-- 부서 번호 30번의 모든 사원보다 급여가 많은 사원의 
-- 이름 출력
-- ALL 전부 만족해야 참이 되는 조건, 
-- 가장 큰 값보다 더 커야함. 
-- MAX()와 비슷한 조건으로 사용한다. 
SELECT ENAME FROM EMP 
WHERE SAL > ALL (
    -- 서브쿼리 결과 6개, 최소 950 부터, 2850 까지
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);

--EXISTS 연산자 
-- 사원이 소속하는 부서의 이름을 출력 
-- 하나라도 존재하면 참(TRUE) 
-- 매우 빠른 조건에 존재 확인에 유리(데이터 확인 아님)
-- 서브쿼리의 실제 데이터가 아니라 존재 유무만 확인함. 
-- 반환값이 있으면 무조건 TRUE
SELECT DEPTNO, DNAME FROM DEPT D 
WHERE EXISTS (
 SELECT * FROM E
 WHERE E.DEPTNO = D.DEPTNO
);
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 30번 부서 사원들과 동일한 급여를 받는 사원 
SELECT ENAME, SAL FROM EMP 
WHERE SAL IN (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);

-- 30번 부서 중 가장 높은 급여보다 작게 급여를 맞는 직원
SELECT ENAME, SAL FROM EMP 
WHERE SAL < ALL (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);

-- 부서별 최대 급여 출력 
SELECT DEPTNO, MAX(SAL) FROM EMP 
GROUP BY DEPTNO ;
SELECT * FROM EMP;



-- 퀴즈1, 
-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 출력  
SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30;
SELECT ENAME, SAL FROM EMP 
WHERE SAL > ALL (
    SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30
);
-- 퀴즈2, 
-- 30번 부서의 최대 급여보다 낮은 급여를 받는 사원 출력  
SELECT ENAME, SAL  FROM EMP 
WHERE SAL < (
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30
);
-- 퀴즈3, 
-- EMP 테이블에 소속된 사원이 있는 부서의 이름을 출력 (`EXISTS`) 
SELECT DNAME FROM DEPT; -- 순서1,  5개의 부서명 중 1개만 이용
SELECT DNAME FROM DEPT D 
WHERE EXISTS ( -- 순서2, ACCOUNTING 한개의 데이터에 대해서 
SELECT * FROM EMP E  -- 순서3, EMP, DEPT 조인한 테이블
WHERE D.DEPTNO = E.DEPTNO  --순서4, 조인한 테이블의 결과 14개
-- 순서5, ACCOUNTING 데이터 하나에, 
-- 서브쿼리의 16개의 데이터를 비교
-- 결론, 총 몇번을 비교하나요? 80번 비교.
-- 서브쿼리의 빈번한 사용은 성능상 좋은 선택은 아니다.
-- 방법) 인덱스 많이 사용하고, 조인을 사용하기. 
-- 쿼리 조회시, 외주, GPT 작업하면, 
-- 반드시 해당 쿼리의 성능 체크도 같이하기. !!!
);
