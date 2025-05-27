desc emp;
desc dept;
desc salgrade;

-- *, 모든 컬럼 조회
select * from emp;
select * from dept;
select ename, mgr, job from emp;

-- distinct 중복제거, 단일 컬럼
select distinct deptno from emp;
-- distinct 중복제거, 여러 컬럼, 1세트: job, deptno
select distinct job, deptno from emp;

-- distinct의 반대 <-> all 중복해서 출력(중복포함), 기본값
select all job, deptno from emp;
select  job, deptno from emp;
-- 위 두개는 같은 코드

-- alias, 별칭을 지정해서, 컬럼을 원하는 이름으로 지정
select ename as "사원 이름", sal*12+comm as 연봉, comm from emp;

-- 상여금(comm)이 있는 사람은 연봉 출력이 가능하지만, 상여금이 없는 사람은 계산이 안됨.
-- nvl 함수 이용해서, 작업.
select ename as "사원 이름", sal*12+comm as "null 때문에 잘안됨", 
--연봉계산이 null때문에 잘안됨
comm, nvl(comm,0) as "상여금 여부", sal*12 + nvl(comm,0) as "총 급여" from emp;


select ename as "사원 이름", sal as "기본급", nvl(comm,0) as "상여금 여부",
sal*12 + nvl(comm,0) as "총 연봉" from emp;

-- NVL 의미 : N(NULL) 값이 없음, 
-- V(value) : 값, 
-- L(Logic) : 논리,
-- null 값을 처리하기 위한 로직

-- 퀴즈1
-- EMP 테이블에서 사원 이름에 '각자 정하고 싶은 이름' 별칭 부여해서 출력해보기

-- 퀴즈2
select sal * 12 as "기본 연봉" from emp;

-- 퀴즈3
select ename as "사원 이름", job as "직무" from emp;

-- 퀴즈4
select ename as "사원명", sal as "기본급", 
sal*12 + nvl(comm,0) as "총 급여" from emp;


-- order by 컬럼명 desc(asc 기본)
select ename as "사원명", sal as "기본급",
sal * 12 + NVL(COMM,0) AS "총 급여" FROM EMP
order by sal desc;

select ename as "사원명", sal as "기본급",
sal * 12 + NVL(COMM,0) AS "총 급여" FROM EMP
order by sal asc;

-- desc -> 내림차순
-- asc -> 오름차순

-- 복합 컬럼 이용
-- 정렬 기준, 첫 번째 기준으로 정렬하고, 동일한 값이 있을 때, 두번째 기준 적용.
-- 부서 내에서 급여를 높은 순서로 정렬
SELECT * FROM EMP ORDER BY DEPTNO ASC, SAL DESC;

-- 열 인덱스로 정렬하기
-- ename(1), job(2), sal(3)
select ename, job, sal from emp
order by 3 desc;

-- 시간은, 최신일 값으로 하면 큰값
-- 과거 일수록 값으로 하면 작은 값.
-- emp 테이블에서 모든 사원의 입사일 기준으로 최신순으로 정렬해보기.
select * from emp
order by hiredate desc;

-- 퀴즈1
-- 커미션이 높은 순으로, 급여가 낮은 순으로 정렬 출력
-- 특정 컬럼 언급 없으면 모든 컬럼 출력.
select * from emp order by comm desc, sal asc;
-- 퀴즈2
-- emp 테이블에서 이름, 부서번호, 급여를 출력 하되, 급여가 높은 순으로 정렬해보기.
select ename, deptno, sal from emp order by sal desc;
-- 퀴즈3
-- salgrade 테이블에서 급여 등급이(grade) 오름차순, 
-- 최고급여(hisal) 내림차순으로 정렬해보기.
select * from salgrade order by grade asc, hisal desc;

select * from emp
order by comm desc, sal asc;

select ename, deptno, sal
from emp
order by sal desc;

select * from salgrade
order by grade asc, hisal desc;

-- where 기본 문법 확인
-- where 조건식(true)일 경우 행만 출력
-- 부선 번호가 30인 경우
select * from emp
where deptno = 30;

