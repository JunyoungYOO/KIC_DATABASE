/*
����

1. LIKE ������

2. IN, NOT IN

3. IS NULL, IS NOT NULL

4. ORDER BY
   COLUMM, ALIAS, SELECT ���� ������ ��ȣ�� ��ȸ����
   EX)  SELECT STUDNO, NAME FROM STUDENT
        1. ORDER BY NAME
        2. ORDER BY �̸�
        3. ORDER BY 2

5. UNION ������, �ߺ�����, ����
   UNION ALL ������, �ΰ��� SELECT�� ����� ��ħ(�ߺ�����)

6. INITCAP ù���� �빮�ڷ�
   UPPER ���� �빮��
   LOWER ���� �ҹ���
   LENGTH ���ڿ��� ����
   LENGTH ���ڿ� ����Ʈ
   SUBSTR �κ� ���ڿ� �ڸ���
          SUBSTR(�÷���or���ڿ� , �ε���, ������ ����)  : �ε��� ��ġ ���ں��� ������ ���� ���� ���ڿ� ���
          
          index = -1�̸� �ޱ��ں���
          ������ ���� �����̸� �ε������� ���ڿ� ���
          
   instr �־��� ������ ��ġ ����
   instr(�÷���or���ڿ�, ã�� ���ڿ�,�����ε���, n��°)   �÷���or���ڿ����� ã�� ���ڿ��� �����ε������� �˻��ϰ� n��° ���ڿ��� ù���� �ε����� ���
   
   
   LPAD, RPAD :��/�����ʿ� �����߰�
   LPAD(��OR��, ��ü����, ä�� ����)
   LTRIM RTRIM: ���� ������ �������� EX) LTRIM(���ڿ�OR�÷���, '������ ���ڿ�')
   TRIM ���� ���� ����    EX) TRIM(���ڿ�OR�÷���)
   
   REPLACE :���� ġȯ
   REPLACE(�÷���OR���ڿ�, ���ڿ�, ġȯ���ڿ�)

*/

-- ���� �����Լ�

--ROUND:�ݿø��Լ�
--ROUND(�÷���OR����, �Ҽ������� �ڸ���)

SELECT round(12.5123) r1, round(12.5123, 0) r2, round(12.5523,1) r3, round(12.5123,2) r4, round(12.5123,-1) r5 from dual;


-- TRUNC�Լ�: ���� �Լ�
-- TRUNC(�÷�||����, ǥ�õǴ� �Ҽ������� �ڸ���)

SELECT TRUNC(12.5123) r1, TRUNC(12.5123, 0) r2, TRUNC(12.5123,1) r3, TRUNC(12.5123,2) r4, TRUNC(12.5123,-1) r5 from dual;

-- MOD �Լ�: ������ �Լ�

SELECT MOD(12,5) r1, MOD(13,9) r2 from dual;

-- CEIL : ����� ū ����  FLOOR(����� ���� ����)
SELECT CEIL(12.345) r1, FLOOR(12.345) r2, CEIL(-12.345) r3, FLOOR(-12.345) r4 from dual;

-- power : �����Լ�   power(������ ��, ������) power(2,5) = 2^5 = 32

select power(12, 2) r1 from dual;

-- abs : ���밪

select abs(-14) r1 from dual;

-- sign : ��ȣ ����� 1 ������ -1 0�̸� 0

-- ����

-- ������ �޿��� 15%�λ��Ͽ� ������ ����ϱ�
-- ���� �̸�, ����޿�, �ݿø��� ����޿�, �������� ����޿� ���

SELECT * FROM PROFESSOR;

SELECT NAME, PAY, PAY*1.15, ROUND(PAY*1.15), TRUNC(PAY*1.15) FROM PROFESSOR;

-- ��¥ ���� �Լ�
-- SYSDATE: ���� ��¥�� ����, �����

SELECT SYSDATE FROM DUAL;

-- months_between : �γ�¥������ ������ ����, �Ҽ��� ǥ��
-- months_between(A,B) : A��¥ - B��¥
SELECT MONTHS_BETWEEN(sysdate, '20221230') from dual;
SELECT MONTHS_BETWEEN(sysdate, '2022/12/30') from dual;
SELECT MONTHS_BETWEEN(sysdate, '2022-12-30') from dual;

-- �л��� �̸�, ����(BIRTHDAY), ������, ���̸� ����ϱ�
-- ���� : ���糯¥���� ���ϱ����� �������� �ݿø��Ͽ� �������
-- ���� : ����/12������ �������� ���

