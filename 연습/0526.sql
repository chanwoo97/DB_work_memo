--데이터 베이스를 위한 데이터를 저장하는 데이터 사전

-- | 접두어 | 설명 | 사용 권한 |
-- |--------|------|------------|
-- | `USER_` | 현재 사용자가 소유한 객체 정보 | 모든 사용자 사용 가능 |
-- | `ALL_` | 현재 사용자가 접근 가능한 객체 정보 | 모든 사용자 사용 가능 |
-- | `DBA_` | 모든 사용자의 모든 객체 정보 | DBA, SYSTEM 사용자 전용 |

-- 데이터 사전 목록 조회
SELECT * FROM DICT;

-- SCOTT 계정 객체 조회
SELECT * FROM USER_OBJECTS;

-- SCOTT 계정 접근 가능한 모든 테이블 조회
SELECT * FROM ALL_TABLES WHERE OWNER = 'SCOTT';

-- SYSTEM 계정에서 모든 사용자 조회
SELECT * FROM DBA_USERS;

-- USER 접두어
SELECT * FROM USER_TABLES;

-- ALL 접두어 사용 VIEW 조회
SELECT * FROM ALL_VIEWS WHERE OWNER = 'SCOTT';

-- SYSYEM 계정에서 DBA_ 접두어 사용
SELECT USERNAME, CREATED FROM DBA_USERS;

-- SCOTT 계정에서 현재 자신이 소유한 객체 리스트 조회
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS;

-- SCOTT 계정에서 모든 테이블의 컬럼 구조를 조회
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_TAB_COLUMNS;

--------------------------------------------------------------------------

-- 더 빠른 검색을 위한 인덱스

-- | 항목 | 설명 |
-- |------|------|
-- | 인덱스(Index) | 특정 열 기준으로 검색 속도를 높이는 보조 구조 |
-- | 생성 구문 | `CREATE INDEX 인덱스명 ON 테이블명(열명)` |
-- | 삭제 구문 | `DROP INDEX 인덱스명` |
-- | 자동 생성 | PRIMARY KEY, UNIQUE 제약 시 자동 생성 |
-- | 수동 생성 | 성능 최적화를 위해 직접 지정 가능 |

-- 인덱스 생성, EMP SAL 급여를 이용해서 이름은 : EMP_SAL_IDX
CREATE INDEX EMP_SAL_IDX ON EMP(SAL);

-- 인덱스 목록 조회
SELECT *FROM USER_INDEXES;

-- 인덱스 컬럼 조회
SELECT * FROM USER_IND_COLUMNS WHERE INDEX_NAME = 'EMP_SAL_IDX';

-- 인덱스 삭제
DROP INDEX EMP_SAL_IDX;

--퀴즈1 ,
-- SCOTT 계정에서 EMP 테이블의 JOB 열에 인덱스를 생성해보기
CREATE INDEX EMP_JOB_IDX ON EMP(JOB);

-- 퀴즈2, 이름은: EMP_ENAME_SAL_IDX , 형식 순서: (ENAME, SAL);
-- 복합 인덱스를 ENAME, SAL 열로 생성해보기
CREATE INDEX EMP_ENAME_SAL_IDX ON EMP(ENAME, SAL);

-- 퀴즈3, 
--  USER_IND_COLUMNS 뷰를 사용해 JOB 인덱스가 생성 되었는지 확인 해보기.
SELECT * FROM USER_IND_COLUMNS WHERE INDEX_NAME = 'EMP_JOB_IDX';


-- 인덱스를 이용한 성능 테스트
-- 더미 테이블 생성, EMP_INDEX_TEST 테이블 생성
DESC EMP;
-- 기존 EMP 테이블은 4자리 사원 번호까지만 이용가능해서, 6자리로 교체.
-- DROP TABLE EMP_INDEX_TEST;
CREATE TABLE EMP_INDEX_TEST (
    EMPNO NUMBER(15) PRIMARY KEY,
    ENAME VARCHAR2(50),
    JOB VARCHAR2(20),
    MGR NUMBER(6),
    HIREDATE DATE,
    SAL NUMBER(8, 2),
    COMM NUMBER(8, 2),
    DEPTNO NUMBER(2)
);
SELECT * FROM EMP_INDEX_TEST;

-- 더미 데이터 삽입 , 100000건 삽입 -> 약 1억건으로 변경해서, 추가중 , 적당히 조절해서 확인
BEGIN
  FOR i IN 1..10000000 LOOP
    INSERT INTO EMP_INDEX_TEST(empno, ename, job, sal, deptno)
    VALUES (
      10000 + i,
      'USER' || i,
      CASE MOD(i, 5)
        WHEN 0 THEN 'CLERK'
        WHEN 1 THEN 'MANAGER'
        WHEN 2 THEN 'SALESMAN'
        WHEN 3 THEN 'ANALYST'
        ELSE 'PRESIDENT'
      END,
      1000 + MOD(i, 5000),
      MOD(i, 4) * 10 + 10  -- 10, 20, 30, 40 중 하나
    );
  END LOOP;
  COMMIT;
END;

SELECT * FROM EMP_INDEX_TEST;

-- 기본 EMP_INDEX_TEST , 자동 생성된 인덱스, EMPNO 로 생성 조회, 
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP_INDEX_TEST';

--------------------------------------------------------------------
-- 인덱스 없이 실행 
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000';

