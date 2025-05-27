-- 유일하게 하나만 있는 값 PRIMARY KEY 제약조건을 가진 테이블을 생성합니다.

-- 방법1, 테이블 생성시, 기본으로 , 이름 지정 없이 만들기
-- 방법2, 테이블 생성시, 제약 조건 이름을 설정해서 만들기 
-- 방법3, 테이블 생성 후, 제약 조건을 추가해서 만들기
DROP TABLE user_primay2;

-- 방법1, 테이블 생성시, 기본으로, 이름 지정 없이 만들기
CREATE TABLE user_primay2(
    ID NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    USER_ID VARCHAR2(20) CONSTRAINT user_id_unique UNIQUE
);

-- 방법2, 테이블 생성시, 제약 조건 이름을 설정해서 만들기
CREATE TABLE user_primay2(
    ID NUMBER(5) CONSTRAINT user_primay2_pk PRIMARY KEY, -- 방법2
    NAME VARCHAR2(20) NOT NULL,
    USER_ID VARCHAR2(20) CONSTRAINT user_id_unique UNIQUE
);

-- 방법3, 테이블 생성 후, 제약 조건을 추가해서 만들기
CREATE TABLE user_primay2(
    ID NUMBER(5) ,
    NAME VARCHAR2(20) NOT NULL,
    USER_ID VARCHAR2(20) CONSTRAINT user_id_unique UNIQUE
);
-- 방법3
ALTER TABLE user_primay2 ADD CONSTRAINT user_primay2_pk PRIMARY KEY(ID);

-- 제약조건 확인 , 데이터 사전
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'user_primay2';

--PK 생성 시 , 자동으로 인덱스 설정함, 인덱스 확인 , 데이터 사전 
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'user_primay2';

-- PK 제약조건 삭제 
ALTER TABLE user_primay2 DROP CONSTRAINT user_primay2_pk;

-- 샘플 데이터 추가, 중복 방지 확인
INSERT INTO user_primay2(ID, NAME, USER_ID) VALUES(1, '홍길동', 'HONG');
INSERT INTO user_primay2(ID, NAME, USER_ID) VALUES(1, '이순신', 'LEE');

-- 샘플 데이터 추가, NULL 방지 확인
INSERT INTO user_primay2(ID, NAME, USER_ID) VALUES(NULL, '강감찬', 'KANG');


-- 퀴즈1, 
-- 테이블 생성 시 PRIMARY 지정 해보기, 방법 1, 2,3 
-- 테이블명 :  user_primay, 컬럼, user_id에 PRIMARY 설정 
DROP TABLE user_primay;
CREATE TABLE user_primay(
    ID NUMBER(5) ,
    NAME VARCHAR2(20) NOT NULL,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
    USER_ID2 VARCHAR2(20) -- 방법3
);
ALTER TABLE user_primay ADD CONSTRAINT user_id_primary PRIMARY KEY (USER_ID2); -- 방법3
-- 제약조건 확인 , 데이터 사전
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_PRIMAY';
 
-- 퀴즈2, 
-- 테이블 생성 후, 제약 조건 추가 , 
-- 테이블명 :  user_primay2, 컬럼, user_id에 PRIMARY 설정 
  CREATE TABLE user_primay2(
    ID NUMBER(5) ,
    NAME VARCHAR2(20) NOT NULL,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
    USER_ID2 VARCHAR2(20) -- 방법3
);
ALTER TABLE user_primay2 ADD CONSTRAINT user_id_primary_q2 PRIMARY KEY (USER_ID2); -- 방법3
-- 제약조건 확인 , 데이터 사전
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_PRIMAY2';
-- 퀴즈3, 
-- user_primay2 , 데이터 입력 . 
-- 중복 , null 테스트도 해보기. 
-- 샘플 데이터 추가, 중복 방지 확인
INSERT INTO user_primay2(ID, NAME, USER_ID2) VALUES(1, '홍길동', 'HONG');
INSERT INTO user_primay2(ID, NAME, USER_ID2) VALUES(2, '이순신', 'HONG');

-- 샘플 데이터 추가, NULL 방지 확인
INSERT INTO user_primay2(ID, NAME, USER_ID2) VALUES(3, '강감찬', null);


-- 복합키 : 2개 이상의 컬럼을 묶어서, 하나의 키로 사용
-- 복합키, 하나의 테이블에 pk 보통 하나인 경우가 많다.

-- 기본 문법
-- 테이블 생성시, 방법1
-- ```sql
-- CREATE TABLE 주문상세 (
--   주문번호     VARCHAR2(10),
--   상품번호     VARCHAR2(10),
--   수량        NUMBER,
--   CONSTRAINT pk_주문상세 PRIMARY KEY (주문번호, 상품번호)
-- );
-- ```
-- 예시 
-- 주문번호,  상품번호, 수량 
-- 1,          1001(청바지),    2
-- 1,          1002(반팔티),    1
-- 1,          1001(청바지),    2 -- 중복 발생하면 안됨. 

-- * `주문번호 + 상품번호` 조합이 **유일하게** 행을 식별
-- * `수량`은 기본키와 무관한 일반 컬럼

-- 테이블 생성 후, 방법2 
-- ALTER TABLE 주문상세
-- ADD CONSTRAINT pk_주문상세 PRIMARY KEY (주문번호, 상품번호);


--예시 
-- 학생 수강 정보 테이블
-- | 학번   | 과목코드 | 성적 |
-- | ----  |   ----   |  --  |
-- | 1001  |   C001   |   A  |
-- | 1001  |   C002   |   B+ |
-- | 1002  |   C001   |   B  |-- 중복 발생하면 안됨

-- 학번   | 과목코드  -> 복합키 로 사용함. 
-- CREATE TABLE 학생수강정보 (
--   학번      VARCHAR2(10),
--   과목코드  VARCHAR2(10),
--   성적      CHAR(2),
--   CONSTRAINT pk_학생수강 PRIMARY KEY (학번, 과목코드)
-- );

-- 필요한 상황 
-- 1) 주문번호 + 상품번호 : 주문 내 상품 항목 식별 
--2) 학생 + 과목코드 : 학생의 특정 과목 수강 정보 식별
--3) 도서id + 저자 id : 다대다 관계 테이블에서 많이 사용.
