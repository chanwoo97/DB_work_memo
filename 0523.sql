-- 테이블에 있는 데이터 수정하기

-- 기본 문법 
-- UPDATE 테이블명 SET 수정할컬럼명 = 수정할값 WHERE 조건절;

-- 복사한 테이블에서 연습하기. 
-- EMP -> EMP_COPY 테이블 복사 
create table emp_copy
   as
      select *
        from emp;
select *
  from emp_copy;

--전체 수정 
update emp_copy
   set
   sal = 1000;
-- 반영, 저장
commit;

-- 조건 수정
update emp_copy
   set
   sal = 2000
 where deptno = 10;
-- 되돌리기
rollback;

-- 서브쿼리 활용 
select deptno
  from emp
 where ename = 'ALLEN'; -- 30
update emp_copy
   set
   sal = 2000
 where deptno = (
   select deptno
     from emp
    where ename = 'ALLEN'
);

-- 먼저는 연습용, 
-- DEPT -> DEPT_TEMP2 테이블 복사해보기
-- 퀴즈1, 
-- DEPT_TEMP2 테이블에서 부서번호가 20인 행의 지역을 'JEJU'로 수정하시오.  
create table dept_temp2
   as
      select *
        from dept;

update dept_temp2
   set
   loc = 'JEJU'
 where deptno = 20;
select *
  from dept_temp2
 where deptno = 20;


-- 퀴즈2, 
-- DEPT_TEMP2 테이블의 전체 지역을 'SEOUL'로 변경하시오.  
update dept_temp2
   set
   loc = 'SEOUL';
select *
  from dept_temp2;

  
-- 퀴즈3, 
-- 직책이 'MANAGER'인 사원의 급여를 5000으로 일괄 수정하시오.  
update emp_copy
   set
   sal = 5000
 where job = 'MANAGER';
select *
  from emp_copy;

---------------------------------------------------------------------------

-- 테이블에 있는 데이터 삭제하기

-- 기본 문법 
-- 조건에 맞는 데이터 삭제하기
delete from 테이블명
 where 조건;
delete from emp
 where deptno = 30;

-- 서브쿼리 활용한 삭제 
delete from emp_copy
 where deptno in (
   select deptno
     from dept
    where loc = 'DALLAS'
);

-- 전체 행 삭제하기 
delete from emp_copy;

select *
  from emp_copy;
-- 부서번호가 30인 사원 삭제하기
delete from emp_copy
 where deptno = 30;

-- 서브쿼리로 'DALLAS'에 있는 부서의 사원 삭제하기
select deptno
  from dept
 where loc = 'DALLAS'; -- 20번 부서번호
delete from emp_copy
 where deptno in (
   select deptno
     from dept
    where loc = 'DALLAS'
);  

-- EMP_COPY 테이블에서 모든 데이터 삭제하기
delete from emp_copy;

-- EMP -> EMP_TEMP2 테이블 복사해보기
create table emp_temp2
   as
      select *
        from emp;

-- 퀴즈1, 
-- EMP_TEMP2 테이블에서 급여가 3000 이상인 사원을 삭제하시오. 
delete from emp_temp2
 where sal >= 3000;

-- 퀴즈2, 
-- EMP_TEMP2 테이블에서 부서번호가 10 또는 20인 사원을 삭제하시오.
delete from emp_temp2
 where deptno in ( 10,
                   20 );
  
-- 퀴즈3, 
-- EMP_TEMP2 테이블의 모든 데이터를 삭제하시오. 
delete from emp_temp2;

-- 하나의 단위로 데이터를 처리하는 트랜잭션
-- 기본문법
-- 데이터 변경
select *
  from emp_copy;
-- EMP_COPY 테이블에 원본 EMP 테이블 복사
insert into emp_copy
   select *
     from emp;
commit;

-- EMP_COPY 순서1, 테이블 데이터 변경
update emp_copy
   set
   sal = sal + 5000
 where deptno = 30;

