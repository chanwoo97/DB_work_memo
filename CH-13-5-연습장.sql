-- 공식 별칭을 지정하는 동의어 SYNONYM을 생성합니다. 즐겨찾기, 또는 사이트 도메인 이름, 연락처 이름.

-- 기본 개념  

-- | 항목 | 설명 |
-- |------|------|
-- | SYNONYM | 테이블, 뷰 등의 별칭을 생성 |
-- | PUBLIC SYNONYM | 모든 사용자가 공통으로 사용 가능 |
-- | PRIVATE SYNONYM | 생성한 사용자만 사용 가능 |
-- | 객체 이름 감추기 | 실제 테이블명을 알리지 않고도 접근 가능 |
-- | 권한 | 대상 객체에 SELECT 권한 필요 |

-- 동의어 생성
CREATE SYNONYM EMP_SYNONYM FOR EMP; -- 이름 의미있게 이용.
CREATE SYNONYM E FOR EMP; -- 비추

-- 동의어를 이용한 조회
SELECT * FROM EMP_SYNONYM; -- EMP 테이블 조회

-- 권한 부여
GRANT SELECT ON EMP TO PUBLIC; -- 모든 사용자에게 SELECT 권한 부여
GRANT SELECT ON EMP TO SCOTT; -- 특정 사용자에게 권한 부여

-- 동의어 삭제
DROP SYNONYM EMP_SYNONYM; -- 동의어 삭제

-- 스키마명 포함 접근
SELECT * FROM SCOTT.EMP;
SELECT * FROM EMP; -- 본인안에 있는 테이블 조회할때는 앞에 스키마명 생략 가능

-- PRIVATE 동의어 생성
CREATE SYNONYM MY_EMP FOR SCOTT.EMP;

-- 사용자 추가
CREATE USER JCW IDENTIFIED BY 1234; -- 새 사용자 생성
-- 기본 접속 권한만 추가
GRANT CREATE SESSION TO JCW; -- 세션 생성 권한 부여

-- 사용자 조회
SELECT * FROM ALL_USERS WHERE USERNAME = 'JCW'; -- JCW 사용자 조회

-- 세션 기준 SCOTT 계정 -> JCW 계정으로 변경
-- MY_EMP 동의어를 이용한 조회
SELECT * FROM MY_EMP; -- JCW 계정에서 SCOTT.EMP 테이블 조회

SELECT * FROM DEPT;



--------------------------------------------------------------------------
--SCOTT 계정에서 동의어 생성하기. 
-- 예를 들어서, 사용하는 테이블이 EMP, DEPT, SALGRADE 테이블이 있다면,
-- 사용하는 테이블이 EMP_MINI, DEPT_MINI, SALGRADE_MINI , 고려해보기. 

-- 현재 , 기존 테이블명과 동일하게 작업하기 -> 이미 존재 해서, 다른 이름으로 작업하기. 
CREATE SYNONYM EMP_MINI FOR SCOTT.EMP; -- EMP 테이블 동의어 생성
CREATE SYNONYM DEPT_MINI FOR SCOTT.DEPT; -- DEPT 테이블 동의어 생성
CREATE SYNONYM SALGRADE_MINI FOR SCOTT.SALGRADE; -- SALGRADE 테이블 동의어 생성

-- 동의어 조회 EMP2 
SELECT * FROM USER_SYNONYMS WHERE SYNONYM_NAME = 'EMP2';
DROP SYNONYM EMP2; -- 동의어 삭제

-- 사용하는 테이블이 EMP_MINI, DEPT_MINI, SALGRADE_MINI , 고려해보기. 
SELECT * FROM EMP_MINI; -- EMP_MINI 동의어를 이용한 조회
SELECT * FROM DEPT_MINI; -- DEPT_MINI 동의어를 이용한 조회
SELECT * FROM SALGRADE_MINI; -- SALGRADE_MINI 동의어를 이용한 조회

-- 퀴즈1, EMP, DEPT 조인 고려하기
-- 동의어를 활용해서 부서명이 ‘ACCOUNTING’인 사원 이름과 직무를 출력하라.
SELECT E.ENAME, E.JOB
FROM EMP_MINI E
JOIN DEPT_MINI D ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'ACCOUNTING';
 
-- 퀴즈2, EMP, SALGRADE 조인 고려하기 
-- 급여 등급(GRADE) 3에 해당하는 사원 목록 출력
SELECT E.ENAME, E.SAL, S.GRADE 
FROM EMP_MINI E
JOIN SALGRADE_MINI S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE = 3;
  
-- 퀴즈3, 자체 조인 및, SALGRADE 테이블 까지 조인을 고려하기
-- 관리자(직속상관=MGR) 이름과 급여 등급을 동의어 기반으로 출력
SELECT E.ENAME AS 사원명, 
       M.ENAME AS 관리자명, 
       S.GRADE AS 급여등급
FROM EMP_MINI E  
JOIN EMP_MINI M ON E.MGR = M.EMPNO   -- 자가 조인
JOIN SALGRADE_MINI S ON E.SAL BETWEEN S.LOSAL AND S.HISAL -- 비등가 조인,
WHERE E.MGR IS NOT NULL; -- 관리자(MGR)가 있는 사원만 조회  

SELECT * FROM EMP_MINI;
SELECT * FROM SALGRADE_MINI;

--------------------------------------------------------------------------