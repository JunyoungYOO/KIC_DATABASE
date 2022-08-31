/*
1. �а����� ��� �����Կ� �л� ���� ����ϵ� ��� ��������  ������������ �����Ͽ���.


[���]
  �а��ڵ� ��ո�����     �л���
---------- ---------- ----------
       201         67          6
       102      64.25          4
       202       62.5          2
       101         60          4
       301         60          2
       103       51.5          2
*/

SELECT DEPTNO1 �а��ڵ�, AVG(WEIGHT) ��ո�����, COUNT(*) �л��� FROM STUDENT
GROUP BY DEPTNO1
ORDER BY ��ո����� DESC;


/*
2.  �л����̺��� birthday�� �������� ������ �¾ �ο��� ����ϱ�

[���]

   �հ�      1��   2��        3��     4��      5��     6��       7��      8��     9��      10��      11��      12��
------- ------- -------- -------- -------- -------- -------- -------- -------- -------- --------- --------- ---------
     20        3     3       2       2         0        1        0        2        2       2         1        2
*/

SELECT * FROM STUDENT;

SELECT COUNT(*),
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '01', '1', '0'))) "1��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '02', '1', '0'))) "2��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '03', '1', '0'))) "3��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '04', '1', '0'))) "4��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '05', '1', '0'))) "5��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '06', '1', '0'))) "6��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '07', '1', '0'))) "7��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '08', '1', '0'))) "8��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '09', '1', '0'))) "9��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '10', '1', '0'))) "10��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '11', '1', '0'))) "11��",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '12', '1', '0'))) "12��"       
FROM STUDENT;
       
 
/*
3. �а��� ���� ���� 2�� ������ �а� ��ȣ, ���� ����  ����Ͽ���
[���]
    DEPTNO   COUNT(*)
---------- ----------
     201        2
     301        2
     202        2
     203        1
*/

SELECT DEPTNO, COUNT(*) FROM PROFESSOR
GROUP BY DEPTNO
HAVING COUNT(*) <= 2;

/*
4.���޺��� ��� �޿��� 320���� ũ�� '���', �۰ų� ������ '����'�� ����Ͽ���

[���]
POSITION                                 �޿�
---------------------------------------- ------------
������                                   ���
���Ӱ���                                 ����
������                                   ���
*/
SELECT POSITION,
  CASE 
    WHEN AVG(PAY) > 320 THEN '���'
    WHEN AVG(PAY) <= 320 THEN '����' END �޿� FROM PROFESSOR
GROUP BY POSITION;

/* 
5. ���� �μ��� �ִ��ο��� ���� �μ��� �ο����� �ּ��ο��� ���� �μ��� �ο��� ����ϱ�

[���]
�ִ��ο� �ּ��ο�
---------- ----------
   3            1
*/
SELECT MAX(COUNT(DEPTNO)) �ִ��ο�, MIN(COUNT(DEPTNO)) �ּ��ο� FROM PROFESSOR
GROUP BY DEPTNO;

/*
6. �������̺��� ��� �޿��� 350�̻��� �μ���   �μ��ڵ�, ��ձ޿�, �޿��հ踦 ����ϱ�

[���]
 �μ��ڵ�   ��ձ޿�   �޿��հ�
---------- ---------- ----------
       102 363.333333       1090
       201        450        900
       101        400       1200
       203        500        500
       103 383.333333       1150
*/

select deptno, avg(pay), sum(pay) from professor
group by deptno
having avg(pay) >= 350;


-- 7. 4�г� �л��� �̸� �а���ȣ, �а��̸� ����ϱ�

select s.name �̸�, s.deptno1 �а���ȣ, d.dname �а��̸� from student s join department d on s.deptno1 = d.deptno
where grade = 4;

-- 8. ������ �л��� �̸�, �а��ڵ�1,�а��̸�,�а���ġ ����ϱ�

select s.name, s.deptno1, d.dname, d.build from student s, department d
where s.name='������' and s.deptno1=d.deptno;

-- 9. �й��� �л� �̸��� �Ҽ��а��̸��� �л� �̸������� �����Ͽ� ���

select s.studno �й�, s.name �л��̸�, d.dname �Ҽ��а� from student s join department d on s.deptno1 = d.deptno
order by s.name;

-- 10. �������� ���� �̸��� ���� �л� ���� ����ϱ�.

select p.name �����̸�, count(s.profno) �����л��� from student s join professor p on s.profno = p.profno
group by p.name
order by p.name;


-- 11. ���� �达�� �л����� �̸�, �а��̸� �а���ġ ����ϱ�

SELECT S.NAME, D.DNAME, D.BUILD FROM STUDENT S, DEPARTMENT D
WHERE S.NAME LIKE '��%' AND S.DEPTNO1 = D.DEPTNO;


SELECT S.NAME, D.DNAME, D.BUILD FROM STUDENT S JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO
WHERE SUBSTR(S.NAME,1,1) = '��';







