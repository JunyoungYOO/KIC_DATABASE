/* 20220816 ����
  trunc ����
  sysdate ���糯¥
  round �ݿ���
  add_months ��¥ ���� �߰������ڿ� ��¥ 
  months_between �� ��¥ ������ ����
  next_day(��¥,����) : ���� ���ƿ� �ش� ���� ��¥�� ����     ����: �� �� ȭ �� �� �� �� = 1 2 3 4 5 6 7
  last_day : last_Day(��¥) ��¥�� ���� ������ ��¥ ����
  
  
  to_char ��¥->���ڿ� yyyy mm dd 
          ����->���ڿ� '99,999'�� ���ڸ����� ��ǥ
  to_number
  to_date
  
  nvl
  decode
  
  case when : when���� ���� ���� ����
  ex)
        case ����
          when ��1 then ����1
          when ��2 then ����2
          when ��3 then ����3
                  .
                  .
                  .
          when �� then ����N end alias from ���̺�  
*/
SELECT * FROM STUDENT;

SELECT GRADE, DEPTNO1, COUNT(*) FROM STUDENT
GROUP BY GRADE, DEPTNO1;

/*
  �׷��Լ�: ������ �Լ�
           �����࿡ ���� ������ ��ȸ�ϴ� �Լ�
  COUNT() : ���ڵ� �Ǽ�, NULL�� ����           

*/


-- ���� ���̺��� ���� ��ü�� �ο����� ������ ���ʽ� �޴� ������ �ο���

SELECT COUNT(*) ��ü�ο���, COUNT(BONUS) �޴��ο�, COUNT(*)-COUNT(BONUS) �����ο�  FROM PROFESSOR;

-- �л��� ��ü�ο����� ���������� ������ �ο���, ���������� ���� �ο���

SELECT * FROM STUDENT;
SELECT COUNT(*) ���ο�, COUNT(PROFNO) �������������ο�, COUNT(*)-COUNT(PROFNO) ���������������ο� FROM STUDENT;


-- �г⺰ �л��� �ο��� ��ȸ

SELECT GRADE, COUNT(*) FROM STUDENT
GROUP BY GRADE
ORDER BY GRADE;

-- �а�(DEPTNO1)�� �ο��� ��ȸ
-- GROUP BY: �÷��� ���� �������� ���ڵ带 �׷�ȭ
--           �׷��Լ��� �÷��� ������ȸ�ϱ� ���ؼ��� �ݵ�� ��ȸ��� �÷����� GROUP BY�� �����������

SELECT DEPTNO1, COUNT(*) FROM STUDENT
GROUP BY DEPTNO1
ORDER BY DEPTNO1;

-- �г⺰, ��ü�ο���, ���������� ������ �ο����� ��ȸ

SELECT GRADE || '�г�' �г�, COUNT(*) ��ü�ο���, COUNT(PROFNO) �������������ο� FROM STUDENT
GROUP BY GRADE
ORDER BY �г�;

-- ���� �� ����(POSITION)�� ������ �ο��� ��ȸ�ϱ�
-- �ο����� ���� ������ �����ϱ�

SELECT POSITION, COUNT(*) FROM PROFESSOR
GROUP BY POSITION
ORDER BY COUNT(*) DESC;

-- SUM �հ� , AVG ���
-- �����鿡�� ���޵Ǵ� ��ü �޿�, �޿� ��� �հ�
-- �޿������ ���� ������ ����

SELECT DEPTNO �а���ȣ, SUM(PAY) �޿������Ѿ�, ROUND(AVG(PAY)) �޿�������� FROM PROFESSOR
GROUP BY DEPTNO
ORDER BY 3 DESC;


-- �μ��� �ο���, �޿����, ���ʽ����

SELECT DEPTNO, COUNT(*) �ο���, AVG(PAY) �޿����, AVG(NVL(BONUS,0)) ���ʽ���� FROM PROFESSOR
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- ��� �׷��Լ��� NULL�� �����ϰ� ����

-- 1. �л��� �г⺰ Ű�� ������ ��հ�, �г⺰�� ����

SELECT GRADE, AVG(HEIGHT) Ű���, AVG(WEIGHT) ��������� FROM STUDENT
GROUP BY GRADE
ORDER BY GRADE;

-- 2. �����鿡 ���޵Ǵ� �μ��� ������ �հ� ��� ���ϱ�
-- ����: �޿�*12+���ʽ�
-- ���: �ݿø�, ���ڸ����� ��ǥ ǥ��

SELECT DEPTNO, TO_CHAR(SUM(PAY*12+NVL(BONUS,0)), '99,999') �����հ�, TO_CHAR(ROUND(AVG(PAY*12+NVL(BONUS,0))), '99,999') �������, COUNT(*) FROM PROFESSOR
GROUP BY DEPTNO;


-- MAX, MIN : �ִ밪 �ּҰ�

SELECT MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT;

-- �а��� ���Ű ūŰ ����Ű

SELECT DEPTNO1, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY DEPTNO1
ORDER BY DEPTNO1;

-- HAVING ����: �׷��Լ��� ���ʹ�
-- �г⺰ �л� �� Ű�� ���� ū �л��� Ű�� ���� �л��� Ű, ���Ű�� ��ȸ
-- ���Ű�� 170�̻��� �г�
SELECT GRADE, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY GRADE
HAVING AVG(HEIGHT) >= 170;

