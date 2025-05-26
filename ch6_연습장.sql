-- 문자열 관련 내장 함수 , 오라클에서 미리 만든 기능 
-- 우리는 이용하는 부분을 공부함. 

-- 이름을 모두 대문자로, 소문자, 첫글자 대문자등 출력 
SELECT 
ENAME, 
UPPER(ENAME) AS "사원명 대문자",
LOWER(ENAME) AS "사원명 소문자",
INITCAP(ENAME) AS "사원명 첫글자 대문자"
FROM EMP;

-- 사원 이름의 길이, 바이트 수 출력
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
SUBSTR(JOB,1,3) AS "1~3글자 읽기",
-- 문자열 바꾸기
-- REPLACE(컬럼명(문자열),바꿀 대상, 바꿀내용)
REPLACE(JOB,'CLERK', '직원') AS "한글 직무"
FROM EMP;

-- LPAD, RPAD : 포맷 맞추기
-- LPAD(컬럼명(문자열), 총길이, '채워질 문자')
--- 사원명에서 전체길이 9자리 만들고, 
-- 남은 부분은 채워질 문자로 채움
SELECT ENAME, 
LPAD(ENAME, 9, '*') AS "9글자포맷마스킹처리",
RPAD(ENAME, 9, '*') AS "9글자포맷마스킹처리"
FROM EMP;

-- TRIM : 문자열 양쪽 문자 제거 
-- TRIM(LEADING | TRAILING | BOTH '제거문자' FROM 문자열)
-- LEADING : 앞에서 제거 
-- TRAILING : 뒤에서 제거 
-- BOTH : 양쪽 제거 (생략 시 기본값으로 적용)
-- 목적, 공백 또는 지정 문자 제거 F
-- DUAL : 더미 테이블, 없는 테이블, 주로, 간단한 함수 
-- 테스트 하는 목적 이용.
SELECT 
TRIM('   ORACLE   ') AS "양쪽 공백 제거" ,
LTRIM('   ORACLE   ') AS "왼쪽 공백 제거" ,
RTRIM('   ORACLE   ') AS "오른쪽 공백 제거" 
FROM DUAL;

-- 
SELECT 
TRIM(BOTH '#' FROM '###HELLO###') AS "BOTH 결과" ,
TRIM('#' FROM '###HELLO###') AS "BOTH 생략 결과",
TRIM(LEADING '#' FROM '###HELLO###') AS "LEADING 결과",
TRIM(TRAILING '#' FROM '###HELLO###') AS "TRAILING 결과"
FROM DUAL;

-- 문자열 연결 해보기 
-- CONCAT(컬러명1(문자열1),컬러명2(문자열2))
-- 2 문자열을 연결(합치는) 함수 
SELECT CONCAT(ENAME, JOB) AS "이름+직무" FROM EMP;
SELECT CONCAT('이', '상용') AS "이름 결합" FROM DUAL;
-- CONCAT 2개까지만 가능, 그 이상 연결시 (||)
-- 키보드 엔터 위에 키 (|) 2번 사용 후 이용 가능. 
SELECT '연결할 문자열 2개이상' || ' 버티컬 바 2개를 붙이기'
|| ' 그러면 연결한 문자열을 합치기 가능함' FROM DUAL;

--퀴즈1 , SUBSTR
-- 주민번호에서 생년월일만 추출 
-- 별칭 생년월일로 출력 해보기, 
-- FROM DUAL  이용하기
SELECT SUBSTR('841205-1234567',1,6) AS "생년월일"
FROM DUAL;

--퀴즈2 , INSTR
-- 이메일에서 @ 위치 찾기
-- 별칭 골뱅이위치로 출력 해보기, 
-- FROM DUAL  이용하기
SELECT INSTR('LSY@naver.com','@') AS "골뱅이위치"
FROM DUAL;

--퀴즈3, REPLACE
-- 전화번호에서 - 제거 해보기, 010-7661-3709
-- 별칭 정리된번호로 출력 해보기, 
-- FROM DUAL  이용하기
SELECT REPLACE('010-7661-3709','-','') AS "정리된번호"
FROM DUAL;

--퀴즈4, LPAD
-- 부서번호를 왼쪽으로 공백 채우기 
-- 별칭 정렬용 출력 해보기, 
-- FROM EMP  이용하기
SELECT ENAME, LPAD(DEPTNO, 4, ' ') AS "정렬용"
FROM EMP;

--퀴즈5, TRIM 
-- 앞뒤 공백 제거 해보기 , 
-- 예제 문자열 :공백공백공백(본인이름)공백공백공백
-- 별칭 정리된문자 출력 해보기, 
-- FROM  DUAL  이용하기
SELECT TRIM('   이상용   ') AS "정리된문자"
FROM DUAL;

--퀴즈6, CONCAT 
-- 사원명 + 부서번호 
-- 별칭 사원명 + 부서번호 출력 해보기, 
-- FROM  EMP  이용하기
SELECT CONCAT(ENAME, JOB) AS "사원명 + 부서번호"
FROM EMP;
SELECT ENAME || '-' || JOB AS "사원명 + 부서번호"
FROM EMP;


--숫자 관련 함수 기본 
-- 급여의 소수점 둘째 자리에서 반올림 
SELECT ENAME,SAL, ROUND(123.456, 1) AS "ROUND(123.456, 1)" 
FROM EMP ;
-- 내림 소수점 이하 제거 TRUNC
SELECT ENAME,SAL, TRUNC(123.456, 0) AS "TRUNC(123.456, 1)" 
FROM EMP ;

-- 사원 번호를 2로 나눈 나머지 출력 
SELECT ENAME, EMPNO, MOD(EMPNO,2) AS "2로 나눈 나머지"
FROM EMP;

--CEIL, FLOOR 비교 
SELECT ENAME, SAL, CEIL(SAL / 3), FLOOR(SAL /3)
FROM EMP;

-- 퀴즈1 ROUND
-- 소수점 둘째 자리까지 반올림 해보기, 
-- 임의 숫자 : 123.4567
-- 별칭 : 소수점 둘째 자리까지 반올림
-- FROM DUAL 
SELECT ROUND(123.4567,2) AS "소수점 둘째 반올림" 
FROM DUAL;

-- 퀴즈2 TRUNC
-- 소수점 첫째 자리에서 내림 해보기, 
-- 임의 숫자 : 123.4567
-- 별칭 : 소수점 첫째 자리에서 내림
-- FROM DUAL 
SELECT TRUNC(123.4567,1) AS "소수점 첫째에서 내림" 
FROM DUAL;
-- 퀴즈3 CEIL, FLOOR
-- CEIL, FLOOR 비교 해보기, 
-- 임의 숫자 : 1.5, -1.5
-- 별칭 : CEIL , FLOOR
-- FROM DUAL 
--  1 ~ 2 사이에서 , 1.5 기준 큰수 : 2, 작은 수:1
SELECT CEIL(1.5) AS "CEIL" ,
FLOOR(1.5) AS "FLOOR",
--  -2 ~ -1 사이에서 , -1.5 기준 
-- 큰수 : -1, 작은 수:-2
CEIL(-1.5) AS "CEIL" ,
FLOOR(-1.5) AS "FLOOR"
FROM DUAL;
-- 퀴즈4 MOD
-- 사원 번호를 4로 나눈 나머지 출력
-- 별칭 : 4로 나눈 나머지
-- FROM DUAL 
SELECT EMPNO, MOD(EMPNO, 4) AS "4로 나눈 나머지"
FROM EMP;


