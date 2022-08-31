-- SELECT ���̺� ��ȸ ��ɹ�
-- SELECT *(����÷�) FROM ���̺�
-- WHERE ����

select * from emp

-- 
desc emp

select *
from emp

-- emp ���̺��� ��� ���� �̸�(ename), ��ȣ(empno) �÷��� ��ȸ�ϱ�
SELECT ename, empno from emp

-- emp ���̺� empno, ename, deptno ��� �� ��ȸ
SELECT empno, ename, deptno from emp

-- ���ͳ�(���, ���ڿ�)�� �÷����� ����

SELECT empno, ename, 'very good ~~~' from emp

select * from professor

select profno, name || '����' from professor

-- �÷��� ����(alias) �ֱ�
-- professor ���̺��� name �÷��� �����̸�, profno �÷� ������ȣ
-- ���� ���� �ַ��� ""���

select name "���� �̸�", profno ������ȣ from professor
select name as "���� �̸�", profno as "���� ��ȣ" from professor

-- ���� 
-- 1. emp ���̺��� empno�� �����ȣ ename�� ����� job�� �������� ���� �����Ͽ� ��ȸ

select empno "�����ȣ", ename "�����", job "����" from emp
select empno as �����ȣ, ename as �����, job as ���� from emp
select empno "��� ��ȣ", ename �����, job ���� from emp

-- �÷��� ���Ǵ� ������
-- ���� ������ : ||, concat �Լ�

select name||position ���� from professor

-- name ���� position�Դϴ�. ���·� �������� ��ȸ�ϱ�

select name || '���� ' || position || '�Դϴ�.' ���� from professor

-- ���������. : +. -. *, /
-- emp ���̺��� ����� �޿��� 10% �λ�

select ename as �����, sal as ����޿�, sal*1.1 as �λ󿹻�޿� from emp

-- ���� : �������̺� (professor)���� �����̸�(name), �޿�(pay), ����(pay*12) �÷��� ��ȸ�ϱ�

select name �����̸�, pay �޿�, pay*12 as ���� from professor

-- ���� �����ϱ�
-- where ���ǹ�

-- �������̺��� ������ȣ�� 1001���� ������ ��� �÷��� ��ȸ�ϱ�

select * from professor
where profno = 1001

-- �л����̺�(student)���� 1�г� �л��� ��� �÷��� ��ȸ�ϱ�
-- �г� �÷� (grade)
select * from student
where grade = 1

-- ����1 : �л����̺��� 1�г� �л��� �й� �̸� �г��� ��ȸ�ϱ�

select studno �й�, name �̸�, grade �г� from student
where grade = 1;

-- ����2 : ������̺��� �޿�(sal)�� 4000���� ū ����� �̸�(ename)�� �޿�(sal) ��ȸ�ϱ�

select ename �̸�, sal �޿� from emp
where sal>4000;

-- emp ���̺��� ����� �޿��� 10% �λ��ϱ����
-- �λ󿹻�޿��� 1000 �̸��� ����� �̸�, ����޿�, �λ󿹻�޿� ��ȸ�ϱ�

select ename, sal, sal*1.1 as �λ󿹻�޿� from emp
where sal*1.1 < 1000;

--1. �������̺��� ��ü ���� ����ϱ�
select * from professor;

--2. �������̺��� �����̸�, �а��ڵ带 ����ϱ�
select name �����̸�, deptno �а��ڵ� from professor;

--3. dept���̺� deptno �μ�#, dname �μ���, loc �μ���ġ �� ������ ���� �Ͽ� ����ϱ�
select deptno �μ�#, dname �μ���, loc �μ���ġ from dept;

--4. �л� ���̺��� name, birthday, height, weight Į���� ����Ͽ���.
--��, name��'�̸�', birthday�� '�������', height�� 'Ű(cm)',weight '������(kg)' ���� ���� �ֱ�

select
  name as �̸�,
  birthday as �������,
  height "Ű(cm)",
  weight as "������(kg)"
from student;

--5. �л����̺��� �л��� �̸� �տ� 'grade �г� �л�'�� �ٿ��� ����ϱ�
--    1�г� �л� ȫ�浿 

select grade || '�г� �л� ' || name as "�л� ����" from student;

--6. �������̺��� �̸�(name)�� ����(position) ���̿� ���� �߰��Ͽ� ����ϱ�
--   ��� ���Ӱ���

select name|| ' ' ||position as ���� from professor;

--7. �л����̺�(student)���� '�л��̸�(name) �� Ű�� 180(height) cm, �����Դ� 80(weight) kg �Դϴ�.' 
--    ��� ��������  ����ϵ��� sql���� �ۼ��ϱ�. �÷������� Ű�͸����Է� �Ѵ�.
--  ȫ�浿�� Ű�� 180 cm, �����Դ� 80 kg �Դϴ�.' 

select name || '�� Ű�� ' || height || 'cm, �����Դ� ' || weight || 'kg �Դϴ�.' from student;

-- 8. ����� �޿��� 3000 ������ ����鸸 �޿��� 5%�λ��ϱ�� �Ѵ�. �λ����� �����
--    �����ȣ, ����̸�, ����޿�, �λ󿹻�޿�, �μ��ڵ带 ����ϱ�

select empno �����ȣ, ename ����̸�, sal ����޿�, sal*1.05 as �λ󿹻�޿�, deptno �μ��ڵ� from emp
where sal <= 3000;

--9. ����� �̸���  SCOTT  �� ����� �̸�,�����ȣ, �޿�, �޿�+100 ��ȸ�ϱ�

select ename, empno, sal, sal+100 "�޿�+100" from emp
where ename = 'SCOTT';

--10.  �л��� �̸��� ȫ�浿�� �л��� ��� �÷��� ��ȸ�ϱ�

select * from student
where name='ȫ�浿';