SELECT * FROM STUDENT;

SELECT NAME, BIRTHDAY, ROUND(MONTHS_BETWEEN(SYSDATE, BIRTHDAY)) ������, TRUNC( MONTHS_BETWEEN(SYSDATE, BIRTHDAY)/12)  ���� FROM STUDENT;

SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '1996-08-19')/12) FROM DUAL;

-- ADD_MONTHS : �������� ���� ���� ��¥ ����

--3������ 3������
SELECT ADD_MONTHS(SYSDATE, 3) "3������", ADD_MONTHS(SYSDATE, -3) "3������" FROM DUAL;

--3���� 3����
SELECT SYSDATE, SYSDATE-3, SYSDATE+3 FROM DUAL;

-- ��¥ - ��¥ : 
SELECT ENAME, HIREDATE, SYSDATE - HIREDATE FROM EMP;

SELECT SYSDATE, TO_DATE('22-08-19')-SYSDATE FROM EMP;

-- ROUND, TRUNC ��¥ ����

SELECT ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL;

-- NEXT_DAY �Լ� : ���� ��¥ ������ ������ ���Ͽ� �ش��ϴ� ��¥ ����
-- �� �� ȭ �� �� �� ��
-- 1  2  3  4 5  6  7
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '��'), NEXT_DAY(SYSDATE,2) FROM DUAL;

-- LAST_DAY : �ش���� ������ ��¥ ����

SELECT LAST_DAY('20/02/01') FROM  DUAL;

-- ROUND, TRUNC, CEIL, FLOOR, 

-- ����

--1. ������̺��� ����� �̸�, ����, �Ի���, �ٹ��ϼ� ����ϱ�
-- �ٹ��ϼ� ���� TRUNC

SELECT ENAME, JOB, HIREDATE �Ի���, TRUNC(SYSDATE-HIREDATE) �ٹ��ϼ� FROM EMP;

--2. ������̺��� �Ի��� 3������ �����Ⱓ�̶�� �����Ҷ� ���� ������ ����ϱ�

SELECT ENAME, JOB, HIREDATE �Ի���, ADD_MONTHS(HIREDATE, 3) ���������� FROM EMP;

-- 90�� ���İ� ���� ������
SELECT ENAME, JOB, HIREDATE �Ի���, HIREDATE+90 ���������� FROM EMP;

--3. ������̺��� �̸�, �Ի���, �ް������� ����ϱ�
-- �ް� ������: �Ի���� ������ ����

SELECT ENAME, HIREDATE �Ի���, LAST_DAY(HIREDATE) "�ް� ������" FROM EMP;

-- ����ȯ �Լ�
-- ����������ȯ : ����Ŭ�� �ڵ����� ����ȯ

SELECT 1 + '1' FROM DUAL;   --ORALCE�� �������
-- 'A'+1�� ����

-- TO_CHAR() : ���ڳ� ��¥���� ���ڿ��� ����
-- ��¥�� ���ڿ��� ����
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT 1+TO_CHAR('123') FROM DUAL;

/*
   ��¥ ���� ����
   yyyy : ������ 4�ڸ��� ǥ��.
   yy   : ������ 2�ڸ��� ǥ��.
   rrrr : 2000�� ���Ŀ� Y2K���׷� ���� �߰��� ���� 4�ڸ��� ǥ��.
   rr   : 2000�� ���Ŀ� Y2K���׷� ���� �߰��� ���� 2�ڸ��� ǥ��.
   year : �������� �⵵ ǥ��
   
   mm    : ���� 2�ڸ��� ǥ��
   mon   : ����ǥ�� �Ҷ� ����ǥ��. FEB  �ѱ��� �������
   month : ����ǥ�� �Ҷ� ��ü �� ǥ��. �ѱ��� �������
   
   dd    : ���� 2�ڷ� ǥ��
   day   : ���� ǥ��. 
   ddth  : ���° ��¥���� ǥ��
   
   �ð�
   hh   : �Ϸ� 12�ð�.
   hh24 : �Ϸ� 24�ð�
   mi   : ��
   ss   : ��
   am   : ����/����
*/

SELECT SYSDATE, TO_CHAR(SYSDATE, 'RRRR-MM-DD HH:MI:SS AM DAY') FROM DUAL;

-- �л��� �̸��� ������ YYYY-MM-DD ����

SELECT NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD DAY') ���� FROM STUDENT;


