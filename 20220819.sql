/*
  
  cross join : m*n 조합
  
  selef 조인 같은 테이블안의 데이터들끼리 비교할때 ㅆ으미
  
  inner join 양쪽 테이블의 조인 컬럼 조건이 맞는 경우 조회
  outer join 조건에 부합하지 않아도 한쪽 테이블 or 양쪽 모두의 데이터를 출력
    ex) left outer join,
        right outer join,
        full outer join은 oracle 방식으로는 union 활용해야함
    
  subquery " select 구문 내부에 select 구문 존재함
    단일행 subquery : where 조건문의 select 구문 결과가 한개인 경우
      사용가능 연산자 : =, >=, <=,
    복수행 subquery : where 조건문의 select 구문 결과가 여러개인 경우
      사용가능 연산자 : in
    
    다중 컬럼 서브 쿼리 : 비교대상 컬럼이 두개 이상임.
    
    서브쿼리 위치
      1. where 조건문
      2. having 조건문
      3. 컬럼부분 : 스칼라 서브쿼리
      4. from 구문 : from절 안에서 sub query가 쓰이는 경우 inline view라고 불림
*/

-- 평균 몸무게가 60보다 큰 학년의 학년과 평균 몸무게를 출력

select grade, avg(weight) from student
group by grade
having avg(weight) > 60;

select grade, avg_weight from (select grade, avg(weight) avg_weight from student group by grade) stu_weight
where avg_weight > 60;



/*
  DML : Data Manipulation Language. 데이터 조작어
    1. insert : 테이블에 데이터 추가
    2. update : 테이블에 기존 데이터 수정
    3. delete : 테이블에 기존 데이터 삭제
    4. merge  : 두개의 테이블 내용 병합시 사용
    
    CRUD : CREATE READ UPDATE DELETE
    TCL : Transaction Control Language
      1. commit
      2. rollback : DML(INSERT UPDATE DELETE MERGE) 명령문 취소 
*/


-- INSERT
-- DEPT2 테이블에 9000번 부서 추가하기


INSERT INTO DEPT2 (DCODE, DNAME, PDEPT, AREA)
VALUES (9000, '특수판매팀', 1000, '임시지역');

SELECT * FROM DEPT2;

/*
  컬럼명을 기술해야 하는 경우
    1. 모든 컬럼에 값을 설정하지 않는경우
    2. 스키마 순서와 상관없이순서를 개발자가 지정할때
    
*/

-- dept2 테이블에 9002번 부서 추가하기
-- 코드:9002, 부서명:특수판매 2팀
-- 코드:9003, 부서명:특수판매 3팀
-- null 값 입력방법
--  1. insert문에서 null값을 입력할 컬럼을 추가하지않음
--  2. 빈문자열값을 설정
--  3. null, NULL로 직접 입력
insert into dept2 (dcode,dname) values(9002, '특수판매2팀');
insert into dept2 values(9003, '특수판매3팀','','');
insert into dept2 values(9004, '특수판매 4팀', null, null);
insert into dept2 values(9005,'특수판매5팀','','');

/*
  Transaction
    commit; 
    rollback;
    
  
*/


/*
  update : 기존의 레코드를 수정
  
  update 테이블명 set 컬럼1=값1, 컬럼2=값2 ...
  where 조건문 가능
   
*/

update dept2 set AREA='동탄'
where area is null;

select * from dept2;


-- 교수 테이블에서 직급이 조교수인 교수의 보너스를 99로 변경

update professor set bonus=99
where position='조교수';

select * from professor
where position='조교수';

-- 장혜진교수와 같은 직급의 교수 중 급여가 300 이하인 교수의 급여만 15% 인상하기

select * from professor;

update professor set pay = pay*1.15
where position = (select position from professor where name='장혜진') and pay<=300;

select * from professor
where position = (select position from professor where name='장혜진');

-- 학생 테이블에서 지도교수가 없는 학생으 ㅣ지도교수를 이서진학생의 지도교수로 변경하기

select * from student
where profno is null;

update student set profno = (select s.profno from student s join professor p on s.profno=p.profno where s.name='이서진')
where profno is null;

select s.NAME from student s join professor p on s.profno=p.profno
where s.profno = (select s.profno from student s join professor p on s.profno=p.profno where s.name='이서진');

rollback;

select * from dept2;

-- 전임 강사의 보너스를 조교수의 평균 보너스의 50%로 변경하기
-- 조교수의 보너스가 없는 경우는 0으로 계산하기
-- 소숫점이하는 절삭하여 보너스로 변경하기

select * from professor
order by position;

-- 전임강사 보너스 레코드
select bonus from professor
where position='전임강사';

-- 소숫점이하 절삭한 조교수의 평균 보너스 50%
select trunc(avg(nvl(bonus,0))/2) from (select * from professor where position='조교수');

