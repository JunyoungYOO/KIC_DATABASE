/*
1. 학생이름과 지도교수이름 출력하기.단 지도학생이 없는 교수이름과,  지도교수가 없는 학생이름도 출력하기
   지도학생이 없는 교수의 경우 지도학생이름은 "****"로 표시하고 지도교수가 없는 학생의 지도교수는 '####'
   으로 출력하기. 
  [결과]
지도학생             지도교수
--------------- -----------------
****                 김도형
****                 김자바
****                 김현정
****                 바비
****                 비
****                 아이유
****                 이창익
구유미               김태희
김문호               나몰라
김주현               ####
김진욱               엄호선
나학생               심슨
노정호               김태희
누구야               나몰라
몰라두               심슨
안광훈               최슬기
안은수               ####
오나라               나몰라
유해진               장혜진
이사랑               엄호선
이서진               김명신
이윤나               ####
인영민               ####
일지매               김명신
조아해               나한열
허우                 ####
홍길동               김명선
*/

select nvl(s.name, '****'), nvl(p.name, '####') from student s full outer join professor p on s.profno = p.profno
order by 1;

select nvl(s.name,'****'), nvl(p.name, '####') from student s, professor p where s.profno(+)=p.profno
union
select nvl(s.name,'****'), nvl(p.name, '####') from student s, professor p where s.profno=p.profno(+)
order by 1;

/*
2.  학과별,학년별 성적이 가장 높은 성적을 받은 학생의 학과코드,학과명,학년,이름,점수 출력하기
[결과]

  학과코드 학과명                                  학년   이름                       점수
---------- ----------------------------   ---------- -------------------- ----------
       101 컴퓨터공학과                               1   이윤나                       91
       101 컴퓨터공학과                               2   일지매                       89
       101 컴퓨터공학과                               3   이서진                       92
       101 컴퓨터공학과                               4   홍길동                       97
       102 멀티미디어공학과                         1   김주현                       83
       102 멀티미디어공학과                         2   김진욱                       77
       102 멀티미디어공학과                         3   유해진                       87
       102 멀티미디어공학과                         4   이사랑                       78
       103 소프트웨어공학과                         1   허우                          84
       103 소프트웨어공학과                         4   조아해                       83
       201 전자공학과                                  1   안은수                       88
       201 전자공학과                                  2   안광훈                       86
       201 전자공학과                                  3   몰라두                       95
       201 전자공학과                                  4   나학생                       62
       202 기계공학과                                  3   오나라                       81
       202 기계공학과                                  4   누구야                       88
       301 문헌정보학과                               2   노정호                       87
       301 문헌정보학과                               3   구유미                       79
*/
select * from exam_01;
select * from student;
select * from department;


select s.deptno1 학과코드, d.dname 학과명, s.grade 학년, s.name 이름, e.total 점수
from student s, department d, exam_01 e
where s.deptno1 = d.deptno and s.studno = e.studno
and (s.deptno1, grade, e.total) in (select s.deptno1, s.grade, max(e.total) from student s, exam_01 e where s.studno = e.studno group by s.deptno1, s.grade)
order by s.deptno1, s.grade;
/*
3. 학과별  생년월일이 가장 빠른 학생의 학번,  이름, 생년월일,학과명을 출력
*/

select s.studno, s.name, s.birthday, d.dname  from student s join department d on s.deptno1 = d.deptno
where s.birthday in (select min(s.birthday) from student s join department d on s.deptno1 = d.deptno group by d.deptno);

/*
4. 교수 테이블의 입사일을 2015년 1월 1일로 입력하기
   교수번호 : 6001 ,       교수명   : 최윤식
   직책     : 조교수,      id      : choiys 
   입사일   : 2015-01-01,  부서코드 : 501
   pay     : 400
*/
select * from professor;

INSERT INTO PROFESSOR (profno, name, position, id, hiredate, deptno, pay) values(6001, '최윤식', '조교수', 'choiys', '2015-01-01', 501, 400);

select * from professor;

/*
5. department 테이블에 메카트로닉스학부의 하위 학과로 메카트로닉스공학과를 401번 코드로 추가하기.
   건물명은 null로 추가한다.
*/
SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = '메카트로닉스학부';

select * from department;

INSERT INTO DEPARTMENT (DEPTNO, DNAME, PART) VALUES('401', '메카트로닉스공학과', (SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = '메카트로닉스학부' ));

SELECT * FROM DEPARTMENT;
/*
6.  department 테이블에서  공과대학 속한  데이터만 저장하는 department10 테이블 생성하기
*/


CREATE TABLE department10 as Select * from department
where deptno in (select d1.deptno from department d1 inner join department d2 on d1.part=d2.deptno inner join department d3 on d2.part = d3.deptno where d3.dname='공과대학');


CREATE TABLE department10 as Select d1.* from department d1, department d2, department d3 where d1.part=d2.deptno and d2.part = d3.deptno and d3.dname='공과대학';

SELECT * FROM DEPARTMENT10;

/*
  DML
    insert into 테이블명 (컬럼명, ..) values('컬럼값',...)
      컬럼에 부합하는 values값 추가
    update 테이블명 set 컬럼명='컬럼값' ...  where(조건문)
      조건 만족하는 레코드 수정
    delete from 테이블 where(조건문)
      조건 만족하는 레코드 삭제
    
  SELECT 컬럼명
  FROM 테이블
  WHERE 조건
  GROUP BY
  HAVING
  ORDER BY
    
  DDL
    create table 테이블명 (
      컬럼명 자료형,
      .
      .
      .
    )
      
    alter : 객체 수정
      https://121202.tistory.com/27
      
    DROP TABLE 테이블명
    
    TRUNCATE 모든 내용 제거   ROLLBACK 불가
*/