-- 직무(job)가 'SALES'인 사원 조회
select * from emp
where job = 'SALESMAN';

-- 퀴즈1
-- 급여가(sal) 2000 이상인 사원만 조회하기
select * from emp 
where sal >= 2000 
order by sal;

-- 퀴즈2
-- 입사일(hiredate이 '1981-02-20' 이후인 사원만 조회하기
-- 날짜가 이후이면, 값으로 치면 큰값, 최신이다.
select * from emp
where hiredate > '1981-02-20'
order by hiredate asc;

-- 퀴즈3
-- 부서 번호가 10이 아닌 사원만 조회 하기.
-- 아니다는 표현이 일단은 '<>'으로 표기 하기
select *from emp
where deptno <> 10
order by deptno asc;

select *from emp
where deptno != 10;


select * from emp where sal >= 2000;

select * from emp where hiredate > '1981-02-20';

select * from emp where deptno <> 10;

-- and, or 논리 조건, 다중 조건
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

-- or 조건
-- 하나라도 만족하면 출력됨
-- JOB 가 CLERK 또는 MANAGER 인 사원 출력해보기
select * from emp
where job = 'CLERK' or job = 'MANAGER';

-- 괄호 사용 (우선수위 명확히 하기)
-- 부서 번호가 10 또는 20이고, 급여가 2000 초과인 경우
select * from emp
where (DEPTNO = 10 or DEPTNO = 20)
and sal > 2000;

-- 퀴즈1
-- 급여가 1500 이상이고, 커미션이 null이 아닌 사원만 조회
-- 힌트) null이 아닌 표현 : IS NOT NULL
SELECT * FROM EMP
WHERE SAL >= 1500
AND
COMM IS NOT NULL; 

-- 퀴즈2
-- 직무가 'SALESMAN' 이거나, 급여가 3000 이상인 사원 출력
SELECT * FROM EMP
WHERE JOB = 'SALESMAN'
OR
SAL >= 3000;

-- 퀴즈3
-- 부서번호가 10,20,30 중 하나이고, 급여가 2000 이상인 사원 출력
-- 힌트) 10,20,30 중 하나 표현 : in (10, 20, 30) 이용
-- OR 조건을 간단히 표현하기 위해
-- 컬럼명 IN (값1, 값2, 값3, ...)
-- 컬럼명의 조건이 IN 안의 값을 하나라도 만족한다면 TRUE
SELECT * FROM EMP
WHERE DEPTNO = 10
OR DEPTNO = 20
OR DEPTNO = 30 AND SAL >= 2000;

-- IN 연산자 이용해서 표현해보기
SELECT * FROM EMP
WHERE DEPTNO IN (10, 20, 30)
AND SAL >= 2000;


select * FROM EMP
where comm is not null
and sal >= 1500;

select * from emp
where job = 'SALESMAN' OR SAL >= '3000';

SELECT * FROM EMP
WHERE DEPTNO IN (10, 20, 30)
AND SAL >= 2000;


-- 연산자 종류와 활용 기본
-- 산술 연산자
SELECT ENAME, SAL * 12 AS "기본 연봉" FROM EMP;

-- 비교 연산자
SELECT * FROM EMP WHERE SAL >= 2000;

-- 문자 비교 (1글자 VS 여러글자)
-- L 보다 뒤에, 사전식 기준 생각하기
SELECT * FROM EMP WHERE ENAME < 'L';

-- 여러 글자, 순서대로 앞의 글자 비교하고 다음글자 비교
SELECT * FROM EMP WHERE ENAME < 'MILLER';


-- 등가 비교 연산자
-- !=, <>, ^=
-- JOB CLERK이 아닌 사원만 출력해보기
SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK';


-- NOT 연산자
-- JOB 이 NANAGER 가 아닌 사원만 출력 해보기
SELECT * FROM EMP WHERE NOT JOB = 'MANAGER';

-- IN 연산자 (NOT 포함 버전)
-- OR을 간결히 사용하기
-- 컬럼명 IN (값1, 값2, 값3...)
-- 컬럼의 값이 IN 연산자안의 값을 만족하면 TRUE
-- 부서번호가 10, 30이 아닌 사원을 출력 해보기.
SELECT * FROM EMP WHERE DEPTNO NOT IN (10, 30);