/*
  SELECT �÷� FROM ���̺�
  WHERE ���ǹ�
  
  --------------------------------
  
  SELECT �÷� FROM ���̺�
  GROUP BY �÷�  -> �÷��� �׷�ȭ�ϴ� ����
  HAVING ���� -> �׷��Լ��� ���ǹ�
  ORDER BY �÷�||����||�÷�����  -> �÷��� �������� ���� [ASC||DESC]
  
*/

-- 


SELECT CASE SUBSTR(JUMIN,7,1)  WHEN '1' THEN '����' WHEN '2' THEN '����' END ����, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY SUBSTR(JUMIN,7,1);

-- 1. �ֹι�ȣ�� �������� ���л��� �ִ�Ű, �ּ�Ű, ���Ű�� ����ϱ�
SELECT CASE SUBSTR(JUMIN,7,1)  
          WHEN '1' THEN '����'
          WHEN '2' THEN '����' END ����,
          MAX(HEIGHT), MIN(HEIGHT),
          AVG(HEIGHT)
FROM STUDENT
GROUP BY SUBSTR(JUMIN,7,1)
HAVING SUBSTR(JUMIN,7,1) = '2';

-- ���� Ű�� ���
SELECT MAX(HEIGHT),
       MIN(HEIGHT),
       AVG(HEIGHT)
FROM STUDENT
WHERE SUBSTR(JUMIN,7,1) = '2';

-- �ֹι�ȣ ���� ���� �ο�
SELECT SUBSTR(JUMIN,3,2)||'��' ��, COUNT(*) �ο� FROM GOGAK
GROUP BY SUBSTR(JUMIN,3,2)
ORDER BY ��;
-- �ֹι�ȣ ���� ���� �ο�
SELECT DECODE(SUBSTR(JUMIN,7,1), 1, '����', 2, '����') ����, COUNT(*) �ο� FROM GOGAK
GROUP BY SUBSTR(JUMIN,7,1)
ORDER BY ����;
-- �ΰ����� ��ȸ
SELECT SUBSTR(JUMIN,3,2)||'��' ��, DECODE(SUBSTR(JUMIN,7,1), 1, '����', 2, '����') ����, COUNT(*) �ο� FROM GOGAK
GROUP BY SUBSTR(JUMIN,3,2), SUBSTR(JUMIN,7,1)
ORDER BY ��;



-- STDDEV() ǥ������ �Լ�
-- VARIANCE() �л�

SELECT STDDEV(HEIGHT), STDDEV(WEIGHT), VARIANCE(HEIGHT), VARIANCE(WEIGHT) FROM STUDENT;

-- ��ȭ��ȣ�� ������ȣ �������� �л��� ����ϱ�

-- 1. �л����� ��ȭ��ȣ�� ������ȣ ��ȸ
SELECT SUBSTR(TEL,1,INSTR(TEL,')')-1) FROM STUDENT;

-- 2. �л����� ��ȭ��ȣ ���� ������ȣ ���� �ο� ���� ���ϱ�
SELECT SUBSTR(TEL,1,INSTR(TEL,')')-1), COUNT(*) FROM STUDENT
GROUP BY SUBSTR(TEL,1,INSTR(TEL,')')-1)
HAVING COUNT(*) >= 3;
--  ������ȣ���� �ο��� ��ȸ�ϱ�

SELECT COUNT(*) �հ�,
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '02', 1, 0 )) "����",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '031', 1, 0 )) "��⵵",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '051', 1, 0 )) "�λ�",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '053', 1, 0 )) "�뱸",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '055', 1, 0 )) "���"
FROM STUDENT;

-- ROWNUM : ���ڵ� ��ȸ ����
--          ORDER BY ���� ������ �̸� �ҷ����⋚���� ORDER BY�� ���� ROWNUM���� �ٲ��� ����
-- ROWID : ���ڵ带 ������ �� �ִ� ������ ID
--         ROWID�� �ٸ� ���� �ٸ� ���ڵ���

SELECT NAME, GRADE, ROWNUM, ROWID FROM STUDENT;
-- �л� ������ 5�Ǹ� ��ȸ�ϱ�
SELECT * FROM STUDENT WHERE ROWNUM < 6;
-- ROWNUM���� 6���� ��ȸ�ϱ� (�Ұ���)
-- ROWNUM�� 1�� ��ȸ�Ҷ� 1���� ����⋚���� WHERE���ǿ� ROWNUM>6�̶� ������ �ٴ� ���� ���� ��ȸ��ü�� �Ұ���

-- �л��̸�, �г�, ���ڵ������ ��ȸ�ϱ�

SELECT NAME, GRADE, ROWNUM FROM STUDENT
ORDER BY NAME;

-- �л��� �г⺰ �ο���, ���ڵ� ���� ��ȸ�ϱ�(�Ұ���)
SELECT GRADE, COUNT(*), ROWNUM FROM STUDENT
GROUP BY GRADE; /*��� ���� �������*/

-- ���ڵ� ������ �г⺰ �ο����� ���ڵ� ������ ��ġ�����ʾ� �г⺰�̶� �׷����� ����������

