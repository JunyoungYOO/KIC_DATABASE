--1. 2022�� 8�� 11�� ���� 2023�� 1�� 16�ϱ��� 
--�������� �ݿø��ؼ� �Ҽ������� ���ڸ��� ����ϱ�

SELECT ROUND(MONTHS_BETWEEN('2023-01-16', '2022-08-11'), 1) ���� FROM DUAL;

--2. �������̺��� ������� �Ի���, ���翬�� 3%�λ� �� ������ ����ϱ�
--  �� ������ pay * 12�� �ϰ�, �λ��� ������ �Ҽ��� ���� ������
SELECT NAME,
       HIREDATE,
       PAY*12 ���翬��,
       TRUNC(PAY*12*1.03) "3%�λ��� ����" FROM PROFESSOR;

--3. EMP ���̺��� ����̸�, �Ի���, �ٹ�������, ������� �ٹ��ϼ��� ����ϱ�
--     �ٹ��������� �Ҽ������� 1�ڸ��� �ݿø��Ͽ� ����ϰ�, �ٹ��ϼ��� �����Ͽ� ������ ����ϱ�.
--     ��, �ٹ��ϼ��� ���� ��� ������ �����Ͽ� ����ϱ�

SELECT ENAME,
       HIREDATE,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE), 1) �ٹ�������,
       TRUNC(SYSDATE-HIREDATE) �ٹ��ϼ� FROM EMP
ORDER BY �ٹ��ϼ� DESC;

--4. EMP ���̺��� 10�� �μ����� ��������� �ٹ� ������ ����Ͽ�  ����Ͽ���.
--    �ٹ������� �ݿø��Ͽ� ������ ����ϱ�

SELECT * FROM EMP;

SELECT ENAME, DEPTNO,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) �ٹ����� FROM EMP
WHERE DEPTNO = 10;

--5.  �����̸�, �Ի���, �Ի�⵵�� �ް�������, ������ �ް������� ����ϱ�
--    �ް������� : �Ի���� ������ ���� 


SELECT NAME,
       HIREDATE,
       LAST_DAY(HIREDATE),
       LAST_DAY(TO_DATE(CONCAT(TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(HIREDATE, 'MMDD')))) �����ް� FROM PROFESSOR;
/*
SELECT NAME, HIREDATE, LAST_DAY(ADD_MONTHS(HIREDATE, (TRUNC((SYSDATE-HIREDATE)/365)*12))) FROM PROFESSOR;
SELECT NAME, HIREDATE, LAST_DAY(HIREDATE) "�Ի��������",  LAST_DAY(ADD_MONTHS(HIREDATE, (ROUND((SYSDATE-HIREDATE)/365)*12))) �����ް������� FROM PROFESSOR;
*/

SELECT NAME, hiredate, last_day(hiredate) �Ի�⵵�ް�������,
             last_day(to_date(to_char(sysdate,'yyyy') || to_char(hiredate,'mmdd'),'yyyymmdd'))  "�������ް�������" 
FROM professor;

--6. �������̺��� 2000�� ������ �Ի��� ������� �Ի���, ���翬��
--  10%�λ� �� ������ ����ϱ�
--  �� ������ pay * 12�� �ϰ�, �λ��� ������ �Ҽ��� ���� ������
--  ����, �λ��Ŀ��� ��½� õ������ �����Ͽ� ,�� �־� ����ϱ�

SELECT NAME, HIREDATE, TO_CHAR(PAY*12, '99,999') ����, TO_CHAR(FLOOR(PAY*12*1.1), '99,999') �λ��Ŀ��� FROM PROFESSOR
WHERE TO_CHAR(HIREDATE,'YYYY') < 2000;

--7. ������ �̸�, �μ���ȣ��, ������ �̸��� �赵���̸� '���±����ĺ�' ����ϰ�,
--   �赵�� ������ �ƴϸ� '�⸶����' ����ϱ�

SELECT NAME, DEPTNO, DECODE(NAME, '�赵��', '���±����ĺ�', '�⸶����') �⸶���� FROM PROFESSOR;

--8. �л��� �̸���, ü�� ,Ű ,�񸸵��� ����ϱ�
--  �񸸵� :( (����ü�� - ǥ��ü��) / ǥ��ü�� ) * 100
--  ǥ��ü�� : (Ű - 100) * 0.9
--  �񸸵� 10�̸� �� '����'
--        10 ~ 20�̸�  '��ü��'
--        20�̻� '��' ���� ����ϱ�

SELECT NAME, WEIGHT ü��, HEIGHT Ű, ROUND(((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100) BMI,
  CASE 
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 < 10 THEN '����'
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 >=10 AND ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 < 20 THEN '��ü��'
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 >=20 THEN '��' END �񸸵�
FROM STUDENT;


--9. �л��� 3�� ������ �з��ϱ� ���� �й��� 3���� ������ 
--   �������� 0�̸� 'A��', 1�̸� 'B��', 2�̸� 'C��'���� 
--   �з��Ͽ� �л� ��ȣ, �̸�, �а� ��ȣ, �� �̸��� ����Ͽ���

SELECT STUDNO, NAME, DEPTNO1, MOD(STUDNO,3),DECODE(MOD(STUDNO,3), '0', 'A��', '1', 'B��', '2', 'C��') ���̸� FROM STUDENT;

SELECT STUDNO, NAME, DEPTNO1,
       CASE MOD(STUDNO,3)
          WHEN 0 THEN 'A��'
          WHEN 1 THEN 'B��'
          WHEN 2 THEN 'C��' END ���̸� FROM STUDENT;

--10. �л��� �̸�, ���� ���� ��ȣ�� ����Ͽ���. 
--   ��, ���� ������ �������� ���� �л��� �������� ��ȣ�� 
--   0000���� ����Ͽ���

SELECT NAME, NVL(TO_CHAR(PROFNO), '0000') FROM STUDENT;

-- ����� �ڵ�
SELECT NAME, TO_CHAR(NVL(PROFNO, 0), '0999') FROM STUDENT;

--11.�ֹε�Ϲ�ȣ�� �������� �л����� �̸�, ����� ���̵�,
--   ��������� ����Ͽ���. 
--   ��, ����� ���̵�� �ҹ��ڷ�, ��������� '1985/02/01' �������� ����Ͽ���

SELECT NAME, LOWER(ID), TO_CHAR(BIRTHDAY, 'YYYY/MM/DD') FROM STUDENT;

SELECT NAME, LOWER(ID), TO_CHAR(TO_DATE(SUBSTR(JUMIN,1,6)), 'YYYY/MM/DD') FROM STUDENT;



--12. �л� ���̺��� �̸�, Ű, Ű�� ������ ���� A, B, C ,D����� ����ϱ�
--    160 �̸� : A���
--    160 ~ 169���� : B���
--    170 ~ 179���� : C���
--    180�̻�       : D���

SELECT NAME, HEIGHT, 
  CASE
    WHEN HEIGHT < 160 THEN 'A���'
    WHEN HEIGHT >= 160 AND HEIGHT <170 THEN 'B���'
    WHEN HEIGHT >= 170 AND HEIGHT <180 THEN 'C���'
    WHEN HEIGHT >= 180 THEN 'D���' END Ű���
FROM STUDENT;
