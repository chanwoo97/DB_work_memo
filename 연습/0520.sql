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
-- 1 ~ 2 사이에서, 1.5기준 큰수:2 작은수:1
-- -2 ~ -1 사이에서, 1.5기준 큰수:-1 작은수:-2
SELECT 
CEIL(1.5) AS "CEIL/1.5",
FLOOR(1.5) AS "FLOOR/1.5",
CEIL(-1.5) AS "CEIL/-1.5",
FLOOR(-1.5) AS "FLOOR/-1.5"
FROM DUAL;

-- 퀴즈4 / MOD / FROM DUAL
-- 사원 번호를 4로 나눈 나머지 출력
-- 별칭 : 4로 나눈 나머지
SELECT MOD(123, 4) AS "4로 나눈 나머지" FROM DUAL;  

SELECT EMPNO, MOD(EMPNO, 4) AS "4로 나눈 나머지" FROM EMP;

---------------------------------------------------------------------

-- distinct 중복 값 제거
SELECT DISTINCT JOB AS "직종" FROM EMP;

-- 반대(ALL, 기본값 생략 가능)
SELECT ALL JOB AS "직종" FROM EMP;

-- DISTINCT 중복 값 제거, 2개 열
-- 
SELECT DISTINCT JOB AS "직종",
DEPTNO AS "부서번호" FROM EMP;

-- 문자열 관련 내장 함수
-- 이름의 첫 글자를 F를 기준으로 사전식 정렬
SELECT * FROM EMP WHERE ENAME < 'F';

-- 부정 연산자, !=, <>, ^=
SELECT * FROM EMP WHERE SAL != 3000;
SELECT * FROM EMP WHERE SAL <> 3000;
SELECT * FROM EMP WHERE SAL ^= 3000;

-- OR 연산자를 조금 더 간결하게 표현하는 IN 연산자
SELECT * FROM EMP
WHERE JOB NOT IN('MANAGER', 'SALESMAN', 'CLERK');

-- BETWEEN A AND B, A 이상 B 이하
SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <=3000;
SELECT *FROM EMP WHERE SAL BETWEEN 2000 AND 3000;

-- % : 모든 문자, _" : 한글자
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
-- 2번째 글자 L를 포함하는 이름
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
-- 3번째 글자 L를 포함하는 이름
SELECT * FROM EMP WHERE ENAME LIKE '__L%';
-- 이름에 AM를 포함하는 사원
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';


-- 문자열 관련 내장 함수
-- 대문자
SELECT ENAME, UPPER(ENAME), LOWER(ENAME),
INITCAP (ENAME) FROM EMP;

-- 글자 길이 비교, 바이트로 비교
-- DUAL, 더미 테이블, 간단한 테스트 용도로 사용함.
SELECT LENGTH('정찬우'), LENGTHB('정찬우'),
LENGTH('ABC'), LENGTHB('ABC') FROM DUAL;

-- SUBSTR, 문자 열에서 특정 구간을 자르기 할 때 사용
-- SUBSTR(선택컬럼(문자열), 시작위치,(1부터 시작), 길이만큼 추출)
-- SUBSTR('HELLO', 1, 3) -> HEL
SELECT JOB, SUBSTR (JOB, 1, 2), SUBSTR(JOB,6) FROM EMP;
-- 조금 어려운 표현
-- PRESIDENT
-- 123456789, 정방향 표현
-- -9-8-7-6-5-4-3-2-1 
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)),
SUBSTR(JOB,-LENGTH(JOB),3)
FROM EMP;
SELECT SUBSTR('HELLO',-5, 2) FROM DUAL;

-- INSTR, 문자의 특정 위치 추출 해보기.
-- INSTR(컬럼명,(문자열), 찾기 위한 문자, 시작 위치, 몇번째 출현)
SELECT INSTR('HELLO HI LOTTO', 'L'), 
INSTR('HELLO HI LOTTO', 'L', 5),
INSTR('HELLO HI LOTTO', 'L', 2, 2), 
INSTR('HELLO HI LOTTO', 'O', 2, 2) 
FROM DUAL;

