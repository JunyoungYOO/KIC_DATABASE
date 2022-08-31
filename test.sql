

/*
 1. 고객테이블과 상품테이블을 조인하여 준비할 상품의 이름과, 필요수량을 출력하기.
  단 수량이 많은 순으로 정렬하기

[결과]
상품명                                                         상품수량
------------------------------------------------------------ ----------
샴푸세트                                                              3
참치세트                                                              3
세차용품세트                                                          3
벽걸이TV                                                              2
주방용품세트                                                          2
산악용자전거                                                          2
노트북                                                                2
LCD모니터                                                             2
양쪽문냉장고                                                          1
*/

select g1.GNAME, count(g1.GNAME) from gift g1 join gogak g2 on g2.POINT between g1.G_START and g1.G_END
group by g1.gname
order by 2 desc;


/*
2.  교수테이블에서 교수번호, 교수이름,입사일 자신보다 입사일이 빠른사람의 인원수를 출력하기
    모든 교수정보가 조회되도록 하고, 입사일이 빠른순으로 정렬하기

[결과]
   PROFNO NAME                                     HIREDATE COUNT(P2.NAME)
---------- ---------------------------------------- -------- --------------
      1001 김명선                                   90/06/23              0
      3001 김도형                                   91/10/23              1
      4001 심슨                                     91/10/23              1
      2013 이창익                                   92/04/29              3
      4005 바비                                     95/09/18              4
      2012 장혜진                                   95/11/30              5
      1002 김명신                                   97/01/30              6
      3002 나한열                                   07/07/01              7
      1003 김자바                                   08/03/22              8
      4003 나몰라                                   09/12/01              9
      4006 비                                      10/06/28             10
      4007 김태희                                   11/05/23             11
      2011 엄호선                                   11/09/01             12
      3003 김현정                                   12/02/24             13
      4004 아이유                                   19/01/28             14
      4002 최슬기                                   19/08/30             15
*/


select p1.profno, p1.name, p1.hiredate, count(p2.name) from professor p1 left outer join professor p2 on p1.HIREDATE > p2.hiredate
group by p1.profno, p1.name, p1.hiredate
order by 3;



/*
3. emp 테이블에서 사원번호,사원명,직업,상사번호,상사이름,상사의직업을 출력하기.
   모든 사원이 조회되도록 한다.
  [결과]
  사원번호 사원명               사원직업             상사번호      상사명               상사직업
---------- -------------------- ------------------ ---------- -------------------- ------------------
      7369 SMITH                CLERK                    7902        FORD                 ANALYST
      7499 ALLEN                SALESMAN              7698       BLAKE                MANAGER
      7521 WARD                SALESMAN             7698        BLAKE                MANAGER
      7566 JONES                MANAGER               7839       KING                 PRESIDENT
      7654 MARTIN              SALESMAN              7698       BLAKE                MANAGER
      7698 BLAKE                MANAGER               7839       KING                 PRESIDENT
      7782 CLARK                MANAGER               7839      KING                 PRESIDENT
      7788 SCOTT                ANALYST                 7566      JONES                MANAGER
      7839 KING                 PRESIDENT
      7844 TURNER               SALESMAN             7698      BLAKE                MANAGER
      7876 ADAMS                CLERK                    7788     SCOTT                ANALYST
      7900 JAMES                CLERK                     7698      BLAKE                MANAGER
      7902 FORD                 ANALYST                  7566     JONES                MANAGER
      7934 MILLER               CLERK                    7782       CLARK                MANAGER
*/


select * from emp;

select e1.empno, e1.ename, e1.job, e2.empno, e2.ename, e2.job from emp e1 left outer join emp e2 on e1.mgr = e2.empno
order by 1;


/*
4. 부서테이블(department)에서 공과대학에 소속된 학과이름을 출력
[결과]
DNAME
------------------------
소프트웨어공학과
컴퓨터공학과
멀티미디어공학과
화학공학과
전자공학과
기계공학과
*/

select * from department;

select d1.dname from department d1 join department d2 on d1.part = d2.deptno join department d3 on d2.part = d3.deptno;

/*
5.학생테이블에서 전공학과가 101번인 학과의 평균몸무게보다  몸무게가 많은 학생들의 이름과 몸무게, 학과명 출력
[결과]
NAME                     WEIGHT   DNAME
-------------------- ----------  -------------------------------------
홍길동                       72       컴퓨터공학과
이사랑                       64       멀티미디어공학과
나학생                       83       전자공학과
누구야                       70       기계공학과
일지매                       72       컴퓨터공학과
김진욱                       70       멀티미디어공학과
안광훈                       82       전자공학과
노정호                       62       문헌정보학과
안은수                       63       전자공학과
인영민                       69       전자공학과
김주현                       81       멀티미디어공학과
*/
select * from student;
select * from department;


