-- NVL, NVL2 함수 기본 예시 

-- 급여가 NULL 이면 0으로 대체 
SELECT ENAME, JOB, COMM, NVL(COMM,0) AS "수당"
FROM EMP;

-- 커미션이 있으면 'O', 없으면 'X'
SELECT ENAME, NVL2(COMM,'O','X') AS "NVL2함수"
FROM EMP;

SELECT * FROM DEPT;
SELECT * FROM EMP;

--퀴즈1 
-- EMP 테이블에서 커미션이 있는 직원 'O', 나머지 'X'로 표시하고  NVL2  표기 
-- 별칭 수당 여부

-- 전체 급여 계산해보기, NVL 이용해서,  NULL 인 경우, 0으로 해서 계산 해보기 
-- 별칭 전체 급여
SELECT ENAME, NVL2(COMM, 'O','X') AS "수당 여부",
SAL * 12 + NVL(COMM,0) AS "전체 급여"
FROM EMP;
