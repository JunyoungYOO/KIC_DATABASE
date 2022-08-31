/*
  
  cross join : m*n ����
  
  selef ���� ���� ���̺���� �����͵鳢�� ���Ҷ� ������
  
  inner join ���� ���̺��� ���� �÷� ������ �´� ��� ��ȸ
  outer join ���ǿ� �������� �ʾƵ� ���� ���̺� or ���� ����� �����͸� ���
    ex) left outer join,
        right outer join,
        full outer join�� oracle ������δ� union Ȱ���ؾ���
    
  subquery " select ���� ���ο� select ���� ������
    ������ subquery : where ���ǹ��� select ���� ����� �Ѱ��� ���
      ��밡�� ������ : =, >=, <=,
    ������ subquery : where ���ǹ��� select ���� ����� �������� ���
      ��밡�� ������ : in
    
    ���� �÷� ���� ���� : �񱳴�� �÷��� �ΰ� �̻���.
    
    �������� ��ġ
      1. where ���ǹ�
      2. having ���ǹ�
      3. �÷��κ� : ��Į�� ��������
      4. from ���� : from�� �ȿ��� sub query�� ���̴� ��� inline view��� �Ҹ�
*/

-- ��� �����԰� 60���� ū �г��� �г�� ��� �����Ը� ���

select grade, avg(weight) from student
group by grade
having avg(weight) > 60;

select grade, avg_weight from (select grade, avg(weight) avg_weight from student group by grade) stu_weight
where avg_weight > 60;



/*
  DML : Data Manipulation Language. ������ ���۾�
    1. insert : ���̺� ������ �߰�
    2. update : ���̺� ���� ������ ����
    3. delete : ���̺� ���� ������ ����
    4. merge  : �ΰ��� ���̺� ���� ���ս� ���
    
    CRUD : CREATE READ UPDATE DELETE
    TCL : Transaction Control Language
      1. commit
      2. rollback : DML(INSERT UPDATE DELETE MERGE) ��ɹ� ��� 
*/


-- INSERT
-- DEPT2 ���̺� 9000�� �μ� �߰��ϱ�


INSERT INTO DEPT2 (DCODE, DNAME, PDEPT, AREA)
VALUES (9000, 'Ư���Ǹ���', 1000, '�ӽ�����');

SELECT * FROM DEPT2;

/*
  �÷����� ����ؾ� �ϴ� ���
    1. ��� �÷��� ���� �������� �ʴ°��
    2. ��Ű�� ������ ������̼����� �����ڰ� �����Ҷ�
    
*/

-- dept2 ���̺� 9002�� �μ� �߰��ϱ�
-- �ڵ�:9002, �μ���:Ư���Ǹ� 2��
-- �ڵ�:9003, �μ���:Ư���Ǹ� 3��
-- null �� �Է¹��
--  1. insert������ null���� �Է��� �÷��� �߰���������
--  2. ���ڿ����� ����
--  3. null, NULL�� ���� �Է�
insert into dept2 (dcode,dname) values(9002, 'Ư���Ǹ�2��');
insert into dept2 values(9003, 'Ư���Ǹ�3��','','');
insert into dept2 values(9004, 'Ư���Ǹ� 4��', null, null);
insert into dept2 values(9005,'Ư���Ǹ�5��','','');

/*
  Transaction
    commit; 
    rollback;
    
  
*/


/*
  update : ������ ���ڵ带 ����
  
  update ���̺�� set �÷�1=��1, �÷�2=��2 ...
  where ���ǹ� ����
   
*/

update dept2 set AREA='��ź'
where area is null;

select * from dept2;


-- ���� ���̺��� ������ �������� ������ ���ʽ��� 99�� ����

update professor set bonus=99
where position='������';

select * from professor
where position='������';

-- ������������ ���� ������ ���� �� �޿��� 300 ������ ������ �޿��� 15% �λ��ϱ�

select * from professor;

update professor set pay = pay*1.15
where position = (select position from professor where name='������') and pay<=300;

select * from professor
where position = (select position from professor where name='������');

-- �л� ���̺��� ���������� ���� �л��� ������������ �̼����л��� ���������� �����ϱ�

select * from student
where profno is null;

update student set profno = (select s.profno from student s join professor p on s.profno=p.profno where s.name='�̼���')
where profno is null;

select s.NAME from student s join professor p on s.profno=p.profno
where s.profno = (select s.profno from student s join professor p on s.profno=p.profno where s.name='�̼���');

rollback;

select * from dept2;

-- ���� ������ ���ʽ��� �������� ��� ���ʽ��� 50%�� �����ϱ�
-- �������� ���ʽ��� ���� ���� 0���� ����ϱ�
-- �Ҽ������ϴ� �����Ͽ� ���ʽ��� �����ϱ�

select * from professor
order by position;

-- ���Ӱ��� ���ʽ� ���ڵ�
select bonus from professor
where position='���Ӱ���';

-- �Ҽ������� ������ �������� ��� ���ʽ� 50%
select trunc(avg(nvl(bonus,0))/2) from (select * from professor where position='������');

