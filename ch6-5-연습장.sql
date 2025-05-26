-- 변환 함수, 날짜 <-> 문자열, 숫자 <-> 문자열 

-- 현재 날짜를 , YYYY-MM-DD 형식으로 출력. 
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
-- 현재 날짜를 , YYYY-MM-DD  HH:MI:SS 형식으로 출력. 
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- 급여를 천 단위로 쉼표 포함 출력,
SELECT ENAME, TO_CHAR(SAL, '999,999') FROM EMP;

-- 급여에 끝자리 단위를 달러 표기 해보기 
SELECT '급여 : ' || TO_CHAR(3000, '999,999') 
|| '$' FROM DUAL;
SELECT ENAME, TO_CHAR(SAL, '999,999') || '$' 
FROM EMP;

--D Day 예제 , 문자열 타입 -> 데이트 날짜 타입 변환
SELECT 
TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE
AS "6/1 기념일 D-DAY" FROM DUAL;

SELECT 
ROUND(TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE,0)
AS "6/1 기념일 D-DAY" FROM DUAL;

SELECT 
TRUNC(TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE)
AS "D-DAY 남은 일수" FROM DUAL;

-- 남은 시간 표기 
SELECT 
TRUNC((TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE) * 24)
AS "D-DAY 남은 시간" FROM DUAL;

--퀴즈1 
-- 1981년 6월 1일 이후 입사한 사원 출력 해보기
-- 주어진 조건의 날짜 문자열 타입인데, 
-- 문자열에서 -> 날짜 타입으로 변환
DESC EMP;
SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD');

--퀴즈2
-- 월과 요일을 각각 'MM월', '요일' 형식으로 출력 해보기
-- 날짜에서 -> 문자열 타입으로 변환
SELECT TO_CHAR(SYSDATE, 'MM"월"') AS "월",
TO_CHAR(SYSDATE, 'DAY') AS "요일"
FROM DUAL;

--퀴즈3 
-- 숫자 문자열을 '1,200'을 숫자로 변환하여 
-- 300을 더한 값 출력 해보기 
SELECT TO_NUMBER('1,200', '9,999') + 300 
AS "결괏값" FROM DUAL;