-- BETWEEN A AND B
-- 급여가 1100이상 3000 이하 인 사원 출력 해보기
SELECT * FROM EMP WHERE SAL BETWEEN 1100 AND 3000;

-- 위의 경우의 반대인 경우
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1100 AND 3000;

-- LIKE 연산자
-- 사원명이 S로 시작하는 사원 출력 해보기
-- 컬럼명 LIKE '조건식'
-- % : 모든 글자
-- _ : 언더바 : 특정 글자
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

-- 사원명이 두 번째 글자가 L을 포함하는 사원 출력하기
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

-- 사원명이 AM 글자를 포함하는 사원 출력하기
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

-- 위의 경우, 반대일 때
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- IS NULL 널 조건이니?/ IS NOT NULL 널이 아닌 조건이니?
-- 커미션이 널인 사원만 출력하기
SELECT * FROM EMP WHERE COMM IS NULL;
-- 위의 경우 반대인 경우
SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- AND + IS NULL
-- JOB 가 SALESMAN 이고 COMM 이 널 인 사원만 출력
SELECT * FROM EMP WHERE JOB = 'SALESMAN'
AND COMM IS NULL;

-- 위의 경우 반대일때
SELECT * FROM EMP WHERE JOB = 'SALESMAN'
AND COMM IS NOT NULL;

-- OR + IS NULL
-- JOB MANAGER 이거나 MGR(직속상관)이 NULL인 사원 출력하기
SELECT * FROM EMP WHERE JOB = 'MANAGERE' 
OR MGR IS NULL;

-- 집합 연산자
-- 1. UNION 중복 제거
-- JOB MANAGER 이거나, DEPTNO 10인 사원 출력하기
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE JOB = 'MANAGER'
UNION SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 10;

-- 2. UNION 중복 포함
-- JOB MANAGER 이거나, DEPTNO 10인 사원 출력하기
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE JOB = 'MANAGER'
UNION ALL 
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 10;

-- 3.MINUS (차집합)
-- 부서 번호가 10인 사원들 중에서
-- 직무가 MANAGER인 사원을 제외한 모든 사원 출력하기.
SELECT ENAME, JOB, DEPTNO FROM EMP 
WHERE DEPTNO = 10
MINUS
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE JOB = 'MANAGER';

-- 4.INTERSECT (교집합)
-- JOB CLERK 이면서 동시에, 부서번호가 20인 사원 출력하기
SELECT ENAME, JOB, DEPTNO FROM EMP 
WHERE JOB = 'CLERK'
INTERSECT
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE DEPTNO = 20;

-- 퀴즈1
-- 급여가 2500 이상인 사원들의 이름과 급여를 조회하기


-- 퀴즈2
-- 부서번호가 10번 또는 20이 이면서, 직무가'CLERK'인 사원 조회하기
SELECT * FROM EMP
WHERE DEPTNO IN(10, 20)
AND JOB = 'CLERK';
-- 퀴즈3
-- 수당이 존재하지 않는 사원 중에서 직무가 'SALESMAN'인 사원 조회하기
SELECT * FROM EMP
WHERE JOB = 'SALESMAN'
AND COMM IS NULL;
-- 퀴즈4
-- 직무가 'CLERK'인 사원 중 급여가 1000 이상 1500 이하 인 사원 조회하기
SELECT * FROM EMP
WHERE JOB = 'CLERK'
AND SAL BETWEEN 1000 AND 1500;
-- 퀴즈5
-- 이름에 'DA'를 포함하는 사원 이름과 직무를 조회하기
SELECT ENAME, JOB 
FROM EMP
WHERE ENAME LIKE '%DA%';
-- 퀴즈6
-- 부서번호가 10번인 사원 중, 직무가 'MANAGER'가 아닌 사원을 출력하기
-- 단, MGR이 NULL인 사람도 포함하기
SELECT * FROM EMP
WHERE DEPTNO = 10
AND (JOB !='MANAGER' OR MGR IS NULL);

