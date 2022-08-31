-- distinct : �ߺ�����  // �÷� �տ� �ѹ��� ��� ����  , ���� © �� �� ���� ����
-- ex) SELECT distinct deptno, distinct name from professor (X)
--     select distinct deptno, name from professor (O)
-- ������ ���� �μ��ڵ� ��ȸ�ϱ�
select distinct position, deptno from professor;

-- between ������
-- �л��� �����԰� 70�̻� 80������ �л��� �̸�, ������, �г� ��ȸ�ϱ�

select name, weight, grade from student
where weight between 70 and 80;

select name, weight, grade from student
where weight >= 70 and weight <=80;

-- ���� :
-- ������ �޿�(pay)�� 300�̻� 500����
-- ������ȣ, �̸�, �޿�, ���ʽ� ����ϱ�

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE PAY BETWEEN 300 AND 500;

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE PAY >=300 AND PAY <= 500;

-- in  ������ : ��ȸ ����� �Ǵ� ���� ����
-- �л� �� 101 �а�, 201�а� �л��� �̸�, �μ��ڵ�, �г� ���

SELECT NAME, STUDNO, DEPTNO1, GRADE FROM STUDENT
WHERE DEPTNO1 in (101,201);

-- 101, 201�а� �л� �� Ű�� 170�̻� 180������ �л���
-- �й� �̸� ������ Ű �а��ڵ� ��ȸ

SELECT STUDNO, NAME, WEIGHT, HEIGHT FROM STUDENT
WHERE DEPTNO1 IN (101, 201) AND HEIGHT BETWEEN 170 AND 180;


-- LIKE ������
-- % : ������ ���� 0�� �̻�
-- _ : ������ ���� 1��

-- �л� �� �̸��� '��' ���ڸ� ���� �л��� �̸��� �μ��ڵ� ��ȸ�ϱ�

SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '%��%';

-- �л��� ���� �达�� �л��� �̸��� �μ��ڵ� ��ȸ�ϱ�

SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '��%';

-- �̸��� ������ �л� ��ȸ '����� �ΰ�'
SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '__';

-- NOT LIKE ������
-- �л� �� ���� ���� �ƴ� �л��� �й�, �̸�, �а��ڵ� ��ȸ�ϱ�

SELECT STUDNO, NAME, DEPTNO1 FROM STUDENT
WHERE NAME NOT LIKE '��%';

-- NOT IN ������
-- ������̺��� �μ��ڵ尡 10, 30 �� �ƴ� �μ��� �ٹ��ϴ� ����� �̸�, �μ��ڵ� ��ȸ�ϱ�

SELECT ENAME, DEPTNO FROM EMP
WHERE DEPTNO NOT IN (10,30);

-- NULL : ���� ����. �񱳴��ƴ�, �����󵵾ƴ�
-- ������ �󿩱��� ���� ������ ������ȣ, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE bonus IS NULL;

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE BONUS IS NOT NULL;

--������ȣ, �̸�, �޿��� �󿩱�, �հ�(�޿�+�󿩱�) ����ϱ�

SELECT PROFNO, NAME, PAY, BONUS, PAY+BONUS AS �հ� FROM PROFESSOR;

/* ORDER BY : �����ϱ�    SELECT ���� ������ �ۼ�

   SELECT �÷��� || * FROM  ���̺��
   WHERE ���ǹ� : ���ڵ� ���� ����
   GROUP BY �÷��� 
   HAVING ���ǹ�
   ORDER BY �÷��� [ASC|DESC] :  ASC �������� (��������),   DESC ��������
*/

-- 1�г� �л��� �̸�, Ű�� ��ȸ�ϱ� , Ű�� ������

SELECT NAME, HEIGHT FROM STUDENT
WHERE GRADE = 1
ORDER BY HEIGHT;

-- �л��� �̸�, Ű, ������, �г� ��ȸ

-- �г� �� Ű�� ū �� ������ ������

