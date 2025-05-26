-- 데이터베이스를 위한 데이터를 저장한 데이터 사전 

-- | 접두어 | 설명 | 사용 권한 |
-- |--------|------|------------|
-- | `USER_` | 현재 사용자가 소유한 객체 정보 | 모든 사용자 사용 가능 |
-- | `ALL_` | 현재 사용자가 접근 가능한 객체 정보 | 모든 사용자 사용 가능 |
-- | `DBA_` | 모든 사용자의 모든 객체 정보 | DBA, SYSTEM 사용자 전용 |

--데이터 사전 목록 조회 
SELECT * FROM DICT;

-- SCOTT 계정 객체 조회 
SELECT * FROM USER_OBJECTS;

-- SCOTT 계정 접근 가능한 모든 테이블 조회 
SELECT * FROM ALL_TABLES WHERE OWNER = 'SCOTT';

-- SYSTEM 계정에서 모든 사용자 조회 
SELECT * FROM DBA_USERS;

-- USER 접두어 
SELECT * FROM USER_TABLES;

-- ALL_ 접두어 사용 VIEW 조회
SELECT * FROM ALL_VIEWS WHERE OWNER = 'SCOTT';

-- SYSTEM 계정에서 DBA_ 접두어 사용 
SELECT USERNAME, CREATED FROM DBA_USERS;

-- SCOTT 계정에서 현재 자신이 소유한 객체 리스트 조회 
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS;

-- SCOTT 계정에서 모든 테이블의 컬럼 구조를 조회
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_TAB_COLUMNS;