--1.
SELECT ENAME, SAL FROM EMP 
WHERE SAL > 2500;

-- 2
SELECT * FROM EMP
WHERE DEPTNO IN(10, 20)
AND JOB ='CLERK';
-- 3
SELECT * FROM EXP
WHERE COMM = 0
AND JOB = 'SALESMAN';
-- 5
SELECT ENAME, JOB 
FROM EMP 
WHERE ENAME LIKE '%DA%';

SELECT DEPTNO, JOB
FROM EMP
WHERE DEPTNO = 10
AND JOB != 'MANAGER'
OR MGR IS NULL;


-- 문자열 관련 내장 함수, 오라클에서 미리 만든 기능
-- 우리는 이용하는 부분을 공유함.
-- 이름을 모두 대문자로 출력
SELECT ENAME, 
UPPER(ENAME) AS "사원명은 대문자",
LOWER(ENAME) AS "사원명은 소문자",
INITCAP(ENAME) AS "사원명은 첫글자 대문자" 
FROM EMP;

-- 사원 이름의 길이 출력, 바이트 수 출력
SELECT ENAME, 
LENGTH(ENAME) AS "사원명 글자 길이",
LENGTHB(ENAME) AS "사원명 바이트 길이"
FROM EMP;

-- 직문 문자열 안에 'A'가 포함된 위치
SELECT JOB, 
-- 문자열 찾기
-- INSTR(컬럼명(문자열), 찾을문자, 시작위치, 몇번째)
INSTR(JOB,'A') AS "A가 몇번째 위치",
-- 문자열 일부 추출
-- SUBSTR(컬럼명(문자열), 시작위치 1부터 시작, 길이)
SUBSTR(JOB, 1, 3) AS "1~3글자 읽기",
-- 문자열 바꾸기
-- REPLACE(컬럼명(문자열), 바꿀 대상, 바꿀내용)
REPLACE(JOB, 'CLERK', '직원') AS "한글 직무"
FROM EMP;


-- LPAD, RPAD : 포매 맞추기
-- LPAD(컬럼명(문자열), 총길이, '채워질 문자')
-- 사원명에서 전체길이 9자리 만들고, 남은 부분은 채워질 문자로 채움
SELECT ENAME, 
LPAD(ENAME, 9, '*') AS "9글자포맷마스킹 처리",
RPAD(ENAME, 9, '*') AS "9글자포맷마스킹 처리"
FROM EMP;

-- TRIM : 문자열 양쪽 문자 제거
-- TRIM(LEADING | TRAILING | BOTH '제거문자' FROM 문자열)
-- LEADING : 앞에서 제거
-- TRAILING : 뒤에서 제거
-- BOTH : 양쪽 제거 (생략 시 기본값으로 적용)
-- 목적, 공백 또는 지정 문자 제거
-- DUAL : 더미 테이블, 없는 테이블, 주로 간단한 함수 테스트 하는 목적 이용.
SELECT 
TRIM('   ORACLE   ') AS "양쪽 공백 제거",
LTRIM('   ORACLE   ') AS "왼쪽 공백 제거",
RTRIM('   ORACLE   ') AS "오른쪽 공백 제거"
FROM DUAL;

--
SELECT 
TRIM(BOTH '#' FROM '###HELLO###') AS "BOTH 결과",
TRIM('#' FROM '###HELLO###') AS "BOTH 생략 결과",
TRIM(LEADING '#' FROM '###HELLO###') AS "LEADING 결과",
TRIM(TRAILING '#' FROM '###HELLO###') AS "TRAILING 결과"
FROM DUAL;

-- 문자열 연결 해보기
-- CONCAT(컬럼명1{문자열1), 컬럼명2(문자열2))
-- 2 문자열을 연결(합치는) 함수
SELECT CONCAT(ENAME, JOB) AS "이름+직무" FROM EMP;
SELECT CONCAT('정', '찬우') AS "이름 결합" FROM DUAL;
-- CONCAT 2개까지만 가능, 그 이상 연결시 (||)
SELECT '연결할 문자열 2개이상' || '버티컬 바 2개를 붙이고' || '그러면 연결한
문자열을 합치기 가능함' FROM DUAL;

