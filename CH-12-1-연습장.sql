-- 객체(테이블)를 생성, 변경, 삭제하는 데이터 정의어 
-- DDL(Data Definition Language)
-- 따로 트랜잭션을 사용하지 않음. -> 알아서 commit됨.
-- CREATE : 객체를 생성하는 명령어
-- ALTER : 객체를 변경하는 명령어
-- DROP : 객체를 삭제하는 명령어
-- TRUNCATE : 테이블의 데이터를 삭제하는 명령어

-- 테이블 이름 명명, 각각 언어의 예약어를 사용하면 안됨. 주의사항, 
CREATE TABLE MEMBER (
    MEMBER_ID NUMBER(5) PRIMARY KEY, -- PK = NOT NULL + UNIQUE(중복 불가)
    MEMBER_NAME VARCHAR2(20) NOT NULL, -- 값이 비어 있으면 안됨.
    MEMBER_EMAIL VARCHAR2(50) NOT NULL
);
SELECT * FROM MEMBER;
-- 샘플 데이터 추가 
INSERT INTO MEMBER_INFO (MEMBER_ID, MEMBER_NAME, MEMBER_EMAIL) VALUES (1, '홍길동', 'HONG@naver.com');
INSERT INTO MEMBER_INFO (MEMBER_ID, MEMBER_NAME, MEMBER_EMAIL) VALUES (2, '이순신', 'ㅇㅇ@naver.com');
INSERT INTO MEMBER_INFO (MEMBER_ID, MEMBER_NAME, MEMBER_EMAIL) VALUES (3, '강감찬', 'ㅇㅇ@naver.com');

-- 테이블 구조 변경하기 
ALTER TABLE MEMBER ADD MEMBER_PHONE VARCHAR2(20);

-- 테이블 이름 변경하기 
ALTER TABLE MEMBER RENAME TO MEMBER_INFO;
SELECT * FROM MEMBER_INFO;

-- 테이블의 내용만 전체 삭제하기 -> 빈 테이블만 남음.
TRUNCATE TABLE MEMBER_INFO;

-- 테이블 삭제하기
DROP TABLE MEMBER_INFO;

-- 퀴즈1, 
-- 테이블 : BOARD , 
-- 컬럼: BOARD_ID(NUMBER 5), TITLE(VARCHAR2(30)), 
-- CONTENT(VARCHAR2(300)), WRITER(VARCHAR2(30)), REGDATE(DATE)
CREATE TABLE BOARD (
    BOARD_ID NUMBER(5) PRIMARY KEY,
    TITLE VARCHAR2(30) NOT NULL, -- 예시)제목 글자 25글자, 제목에 담을수 있는 저장 공간 30까지 
    -- 저장은 25로 됨. , 제목 글자 10글자, 저장공간 30, 
    -- CHAR(30)과 VARCHAR2(30)의 차이점은 CHAR는 고정 길이, VARCHAR2는 가변 길이
    -- 고정 길이 인경우 예시 -> 제목 글자 10글자 , 저장은 30으로 됨.
    CONTENT VARCHAR2(300),
    WRITER VARCHAR2(30),
    REGDATE DATE DEFAULT SYSDATE -- 날짜 값을 정해 주지 않으면 현재 날짜로 자동 설정
);
 
-- 퀴즈2,ALTER ~ MODIFY
-- BOARD 테이블에 특정 컬럼의 타입 변경 변경해보기. (WRITER VARCHAR2 40으로 변경)
ALTER TABLE BOARD MODIFY WRITER VARCHAR2(40);
-- 퀴즈3, 
-- BOARD 테이블에 , 내용만 삭제 해보기
TRUNCATE TABLE BOARD;