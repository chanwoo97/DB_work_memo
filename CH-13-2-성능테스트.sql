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
EXPLAIN PLAN FOR 
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';
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
EXPLAIN PLAN FOR 
SELECT * FROM EMP_INDEX_TEST WHERE ENAME = 'USER50000' AND JOB = 'CLERK';
-- 실행계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 결과
--| Id  | Operation         | Name                          | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  2 |   INDEX RANGE SCAN| EMP_INDEX_TEST_ENAME_JOB_IDX |     1 |       |     1   (0)| 00:00:01 |