update professor set bonus = (select trunc(avg(nvl(bonus,0))/2) from (select * from professor where position='������'))
where position='���Ӱ���';

select * from professor
where position='���Ӱ���';



/*
  delete : ���ڵ� ���� ��ɾ�
  
  delete [from] ���̺��
  [where ���ǹ�] => ������ ���ڵ� ����. ���� ���� ��� ���ڵ� ����. ���� �ʿ�

*/


-- dept2 ���̺��� dcode�� 9000�� ����

delete from dept2 where dcode = 9000;

select * from dept2 where dcode >= 9000;

-- ���� ���̺��� �ɽ������� ���� �μ��� ������ ������Ű��

select * from professor
where deptno = (select deptno from professor where name ='�ɽ�');

select deptno from professor
where name='�ɽ�';

delete from professor where deptno = (select deptno from professor where name='�ɽ�');

select * from professor;
rollback;


/*
  DDL : Data Definition Language ������ ���Ǿ�
        ��ü�� ����, ����, ���� ����� ����ϴ� ��ɾ�
        ��ü : table, index, user, sequence, ...
        table ���� : create table ���̺��
        index ���� : create index �ε�����
        user ���� : create user ������ 
        
  DDL ��ɾ�
    1. create : ��ü (table) ����
    2. alter : ��ü ����
    3. drop : ��ü ����
    4. truncate ��ü�� ������ �и�
  
  DDL ��ɾ� Ư¡
    1. commit, rollback �ǹ̰� ����.
    2. DDL ��ɾ ����Ǹ�, �ڵ� commit��.
      rollback�� �ϰ������, rollback ���� ������ DDL ��ɾ� ����
      
*/

create table ddl_test(
  no number(3),     -- �ִ� ���� 3�ڸ� ���·� ������ ����
  name varchar(10), -- �ִ� 10����Ʈ ���� ���� ������ ����. �ѱ� 3����Ʈ
  birth date default sysdate
);

select * from DDL_TEST;

insert into ddl_test (no, name) values(1,'ȫ�浿');

insert into ddl_test (no,name)  values(2,'���ñ浿');

-- dll_test2 ���̺� �����ϱ�
-- no : nubmer, name: varchar �⺻, 'ȫ�浿, birth

create table ddl_test2(
  no number(3),
  name varchar(10) default 'ȫ�浿',
  birth date default sysdate
);

drop table ddl_test2;

insert into ddl_test2 (no) values(1);

select * from ddl_test2;


-- ddl_test2 ���̺� no:2, name:���, birth:90-01-01

insert into ddl_test2 values(2, '���','90-01-01');

-- DDL ��ɾ �����ϸ� �ڵ� COMMIT
-- primary key : �⺻Ű, ���ڵ� ������ ������ �ǹ̸� ������ �÷�
--               �÷��� ���� ���̺� ������ ������. �ߺ��ȵ�.

create table ddl_test3(
  no number(3) primary key,
  name varchar(10) default 'ȫ�浿',
  birth date default sysdate
);

drop table ddl_test3;

insert into ddl_test2 (no) values(1);
select * from ddl_test2;  -- no �÷��� ���� �ߺ� ����
insert into ddl_test3 (no) values(1); -- ddl_test3 ���̺��� no�÷��� �����̸Ӹ� Ű�̱⶧���� �ߺ� �μ�Ʈ �Ұ�
select * from ddl_test3; 




/*
  alter : ���� ��ü�� ������ �����ϴ� ��ɾ�
          �÷��� �߰� �Ǵ� ���� ������� ������
*/

-- dept2 ���̺��� dept3 ���̺� �����ϱ�

create table dept3 as select * from dept2;
select * from dept3;


alter table dept3 add tel varchar(20);

-- dept3 ���̺� tel �÷��� phone���� �����ϱ�
alter table dept3 rename column tel to phone;
desc dept3;

-- dept3 ���̺� area �÷��� ũ�⸦ 30���� ����
-- dept3 ���̺� area �÷��� ũ�⸦ 10���� ���� --> ����  --> ����� �������� ũ�Ⱑ 10���� Ŀ�� �ٿ����� ����
-- area�� ����� �������� �ִ� ũ�� ��ȸ�ϱ�
select max(lengthb(area)) from dept3;
-- ������ ũ�⸦ ����
alter table dept3 modify phone varchar2(12);
alter table dept3 drop column phone;  -- �÷� ���
desc dept3;

drop table dept3;
desc dept3;


/*
  truncate : ���� �����ϱ�
  ROLLBACK �ȵǴ� �Լ�
  
    delete ��ɾ�� rollback ����
    truncate ��ɾ�� rollback �Ұ���, ���� �ӵ� ����(��뷮 ������ ����)
    
    delete ��ɾ�� rollback�� �Ϳ� ����Ͽ� ���۰� ���� �ɸ�
*/
select * from ddl_test2;
truncate table ddl_test2;
select * from ddl_test2;

select * from ddl_test3;
delete from ddl_test3;
select * from ddl_test3;
rollback;
select * from ddl_test3;

-- truncate �ѹ� �ȵ�
-- delete �ѹ� ����

truncate table ddl_test3;
select * from ddl_test3;
rollback;

