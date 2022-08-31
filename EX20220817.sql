/*
1. 학과별로 평균 몸무게와 학생 수를 출력하되 평균 몸무게의  내림차순으로 정렬하여라.


[결과]
  학과코드 평균몸무게     학생수
---------- ---------- ----------
       201         67          6
       102      64.25          4
       202       62.5          2
       101         60          4
       301         60          2
       103       51.5          2
*/

SELECT DEPTNO1 학과코드, AVG(WEIGHT) 평균몸무게, COUNT(*) 학생수 FROM STUDENT
GROUP BY DEPTNO1
ORDER BY 평균몸무게 DESC;


/*
2.  학생테이블의 birthday를 기준으로 월별로 태어난 인원수 출력하기

[결과]

   합계      1월   2월        3월     4월      5월     6월       7월      8월     9월      10월      11월      12월
------- ------- -------- -------- -------- -------- -------- -------- -------- -------- --------- --------- ---------
     20        3     3       2       2         0        1        0        2        2       2         1        2
*/

SELECT * FROM STUDENT;

SELECT COUNT(*),
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '01', '1', '0'))) "1월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '02', '1', '0'))) "2월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '03', '1', '0'))) "3월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '04', '1', '0'))) "4월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '05', '1', '0'))) "5월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '06', '1', '0'))) "6월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '07', '1', '0'))) "7월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '08', '1', '0'))) "8월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '09', '1', '0'))) "9월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '10', '1', '0'))) "10월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '11', '1', '0'))) "11월",
       SUM((DECODE(TO_CHAR(BIRTHDAY, 'MM'), '12', '1', '0'))) "12월"       
FROM STUDENT;
       
 
/*
3. 학과별 교수 수가 2명 이하인 학과 번호, 교수 수를  출력하여라
[결과]
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
4.직급별로 평균 급여가 320보다 크면 '우수', 작거나 같으면 '보통'을 출력하여라

[결과]
POSITION                                 급여
---------------------------------------- ------------
정교수                                   우수
전임강사                                 보통
조교수                                   우수
*/
SELECT POSITION,
  CASE 
    WHEN AVG(PAY) > 320 THEN '우수'
    WHEN AVG(PAY) <= 320 THEN '보통' END 급여 FROM PROFESSOR
GROUP BY POSITION;

/* 
5. 교수 부서중 최대인원을 가진 부서의 인원수와 최소인원을 가진 부서의 인원수 출력하기

[결과]
최대인원 최소인원
---------- ----------
   3            1
*/
SELECT MAX(COUNT(DEPTNO)) 최대인원, MIN(COUNT(DEPTNO)) 최소인원 FROM PROFESSOR
GROUP BY DEPTNO;

/*
6. 교수테이블에서 평균 급여가 350이상인 부서의   부서코드, 평균급여, 급여합계를 출력하기

[결과]
 부서코드   평균급여   급여합계
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


-- 7. 4학년 학생의 이름 학과번호, 학과이름 출력하기

select s.name 이름, s.deptno1 학과번호, d.dname 학과이름 from student s join department d on s.deptno1 = d.deptno
where grade = 4;

-- 8. 오나라 학생의 이름, 학과코드1,학과이름,학과위치 출력하기

select s.name, s.deptno1, d.dname, d.build from student s, department d
where s.name='오나라' and s.deptno1=d.deptno;

-- 9. 학번과 학생 이름과 소속학과이름을 학생 이름순으로 정렬하여 출력

select s.studno 학번, s.name 학생이름, d.dname 소속학과 from student s join department d on s.deptno1 = d.deptno
order by s.name;

-- 10. 교수별로 교수 이름과 지도 학생 수를 출력하기.

select p.name 교수이름, count(s.profno) 지도학생수 from student s join professor p on s.profno = p.profno
group by p.name
order by p.name;


-- 11. 성이 김씨인 학생들의 이름, 학과이름 학과위치 출력하기

SELECT S.NAME, D.DNAME, D.BUILD FROM STUDENT S, DEPARTMENT D
WHERE S.NAME LIKE '김%' AND S.DEPTNO1 = D.DEPTNO;


SELECT S.NAME, D.DNAME, D.BUILD FROM STUDENT S JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO
WHERE SUBSTR(S.NAME,1,1) = '김';







