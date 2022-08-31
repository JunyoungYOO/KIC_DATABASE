-- �� ���� : NON EQUI JOIN
--              �����÷��� ������ =�� �ƴ� ����

SELECT * FROM GOGAK;
SELECT * FROM GIFT;


-- �����̺�� ��ǰ���̺��� �̿��ؼ� ���� ����Ʈ�� �������ִ� ��ǰ�� ��¤���
SELECT G1.GNAME, G1.POINT, G2.GNAME FROM GOGAK G1, GIFT G2
WHERE G1.POINT BETWEEN G2.G_START AND G2.G_END;

select g1.gname, g1.point, g2.gname from gogak g1 join gift g2
on g1.point between g2.g_start and g2.g_end;

-- �л��� �̸�, ����, ���� ��ȸ�ϱ�
SELECT * FROM EXAM_01;
select * from hakjum;

select s.name �̸�, e.total ����,  h.grade ���� from student s, exam_01 e, hakjum h
where s.studno=e.studno and e.TOTAL between h.min_point and max_point;

select s.name, e.total, h.grade from student s join exam_01 e on s.studno=e.studno join hakjum h on e.total between h.min_point and h.max_point;

-- ���� �ڱ� ����Ʈ ���� ���� ����Ʈ ��ǰ �� �Ѱ����� ���� �Ҽ� �ִٰ� �Ҷ�
-- ��ǿ� �����Ÿ� ������ �� �ִ� ����, ����Ʈ , ��ǰ���� ��ȸ�ϱ�


SELECT * FROM GOGAK;
SELECT * FROM GIFT;

SELECT G1.GNAME ����, G1.POINT ����Ʈ, G2.GNAME FROM GOGAK G1, GIFT G2
WHERE G1.POINT >= G2.G_START AND G2.GNAME='��ǿ�������';


-- ���� �ڱ� ����Ʈ ���� ���� ����Ʈ ��ǰ �� �Ѱ����� ���� �� �� �ִٰ� �Ҷ�, ���� ������ �� �ִ� ��ǰ�� ���� ����ϱ�
-- ����� ���ð����� ��ǰ ����



select g1.gname ����, count(g2.gname) "���ð����� ��ǰ��" from gogak g1 join gift g2 on g1.point >= g2.g_start
group by g1.gname
order by 1;
--GROUP BY G1.GNAME;


-- OUTER JOIN
-- ���������� �������� ���� ���̺��� ���ڵ� ���� ��ȸ
-- �л��� �̸��� ���������� �̸��� ��ȸ
-- �� ���������� ���� �л��� ��ȸ�ϱ�
select s.name �л�, p.name �������� from student s, professor p
where s.profno(+) = p.profno;

select s.name �л�, p.name �������� from student s, professor p
where s.profno = p.profno(+);

  --outer join
  --1. left outer join : ���� ���̺��� ��� ���� ��ȸ.
    -- oracle ���
    select s.name �л�, p.name �������� from student s, professor p
    where s.profno = p.profno(+);  
    -- ansi ���
    select s.name �л�, p.name �������� from student s left outer join professor p on s.profno = p.profno;  
    
  --2. right outer join : ������ ���̺��� ��� ���� ��ȸ.
    -- oracle ���
    select s.name �л�, p.name �������� from student s, professor p
    where s.profno(+) = p.profno;  
    -- ansi ���
    select s.name �л�, p.name �������� from student s right outer join professor p on s.profno = p.profno;  
    
  --3. full outer join : ���� ���̺��� ��� ���� ��ȸ.
    -- oracle ���
    select s.name �л�, p.name �������� from student s, professor p
    where s.profno(+) = p.profno
    union
    select s.name �л�, p.name �������� from student s, professor p
    where s.profno = p.profno(+);  
    -- ansi ���
    select s.name �л�, p.name �������� from student s full outer join professor p on s.profno = p.profno;

-- �������� ���� �̸��� ���� �л����� ���
-- �����л� ���� ������ ���

select p.name, count(s.name) from professor p left outer join student s on p.profno = s.profno
group by p.name;

select p.name, count(s.name) from professor p, student s
where p.profno = s.profno(+)
group by p.name
order by p.name;


/*
  self join
*/

select * from dept2;

select d1.dname, d2.dname from dept2 d1 join dept2 d2 on d1.pdept = d2.dcode
order by 1;

-- dept2 ���̺��� �μ��ڵ� �μ��� �����μ��ڵ� �����μ����� ���

select * from dept2;

select d1.dcode �μ��ڵ�, d1.dname �μ���, d1.pdept �����μ��ڵ�, d2.dname �����μ��� from dept2 d1 left outer join dept2 d2 on d1.pdept=d2.dcode
order by d1.dcode;

-- dept2 ���̺��� �����μ���, �����μ��� ���� ���
-- ��� �μ� ��ȸ�ϱ�

select d1.dname �����μ���, count(d2.dcode) "�����μ��� ����" from dept2 d1 left outer join dept2 d2 on d1.dcode = d2.pdept
group by d1.dname
order by 2 desc;

select d1.dname �����μ���, d2.dcode "�����μ��� ����" from dept2 d1 join dept2 d2 on d1.dcode = d2.pdept;






