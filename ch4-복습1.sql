desc emp;
desc dept;
desc salgrade;

-- *, 모든 컬럼 조회 
select * from emp;
select * from dept;
select ename, mgr , job from emp;

-- distinct 중복제거 , 단일 컬럼
select distinct deptno from emp;
-- distinct 중복제거 , 여러 컬럼, 
-- 1세트: job, deptno
select distinct job, deptno from emp;

-- distinct 의 반대 <-> all 중복해서 출력, 기본값 
select all job, deptno from emp;
select job, deptno from emp;

-- ALIAS , 별칭을 지정해서, 컬럼을 원하는 이름으로 지정
select ename as "사원 이름", sal*12+comm as 연봉 
,comm from emp;

-- 상여금이 있는 사람은 연봉 출력이 가능하지만, 
-- 상여금이 없는 사람은 계산이 안됨. 
-- nvl 함수 이용해서, 작업. 
-- NVL(COMM,0)
select ename as "사원 이름", 
sal as "기본급",
nvl(comm,0) as "상여금 여부", 
sal*12 + nvl(comm,0) as "총 연봉" from emp;