-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000';
-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
--------------------------------------------------------------------
--------------------------------------------------------------------
-- 인덱스 생성
CREATE INDEX EMP_INDEX_TEST_ENAME_IDX ON EMP_INDEX_TEST(ENAME);
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000';

-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000';
-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- |*  2 |   INDEX RANGE SCAN          | EMP_INDEX_TEST_ENAME_IDX |   401 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------

-- 복합키 예시 
-- 순서, JOB, DEPTNO 컬럼의 순서로 인덱스 생성, 
-- 전 , 후 성능 비교 
---------------------------------------------------------------------------------
-- 인덱스 생성 전 
SELECT * FROM EMP_INDEX_TEST WHERE JOB = 'CLERK' AND DEPTNO = 10;
-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR
SELECT * FROM EMP_INDEX_TEST WHERE JOB = 'CLERK' AND DEPTNO = 10;
-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 결과 
--| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  1 |  TABLE ACCESS FULL| EMP_INDEX_TEST |  4993 |   550K|   147   (3)| 00:00:02 |
---------------------------------------------------------------------------------
-- 인덱스 생성
CREATE INDEX EMP_INDEX_TEST_JOB_DEPTNO_IDX ON EMP_INDEX_TEST(JOB, DEPTNO);

-- 인덱스 조회 
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP_INDEX_TEST';

SELECT * FROM EMP_INDEX_TEST WHERE JOB = 'CLERK' AND DEPTNO = 10;

-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR
SELECT * FROM EMP_INDEX_TEST WHERE JOB = 'CLERK' AND DEPTNO = 10;

-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 결과 
--| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  1 |  TABLE ACCESS FULL| EMP_INDEX_TEST |  4993 |   550K|   147   (3)| 00:00:02 |
-- 인덱스 검색이 아닌 전체 검색이 나온 이유는 

SELECT * FROM EMP_INDEX_TEST WHERE job = 'CLERK';
SELECT COUNT(*) FROM emp_index_test WHERE job = 'CLERK';
---------------------------------------------------------------------------------
-- 복합키 인덱스 예시2 
-- 기존 단일키 인덱스 삭제
DROP INDEX EMP_INDEX_TEST_ENAME_IDX;

-- 기존 복합키 인덱스 삭제 
DROP INDEX EMP_INDEX_TEST_JOB_DEPTNO_IDX;

-- 인덱스 조회 
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP_INDEX_TEST';

-- ENAME, JOB 컬럼의 순서로 인덱스 생성,
-- 인덱스 생성 전
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';

-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';

-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 결과
--| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  1 |  TABLE ACCESS FULL| EMP_INDEX_TEST |    10 |  1130 |   146   (2)| 00:00:02 |

-------------------------------------------------------------------------------------------------

-- 인덱스 생성 후
CREATE INDEX EMP_INDEX_TEST_ENAME_JOB_IDX ON EMP_INDEX_TEST(ENAME, JOB);
-- 인덱스 조회
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'EMP_INDEX_TEST';

SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';

-- 성능 비교 (실행계획 확인)
EXPLAIN PLAN FOR SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';

-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 결과
--| Id  | Operation         | Name                          | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  2 |   INDEX RANGE SCAN| EMP_INDEX_TEST_ENAME_JOB_IDX |     1 |       |     1   (0)| 00:00:01 |


-- 퀴즈1, 
--  SAL이 높은 상위 5명을 추출하는 뷰 emp_top5를 생성하시오.
CREATE VIEW EMP_TOP5 AS 
SELECT  * FROM (
    SELECT EMPNO, ENAME, SAL FROM EMP 
    WHERE SAL IS NOT NULL
    ORDER BY SAL DESC
) WHERE ROWNUM <= 5;
-- DROP VIEW EMP_TOP5;
-- 가상 뷰 작업 하기 전에, 실제 쿼리 동작 여부 확인, (단위테스트)
-- SELECT ROWNUM,EMPNO, ENAME, SAL   FROM (
--     SELECT EMPNO, ENAME, SAL FROM EMP 
--     WHERE SAL IS NOT NULL
--     ORDER BY SAL DESC
-- ) WHERE ROWNUM <= 5;

-- 제 데이터에는 널이 포함이 되어 있어서, 일단 서브 쿼리 결과 먼저 체크 후, 
--  SELECT EMPNO, ENAME, SAL FROM EMP 
--  WHERE SAL IS NOT NULL
--     ORDER BY SAL DESC;

-- 뷰에서 데이터 조회
SELECT * FROM EMP_TOP5;


-- 퀴즈2, 
-- 인라인 뷰를 사용해 부서별 평균 급여를 구한 뒤, 평균이 2000 이상인 부서만 추출하시오.
  SELECT * FROM (
    SELECT DEPTNO, AVG(SAL) AS AVG_SAL FROM EMP 
    GROUP BY DEPTNO
  ) WHERE AVG_SAL >= 2000;

  SELECT * FROM DEPT;

-- 퀴즈3, 
--  WITH절을 이용해 JOB별 최고 급여를 구한 후, 최고급여가 2500 이상인 직무만 출력하시오.
WITH JOB_SAL_MAX AS (
    SELECT JOB, MAX(SAL) AS MAX_SAL FROM EMP
    GROUP BY JOB
) SELECT * FROM JOB_SAL_MAX WHERE MAX_SAL >= 2500;

-------------------------------------------------------------------------------------------------


