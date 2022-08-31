-----------------------------------------------
-- JOIN : �������� ���̺��� �����Ͽ� ��ȸ.
-----------------------------------------------
-- CROSS JOIN (īƼ�ǰ�) : ���� ����
-- �ΰ��� ���̺��� �����̺��� ���ڵ� �ϳ��� �ٸ� ���̺� ���ڵ��ѹ��� ���� ������
SELECT COUNT(*) FROM EMP;   -- 14��
SELECT COUNT(*) FROM DEPT;  --  4��
SELECT * FROM EMP;
SELECT * FROM DEPT;


SELECT ENAME, EMP.DEPTNO, DNAME FROM EMP, DEPT;
--  �ΰ� ���̺��� �÷����� ���� ��쿣 �ݵ�� ���̺���� ����ؾ��Ѵ� EX) EMP.DEPTNO

--oracle
select e.ename, e.deptno, d.deptno, d.dname from emp e, dept d;
-- ANSI ���ι��

SELECT E.ENAME, E.DEPTNO, D.DEPTNO, D.DNAME FROM EMP E CROSS JOIN DEPT D;

-- ����� (EQUI JOIN) : �ΰ��� ���̺��� �������ִ� �÷����� ���ڵ� ��ȸ.
--            ���� ���� : �����÷��� ���� ���� ���

-- �л����̺� �а����̺� ����Ͽ� �л��̸� �����а� �����а��̸� ���

-- ����Ŭ ���
SELECT S.NAME, S.DEPTNO1, D.DNAME FROM STUDENT S, DEPARTMENT D
WHERE S.DEPTNO1 = D.DEPTNO;
-- ANSI ���
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

-- �л����̺�� �������̺��� �̿��Ͽ� �л��� �̸� ����������ȣ ���������̸��� ��ȸ�ϱ�, ���������� ���� �л��� ��ȸ��������.
-- oracle
select s.name �л��̸�, s.profno ����������ȣ, p.name ���������̸� from student s, professor p
where s.profno = p.profno;
--ansl
select s.name �л��̸�, s.profno ����������ȣ, p.name ���������̸� from student s join professor p on s.profno = p.profno;


-- �л����̺������̺� �̿��ؼ� ������ �л��� �̸� ����������ȣ ���������̸���ȸ�ϱ�
-- oracle
select s.name �л��̸�, s.profno ����������ȣ, p.name ���������̸� from student s, professor p
where s.profno = p.profno and s.name = '������';

--ansi
select s.name �л��̸�, s.profno ����������ȣ, p.name ���������̸� 
from student s join professor p 
on s.profno = p.profno
where s.name = '������';

-- �л��� �̸�, �а��̸�, ���������̸��� ��ȸ�ϱ�

select s.name �̸�, d.dname, p.name from student s, department d, professor p
where s.deptno1 = d.deptno 
  and s.profno = p.profno;

select 
  s.name �̸�,
  d.dname �а�,
  p.name ���������̸�
  from student s join department d on s.deptno1 = d.deptno join professor p on s.profno = p.profno;