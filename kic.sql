-- SELECT 테이블 조회 명령문
-- SELECT *(모든컬럼) FROM 테이블
-- WHERE 조건

select * from emp

-- 
desc emp

select *
from emp

-- emp 테이블의 모든 행의 이름(ename), 번호(empno) 컬럼만 조회하기
SELECT ename, empno from emp

-- emp 테이블 empno, ename, deptno 모든 행 조회
SELECT empno, ename, deptno from emp

-- 리터널(상수, 문자열)을 컬럼으로 생성

SELECT empno, ename, 'very good ~~~' from emp

select * from professor

select profno, name || '교수' from professor

-- 컬럼에 별명(alias) 주기
-- professor 테이블의 name 컬럼을 교수이름, profno 컬럼 교수번호
-- 별명에 공백 주려면 ""사용

select name "교수 이름", profno 교수번호 from professor
select name as "교수 이름", profno as "교수 번호" from professor

-- 문제 
-- 1. emp 테이블에서 empno는 사원번호 ename은 사원명 job은 직업으로 별명 설정하여 조회

select empno "사원번호", ename "사원명", job "직업" from emp
select empno as 사원번호, ename as 사원명, job as 직업 from emp
select empno "사원 번호", ename 사원명, job 직업 from emp

-- 컬럼에 사용되는 연산자
-- 연결 연산자 : ||, concat 함수

select name||position 교수 from professor

-- name 님은 position입니다. 형태로 교수정보 조회하기

select name || '님은 ' || position || '입니다.' 교수 from professor

-- 산술연산자. : +. -. *, /
-- emp 테이블에서 사원의 급여를 10% 인상

select ename as 사원명, sal as 현재급여, sal*1.1 as 인상예상급여 from emp

-- 문제 : 교수테이블 (professor)에서 교수이름(name), 급여(pay), 연봉(pay*12) 컬럼을 조회하기

select name 교수이름, pay 급여, pay*12 as 연봉 from professor

-- 행을 선택하기
-- where 조건문

-- 교수테이블에서 교수번호가 1001번인 교수의 모든 컬럼을 조회하기

select * from professor
where profno = 1001

-- 학생테이블(student)에서 1학년 학생의 모든 컬럼을 조회하기
-- 학년 컬럼 (grade)
select * from student
where grade = 1

-- 문제1 : 학생테이블에서 1학년 학생의 학번 이름 학년을 조회하기

select studno 학번, name 이름, grade 학년 from student
where grade = 1;

-- 문제2 : 사원테이블에서 급여(sal)가 4000보다 큰 사람의 이름(ename)과 급여(sal) 조회하기

select ename 이름, sal 급여 from emp
where sal>4000;

-- emp 테이블에서 사원의 급여를 10% 인상하기로함
-- 인상예상급여가 1000 미만인 사원의 이름, 현재급여, 인상예상급여 조회하기

select ename, sal, sal*1.1 as 인상예상급여 from emp
where sal*1.1 < 1000;

--1. 교수테이블의 전체 내용 출력하기
select * from professor;

--2. 교수테이블에서 교수이름, 학과코드를 출력하기
select name 교수이름, deptno 학과코드 from professor;

--3. dept테이블 deptno 부서#, dname 부서명, loc 부서위치 로 별명을 설정 하여 출력하기
select deptno 부서#, dname 부서명, loc 부서위치 from dept;

--4. 학생 테이블에서 name, birthday, height, weight 칼럼을 출력하여라.
--단, name은'이름', birthday는 '생년월일', height는 '키(cm)',weight '몸무게(kg)' 으로 별명 주기

select
  name as 이름,
  birthday as 생년월일,
  height "키(cm)",
  weight as "몸무게(kg)"
from student;

--5. 학생테이블에서 학생의 이름 앞에 'grade 학년 학생'을 붙여서 출력하기
--    1학년 학생 홍길동 

select grade || '학년 학생 ' || name as "학생 정보" from student;

--6. 교수테이블에서 이름(name)과 직급(position) 사이에 공백 추가하여 출력하기
--   김명선 전임강사

select name|| ' ' ||position as 교수 from professor;

--7. 학생테이블(student)에서 '학생이름(name) 의 키는 180(height) cm, 몸무게는 80(weight) kg 입니다.' 
--    라는 형식으로  출력하도록 sql구문 작성하기. 컬럼별명은 키와몸무게로 한다.
--  홍길동의 키는 180 cm, 몸무게는 80 kg 입니다.' 

select name || '의 키는 ' || height || 'cm, 몸무게는 ' || weight || 'kg 입니다.' from student;

-- 8. 사원의 급여가 3000 이하인 사원들만 급여를 5%인상하기로 한다. 인상예정인 사원의
--    사원번호, 사원이름, 현재급여, 인상예상급여, 부서코드를 출력하기

select empno 사원번호, ename 사원이름, sal 현재급여, sal*1.05 as 인상예상급여, deptno 부서코드 from emp
where sal <= 3000;

--9. 사원의 이름이  SCOTT  인 사원의 이름,사원번호, 급여, 급여+100 조회하기

select ename, empno, sal, sal+100 "급여+100" from emp
where ename = 'SCOTT';

--10.  학생의 이름이 홍길동인 학생의 모든 컬럼을 조회하기

select * from student
where name='홍길동';
