select * from dept;
select * from emp;
select * from salgrade;

desc emp;
desc dept;
desc salgrade;

select * from emp;
-- 오라클 sql developer 에서 주석(-)2번입니다.
-- 행 기준으로 검색, where 조건 이용
select * from emp where job = 'manager';
select * from emp where job = 'MANAGER';

-- 열기준으로 프로젝션, 보고 싶은 열만 선택해서 조회해보기
select ename, job from emp where job = 'MANAGER';
select ename, job from emp;

-- 기본 퀴즈1
-- 셀력션 - 'SALES' 부서 소속 직원만 조회 
select * from emp where deptno = 30;
-- 기본 퀴즈2
-- 프로젝션 - 사원명과 입사일만 조회 
select ename, hiredate from emp;
-- 기본 퀴즈3
-- 급여가 3000 이상인 직원만 조회
select * from emp where sal >= 3000;
-- 기본 퀴즈4
-- EMP 테이블에서 이름(ename), 급여(sal), 
-- 부서번호(deptno)만 조회 해보기
select ename, sal, deptno from emp;

-- ----------------------------------------------------
-- distinct 중복 제거 
select distinct job from emp;

-- all(생략가능, 기본값) , 중복 포함, 
select all job from emp;
select job from emp;

-- 직무 + 부서 번호 조합의 고유 데이터 추출 
-- JOB 직무, 부서 번호 조합의 중복 되지 않는 행만 조회.
-- 결론, 동일한 직무와 동일한 부서 번호를 가진 직원이 
-- 여러명 있어도 한번만 결과에 나타남
select DISTINCT JOB, DEPTNO FROM EMP;
select JOB, DEPTNO FROM EMP;

-- 주의사항
-- 1 DISTINCT 는 SELECT 문 뒤에 위치를 하고
-- 2 하나의 컬럼에 적용 되는게 아니라, 예시
-- 2개의 컬럼이 하나처럼 취급이 되어서 동작. 

--퀴즈1 
-- EMP 테이블에서 중복되지 않는 부서번호만 출력하기
SELECT DISTINCT DEPTNO FROM EMP;
-- 퀴즈 2
--EMP 테이블에서 사원 직무와 부서번호 
-- 조합이 고유한 결과 한번더 해보기
SELECT DISTINCT JOB, DEPTNO FROM EMP;
--퀴즈3 
--EMP 테이블에서 중복을 제거하지 않고 
-- 사원 직무와 부서 번호를 모두 출력하기 
-- ALL 키워드 이용해보기
SELECT ALL JOB, DEPTNO FROM EMP;
-- -------------------------------------------------

-- ALIAS 별칭 사용해보기
SELECT ENAME AS "사원명" FROM EMP;
SELECT ENAME AS "직원 이름" FROM EMP;
SELECT ENAME "직원 이름2" FROM EMP;
SELECT ENAME AS "사원명" , SAL * 12 AS "연봉" FROM EMP;

-- 퀴즈1
-- EMP 테이블에서 사원 이름에 '각자 정하고 싶은 이름'
-- 별칭을 부여해서 출력해보기 
select ename as "직원 이름" from emp;
-- 퀴즈2 
-- EMP 테이블에서 급여(SAL)를 연봉으로 계산해서 출력해
-- 보기, 한번더
select sal * 12 as "기본 연봉" from emp;
-- 퀴즈3 
-- 사원명과 직무를 각각 '사원이름', '직무'로 출력해보기 
select ename as "사원 이름", 
job as "직무" from emp;
-- 퀴즈4 
-- 사원명과 급여, 그리고 커미션(COMM)이 있을 경우 
-- 총 수입을 계산하기, 
-- 출력 별칭은 "총 급여"로 지정해서 출력. 
-- 특정 옵션 함수 
-- NVL(COMM,0):COMM 있으면, COMM 값으로 출력,
-- NVL(COMM,0):COMM 없으면, 0 값으로 출력,
-- NVL 의미 : N(NULL) 값이 없음, 
-- V (value) : 값, 
-- L (Logic) : 논리 
-- null 값을 처리하기 위한 로직
select ename as "사원명", sal as "기본급",
sal * 12 + NVL(COMM,0) AS "총 급여" FROM EMP;

-- order by 컬럼명 desc(asc 기본)
select ename as "사원명", sal as "기본급",
sal * 12 + NVL(COMM,0) AS "총 급여" FROM EMP
order by sal desc;

select ename as "사원명", sal as "기본급",
sal * 12 + NVL(COMM,0) AS "총 급여" FROM EMP
order by sal asc;


-- 복합 컬럼 이용 
-- 정렬 기준, 첫 번째 기준으로 정렬하고, 
-- 동일한 값이 있을 때, 두번째 기준 적용.

-- 부서 내에서 급여를 높은 순서 정렬
SELECT * FROM EMP 
ORDER BY DEPTNO ASC, SAL DESC;

-- 열 인덱스로 정렬하기 
-- ename(1),job(2), sal(3)
select ename,job, sal from emp 
order by 3 desc;

-- 시간은 , 최신일 값으로 하면 큰값 
-- 과거 일수록 값으로 하면 작은 값. 
-- emp 테이블에서 모든 사원의 입사입 기준으로 
-- 최신순으로 정렬 해보기. 
select * from emp 
order by hiredate desc;


-- 퀴즈1
-- 커미션이 높은 순으로, 급여가 낮은 순으로 정렬 출력
-- 특정 컬럼 언급 없으면 모든 컬럼 출력. 
select * from emp order by comm desc, sal asc;
-- 퀴즈2
-- emp 테이블에서 이름, 부서번호, 급여를 출력 하되
-- 급여가 높은 순으로 정렬해보기, 한번더 
select ename, deptno, sal from emp
order by sal desc;
-- 퀴즈 3 
-- salgrade 테이블에서 급여 등급(grade) 을 오름차순, 
-- 최고 급여(hisal) 내림차순으로 정렬해보기.
-- 특정 컬럼 언급 없으면 모든 컬럼 출력. 
select * from salgrade 
order by grade asc, hisal desc;