SELECT NAME, HEIGHT, WEIGHT, GRADE FROM STUDENT
ORDER BY GRADE, HEIGHT DESC, WEIGHT;

SELECT NAME, HEIGHT, WEIGHT, GRADE FROM STUDENT
ORDER BY 4, 2 DESC, 3;            /* ��ȸ�Ǵ� �÷� ������ ���ڷ� ǥ������ ALIAS�� ����*/

-- ������ �޿� 10% �λ�
-- ������ȣ �����̸� �а��ڵ� �޿� ����޿�(10%�λ�) ��ȸ�ϱ�
-- �а��ڵ������ ����޿��� ��������

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS ����޿� FROM PROFESSOR
ORDER BY DEPTNO, ����޿� DESC;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS ����޿� FROM PROFESSOR
ORDER BY 3, 5 DESC;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS ����޿� FROM PROFESSOR
ORDER BY DEPTNO, PAY*1.1 DESC;
-- �л����̺��� ���������� �������� ���� �л��� �й� �̸� ����������ȣ �а��ڵ� ���
-- �а��ڵ� ������ ����

SELECT STUDNO, NAME, PROFNO, DEPTNO1 FROM STUDENT
WHERE PROFNO IS NULL
ORDER BY DEPTNO1;

/*
  ������ UNION, UNION ALL
  UNION : ������, �ߺ����� ����
  UNION ALL : ������, �ΰ��� ���� ��� ���Ͽ� ��� , �ߺ� ������ ��ȸ, �ΰ� ������ ��� �÷��� ������ �����ؾ� ����
*/
-- ������ �󿩱� �ִ� ���� �޿��հ� �޿�+�󿩱�
-- �󿩱��� ���� ���� �޿��հ�� ��ȸ�ϱ�
-- ������ ������ȣ �̸� �μ��ڵ� �޿� �޿��հ踦 ����ϱ�
-- �μ��ڵ� ������ �����ϱ�

SELECT PROFNO, NAME, DEPTNO, PAY, PAY+BONUS FROM PROFESSOR
WHERE BONUS IS NOT NULL
UNION ALL
SELECT PROFNO, NAME, DEPTNO, PAY, PAY FROM PROFESSOR
WHERE BONUS IS NULL
ORDER BY DEPTNO;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY+NVL(BONUS,0) FROM PROFESSOR
ORDER BY DEPTNO;


-- ���� 
-- 101�а� �л��� �й� �̸� �а���ȣ1
-- 101�а� ������ ������ȣ, �̸�, �а���ȣ�� ����ϱ�

SELECT STUDNO AS "������ȣ", NAME �̸�, DEPTNO1 �а���ȣ, '�л�' ���� FROM STUDENT
WHERE DEPTNO1 = 101
UNION
SELECT PROFNO, NAME, DEPTNO, '����' FROM PROFESSOR
WHERE DEPTNO = 101;

/*
  ������ �Լ�
  - �����Լ� : �빮��OR�ҹ��ڷ� ����
  - �����Լ� : �ݿø�, ����
  - ��¥�Լ� : ��¥����
  - ��ȯ�Լ� : �������� ��ȯ, ����->��¥ ����->����
  - �Ϲ��Լ� : NULL�� ó�� NVL, �����Լ�
  
*/

-- �����Լ�
-- ��ҹ��� ��ȯ

SELECT NAME, ID, INITCAP(ID), UPPER(ID), LOWER(ID) FROM STUDENT
WHERE DEPTNO1 = 101;


SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE LOWER(ENAME) = 'smith';
-- ����
-- 1. �л� �� id���� M���ڸ� ������ �ִ� �л��� �̸�, id, �а���ȣ1�� ��ȸ�ϱ�
-- �� id�� ������ ��ҹ��� ������� ��ȸ�Ǿ����

SELECT NAME, ID, DEPTNO1 FROM STUDENT
WHERE upper(ID) LIKE '%M%';

