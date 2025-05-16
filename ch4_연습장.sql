select * from dept;
select * from emp;
select * from salgrade;

desc emp;
desc dept;
desc salgrade;

select * from emp;
-- 오라클 sql developer에서 주석(-)2번입니다.
-- 행 기준으로 검색, where 조건 이용
select * from emp where job = 'manager';
select * from emp where job = 'MANAGER';

-- 열 기준으로 프로젝션, 보고 싶은 열만 선택해서 조회해보기
select ename, job from emp where job = 'MANAGER';
select ename, job from emp;