-- REPLACE
SELECT '010-3445-6223' AS "변경전 문자열",
REPLACE('010-3445-6223','-', ' ') AS "-,공백으로 변경",
REPLACE('010-3445-6223','-') AS "변경 옵션이 없을경우"
FROM DUAL;

-- LPAD, 왼쪽으로 특정 문자 채우기
-- RPAD, 오른쪽으로 특정 문자 채우기
-- TRIM, 양쪽 공백 제거하기

SELECT 'ORACLE', LPAD('ORACLE',10,'#'),
RPAD('ORACLE',10,'#'),
RPAD('971027-1', 14, '*')
FROM DUAL;

SELECT TRIM('   ORACLE   '),
TRIM(LEADING FROM '   ORACLE   '), 
TRIM(TRAILING FROM '   ORACLE   ')
FROM DUAL;

-- 검색, %am%
-- 현재, EMP 테이블의 데이터 내용은 모두 대문자.
-- 만약, 나중에 데이터가 대,소문자가 섞여 있는 상황
-- 사용자 검색을 단순 소문자로만 했을 경우, 
-- 검색의 결과는 대,소문자 상관없이 결과에 나오게 하기
-- 1번째 방법 / 정확히 일치하는 것만 검색
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) = LOWER('scott');
 
-- 2번째 방법 / am 포함하는 키워드 찾기
SELECT ENAME FROM EMP
WHERE ENAME LIKE UPPER('%am%');

-- 3번째 방법 / 기존 데이터를 모두 소문자로 변경후 am 포함하는 키워드 찾기.
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) LIKE LOWER('%Am%');


----------------------------------------------------------------------
-- 시간 설정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- 오라클 시간 동기화
-- 도커 데스크톱 실행 후
-- 도커 데스크톱 -> 컨테이너 아이디 복사
-- 예시 / a96d6a58181d6f33870f9b01fd8a824e70e8a7b607c0337af8ea85e7d31cab53

-- 터미널에서 하기
-- 마이크로소프트의 스토어 : 터미널 검색 후 설치
-- docker exec -it a96d6a58181d6f33870f9b01fd8a824e70e8a7b607c0337af8ea85e7d31cab53 /bin/bash

-- dpkg-reconfigure tzdata

-- 만약 안될경우, apt-get update
-- 만약 안될경우2, apt-get install --reinstall tzdata 

-- 6 asis , 선택
-- 69 seoul 선택
-- date, 명령어 확인


-- 날짜 데이터를 다루는 내장 함수

-- 현재 날짜
SELECT SYSDATE FROM DUAL;

-- 3개월 후
SELECT ADD_MONTHS(SYSDATE, 3) FROM DUAL;

-- 개월 차이
SELECT MONTHS_BETWEEN(SYSDATE, HIREDATE) FROM EMP;

-- 다음 금요일, 요일 선택 부분에 서버의 언어맞게 설정하기
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;

-- 이번달 말이
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 날짜를 반올림 / 버림
SELECT ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL;

-- 입사일로부터 10주년 구하기
SELECT ENAME, ADD_MONTHS(HIREDATE, 120) AS "10주년" FROM EMP;

-- 퀴즈1
-- 입사일로부터 32년이 지난 사원만 출력하기
SELECT ENAME, HIREDATE FROM EMP
WHERE ADD_MONTHS(HIREDATE, 32 * 12) < SYSDATE;

-- 32 * 12 = 384
SELECT * FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) > 384;

-- 퀴즈2
-- 사원별로 입사일 기준 다음 월요일 출력하기
SELECT ENAME, NEXT_DAY(HIREDATEM, 'MONDAY') FROM EMP;

SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE, '월요일') AS "다음 월요일" FROM EMP;

-- 퀴즈3
-- 사원의 입사일을 월 단위로 반올림 해서 출력하기
SELECT ENAME, HIREDATE, ROUND(HIREDATE, 'MONTH') AS "월단위반올림" FROM EMP;

