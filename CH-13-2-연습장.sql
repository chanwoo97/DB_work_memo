-- 더 빠른 검색을 위한 인덱스 

-- 
-- | 항목 | 설명 |
-- |------|------|
-- | 인덱스(Index) | 특정 열 기준으로 검색 속도를 높이는 보조 구조 |
-- | 생성 구문 | `CREATE INDEX 인덱스명 ON 테이블명(열명)` |
-- | 삭제 구문 | `DROP INDEX 인덱스명` |
-- | 자동 생성 | PRIMARY KEY, UNIQUE 제약 시 자동 생성 |
-- | 수동 생성 | 성능 최적화를 위해 직접 지정 가능 |

-- 인덱스 생성 , EMP SAL 급여를 이용해서 이름은 : EMP_SAL_IDX
CREATE INDEX EMP_SAL_IDX ON EMP(SAL);

-- 인덱스 목록 조회 
SELECT * FROM USER_INDEXES;

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
SELECT * FROM USER_IND_COLUMNS WHERE INDEX_NAME = 'EMP_ENAME_SAL_IDX';