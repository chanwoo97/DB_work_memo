-- 데이터 형태와 범위를 정하는 CHECK 제약 조건

-- 방법1, 테이블 생성시 제약 조건 추가 
CREATE TABLE EMP_CHECK (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    -- NUMBER(7,2) : -- 전체 7자리, 소수점 2자리, 즉 정수 5자리 + 소수 2자리
    SAL NUMBER(7,2) CHECK (SAL >= 0), -- 급여는 0 이상
    COMM NUMBER(7,2) CHECK (COMM >= 0 OR COMM IS NULL), -- 커미션은 0 이상 또는 NULL
    DEPTNO NUMBER(2) CHECK (DEPTNO IN (10, 20, 30, 40)) -- 부서번호는 지정된 값 중 하나
);

-- 방법2, 테이블 생성 후 ALTER TABLE 명령어로 제약 조건 추가
ALTER TABLE EMP_CHECK ADD CONSTRAINT EMP_SAL_CHECK CHECK (SAL >= 0);

-- 제약 조건 조회 
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP_CHECK';

-- 제약 조건 삭제 
ALTER TABLE EMP_CHECK DROP CONSTRAINT EMP_SAL_CHECK;

-- 샘플 데이터 삽입, 제약 조건 위배 확인
INSERT INTO EMP_CHECK (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES (1, '홍길동', 'CLERK', 1000, 10); -- 정상
INSERT INTO EMP_CHECK (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES (2, '홍길동', 'CLERK', 1000, 50); -- 오류
INSERT INTO EMP_CHECK (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES (3, '홍길동', 'CLERK', -100, 40); -- 오류
SELECT * FROM EMP_CHECK;


--------------------------------------------------------------------------------------------------------------------

-- 퀴즈1, 
-- EMP_CHECK , 테이블 생성해서 해보기
-- 테이블 명: EMP_CHECK , SAL 0 이상, 10000 이하 경우만 입력 허용
ALTER TABLE EMP_CHECK ADD CONSTRAINT EMP_SAL_CHECK CHECK ((SAL >= 0 AND SAL <= 10000));

-- 퀴즈2, 
-- 테이블 명: EMP_CHECK , 직무(JOB) : 'MANAGER', 'CLERK', 'ANALYST', 
-- 현재 직무 외에는 입력 불가 
ALTER TABLE EMP_CHECK ADD CONSTRAINT EMP_JOB_CHECK CHECK ((JOB IN ('MANAGER', 'CLERK', 'ANALYST')));

-- 퀴즈3, 
-- 테이블 명: EMP_CHECK, COMM , NOT NULL 또는 0이상인 조건만 허용.
ALTER TABLE EMP_CHECK ADD CONSTRAINT EMP_COMM_CHECK CHECK ((COMM IS NOT NULL OR COMM >= 0));

--------------------------------------------------------------------------------------------------------------------

-- EMP_CHECK , 테이블 생성해서 해보기
-- 퀴즈1, 
-- 테이블 명: EMP_CHECK , SAL 0 이상, 10000 이하 경우만 입력 허용
-- 퀴즈2, 
-- 테이블 명: EMP_CHECK , 직무(JOB) : 'MANAGER', 'CLERK', 'ANALYST', 
-- 현재 직무 외에는 입력 불가 
  
-- 퀴즈3, 
-- 테이블 명: EMP_CHECK, COMM , NOT NULL 또는 0이상인 조건만 허용.

 CREATE TABLE EMP_CHECK3 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    MGR NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    -- NUMBER(7,2) : -- 전체 7자리, 소수점 2자리, 즉 정수 5자리 + 소수 2자리
    SAL NUMBER(7,2) CHECK (SAL >= 0 AND SAL <= 10000), -- 급여는 0 이상
    JOB VARCHAR2(9) CHECK (JOB IN ('MANAGER', 'CLERK', 'ANALYST')), -- 직무는 지정된 값 중 하나
    COMM NUMBER(7,2) CHECK (COMM >= 0 AND COMM IS NOT NULL), -- 커미션은 0 이상 또는 NULL
    DEPTNO NUMBER(2) CHECK (DEPTNO IN (10, 20, 30, 40)) -- 부서번호는 지정된 값 중 하나
);
-- 제약 조건 조회
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP_CHECK2';

INSERT INTO EMP_CHECK2 (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES (1, '홍길동', 'CLERK2', 1000, 10); 
INSERT INTO EMP_CHECK2 (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES (1, '홍길동', 'CLERK', 100000, 10); 
INSERT INTO EMP_CHECK3 (EMPNO, ENAME, JOB, SAL, COMM) VALUES (2, '홍길동', 'CLERK', 1000, NULL); 
SELECT * FROM EMP_CHECK3;