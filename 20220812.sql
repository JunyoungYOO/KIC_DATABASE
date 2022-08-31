-- distinct : 중복제거  // 컬럼 앞에 한번만 사용 가능  , 쿼리 짤 때 잘 쓰지 않음
-- ex) SELECT distinct deptno, distinct name from professor (X)
--     select distinct deptno, name from professor (O)
-- 교수가 속한 부서코드 조회하기
select distinct position, deptno from professor;

-- between 연산자
-- 학생의 몸무게가 70이상 80이하인 학생의 이름, 몸무게, 학년 조회하기

select name, weight, grade from student
where weight between 70 and 80;

select name, weight, grade from student
where weight >= 70 and weight <=80;

-- 문제 :
-- 교수의 급여(pay)가 300이상 500이하
-- 교수번호, 이름, 급여, 보너스 출력하기

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE PAY BETWEEN 300 AND 500;

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE PAY >=300 AND PAY <= 500;

-- in  연산자 : 조회 대상이 되는 값을 선택
-- 학생 주 101 학과, 201학과 학생의 이름, 부서코드, 학년 출력

SELECT NAME, STUDNO, DEPTNO1, GRADE FROM STUDENT
WHERE DEPTNO1 in (101,201);

-- 101, 201학과 학생 중 키가 170이상 180이하인 학생의
-- 학번 이름 몸무게 키 학과코드 조회

SELECT STUDNO, NAME, WEIGHT, HEIGHT FROM STUDENT
WHERE DEPTNO1 IN (101, 201) AND HEIGHT BETWEEN 170 AND 180;


-- LIKE 연산자
-- % : 임의의 문자 0개 이상
-- _ : 임의의 문자 1개

-- 학생 중 이름에 '진' 글자를 가진 학생의 이름과 부서코드 조회하기

SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '%진%';

-- 학생중 성이 김씨인 학생의 이름과 부서코드 조회하기

SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '김%';

-- 이름이 두자인 학생 조회 '언더바 두개'
SELECT NAME, DEPTNO1 FROM STUDENT
WHERE NAME LIKE '__';

-- NOT LIKE 연산자
-- 학생 중 성이 김이 아닌 학생의 학번, 이름, 학과코드 조회하기

SELECT STUDNO, NAME, DEPTNO1 FROM STUDENT
WHERE NAME NOT LIKE '김%';

-- NOT IN 연산자
-- 사원테이블에서 부서코드가 10, 30 이 아닌 부서에 근무하는 사원의 이름, 부서코드 조회하기

SELECT ENAME, DEPTNO FROM EMP
WHERE DEPTNO NOT IN (10,30);

-- NULL : 값이 없음. 비교대상아님, 연산대상도아님
-- 교수중 상여금이 없는 교수의 교수번호, 이름, 급여, 보너스를 조회하기

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE bonus IS NULL;

SELECT PROFNO, NAME, PAY, BONUS FROM PROFESSOR
WHERE BONUS IS NOT NULL;

--교수번호, 이름, 급여와 상여금, 합계(급여+상여금) 출력하기

SELECT PROFNO, NAME, PAY, BONUS, PAY+BONUS AS 합계 FROM PROFESSOR;

/* ORDER BY : 정렬하기    SELECT 구문 마지막 작성

   SELECT 컬러명 || * FROM  테이블명
   WHERE 조건문 : 레코드 선택 기준
   GROUP BY 컬럼명 
   HAVING 조건문
   ORDER BY 컬럼명 [ASC|DESC] :  ASC 오름차순 (생략가능),   DESC 내림차순
*/

-- 1학년 학생의 이름, 키를 조회하기 , 키가 작은순

SELECT NAME, HEIGHT FROM STUDENT
WHERE GRADE = 1
ORDER BY HEIGHT;

-- 학생의 이름, 키, 몸무게, 학년 조회

-- 학년 순 키가 큰 순 몸무게 작은순

SELECT NAME, HEIGHT, WEIGHT, GRADE FROM STUDENT
ORDER BY GRADE, HEIGHT DESC, WEIGHT;

SELECT NAME, HEIGHT, WEIGHT, GRADE FROM STUDENT
ORDER BY 4, 2 DESC, 3;            /* 조회되는 컬럼 순서를 숫자로 표현가능 ALIAS도 가능*/

-- 교수의 급여 10% 인상
-- 교수번호 교수이름 학과코드 급여 예상급여(10%인상) 조회하기
-- 학과코드순으로 예상급여의 역순으로

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS 예상급여 FROM PROFESSOR
ORDER BY DEPTNO, 예상급여 DESC;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS 예상급여 FROM PROFESSOR
ORDER BY 3, 5 DESC;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY*1.1 AS 예상급여 FROM PROFESSOR
ORDER BY DEPTNO, PAY*1.1 DESC;
-- 학생테이블에서 지도교수가 배정되지 않은 학생의 학번 이름 지도교수번호 학과코드 출력
-- 학과코드 순으로 정렬

SELECT STUDNO, NAME, PROFNO, DEPTNO1 FROM STUDENT
WHERE PROFNO IS NULL
ORDER BY DEPTNO1;

/*
  합집합 UNION, UNION ALL
  UNION : 합집합, 중복제거 정렬
  UNION ALL : 합집합, 두개의 쿼리 결과 합하여 출력 , 중복 데이터 조회, 두개 쿼리의 결과 컬럼의 갯수가 동일해야 적용
*/
-- 교수중 상여금 있는 경우는 급여합계 급여+상여금
-- 상여금이 없는 경우는 급여합계로 조회하기
-- 교수의 교수번호 이름 부서코드 급여 급여합계를 출력하기
-- 부서코드 순으로 정렬하기