SELECT ENAME, HIREDATE, ROUND(HIREDATE, 'MONTH') AS "반올림일자" FROM EMP;

----------------------------------------------------------------------------

-- 변환 함수, 날짜 <-> 문자열, 숫자 <-> 문자열

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
-- 현재 날짜를, YYYY-MM-DD 형식으로 츨력.
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
-- 현재 날짜를, YYYY-MM-DD  HH:MI:SS 형식으로 출력.
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI') FROM DUAL;

-- 급여를 천 단위로 쉼표 포함 출력
SELECT ENAME, TO_CHAR(SAL, '999,999') FROM EMP;

-- 급여에 끝자리 단위로 달러 표기 해보기
SELECT '급여 : '|| TO_CHAR(3000,'999,999') || '$' FROM DUAL;

SELECT ENAME, TO_CHAR(SAL,'999,999') || '$' FROM EMP;

-- D DAY 예제, 문자열 타입 -> 데이트 날짜 타입 변환
SELECT
TO_DATE('2025-06-01' , 'YYYY-MM-DD') - SYSDATE
AS "6/1 기념일 D-DAY" FROM DUAL;

SELECT
ROUND(TO_DATE('2025-06-01' , 'YYYY-MM-DD') - SYSDATE, 0)
AS "6/1 기념일 D-DAY" FROM DUAL;

SELECT
TRUNC(TO_DATE('2025-06-01' , 'YYYY-MM-DD') - SYSDATE)
AS "D-DAY 남은 일수" FROM DUAL;

-- 남은 시간 표기
SELECT
TRUNC((TO_DATE('2025-06-01' , 'YYYY-MM-DD') - SYSDATE) * 24)
AS "D-DAY 남은 시간" FROM DUAL;

-- 퀴즈1 
-- 1981년 6월 1일 이후 입사한 사원 출력
DESC EMP;

SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD');

SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD');

-- 퀴즈2
-- 월과 요일을 각각 'MM월', '요일' 형식으로 출력
-- 주어진 조건의 날짜 문자열 타입인데, 문자열에서 -> 날짜 타입으로 변환
-- 날짜에서 -> 문자열 타입으로 변환 
SELECT TO_CHAR('SYSDATE', 'MM월', '요일') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MM"월"') AS "월",
TO_CHAR(SYSDATE, 'DAY') AS "요일"
FROM DUAL;

-- 퀴즈3
-- 숫자 문자열을 '1,200'을 숫자로 변환하여 300을 더한 값 출력
SELECT TO_NUMBER('1,200', '9,999') + 300 AS "결과값" FROM DUAL;

----------------------------------------------------------------------------

-- NVL, NVL2 함수 기본 예시

-- 급여가 NULL이면 0으로 대체
SELECT ENAME, JOB, COMM, NVL(COMM, 0) AS "수당" FROM EMP;

-- 커미션이 있으면 'O' 없으면 'X'
SELECT ENAME, NVL2(COMM, 'O', 'X') AS "NVL2함수" FROM EMP;

-- 퀴즈1
-- EMP 테이블에서 커미션이 있는 직원 'O', 나머지 'X'로 표시하고 / NVL2 표기 / 별칭 : 수당여부
-- 전체급여 계산해보기, NVL 이용해서, NULL인 경우 0으로 해서 계산 / 별칭 : 전체 급여
SELECT ENAME, COMM, NVL2(COMM, 'O', 'X') AS "수당여부" FROM EMP;
SELECT ENAME, COMM, SAL, SAL+NVL(COMM, 0) AS "전체 급여" FROM EMP;

SELECT ENAME, NVL2(COMM, 'O', 'X') AS "수당여부",
SAL *12 + NVL(COMM, 0) AS "전체 급여"
FROM EMP;

--------------------------------------------------------------------------

-- DECODE, CASE -> 조건문 쉽게 생각하기
SELECT ENAME, JOB,
DECODE(JOB, 'MANAGER', '관리자',
'CLERK', '사무직',
'SALESMAN', '영업직',
'PRESIDENT', '대표이사',
'ANALYST', '분석팀',
'기타') AS "직무 이름" FROM EMP;