-- 순서2, 트랜잭션 저장
commit;

-- 순서3, 트랜잭션 취소
rollback;

-- 순서4, 특정 지점으로 설정
savepoint sp1;

-- 순서5, 특정 지점으로 롤백
rollback to spt;

-- EMP -> EMP_COPY2테이블 복사를 먼저 진행 후,
-- 퀴즈1, 부서번호가 20인 사원들의 급여를 10% 인상 후, 조건에 따라
-- 되돌릴 수 있도록 SAVEPOINT (SP2)를 설정하시오.
select *
  from emp_copy2;
create table emp_copy2
   as
      select *
        from emp;
update emp_copy2
   set
   sal = sal * 1.1
 where deptno = 20;
commit;
savepoint sp2;

-- 퀴즈2, 사번이 7839인 사원의 급여를 5000으로 변경하고, 이 작업만 ROLLBACK하시오.
update emp_copy2
   set
   sal = 5000
 where mgr = 7839;
rollback to sp2;

-- 퀴즈3, 여러 UPDATE 작업 수행 후 COMMIT하지 않고 전체를 ROLLBACK 하시오.
rollback;

-------------------------------------------------------------------------

-- 객체(테이블)를 생성, 변경, 삭제하는 데이터 정의어 

-- CREATE : 객체를 생성하는 명령어
-- ALTER : 객체를 변경하는 명령어
-- DROP : 객체를 삭제하는 명령어
-- TRUNCATE : 테이블의 데이터를 삭제하는 명령어

-- 테이블 이름 명명, 각각 언어의 예약어를 사용하면 안됨. 주의사항, 
create table member_info (
   member_id    number(5) primary key, -- PK = NOT NULL + UNIQUE(중복 불가)
   member_name  varchar2(20) not null, -- 값이 비어 있으면 안됨.
   member_email varchar2(50) not null
);
select *
  from member;
-- 샘플 데이터 추가 
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 1,
           '홍길동',
           'HONG@naver.com' );
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 2,
           '이순신',
           'DDD@naver.com' );
insert into member_info (
   member_id,
   member_name,
   member_email
) values ( 3,
           '강감찬',
           'AAA@naver.com' );
-- 테이블 구조 변경하기 
alter table member add member_phone varchar2(20);

-- 테이블 이름 변경하기 
alter table member rename to member_info;
select *
  from member_info;

-- 테이블의 내용만 전체 삭제하기 -> 빈 테이블만 남음.
truncate table member_info;

-- 테이블 삭제하기
drop table member_info;

-- 퀴즈1, 
-- 테이블 : BOARD , 
-- 컬럼: BOARD_ID(NUMBER 5), TITLE(VARCHAR2(30)), 
-- CONTENT(VARCHAR2(300)), WRITER(VARCHAR2(30)), REGDATE(DATE)
-- VARCHAR : 가변 길이 문자열 / 제목글자가 20이면 공간이 30이여도 20만큼 사용
-- CHAR : 고정 길이 문자열 / 제목글자가 20이면 공간은 30이여도 30만큼 사용
-- 속도는 CHAR가 빠르지만, 공간 낭비가 발생함.
select *
  from board;

create table board (
   board_id number(5) primary key,
   title    varchar2(30) not null,
   content  varchar2(300) not null,
   writer   varchar2(30) not null,
   regdate  date default sysdate -- 날짜 값을 정해 주지 않으면 현재 날짜로 자동 입력됨.
);

insert into board (
   board_id,
   title,
   content,
   writer,
   regdate
) values ( 1,
           '첫번째',
           '첫번째 컨텐츠',
           '관리자',
           sysdate );

-- 퀴즈2,ALTER ~ MODIFY
-- BOARD 테이블에 특정 컬럼의 타입 변경 변경해보기. (WRITER VARCHAR2 40으로 변경)
alter table board modify
   writer varchar2(40);
  
-- 퀴즈3, 
-- BOARD 테이블에 , 내용만 삭제 해보기
truncate table board;