SELECT PROFNO, NAME, DEPTNO, PAY, PAY+BONUS FROM PROFESSOR
WHERE BONUS IS NOT NULL
UNION ALL
SELECT PROFNO, NAME, DEPTNO, PAY, PAY FROM PROFESSOR
WHERE BONUS IS NULL
ORDER BY DEPTNO;

SELECT PROFNO, NAME, DEPTNO, PAY, PAY+NVL(BONUS,0) FROM PROFESSOR
ORDER BY DEPTNO;


-- 문제 
-- 101학과 학생의 학번 이름 학과번호1
-- 101학과 교수의 교수번호, 이름, 학과번호를 출력하기

SELECT STUDNO AS "고유번호", NAME 이름, DEPTNO1 학과번호, '학생' 구분 FROM STUDENT
WHERE DEPTNO1 = 101
UNION
SELECT PROFNO, NAME, DEPTNO, '교수' FROM PROFESSOR
WHERE DEPTNO = 101;

/*
  단일행 함수
  - 문자함수 : 대문자OR소문자로 변경
  - 숫자함수 : 반올림, 버림
  - 날짜함수 : 날짜계산기
  - 변환함수 : 데이터형 변환, 문자->날짜 문자->숫자
  - 일반함수 : NULL값 처리 NVL, 조건함수
  
*/

-- 문자함수
-- 대소문자 변환

SELECT NAME, ID, INITCAP(ID), UPPER(ID), LOWER(ID) FROM STUDENT
WHERE DEPTNO1 = 101;


SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE LOWER(ENAME) = 'smith';
-- 문제
-- 1. 학생 중 id값에 M문자를 가지고 있는 학생의 이름, id, 학과번호1을 조회하기
-- 단 id의 내용은 대소문자 상관없이 조회되어야함

SELECT NAME, ID, DEPTNO1 FROM STUDENT
WHERE upper(ID) LIKE '%M%';

SELECT NAME, ID, DEPTNO1 FROM STUDENT
WHERE ID LIKE '%M%' OR ID LIKE '%m%';

-- 문자열 길이
-- length   : 문자열길이
-- lengthb  : 저장하기 위한 필요한 바이트 수.
--  한글 저장시 3바이트 필요 -> 시스템 별로 다름
select name, length(name), lengthb(name), id, length(id), lengthb(id) from student;

-- dual 테이블 : 더미테이블   //오라클에서 의미ㅓㅄ는 테이블로 사용할 수 있도록 생성된 테이블
select lengthb('홍길동') from dual;

-- substr : 부분 문자열 함수

select substr('안녕 나는 홍길동이야', 7, 3) from dual;
-- 학생 중 생일이 3월인 학생의 이름, 생년월일 조회하기

select name, jumin from student
where substr(jumin,3,2) = '03';

-- 학생의 이름, 생년월일 조회하기
-- 생일의 월을 기준으로 정렬하여 출력하기
-- SUBSTR('9608191234567', 1,6) : 960819

select name, substr(jumin,1,6) 생년월일 from student
order by substr(jumin,3,2);

select name, substr(jumin,1,6) 생년월일 from student
order by substr(jumin, -13, 2);     --뒤에서 13번째 ORACLE만

select name, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') from student
WHERE SUBSTR(TO_CHAR(BIRTHDAY, 'YYYY-MM-DD'),6,2) = '03';

-- instr : 문자열(컬럼값)에서 해당문자의 위치값 리턴
-- instr('string', 's') index값 1부터 시작
-- instr('string', 's', 1, 2) 1번째위치에서 찾고 2번째 s 출력
select instr('A*B*C', '*') from dual;

select instr('A*B*C*', '*', 3, 2) from dual;

select instr('A*B*C*', '*', -1, 3) from dual;

select INSTRB('CORPORATE FLOOR','OR',5,2) from dual;

-- 학생 테이블에서, 이름, 전화번호tel, tel 컬럼의 ')' 문자의 위치 출력하기

select name, instr(tel, ')')from student;

-- 문제
-- 학생의 이름, 전화번호ㅡ 지역번호를 출력하기

select name, tel, substr(tel,1,instr(tel, ')')-1) as 지역번호 from student;

-- 문자추가함수 lpad, rpad
-- lpad : 왼쪽에 문자를 추가
-- rpad : 오른쪽에 문자를 추가
-- LPAD(COL, 총 자리수, 채울문자)

SELECT NAME, GRADE, LPAD(ID, 10, '&') FROM STUDENT;

-- 문자 제거하기LTRIM, : LTRIM(COL, 제거할 문자) -> 제거할 문자가 생략되면 공백  RTRIM, TRIM
-- LTRIM 왼쪽 지정문자 제거, RTRIM 오른쪽 지정문자 제거, TRIM 양쪽 공백 제거

SELECT NAME, HPAGE, LTRIM(HPAGE, 'http://') URL FROM PROFESSOR
WHERE HPAGE IS NOT NULL;

SELECT LTRIM('   AAA B  ','   A') A FROM DUAL;
SELECT RTRIM('   AAA   ') A FROM DUAL;
SELECT TRIM('   AAA   ') A FROM DUAL;

-- 문자열 치환함수 : replace
-- replace(컬럼명, '문자1, '문자2') : 컬럼의 값을 문자1을 문자2로 치환

-- 문제. 학생테이블에서 학생의 이름의 첫자만 #문자로 변경하여

SELECT REPLACE(NAME, SUBSTR(NAME,1,1), '#' )  이름, GRADE FROM STUDENT;