SELECT NAME, ID, DEPTNO1 FROM STUDENT
WHERE ID LIKE '%M%' OR ID LIKE '%m%';

-- ���ڿ� ����
-- length   : ���ڿ�����
-- lengthb  : �����ϱ� ���� �ʿ��� ����Ʈ ��.
--  �ѱ� ����� 3����Ʈ �ʿ� -> �ý��� ���� �ٸ�
select name, length(name), lengthb(name), id, length(id), lengthb(id) from student;

-- dual ���̺� : �������̺�   //����Ŭ���� �ǹ̤ä��� ���̺�� ����� �� �ֵ��� ������ ���̺�
select lengthb('ȫ�浿') from dual;

-- substr : �κ� ���ڿ� �Լ�

select substr('�ȳ� ���� ȫ�浿�̾�', 7, 3) from dual;
-- �л� �� ������ 3���� �л��� �̸�, ������� ��ȸ�ϱ�

select name, jumin from student
where substr(jumin,3,2) = '03';

-- �л��� �̸�, ������� ��ȸ�ϱ�
-- ������ ���� �������� �����Ͽ� ����ϱ�
-- SUBSTR('9608191234567', 1,6) : 960819

select name, substr(jumin,1,6) ������� from student
order by substr(jumin,3,2);

select name, substr(jumin,1,6) ������� from student
order by substr(jumin, -13, 2);     --�ڿ��� 13��° ORACLE��

select name, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') from student
WHERE SUBSTR(TO_CHAR(BIRTHDAY, 'YYYY-MM-DD'),6,2) = '03';

-- instr : ���ڿ�(�÷���)���� �ش繮���� ��ġ�� ����
-- instr('string', 's') index�� 1���� ����
-- instr('string', 's', 1, 2) 1��°��ġ���� ã�� 2��° s ���
select instr('A*B*C', '*') from dual;

select instr('A*B*C*', '*', 3, 2) from dual;

select instr('A*B*C*', '*', -1, 3) from dual;

select INSTRB('CORPORATE FLOOR','OR',5,2) from dual;

-- �л� ���̺���, �̸�, ��ȭ��ȣtel, tel �÷��� ')' ������ ��ġ ����ϱ�

select name, instr(tel, ')')from student;

-- ����
-- �л��� �̸�, ��ȭ��ȣ�� ������ȣ�� ����ϱ�

select name, tel, substr(tel,1,instr(tel, ')')-1) as ������ȣ from student;

-- �����߰��Լ� lpad, rpad
-- lpad : ���ʿ� ���ڸ� �߰�
-- rpad : �����ʿ� ���ڸ� �߰�
-- LPAD(COL, �� �ڸ���, ä�﹮��)

SELECT NAME, GRADE, LPAD(ID, 10, '&') FROM STUDENT;

-- ���� �����ϱ�LTRIM, : LTRIM(COL, ������ ����) -> ������ ���ڰ� �����Ǹ� ����  RTRIM, TRIM
-- LTRIM ���� �������� ����, RTRIM ������ �������� ����, TRIM ���� ���� ����

SELECT NAME, HPAGE, LTRIM(HPAGE, 'http://') URL FROM PROFESSOR
WHERE HPAGE IS NOT NULL;

SELECT LTRIM('   AAA B  ','   A') A FROM DUAL;
SELECT RTRIM('   AAA   ') A FROM DUAL;
SELECT TRIM('   AAA   ') A FROM DUAL;

-- ���ڿ� ġȯ�Լ� : replace
-- replace(�÷���, '����1, '����2') : �÷��� ���� ����1�� ����2�� ġȯ

-- ����. �л����̺��� �л��� �̸��� ù�ڸ� #���ڷ� �����Ͽ�

SELECT REPLACE(NAME, SUBSTR(NAME,1,1), '#' )  �̸�, GRADE FROM STUDENT;