select s.name, s.weight, d.dname from student s join department d on s.deptno1 = d.deptno
where weight > (select avg(s.weight) from student s join department d on s.deptno1 = d.deptno and s.deptno1=101);

/*
6. 교수테이블의 심슨교수와 같은 입사일에 입사한 교수 중  김명선교수 보다 월급을 적게받는 교수의 이름, 급여, 입사일 출력
[결과]
NAME                                            PAY HIREDATE
---------------------------------------- ---------- --------
김도형                                          530 91/10/23
*/

select * from professor;

select hiredate from professor
where name='심슨';
select pay from professor
where name='김명선';

select name, pay, hiredate from professor
where pay < (select pay from professor
where name='김명선') and hiredate = (select hiredate from professor
where name='심슨');

/*
7.101번 학과 학생들의 평균 몸무게 보다  몸무게가 적은 학생의  학번과,이름과, 학과번호, 몸무게를 출력
[결과]
    STUDNO NAME                    DEPTNO1     WEIGHT
---------- -------------------- ---------- ----------
      9413 조아해                      103         52
      9511 이서진                      101         48
      9512 유해진                      102         42
      9513 오나라                      202         55
      9514 구유미                      301         58
      9515 몰라두                      201         54
      9614 김문호                      201         51
      9711 이윤나                      101         48
      9715 허우                        103         51
*/

select studno, name, deptno1, weight from student
where weight < (select avg(weight) from student where deptno1 = 101)
order by 1;

/*
8.  9712학생과 학년이 같고 키는 9713학생보다  큰 학생의 이름, 학년, 키를 출력
[결과]
NAME                      GRADE     HEIGHT
-------------------- ---------- ----------
안은수                        1        175
김주현                        1        179
*/

select name, grade, height from student
where grade = (select grade from student
where studno=9712) and height > (select height from student
where studno=9713);

select grade from student
where studno=9712;

select height from student
where studno=9713;

/*
9. 컴퓨터정보학부에 소속된 모든 학생의 학번,이름, 학과번호 출력
   학과번호 순으로 정렬하여 출력하기
[결과]
      학번 이름                   학과번호
---------- -------------------- ----------
      9511 이서진                      101
      9411 홍길동                      101
      9611 일지매                      101
      9711 이윤나                      101
      9412 이사랑                      102
      9512 유해진                      102
      9612 김진욱                      102
      9714 김주현                      102
      9413 조아해                      103
      9715 허우                        103
*/


select studno, name, deptno1 from student 
where deptno1 in (select d1.deptno from department d1 join department d2 on d1.part = d2.deptno and d2.dname='컴퓨터정보학부')
order by 3;

select studno, name, deptno1 from student s join department d on s.deptno1 = d.deptno;

select * from student;
select * from department;

select s.
select d1.deptno from department d1 join department d2 on d1.part = d2.deptno and d2.dname='컴퓨터정보학부';

/*
10. 4학년학생 중 키가 제일 작은 학생보다 키가 더 작은 학생의 학번,이름,키를 출력
[결과]
    STUDNO NAME                     HEIGHT
---------- -------------------- ----------
      9511 이서진                      164
      9512 유해진                      161
      9514 구유미                      160
      9614 김문호                      166
      9711 이윤나                      162
      9715 허우                         163
*/

select studno, name, height from student
where height < (select min(height) from student where grade=4);


/*
11. 학생 중에서 생년월일이 가장 빠른 학생의 학번, 이름, 생년월일을 출력
[결과]
    STUDNO NAME                 BIRTHDAY
---------- -------------------- --------
      9412 이사랑               75/02/24
*/

select studno, name, birthday from student
where birthday = (select min(birthday) from student); 

/*
12.학년별로 평균체중이 가장 적은 학년의 학년과 평균 몸무게를 출력
[결과]
     GRADE AVG(WEIGHT)
---------- -----------
         3        51.4
*/

select grade, avg(weight) from student
group by grade
having avg(weight) = (select min(avg(weight)) from student group by grade);

select min(avg(weight)) from student group by grade;


select grade, avg(weight) from student
where avg(weight) in (select min(avg(weight)) from student group by grade)
group by grade;
