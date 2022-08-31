-----------------------------------------------
-- JOIN : 여러개의 테이블을 연결하여 조회.
-----------------------------------------------
-- CROSS JOIN (카티션곱) : 사용시 주의
-- 두개의 테이블의 한테이블의 레코드 하나당 다른 테이블 레코드한번씩 전부 조인함
SELECT COUNT(*) FROM EMP;   -- 14건
SELECT COUNT(*) FROM DEPT;  --  4건
SELECT * FROM EMP;
SELECT * FROM DEPT;


SELECT ENAME, EMP.DEPTNO, DNAME FROM EMP, DEPT;
--  두개 테이블의 컬럼명이 같은 경우엔 반드시 테이블명을 명시해야한다 EX) EMP.DEPTNO

--oracle
select e.ename, e.deptno, d.deptno, d.dname from emp e, dept d;
-- ANSI 조인방식

SELECT E.ENAME, E.DEPTNO, D.DEPTNO, D.DNAME FROM EMP E CROSS JOIN DEPT D;

-- 등가조인 (EQUI JOIN) : 두개의 테이블을 연결해주는 컬럼으로 레코드 조회.
--            연결 조건 : 연결컬럼의 값이 같은 경우

-- 학생테이블 학과테이블 사용하여 학생이름 전공학과 전공학과이름 출력

-- 오라클 방식
SELECT S.NAME, S.DEPTNO1, D.DNAME FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO1 = D.DEPTNO;
-- ANSI 방식
SELECT S.NAME, S.DEPTNO1, D.DNAME FROM STUDENT S JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO;

-- EMP

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT E.ENAME, E.DEPTNO, D.DNAME FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME,
       E.DEPTNO,
       D.DNAME
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

select e.ename, d.deptno, d.dname from emp e, dept d
where e.deptno = d.deptno;

-- 학생테이블과 교수테이블을 이용하여 학생의 이름 지도교수번호 지도교수이름을 조회하기, 지도교수가 없는 학생은 조회하지않음.
-- oracle
select s.name 학생이름, s.profno 지도교수번호, p.name 지도교수이름 from student s, professor p
where s.profno = p.profno;
--ansl
select s.name 학생이름, s.profno 지도교수번호, p.name 지도교수이름 from student s join professor p on s.profno = p.profno;


-- 학생테이블교수테이블 이용해서 오나라 학생의 이름 지도교수번호 지도교수이름조회하기
-- oracle
select s.name 학생이름, s.profno 지도교수번호, p.name 지도교수이름 from student s, professor p
where s.profno = p.profno and s.name = '오나라';

--ansi
select s.name 학생이름, s.profno 지도교수번호, p.name 지도교수이름 
from student s join professor p 
on s.profno = p.profno
where s.name = '오나라';

-- 학생의 이름, 학과이름, 지도교수이름을 조회하기

select s.name 이름, d.dname, p.name from student s, department d, professor p
where s.deptno1 = d.deptno 
  and s.profno = p.profno;

select 
  s.name 이름,
  d.dname 학과,
  p.name 지도교수이름
  from student s join department d on s.deptno1 = d.deptno join professor p on s.profno = p.profno;