update professor set bonus = (select trunc(avg(nvl(bonus,0))/2) from (select * from professor where position='조교수'))
where position='전임강사';

select * from professor
where position='전임강사';



/*
  delete : 레코드 삭제 명령어
  
  delete [from] 테이블명
  [where 조건문] => 삭제될 레코드 조건. 없는 경우는 모든 레코드 삭제. 주의 필요

*/


-- dept2 테이블의 dcode값 9000번 삭제

delete from dept2 where dcode = 9000;

select * from dept2 where dcode >= 9000;

-- 교수 테이블에서 심슨교수와 같은 부서의 교수를 퇴직시키기

select * from professor
where deptno = (select deptno from professor where name ='심슨');

select deptno from professor
where name='심슨';

delete from professor where deptno = (select deptno from professor where name='심슨');

select * from professor;
rollback;


/*
  DDL : Data Definition Language 데이터 정의어
        객체를 생성, 변경, 제거 기능을 담당하는 명령어
        객체 : table, index, user, sequence, ...
        table 생성 : create table 테이블명
        index 생성 : create index 인덱스명
        user 생성 : create user 유저명 
        
  DDL 명령어
    1. create : 객체 (table) 생성
    2. alter : 객체 수정
    3. drop : 객체 제거
    4. truncate 객체와 데이터 분리
  
  DDL 명령어 특징
    1. commit, rollback 의미가 없다.
    2. DDL 명령어가 실행되면, 자동 commit됨.
      rollback을 하고싶으면, rollback 먼저 실행후 DDL 명령어 실행
      
*/

create table ddl_test(
  no number(3),     -- 최대 숫자 3자리 형태로 데이터 저장
  name varchar(10), -- 최대 10바이트 문자 형태 데이터 저장. 한글 3바이트
  birth date default sysdate
);

select * from DDL_TEST;

insert into ddl_test (no, name) values(1,'홍길동');

insert into ddl_test (no,name)  values(2,'남궁길동');

-- dll_test2 테이블 생성하기
-- no : nubmer, name: varchar 기본, '홍길동, birth

create table ddl_test2(
  no number(3),
  name varchar(10) default '홍길동',
  birth date default sysdate
);

drop table ddl_test2;

insert into ddl_test2 (no) values(1);

select * from ddl_test2;


-- ddl_test2 테이블에 no:2, name:김삿갓, birth:90-01-01

insert into ddl_test2 values(2, '김삿갓','90-01-01');

-- DDL 명령어를 실행하면 자동 COMMIT
-- primary key : 기본키, 레코드 내용을 유일한 의미를 가지는 컬럼
--               컬럼의 값은 테이블 내에서 유일함. 중복안됨.

create table ddl_test3(
  no number(3) primary key,
  name varchar(10) default '홍길동',
  birth date default sysdate
);

drop table ddl_test3;

insert into ddl_test2 (no) values(1);
select * from ddl_test2;  -- no 컬럼의 값이 중복 가능
insert into ddl_test3 (no) values(1); -- ddl_test3 테이블은 no컬럼이 프라이머리 키이기때문에 중복 인서트 불가
select * from ddl_test3; 




/*
  alter : 기존 객체의 구조를 변경하는 명령어
          컬럼을 추가 또는 삭제 변경등이 가능함
*/

-- dept2 테이블을 dept3 테이블 복사하기

create table dept3 as select * from dept2;
select * from dept3;


alter table dept3 add tel varchar(20);

-- dept3 테이블에 tel 컬럼을 phone으로 변경하기
alter table dept3 rename column tel to phone;
desc dept3;

-- dept3 테이블에 area 컬럼의 크기를 30으로 변경
-- dept3 테이블에 area 컬럼의 크기를 10으로 변경 --> 오류  --> 저장된 데이터의 크기가 10보다 커서 줄여지지 않음
-- area에 저장된 데이터의 최대 크기 조회하기
select max(lengthb(area)) from dept3;
-- 데이터 크기를 변경
alter table dept3 modify phone varchar2(12);
alter table dept3 drop column phone;  -- 컬럼 드랍
desc dept3;

drop table dept3;
desc dept3;


/*
  truncate : 내용 제거하기
  ROLLBACK 안되는 함수
  
    delete 명령어는 rollback 가능
    truncate 명령어는 rollback 불가능, 삭제 속도 빠름(대용량 삭제에 유용)
    
    delete 명령어는 rollback할 것에 대비하여 버퍼가 많이 걸림
*/
select * from ddl_test2;
truncate table ddl_test2;
select * from ddl_test2;

select * from ddl_test3;
delete from ddl_test3;
select * from ddl_test3;
rollback;
select * from ddl_test3;

-- truncate 롤백 안됨
-- delete 롤백 가능

truncate table ddl_test3;
select * from ddl_test3;
rollback;