-- 퀴즈1 SUBSTR / FROM DUAL 이용
-- 주민번호에서 생년월일만 추출 / 별칭 생년월일로 출력 해보기
SELECT SUBSTR('971027-1234567', 1, 6) AS "생년월일" FROM DUAL;

-- 퀴즈2 INSTR / FROM DUAL 이용 
-- 이메일에서 @ 위치 찾기 / 별칭 골뱅이위치로 출력 해보기
SELECT INSTR('jcw6223@naver.com', '@') AS "골뱅이 위치" FROM DUAL;

-- 퀴즈3 REPLACE / FROM DUAL이용
-- 전화번호에서 - 제거 해보기, 010-1234-5678
-- 별칭 정리된번호로 출력 해보기
SELECT REPLACE('010-3445-6223', '-', '') AS "정리된 번호" FROM DUAL;

-- 퀴즈4 LPAD / FROM EMP 이용
-- 부서번호를 왼쪽으로 공백 채우기 / 별칭 정렬용 출력해보기
 SELECT ENAME, LPAD(DEPTNO, 4, ' ') AS "정렬용" FROM EMP;

-- 퀴즈5 TRIM / FROM DUAL 이용
-- 앞뒤 공백 제거 해보기 / 별칭 정리된 문자 출력 해보기 
-- 예제 문자열 : 공백공백공백(본인이름)공백공백공백
SELECT TRIM(   '정찬우'   ) AS "정리된 문자" FROM DUAL;

-- 퀴즈6 CONCAT / FROM EMP 이용
-- 사원명 + 부서번호 / 별칭 사원명 + 부서번호 출력 해보기
SELECT CONCAT(ENAME, DEPTNO) AS "사원명+부서번호" FROM EMP;
SELECT ENAME || '-' || JOB AS "사원명+부서번호" FROM EMP;


-- 숫자 관련 함수
-- 급여의 소수점 둘째 자리에서 반올림
SELECT ENAME,SAL, ROUND(123.456, 1) AS "ROUND(SAL, 1)" FROM EMP;
-- 내림 소수점 이하 제거
SELECT ENAME,SAL, TRUNC(123.456, 0) AS "ROUND(SAL, 1)" FROM EMP;
-- 사원 번호를 2로 나눈 나머지출력
SELECT ENAME,EMPNO, MOD(EMPNO,2) AS "2로 나눈 나머지" FROM EMP;

-- CELL, FLOOR 비교
SELECT ENAME, SAL, CEIL(SAL / 3), FLOOR(SAL / 3) FROM EMP;


-- 퀴즈1 / FROM DUAL  / ROUND 활용 / 별칭 : 소수점 둘째 자리까지 반올림
-- 소수점 둘째 자리까지 반올림 해보기
-- 임의 숫자 : 123.4567
SELECT ROUND(123.4567, 2) AS "둘째자리까지반올림" FROM DUAL;

-- 퀴즈2 / FROM DUAL  / TRUNC 활용 / 별칭 : 소수점 첫째 자리에서 내림
-- 소수점 첫째 자리까지 내림 해보기
-- 임의 숫자 : 123.4567
SELECT TRUNC(123.4567, 1) AS "첫째자리까지내림" FROM DUAL;

-- 퀴즈3 / FROM DUAL / 별칭 : CEIL, FLOOR
-- CEIL,FLOOR 비교해보기
-- 임의 숫자 : 1.5, -1.5
SELECT 
CEIL(1.5) AS "CEIL/1.5",
FLOOR(1.5) AS "FLOOR/1.5",
CEIL(-1.5) AS "CEIL/-1.5",
FLOOR(-1.5) AS "FLOOR/-1.5"
FROM DUAL;

-- 퀴즈4 / MOD / FROM DUAL
-- 사원 번호를 4로 나눈 나머지 출력
-- 별칭 : 4로 나눈 나머지
SELECT MOD(123,4) AS "4로 나눈 나머지"
FROM DUAL;