

/*
 1. �����̺�� ��ǰ���̺��� �����Ͽ� �غ��� ��ǰ�� �̸���, �ʿ������ ����ϱ�.
  �� ������ ���� ������ �����ϱ�

[���]
��ǰ��                                                         ��ǰ����
------------------------------------------------------------ ----------
��Ǫ��Ʈ                                                              3
��ġ��Ʈ                                                              3
������ǰ��Ʈ                                                          3
������TV                                                              2
�ֹ��ǰ��Ʈ                                                          2
��ǿ�������                                                          2
��Ʈ��                                                                2
LCD�����                                                             2
���ʹ������                                                          1
*/

select g1.GNAME, count(g1.GNAME) from gift g1 join gogak g2 on g2.POINT between g1.G_START and g1.G_END
group by g1.gname
order by 2 desc;


/*
2.  �������̺��� ������ȣ, �����̸�,�Ի��� �ڽź��� �Ի����� ��������� �ο����� ����ϱ�
    ��� ���������� ��ȸ�ǵ��� �ϰ�, �Ի����� ���������� �����ϱ�

[���]
   PROFNO NAME                                     HIREDATE COUNT(P2.NAME)
---------- ---------------------------------------- -------- --------------
      1001 ���                                   90/06/23              0
      3001 �赵��                                   91/10/23              1
      4001 �ɽ�                                     91/10/23              1
      2013 ��â��                                   92/04/29              3
      4005 �ٺ�                                     95/09/18              4
      2012 ������                                   95/11/30              5
      1002 ����                                   97/01/30              6
      3002 ���ѿ�                                   07/07/01              7
      1003 ���ڹ�                                   08/03/22              8
      4003 ������                                   09/12/01              9
      4006 ��                                      10/06/28             10
      4007 ������                                   11/05/23             11
      2011 ��ȣ��                                   11/09/01             12
      3003 ������                                   12/02/24             13
      4004 ������                                   19/01/28             14
      4002 �ֽ���                                   19/08/30             15
*/


select p1.profno, p1.name, p1.hiredate, count(p2.name) from professor p1 left outer join professor p2 on p1.HIREDATE > p2.hiredate
group by p1.profno, p1.name, p1.hiredate
order by 3;



/*
3. emp ���̺��� �����ȣ,�����,����,����ȣ,����̸�,����������� ����ϱ�.
   ��� ����� ��ȸ�ǵ��� �Ѵ�.
  [���]
  �����ȣ �����               �������             ����ȣ      ����               �������
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
4. �μ����̺�(department)���� �������п� �Ҽӵ� �а��̸��� ���
[���]
DNAME
------------------------
����Ʈ������а�
��ǻ�Ͱ��а�
��Ƽ�̵����а�
ȭ�а��а�
���ڰ��а�
�����а�
*/

select * from department;

select d1.dname from department d1 join department d2 on d1.part = d2.deptno join department d3 on d2.part = d3.deptno;

/*
5.�л����̺��� �����а��� 101���� �а��� ��ո����Ժ���  �����԰� ���� �л����� �̸��� ������, �а��� ���
[���]
NAME                     WEIGHT   DNAME
-------------------- ----------  -------------------------------------
ȫ�浿                       72       ��ǻ�Ͱ��а�
�̻��                       64       ��Ƽ�̵����а�
���л�                       83       ���ڰ��а�
������                       70       �����а�
������                       72       ��ǻ�Ͱ��а�
������                       70       ��Ƽ�̵����а�
�ȱ���                       82       ���ڰ��а�
����ȣ                       62       ���������а�
������                       63       ���ڰ��а�
�ο���                       69       ���ڰ��а�
������                       81       ��Ƽ�̵����а�
*/
select * from student;
select * from department;


select s.name, s.weight, d.dname from student s join department d on s.deptno1 = d.deptno
where weight > (select avg(s.weight) from student s join department d on s.deptno1 = d.deptno and s.deptno1=101);

/*
6. �������̺��� �ɽ������� ���� �Ի��Ͽ� �Ի��� ���� ��  ������� ���� ������ ���Թ޴� ������ �̸�, �޿�, �Ի��� ���
[���]
NAME                                            PAY HIREDATE
---------------------------------------- ---------- --------
�赵��                                          530 91/10/23
*/

select * from professor;

select hiredate from professor
where name='�ɽ�';
select pay from professor
where name='���';

select name, pay, hiredate from professor
where pay < (select pay from professor
where name='���') and hiredate = (select hiredate from professor
where name='�ɽ�');

/*
7.101�� �а� �л����� ��� ������ ����  �����԰� ���� �л���  �й���,�̸���, �а���ȣ, �����Ը� ���
[���]
    STUDNO NAME                    DEPTNO1     WEIGHT
---------- -------------------- ---------- ----------
      9413 ������                      103         52
      9511 �̼���                      101         48
      9512 ������                      102         42
      9513 ������                      202         55
      9514 ������                      301         58
      9515 �����                      201         54
      9614 �蹮ȣ                      201         51
      9711 ������                      101         48
      9715 ���                        103         51
*/

select studno, name, deptno1, weight from student
where weight < (select avg(weight) from student where deptno1 = 101)
order by 1;

/*
8.  9712�л��� �г��� ���� Ű�� 9713�л�����  ū �л��� �̸�, �г�, Ű�� ���
[���]
NAME                      GRADE     HEIGHT
-------------------- ---------- ----------
������                        1        175
������                        1        179
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
9. ��ǻ�������кο� �Ҽӵ� ��� �л��� �й�,�̸�, �а���ȣ ���
   �а���ȣ ������ �����Ͽ� ����ϱ�
[���]
      �й� �̸�                   �а���ȣ
---------- -------------------- ----------
      9511 �̼���                      101
      9411 ȫ�浿                      101
      9611 ������                      101
      9711 ������                      101
      9412 �̻��                      102
      9512 ������                      102
      9612 ������                      102
      9714 ������                      102
      9413 ������                      103
      9715 ���                        103
*/


select studno, name, deptno1 from student 
where deptno1 in (select d1.deptno from department d1 join department d2 on d1.part = d2.deptno and d2.dname='��ǻ�������к�')
order by 3;

select studno, name, deptno1 from student s join department d on s.deptno1 = d.deptno;

select * from student;
select * from department;

select s.
select d1.deptno from department d1 join department d2 on d1.part = d2.deptno and d2.dname='��ǻ�������к�';

/*
10. 4�г��л� �� Ű�� ���� ���� �л����� Ű�� �� ���� �л��� �й�,�̸�,Ű�� ���
[���]
    STUDNO NAME                     HEIGHT
---------- -------------------- ----------
      9511 �̼���                      164
      9512 ������                      161
      9514 ������                      160
      9614 �蹮ȣ                      166
      9711 ������                      162
      9715 ���                         163
*/

select studno, name, height from student
where height < (select min(height) from student where grade=4);


/*
11. �л� �߿��� ��������� ���� ���� �л��� �й�, �̸�, ��������� ���
[���]
    STUDNO NAME                 BIRTHDAY
---------- -------------------- --------
      9412 �̻��               75/02/24
*/

select studno, name, birthday from student
where birthday = (select min(birthday) from student); 

/*
12.�г⺰�� ���ü���� ���� ���� �г��� �г�� ��� �����Ը� ���
[���]
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
