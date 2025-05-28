-- 모든 컬럼 조회
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

-- DISTINCT 중복제거 / 단일컬럼
SELECT DISTINCT DEPTNO FROM EMP;
-- DISTINCT 중복제거 / 복합컬럼(여러컬럼)
SELECT DISTINCT JOB, DEPTNO FROM EMP;

-- ALL : 중복제거 안함
SELECT ALL JOB, DEPTNO FROM EMP;
-- ALL 생략가능
SELECT JOB, DEPTNO FROM EMP;

-- ALIAS 별칭 / AS 라고 표기
SELECT ENAME AS "직원 이름" FROM EMP;

-- 특정 옵션 함수 
-- NVL(COMM,0):COMM 있으면, COMM 값으로 출력,
-- NVL(COMM,0):COMM 없으면, 0 값으로 출력,
-- NVL 의미 : N(NULL) 값이 없음 / V (value) : 값 / L (Logic) : 논리 
-- null 값을 처리하기 위한 로직

-- ORDER BY 컬럼명 / ASC(오름차순) / DESC(내림차순)
SELECT SAL FROM EMP ORDER BY SAL ASC; -- 급여 오름차순 정렬
SELECT SAL FROM EMP ORDER BY SAL DESC; -- 급여 내림차순 정렬
-- ORDER BY 여러 컬럼
SELECT * FROM EMP ORDER BY COMM DESC, SAL ASC; -- 커미션 높은 순, 급여 낮은 순 정렬
-- 시간은 , 최신일 값으로 하면 큰값 / 과거 일수록 값으로 하면 작은 값.

-- 부정 연산자, !=, <>, ^= 

-- BETWEEN A AND B , A 이상 B 이하 
SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <=3000;
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000 ;

-- % : 모든 문자, _: 한글자 
-- S로 시작하는 모든 문자열 검색. 
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
-- 2번째 글자 L를 포함하는 이름 
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
-- 이름에 AM를 포함하는 사원
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';