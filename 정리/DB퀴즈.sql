-- 'SALES' 부서 소속 직원만 조회 
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 사원명과 입사일만 조회 
SELECT ENAME, HIREDATE FROM EMP;

-- 급여가 3000 이상인 직원만 조회
SELECT * FROM EMP WHERE SAL >= 3000;

-- EMP 테이블에서 이름(ename), 급여(sal), 부서번호(deptno)만 조회 해보기
SELECT ENAME, SAL, DEPTNO FROM EMP;

--------------------------------------------------------------------------------------------------------------------------

-- EMP 테이블에서 중복되지 않는 부서번호만 출력하기
SELECT DISTINCT DEPTNO FROM EMP;

--EMP 테이블에서 사원 직무와 부서번호 / 조합이 고유한 결과 한번더 해보기
SELECT DISTINCT JOB, DEPTNO FROM EMP;

-- EMP 테이블에서 중복을 제거하지 않고 사원 직무와 부서 번호를 모두 출력하기 
-- ALL 키워드 이용해보기
SELECT ALL JOB, DEPTNO FROM EMP;

--------------------------------------------------------------------------------------------------------------------------

-- EMP 테이블에서 사원 이름에 '각자 정하고 싶은 이름' 별칭을 부여해서 출력해보기 
SELECT ENAME AS "직원 이름" FROM EMP;

-- EMP 테이블에서 급여(SAL)를 연봉으로 계산해서 출력해보기, 한번더
SELECT SLA * 12 AS "기본 연봉" FROM EMP;

-- 사원명과 직무를 각각 '사원이름', '직무'로 출력해보기 
SELECT ENAME AS "사원이름", JOB AS "직무" FROM EMP;

-- 특정 옵션 함수 
-- NVL(COMM,0):COMM 있으면, COMM 값으로 출력,
-- NVL(COMM,0):COMM 없으면, 0 값으로 출력,
-- NVL 의미 : N(NULL) 값이 없음 / V (value) : 값 / L (Logic) : 논리 
-- null 값을 처리하기 위한 로직
-- 사원명과 급여, 그리고 커미션(COMM)이 있을 경우, 총 수입을 계산하기, 출력 별칭은 "총 급여"로 지정해서 출력. 
SELECT ENAME AS "사원명", SAL AS "기본급", SAL * 12 + NVL(COMM, 0) AS "총 급여" FROM EMP;

--------------------------------------------------------------------------------------------------------------------------

-- 커미션이 높은 순으로, 급여가 낮은 순으로 정렬 출력, 특정 컬럼 언급 없으면 모든 컬럼 출력. 
SELECT * FROM EMP ORDER BY COMM DESC, SAL ASC;

-- emp 테이블에서 이름, 부서번호, 급여를 출력 하되, 급여가 높은 순으로 정렬해보기, 한번더 
SELECT ENAME, DEPTNO, SAL FROM EMP ORDER BY SAL DESC;

-- salgrade 테이블에서 급여 등급(grade) 을 오름차순, 최고 급여(hisal) 내림차순으로 정렬해보기.
-- 특정 컬럼 언급 없으면 모든 컬럼 출력. 
SELECT * FROM SALGRADE ORDER BY GRADE ASC, HISAL DESC;

-- 이름의 첫글자를 F를 기준으로 사전식 정렬 
SELECT * FROM EMP WHERE ENAME < 'F';    