-- 부서 번호에 따라 부서명 출력 (CASE 출력)
SELECT ENAME, DEPTNO, 
CASE DEPTNO
WHEN 10 THEN '인사부'
WHEN 20 THEN '연구개발부'
WHEN 30 THEN '영업부'
ELSE '기타부서'
END
AS "CASE별 부서명" FROM EMP;

-- 급여에 따라 급여 등급 부여
-- E : EMP, S : SALGRADE
SELECT E.ENAME, E.SAL,
CASE 
WHEN E.SAL BETWEEN S.LOSAL AND S.HISAL THEN S.GRADE
END
AS "급여 등급" FROM EMP E, SALGRADE S;

-- 퀴즈 1
-- DECODE로 JOB에 따른 직책 명시 / (CLERK : 사원, MANAGER : 관리자, ANALYST : 분석가)
-- 별칭 : 직책 이름
SELECT ENAME, JOB,
DECODE(JOB, 
'CLERK', '사원',
'MANAGER', '관리자',
'ALANYST', '분석가',
'기타')
AS "직책 이름" FROM EMP;

-- 퀴즈 2
-- 'CASE'로 근속 연수 분류
-- (HIREDATE 기준, 1982년 이전 : 장기근속, 이후 : 일반)
-- 별칭 : 근속 연수
SELECT ENAME, HIREDATE,
CASE 
WHEN HIREDATE < TO_DATE('1982-01-01', 'YYYY-MM-DD') THEN '장기근속'
ELSE '일반'
END
AS "근속 연수" FROM EMP;

-- 퀴즈3
-- `CASE` 단순형으로 DEPTNO에 따라 위치 표시 
-- (10: NEW YORK, 20: DALLAS, 30: CHICAGO)
-- 별칭 : 근무 지역
SELECT ENAME,
CASE DEPTNO
WHEN 10 THEN 'NEW YORK'
WHEN 20 THEN 'DALLAS'
WHEN 30 THEN 'CHICAGO'
ELSE '미지정'
END 
AS "근무 지역" FROM EMP;

--------------------------------------------------------------------------

-- 다중행 함수
-- 하나의 열에 출력 결과를 담는 다중행 함수. 집계함수, AGGREGATE, 갯수, 평균, 합계, 최대, 최소 등

-- 전체 급여 합계
-- 다중행 함수는 단일 행 함수와 달리 집계처리가 핵심.
SELECT ENAME FROM EMP;
SELECT MAX(SAL), MIN(SAL), SUM(SAL) FROM EMP;

-- 갯수 구해보기
-- 급여가 있는 사원의 수
SELECT COUNT(SAL) FROM EMP;

-- 부서번호가 30번인 사원의 수
-- COUNT(*) : NULL 여부 관계없이 해당 조건을 만족하는 전체 행의 수를 반환 한다는 의미.
-- SAL이 NULL 이어도 포함함.
-- COUNT(SAL) : SAL 컬럼 값이 NULL이 아닌 경우만 카운트 함 / NULL이면 제외함.
SELECT COUNT(*) FROM EMP
WHERE DEPTNO = 30;

-- 퀴즈1 
-- 부서번호가 10번인 사원들의 최대, 최소 급여를 출력하시오.  
-- 별칭 : 최대 급여, 최소 급여
SELECT MAX(SAL) AS "최대 급여",
MIN(SAL) AS "최소 급여"
FROM EMP
WHERE DEPTNO = 10;

-- 퀴즈2
-- 부서번호가 20번인 사원의 입사일 중 가장 오래된 날짜를 구하시오.  
-- 별칭 : 가장 오래된 날짜
SELECT MIN(HIREDATE) AS "가장 오래된 날짜"
FROM EMP
WHERE DEPTNO = 20;


