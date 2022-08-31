-- 비등가 조인 : NON EQUI JOIN
--              조인컬럼의 조건이 =이 아닌 조인

SELECT * FROM GOGAK;
SELECT * FROM GIFT;


-- 고객테이블과 상품테이블을 이용해서 고객의 포인트로 받을수있는 상품을 출력ㅎ라
SELECT G1.GNAME, G1.POINT, G2.GNAME FROM GOGAK G1, GIFT G2
WHERE G1.POINT BETWEEN G2.G_START AND G2.G_END;

select g1.gname, g1.point, g2.gname from gogak g1 join gift g2
on g1.point between g2.g_start and g2.g_end;

-- 학생의 이름, 점수, 학점 조회하기
SELECT * FROM EXAM_01;
select * from hakjum;

select s.name 이름, e.total 점수,  h.grade 학점 from student s, exam_01 e, hakjum h
where s.studno=e.studno and e.TOTAL between h.min_point and max_point;

select s.name, e.total, h.grade from student s join exam_01 e on s.studno=e.studno join hakjum h on e.total between h.min_point and h.max_point;

-- 고객이 자기 포인트 보다 낮은 포인트 상품 중 한가지를 선택 할수 있다고 할때
-- 산악용 자전거를 선택할 수 있는 고객명, 포인트 , 상품명을 조회하기


SELECT * FROM GOGAK;
SELECT * FROM GIFT;

SELECT G1.GNAME 고객명, G1.POINT 포인트, G2.GNAME FROM GOGAK G1, GIFT G2
WHERE G1.POINT >= G2.G_START AND G2.GNAME='산악용자전거';


-- 고객이 자기 포인트 보다 낮은 포인트 상품 중 한가지를 선택 할 수 있다고 할때, 고객이 선택할 수 있는 상품의 갯수 출력하기
-- 고객명과 선택가능한 상품 갯수



select g1.gname 고객명, count(g2.gname) "선택가능한 상품수" from gogak g1 join gift g2 on g1.point >= g2.g_start
group by g1.gname
order by 1;
--GROUP BY G1.GNAME;


-- OUTER JOIN
-- 조인조건을 만족하지 않은 테이블의 레코드 정보 조회
-- 학생의 이름과 지도교수의 이름을 조회
-- 단 지도교수가 없는 학생도 조회하기
select s.name 학생, p.name 지도교수 from student s, professor p
where s.profno(+) = p.profno;

select s.name 학생, p.name 지도교수 from student s, professor p
where s.profno = p.profno(+);

  --outer join
  --1. left outer join : 왼쪽 테이블의 모든 정보 조회.
    -- oracle 방식
    select s.name 학생, p.name 지도교수 from student s, professor p
    where s.profno = p.profno(+);  
    -- ansi 방식
    select s.name 학생, p.name 지도교수 from student s left outer join professor p on s.profno = p.profno;  
    
  --2. right outer join : 오른쪽 테이블의 모든 정보 조회.
    -- oracle 방식
    select s.name 학생, p.name 지도교수 from student s, professor p
    where s.profno(+) = p.profno;  
    -- ansi 방식
    select s.name 학생, p.name 지도교수 from student s right outer join professor p on s.profno = p.profno;  
    
  --3. full outer join : 양쪽 테이블의 모든 정보 조회.
    -- oracle 방식
    select s.name 학생, p.name 지도교수 from student s, professor p
    where s.profno(+) = p.profno
    union
    select s.name 학생, p.name 지도교수 from student s, professor p
    where s.profno = p.profno(+);  
    -- ansi 방식
    select s.name 학생, p.name 지도교수 from student s full outer join professor p on s.profno = p.profno;

-- 교수별로 교수 이름과 지도 학생수를 출력
-- 지도학생 없는 교수도 출력

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

-- dept2 테이블에서 부서코드 부서명 상위부서코드 상위부서명을 출력

select * from dept2;

select d1.dcode 부서코드, d1.dname 부서명, d1.pdept 상위부서코드, d2.dname 상위부서명 from dept2 d1 left outer join dept2 d2 on d1.pdept=d2.dcode
order by d1.dcode;

-- dept2 테이블에서 상위부서명, 하위부서의 갯수 출력
-- 모든 부서 조회하기

select d1.dname 상위부서명, count(d2.dcode) "하위부서의 갯수" from dept2 d1 left outer join dept2 d2 on d1.dcode = d2.pdept
group by d1.dname
order by 2 desc;

select d1.dname 상위부서명, d2.dcode "하위부서의 갯수" from dept2 d1 join dept2 d2 on d1.dcode = d2.pdept;






