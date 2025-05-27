-- 기본값을 정하는 DEFAULT 

-- 방법1, 테이블 생성시 기본값 추가
CREATE TABLE emp_default (
  empno NUMBER,
  ename VARCHAR2(20),
  hiredate DATE DEFAULT SYSDATE
);

-- 방법2, ALTER TABLE로 기본값 추가
ALTER TABLE emp_default ADD (sal NUMBER DEFAULT 1000);

-- 제약조건 확인 
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'EMP_DEFAULT';

-- 제약조건 삭제 
ALTER TABLE emp_default MODIFY (sal DEFAULT NULL); -- 기본값 삭제

-- 샘플 데이터 추가
INSERT INTO emp_default (empno, ename) VALUES (1, '홍길동'); -- hiredate는 기본값 SYSDATE
SELECT * FROM emp_default;

------------------------------------------------------------------------------------------------

-- 테이블 생성, 제약조건 설정, 샘플 데이터 입력, 제약 조건 확인. 
-- 퀴즈1, 
-- 테이블명 : EMP_MEMBER, 컬럼명 : ID(NUMBER), NAME(VARCHAR2), REGDATE(DATE)
-- REGDATE , 제약 조건 DEFAULT 이용하고, 현재 날짜로 입력하기. 
CREATE TABLE EMP_MEMBER (
    ID NUMBER,
    NAME VARCHAR2(50),
    REGDATE DATE DEFAULT SYSDATE
);

-- 샘플 데이터 추가
INSERT INTO EMP_MEMBER (ID, NAME) VALUES (1, '홍길동');

-- 샘플 데이터 확인
SELECT * FROM EMP_MEMBER; 

-- 제약조건 확인 
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'EMP_DEFAULT';


-- 퀴즈2, 
-- 테이블명 : PRODUCT, 컬럼명 : PCODE (VARCHAR2), PNAME (VARCHAR2),USE_YN (CHAR(1))
-- USE_YN (CHAR(1)), DEFAULT 이용하고, Y
CREATE TABLE PRODUCT (
    PCODE VARCHAR2(20),
    PNAME VARCHAR2(50),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 샘플 데이터 추가



-- 퀴즈3, 
-- 테이블명 : INVENTORY , 컬럼명 : ITEM_ID (NUMBER), QUANTITY (NUMBER)
-- QUANTITY , DEFAULT, 기본 수량 10으로 설정 해보기. 


------------------------------------------------------------------------------------------------

-- 테이블 생성, 제약조건 설정, 샘플 데이터 입력, 제약 조건 확인. 
-- 퀴즈1, 
-- 테이블명 : EMP_MEMBER, 컬럼명 : ID(NUMBER), NAME(VARCHAR2), REGDATE(DATE)
-- REGDATE , 제약 조건 DEFAULT 이용하고, 현재 날짜로 입력하기. 
 CREATE TABLE emp_member (
  id NUMBER PRIMARY KEY,
  name VARCHAR2(50) NOT NULL,
  regdate DATE DEFAULT SYSDATE);
  -- 샘플데이터 추가
  INSERT INTO emp_member (id, name) VALUES (1, '홍길동'); -- regdate는 기본값 SYSDATE
SELECT * FROM emp_member;
-- 퀴즈2, 
-- 테이블명 : PRODUCT, 컬럼명 : PCODE (VARCHAR2), PNAME (VARCHAR2),USE_YN (CHAR(1))
-- USE_YN (CHAR(1)), DEFAULT 이용하고, Y 
CREATE TABLE product (
  pcode VARCHAR2(10) PRIMARY KEY,
  pname VARCHAR2(50) NOT NULL,
  use_yn CHAR(1) DEFAULT 'Y' CHECK (use_yn IN ('Y', 'N')) -- Y 또는 N만 허용
);
INSERT INTO product (pcode, pname) VALUES ('P001', '노트북'); -- use_yn은 기본값 Y
SELECT * FROM product;
  
-- 퀴즈3, 
-- 테이블명 : INVENTORY , 컬럼명 : ITEM_ID (NUMBER), QUANTITY (NUMBER)
-- QUANTITY , DEFAULT, 기본 수량 10으로 설정 해보기. 
CREATE TABLE inventory (
  item_id NUMBER PRIMARY KEY,
  quantity NUMBER DEFAULT 10 CHECK (quantity >= 0) -- 수량은 0 이상
);
INSERT INTO inventory (item_id) VALUES (1); -- quantity는 기본값 10
SELECT * FROM inventory;
