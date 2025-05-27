-- 규칙에 따라 순번을 생성하는 시퀀스 (sequence) 생성

-- 기본 개념

-- | 항목 | 설명 |
-- |------|------|
-- | 시퀀스 | 자동으로 순차적인 숫자를 생성하는 오라클 객체 |
-- | NEXTVAL | 다음 번호 생성 |
-- | CURRVAL | 최근 생성된 번호 |
-- | START WITH | 시작 숫자 설정 |
-- | INCREMENT BY | 증가 값 설정 |
-- | CYCLE | MAX 도달 시 초기화 여부 설정 |


-- 시퀀스 생성
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

-- 테스트 할 빈 테이블 복사
CREATE TABLE EMP_SEQUENCE_TEST AS SELECT * FROM EMP WHERE 1=0;
-- 테이블의 내용만 삭제
TRUNCATE TABLE EMP_SEQUENCE_TEST;

-- 빈 테이블 조회
SELECT * FROM EMP_SEQUENCE_TEST;

-- 시퀀스 조회
SELECT EMP_SEQ_NEXTVAL FROM DUAL;
DESC EMP_SEQUENCE_TEST;
-- 시퀀스 이용해서, 데이터 추가 해보기.
INSERT INTO EMP_SEQUENCE_TEST VALUES (
    EMP_SEQ.NEXTVAL, -- EMPNO 기존에는 숫자 형태로 직접 지정 했고, 자동 생성.
    '홍길동',   -- ENAME / 문자열 타입
    '강사',     -- JOB / 문자열 타입
    '7839',     -- MGR / 숫자 타입
    SYSDATE,    -- HIREDATE / DATE 타입
    1000,       -- SAL / 숫자 타입
    500,        -- COMM / 숫자 타입
    10          -- DEPTNO; / 숫자 타입
);
SELECT * FROM EMP_SEQUENCE_TEST;

-- 기본 시퀀스 삭제 후 다시 생성
DROP SEQUENCE EMP_SEQ;