select to_char(sysdate, 'yyyy') �⵵1,  to_char(sysdate, 'rrrr') �⵵2,
       to_char(sysdate, 'yy') �⵵3,    to_char(sysdate, 'year') �⵵4,
       to_char(sysdate, 'rr') �⵵5,
       to_char(sysdate, 'mm') ��1,
       to_char(sysdate, 'mon') ��2, --����ǥ��
       to_char(sysdate, 'month') ��3, 
       to_char(sysdate, 'dd') ��1, -- ����
       to_char(sysdate, 'day') ��2, --����
       to_char(sysdate, 'ddth') ��3, --
       to_char(sysdate, 'hh') �ð�1, -- 1 ~ 12
       to_char(sysdate, 'hh24') �ð�2, -- 0 ~ 23
       to_char(sysdate, 'mi') ��1,   -- ��
       to_char(sysdate, 'ss') ��1,   -- ��
       to_char(sysdate, 'am') AM     -- ����,����
    from dual;


-- ���� 
-- ���� 2022-08-16 12:03:%5 ������

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY') FROM DUAL;


SELECT TO_CHAR(SYSDATE, 'YY-MM-DD HH:MI:SS DAY') FROM DUAL;

-- TO_CHAR(����, '���Ĺ���') : ���ڸ� ����ȭ�� ���ڿ� ���

select to_char(1234.56,'9999999') ����1, --���� 7�ڸ�. �ݿø�
       to_char(1234.56,'0999999') ����2, --���� 7�ڸ� ���ڸ� 0���� ä��
       to_char(12.3456,'$9999.99') ����3, -- $ǥ��, �Ҽ������� 2�ڸ����      
       to_char(12.3456,'9999.99') ����4,  -- �Ҽ������� 2�ڸ����            
       to_char(1234.3456,'9,999.99') ����5 -- ���ڸ����� , ǥ���ϰ� �Ҽ������� 2�ڸ� ���
from dual;


-- ������ �̸�, ����޿�, ���� ����ϱ�
-- ������ �޿�*12 ��½� ���ڸ�����, ǥ���ϱ�

SELECT NAME, PAY, TO_CHAR(PAY*12, '99,999') FROM PROFESSOR;


-- TO_NUMBER

SELECT TO_NUMBER('12') + 10 FROM DUAL;

-- TO_DATE : ���� -> ��¥��

SELECT TO_DATE('20220818', 'yyyymmdd') FROM DUAL;

-- '20220817' ��¥�� 2022-08-17 ������

SELECT TO_CHAR(TO_DATE('20220817', 'yyyymmdd'), 'yyyy-mm-dd DAY') FROM DUAL;


-- ����
-- �������̺� �Ի��� 2���� �� ������ 1���� ���� �Ի��Ϸ� �Ѵ�.
-- ������ �̸� �Ի���, �����Ի��� ���
-- �� �����Ի����� ���ϵ� ǥ���ϱ�
SELECT NAME, HIREDATE, TO_CHAR(ADD_MONTHS(HIREDATE, 3) - (TO_NUMBER(SUBSTR(HIREDATE,7,2)) - 1), 'YYYY-MM-DD DAY') �����Ի���
FROM PROFESSOR;


SELECT NAME, HIREDATE, TO_CHAR(LAST_DAY(ADD_MONTHS(HIREDATE, 2)) + 1, 'YYYY-MM-DD DAY') �����Ի���
FROM PROFESSOR;

-- �Ϲ��Լ�
-- nvl : null ���� �ٸ� ������ ��ȯ�ϴ� �Լ�   NVL(�÷�, �ٸ� ��) 
-- ������ �̸�, ����(�޿�*12+���ʽ�) ����ϱ�

SELECT NAME, PAY*12+BONUS ���� FROM PROFESSOR
WHERE BONUS IS NOT NULL
UNION
SELECT NAME, PAY*12 ���� FROM PROFESSOR
WHERE BONUS IS NULL;
--  NVL(BONUS, 0) : BONUS �÷��� ���� NULL�� ��� 0���� ���� ġȯ
--                  NULL�� �ƴ� ��� BONUS �� �״��
SELECT NAME, PAY*12+NVL(BONUS,0) ���� FROM PROFESSOR;

-- ����
-- 1. �л��� �̸��� ����������ȣ(PROFNO)

SELECT NAME, NVL(PROFNO,9999) FROM STUDENT;

