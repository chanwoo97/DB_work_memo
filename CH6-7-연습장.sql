-- DECODE , CASE -> 조건문 쉽게 생각하기
-- DECODE(표현식, 
--       값1, 반환값1, 
--       값2, 반환값2, 
--       ..., 
--       기본값)
SELECT ENAME, JOB,
DECODE(JOB ,
'MANAGER', '관리자',
'CLERK' , '사무직',
'SALESMAN', '영업직',
'PRESIDENT', '대표이사',
'ANALYST','분석팀',
'기타') AS "직무 이름"
FROM EMP;

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
-- E : EMP , S : SALGRADE
SELECT E.ENAME, E.SAL, 
CASE 
WHEN E.SAL BETWEEN S.LOSAL AND S.HISAL THEN S.GRADE
END 
AS "급여 등급"
FROM EMP E, SALGRADE S;

--퀴즈1 
-- `DECODE`로 JOB에 따른 직책 명시 
-- (CLERK: 사원, MANAGER: 관리자, ANALYST: 분석가)
-- 별칭 : 직책 이름
SELECT ENAME, 
DECODE(JOB,
'CLERK','사원',
'MANAGER', '관리자',
'ANALYST','분석가',
'기타') 
AS "직책 이름" FROM EMP;

--퀴즈2
-- `CASE`로 근속 연수 분류 
-- (HIREDATE 기준, 1982년 이전: 장기근속, 이후: 일반)
-- 별칭 : 근속 연수
SELECT ENAME, HIREDATE,
CASE 
WHEN HIREDATE < TO_DATE('1982-01-01','YYYY-MM-DD') THEN '장기근속'
ELSE '일반'
END
AS "근속 연수" FROM EMP;


--퀴즈3
-- `CASE` 단순형으로 DEPTNO에 따라 위치 표시 
--(10: NEW YORK, 20: DALLAS, 30: CHICAGO)
-- 별칭 : 근무 지역
SELECT ENAME, 
CASE DEPTNO 
WHEN 10 THEN '뉴욕'
WHEN 20 THEN '달러스'
WHEN 30 THEN '시카고'
ELSE '미지정'
END
AS "근무 지역" FROM EMP;







