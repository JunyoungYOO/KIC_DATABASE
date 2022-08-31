/*
1. �л��̸��� ���������̸� ����ϱ�.�� �����л��� ���� �����̸���,  ���������� ���� �л��̸��� ����ϱ�
   �����л��� ���� ������ ��� �����л��̸��� "****"�� ǥ���ϰ� ���������� ���� �л��� ���������� '####'
   ���� ����ϱ�. 
  [���]
�����л�             ��������
--------------- -----------------
****                 �赵��
****                 ���ڹ�
****                 ������
****                 �ٺ�
****                 ��
****                 ������
****                 ��â��
������               ������
�蹮ȣ               ������
������               ####
������               ��ȣ��
���л�               �ɽ�
����ȣ               ������
������               ������
�����               �ɽ�
�ȱ���               �ֽ���
������               ####
������               ������
������               ������
�̻��               ��ȣ��
�̼���               ����
������               ####
�ο���               ####
������               ����
������               ���ѿ�
���                 ####
ȫ�浿               ���
*/

select nvl(s.name, '****'), nvl(p.name, '####') from student s full outer join professor p on s.profno = p.profno
order by 1;

select nvl(s.name,'****'), nvl(p.name, '####') from student s, professor p where s.profno(+)=p.profno
union
select nvl(s.name,'****'), nvl(p.name, '####') from student s, professor p where s.profno=p.profno(+)
order by 1;

/*
2.  �а���,�г⺰ ������ ���� ���� ������ ���� �л��� �а��ڵ�,�а���,�г�,�̸�,���� ����ϱ�
[���]

  �а��ڵ� �а���                                  �г�   �̸�                       ����
---------- ----------------------------   ---------- -------------------- ----------
       101 ��ǻ�Ͱ��а�                               1   ������                       91
       101 ��ǻ�Ͱ��а�                               2   ������                       89
       101 ��ǻ�Ͱ��а�                               3   �̼���                       92
       101 ��ǻ�Ͱ��а�                               4   ȫ�浿                       97
       102 ��Ƽ�̵����а�                         1   ������                       83
       102 ��Ƽ�̵����а�                         2   ������                       77
       102 ��Ƽ�̵����а�                         3   ������                       87
       102 ��Ƽ�̵����а�                         4   �̻��                       78
       103 ����Ʈ������а�                         1   ���                          84
       103 ����Ʈ������а�                         4   ������                       83
       201 ���ڰ��а�                                  1   ������                       88
       201 ���ڰ��а�                                  2   �ȱ���                       86
       201 ���ڰ��а�                                  3   �����                       95
       201 ���ڰ��а�                                  4   ���л�                       62
       202 �����а�                                  3   ������                       81
       202 �����а�                                  4   ������                       88
       301 ���������а�                               2   ����ȣ                       87
       301 ���������а�                               3   ������                       79
*/
select * from exam_01;
select * from student;
select * from department;


select s.deptno1 �а��ڵ�, d.dname �а���, s.grade �г�, s.name �̸�, e.total ����
from student s, department d, exam_01 e
where s.deptno1 = d.deptno and s.studno = e.studno
and (s.deptno1, grade, e.total) in (select s.deptno1, s.grade, max(e.total) from student s, exam_01 e where s.studno = e.studno group by s.deptno1, s.grade)
order by s.deptno1, s.grade;
/*
3. �а���  ��������� ���� ���� �л��� �й�,  �̸�, �������,�а����� ���
*/

select s.studno, s.name, s.birthday, d.dname  from student s join department d on s.deptno1 = d.deptno
where s.birthday in (select min(s.birthday) from student s join department d on s.deptno1 = d.deptno group by d.deptno);

/*
4. ���� ���̺��� �Ի����� 2015�� 1�� 1�Ϸ� �Է��ϱ�
   ������ȣ : 6001 ,       ������   : ������
   ��å     : ������,      id      : choiys 
   �Ի���   : 2015-01-01,  �μ��ڵ� : 501
   pay     : 400
*/
select * from professor;

INSERT INTO PROFESSOR (profno, name, position, id, hiredate, deptno, pay) values(6001, '������', '������', 'choiys', '2015-01-01', 501, 400);

select * from professor;

/*
5. department ���̺� ��īƮ�δн��к��� ���� �а��� ��īƮ�δн����а��� 401�� �ڵ�� �߰��ϱ�.
   �ǹ����� null�� �߰��Ѵ�.
*/
SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = '��īƮ�δн��к�';

select * from department;

INSERT INTO DEPARTMENT (DEPTNO, DNAME, PART) VALUES('401', '��īƮ�δн����а�', (SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = '��īƮ�δн��к�' ));

SELECT * FROM DEPARTMENT;
/*
6.  department ���̺���  �������� ����  �����͸� �����ϴ� department10 ���̺� �����ϱ�
*/


CREATE TABLE department10 as Select * from department
where deptno in (select d1.deptno from department d1 inner join department d2 on d1.part=d2.deptno inner join department d3 on d2.part = d3.deptno where d3.dname='��������');


CREATE TABLE department10 as Select d1.* from department d1, department d2, department d3 where d1.part=d2.deptno and d2.part = d3.deptno and d3.dname='��������';

SELECT * FROM DEPARTMENT10;

/*
  DML
    insert into ���̺�� (�÷���, ..) values('�÷���',...)
      �÷��� �����ϴ� values�� �߰�
    update ���̺�� set �÷���='�÷���' ...  where(���ǹ�)
      ���� �����ϴ� ���ڵ� ����
    delete from ���̺� where(���ǹ�)
      ���� �����ϴ� ���ڵ� ����
    
  SELECT �÷���
  FROM ���̺�
  WHERE ����
  GROUP BY
  HAVING
  ORDER BY
    
  DDL
    create table ���̺�� (
      �÷��� �ڷ���,
      .
      .
      .
    )
      
    alter : ��ü ����
      https://121202.tistory.com/27
      
    DROP TABLE ���̺��
    
    TRUNCATE ��� ���� ����   ROLLBACK �Ұ�
*/