-- 2. �μ� ���̺� (department)���� �μ��ڵ�� �μ���

SELECT DEPTNO, DNAME, NVL(BUILD, '�ǹ�����') FROM DEPARTMENT;

-- ������ �̸�, �޿�, ���ʽ�, ������ ���
-- ������ : ���ʽ��� �ִ� ��� ���ʽ� *3
-- 

SELECT NAME, PAY, NVL(BONUS, 0), NVL(BONUS*3, 50) FROM PROFESSOR;

-- �����Լ�: DECODE
-- DECODE(�÷���, ��, ��, ����)
-- ���� ���̺��� �����̸�, �а���ȣ, �а��� ����ϱ�
SELECT * FROM PROFESSOR;

SELECT NAME, DEPTNO, DECODE(DEPTNO, 101, '��ǻ�Ͱ���', '��Ÿ�а�') �а��� FROM PROFESSOR;

-- 102�� ��� ��Ƽ�̵��
-- 201�� ��� ������
-- �� �ܴ� ��Ÿ

SELECT NAME, DEPTNO, DECODE(DEPTNO, 101, '��ǻ�Ͱ���', 102, '��Ƽ�̵���а�', 201, '������', '��Ÿ�а�') �а���  FROM PROFESSOR;

-- ����
-- 1. �л��� �ֹι�ȣ 7��° �ڸ��� 1, 3�� ���� ����, 2,4�� ���� ���ڷ� ����ϱ�
-- �л��� �̸�, �ֹι�ȣ, ���� ��ȸ�ϱ�

SELECT * FROM STUDENT;

SELECT NAME, JUMIN, DECODE(MOD(SUBSTR(JUMIN, 7,1), 2), '1' , '����', '0', '����') ���� FROM STUDENT;
SELECT NAME, JUMIN, DECODE(SUBSTR(JUMIN, 7,1), '1' , '����', '2', '����', '3', '����', '4', '����') ���� FROM STUDENT;


SELECT NAME, TEL, DECODE(SUBSTR(TEL, 1, INSTR(TEL, ')')-1), '02', '����', '051', '�λ�', '055', '���', '��Ÿ') ���� FROM STUDENT
ORDER BY ����;

-- CASE ���� : ���ǹ�. DECODE �Լ��� ���� ���, ���� ���� ����

SELECT NAME, TEL,
  CASE SUBSTR(TEL, 1, INSTR(TEL,')')-1)
    WHEN '02' THEN '����'
    WHEN '051' THEN '�λ�'
    WHEN '055' THEN '���'
    ELSE '��Ÿ' END ������
FROM STUDENT;


-- �л��� �ֹι�ȣ 7�ڸ��� 1,3�ΰ��� ����, 2,4�ΰ��� ���ڷ� ���

SELECT NAME, JUMIN,
  CASE SUBSTR(JUMIN,7,1)
    WHEN '1' THEN '����'
    WHEN '2' THEN '����'
    WHEN '3' THEN '����'
    WHEN '4' THEN '����' END ����
FROM STUDENT;

SELECT NAME, JUMIN, 
  CASE 
   WHEN SUBSTR(JUMIN,7,1) IN (1,3) THEN '����'
   WHEN SUBSTR(JUMIN,7,1) IN (2,4) THEN '����'
  END
  FROM STUDENT;

-- ����
-- �л��� ������ 1~3���� ��� 1�б�, 4~6�� 2�б�, 7~9�� 3�б�, 10~12�� 4�б� ����б�
-- �л��� �̸�, �ֹι�ȣ, ����б⸦ ���
-- �� ������ �ֹι�ȣ �������� �Ѵ�.

SELECT NAME, JUMIN,
  CASE 
    WHEN SUBSTR(JUMIN,3,2) IN ('01', '02', '03') THEN '1�б�'
    WHEN SUBSTR(JUMIN,3,2) IN ('04', '05', '06') THEN '2�б�'
    WHEN SUBSTR(JUMIN,3,2) IN ('07', '08', '09') THEN '3�б�'
    WHEN SUBSTR(JUMIN,3,2) IN ('10', '11', '12') THEN '4�б�' END ����б�
FROM STUDENT
ORDER BY 3;

--2. BIRTHDAY �������� ���

SELECT NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY,
  CASE 
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '01' AND '03' THEN '1�б�'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '04' AND '06' THEN '2�б�'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '07' AND '09' THEN '3�б�'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '10' AND '12' THEN '4�б�' END ����б�
FROM STUDENT;