-- 퀴즈3
-- 중복된 급여를 제외한 평균 급여를 출력하시오. 
-- DISTINCT 힌트 
-- 별칭 : 평균 급여
SELECT AVG(DISTINCT SAL) AS "평균 급여" FROM EMP;
SELECT AVG(DISTINCT SAL) AS "중복 X 평균 급여" FROM EMP;
SELECT TRUNC(AVG(SAL)) AS "중복 O 평균 급여" FROM EMP;

---------------------------------------------------------------------
-- 기본 문법 
-- SELECT 그룹열, 집계함수 
-- FROM 테이블 
-- GROUP BY 그룹열
-- [ORDER BY 정렬열]

-- 기본 예제 확인. 
-- 부서별 , 평균 급여 
SELECT deptno, AVG(sal) FROM emp 
GROUP BY deptno;

-- 직책별 최대 급여 
SELECT JOB, MAX(SAL) FROM EMP
GROUP BY JOB;

-- 부서번호 + 직책 기준 평균 급여 
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP 
GROUP BY DEPTNO, JOB;

-- 부서별 사원의 수 구하기 
SELECT DEPTNO, COUNT(*) FROM EMP 
GROUP BY DEPTNO;

-- 각 부서의 평균 급여를 내림차순으로 정렬해보기. 
SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO 
ORDER BY AVG(SAL) DESC;

-- 퀴즈1 
-- 부서 번호와 직책별 평균 급여를 출력하고, 
-- 평균 급여 기준 내림차순 정렬하시오.   
-- 별칭 : 평균 급여
SELECT DEPTNO, JOB, AVG(SAL) AS "평균 급여"
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY AVG(SAL) DESC;

-- 퀴즈2
-- `GROUP BY` 절에 포함되지 않은 `ename`을 
-- `SELECT`에서 사용한 경우의 오류 상황을 만들어 보시오.  

SELECT DEPTNO, JOB, ENAME, AVG(SAL) AS "평균 급여"
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY AVG(SAL) DESC;

-- 퀴즈3
-- 각 부서별로 보너스가 있는 사원의 수를 구하시오. 
-- 별칭 : 보너스 받는 직원수
SELECT DEPTNO, COUNT(COMM) AS "보너스 받는 직원수"
FROM EMP
WHERE BOUNS IS NOT NULL
GROUP BY EDPTNO;

SELECT DEPTNO, COUNT(COMM) AS "보너스 받는 직원수" FROM EMP
GROUP BY DEPTNO;

---------------------------------------------------------------------------

-- 그룹으로 나눈 대상에, 필터(집계하기), 
-- 평균, 갯수, 최대, 최소, 카운트 
-- 기본 문법
-- SELECT 그룹열, 집계함수
-- FROM 테이블명
-- [WHERE 조건]           -- 행 필터링
-- GROUP BY 그룹열
-- [HAVING 집계조건]      -- 그룹 필터링
-- ORDER BY 정렬조건;

-- 평균 급여가 2000 이상인 부서 출력 해보기 
SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

-- 사원수가 3명 이상인 직책 그룹만 출력 
SELECT JOB, COUNT(*) FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- WHERE 절과 HAVING 절 같이 사용해보기. 
SELECT * FROM EMP WHERE JOB = 'SALESMAN';

-- 조건 기반 평균 급여 필터링, 
-- 순서
-- 1. EMP 테이블에서 JOB = 'SALESMAN' 조건 
-- 만족하는 행만 선택 
-- 2 선택된 SALESMAN 들 중 DEPTNO 기준으로 그룹화 
-- 3 각 그룹별로 AVG(SAL) 계산 
-- 4 평균이 1000보다 큰 그룹만 출력. 
SELECT DEPTNO , AVG(SAL) FROM EMP 
WHERE JOB = 'SALESMAN'
GROUP BY DEPTNO 
HAVING AVG(SAL) > 1000;


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
-- 그 중 평균 급여가 3000 이상인 부서만 출력하시오.  
-- 별칭 : 평균 급여
SELECT DEPTNO, AVG(SAL) AS "평균 급여" FROM EMP
WHERE DEPTNO IN(10, 20)
GROUP BY DEPTNO
HAVING AVG(SAL) >= 3000;









