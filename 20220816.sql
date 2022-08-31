/*
복기

1. LIKE 연산자

2. IN, NOT IN

3. IS NULL, IS NOT NULL

4. ORDER BY
   COLUMM, ALIAS, SELECT 조건 순서별 번호로 조회가능
   EX)  SELECT STUDNO, NAME FROM STUDENT
        1. ORDER BY NAME
        2. ORDER BY 이름
        3. ORDER BY 2

5. UNION 합집합, 중복제거, 정렬
   UNION ALL 합집합, 두개의 SELECT문 결과를 합침(중복포함)

6. INITCAP 첫글자 대문자로
   UPPER 전부 대문자
   LOWER 전부 소문자
   LENGTH 문자열의 길이
   LENGTH 문자열 바이트
   SUBSTR 부분 문자열 자르기
          SUBSTR(컬럼명or문자열 , 인덱스, 문자의 갯수)  : 인덱스 위치 글자부터 문자의 갯수 까지 문자열 출력
          
          index = -1이면 뒷글자부터
          문자의 갯수 생략이면 인데스부터 문자열 출력
          
   instr 주어진 문자의 위치 리턴
   instr(컬럼명or문자열, 찾을 문자열,시작인덱스, n번째)   컬럼명or문자열에서 찾을 문자열을 시작인덱스부터 검색하고 n번째 문자열의 첫글자 인덱스를 출력
   
   
   LPAD, RPAD :왼/오른쪽에 문자추가
   LPAD(컬OR문, 전체길이, 채울 문자)
   LTRIM RTRIM: 왼쪽 오른쪽 문자제거 EX) LTRIM(문자열OR컬럼명, '제거할 문자열')
   TRIM 양쪽 공백 제거    EX) TRIM(문자열OR컬럼명)
   
   REPLACE :문자 치환
   REPLACE(컬럼명OR문자열, 문자열, 치환문자열)

*/

-- 숫자 관련함수

--ROUND:반올림함수
--ROUND(컬럼명OR숫자, 소숫점이하 자리수)

SELECT round(12.5123) r1, round(12.5123, 0) r2, round(12.5523,1) r3, round(12.5123,2) r4, round(12.5123,-1) r5 from dual;


-- TRUNC함수: 버림 함수
-- TRUNC(컬럼||숫자, 표시되는 소숫점이하 자리수)

SELECT TRUNC(12.5123) r1, TRUNC(12.5123, 0) r2, TRUNC(12.5123,1) r3, TRUNC(12.5123,2) r4, TRUNC(12.5123,-1) r5 from dual;

-- MOD 함수: 나머지 함수

SELECT MOD(12,5) r1, MOD(13,9) r2 from dual;

-- CEIL : 가까운 큰 정수  FLOOR(가까운 작은 정수)
SELECT CEIL(12.345) r1, FLOOR(12.345) r2, CEIL(-12.345) r3, FLOOR(-12.345) r4 from dual;

-- power : 제곱함수   power(제곱할 수, 제곱수) power(2,5) = 2^5 = 32

select power(12, 2) r1 from dual;

-- abs : 절대값

select abs(-14) r1 from dual;

-- sign : 부호 양수면 1 음수면 -1 0이면 0

-- 문제

-- 교수의 급여를 15%인상하여 정수로 출력하기
-- 교수 이름, 현재급여, 반올림된 예상급여, 버림도니 예상급여 출력

SELECT * FROM PROFESSOR;

SELECT NAME, PAY, PAY*1.15, ROUND(PAY*1.15), TRUNC(PAY*1.15) FROM PROFESSOR;

-- 날짜 관련 함수
-- SYSDATE: 현재 날짜를 리턴, 예약어

SELECT SYSDATE FROM DUAL;

-- months_between : 두날짜사이의 개월수 리턴, 소숫점 표현
-- months_between(A,B) : A날짜 - B날짜
SELECT MONTHS_BETWEEN(sysdate, '20221230') from dual;
SELECT MONTHS_BETWEEN(sysdate, '2022/12/30') from dual;
SELECT MONTHS_BETWEEN(sysdate, '2022-12-30') from dual;

-- 학생의 이름, 생일(BIRTHDAY), 개월수, 나이를 출력하기
-- 개월 : 현재날짜에서 생일까지의 개월수를 반올림하여 정수출력
-- 나이 : 개월/12나누고 버림으로 출력

SELECT * FROM STUDENT;

SELECT NAME, BIRTHDAY, ROUND(MONTHS_BETWEEN(SYSDATE, BIRTHDAY)) 개월수, TRUNC( MONTHS_BETWEEN(SYSDATE, BIRTHDAY)/12)  나이 FROM STUDENT;

SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '1996-08-19')/12) FROM DUAL;

-- ADD_MONTHS : 개월수를 더한 후의 날짜 리턴

--3개월전 3개월후
SELECT ADD_MONTHS(SYSDATE, 3) "3개월후", ADD_MONTHS(SYSDATE, -3) "3개월전" FROM DUAL;

--3일전 3일후
SELECT SYSDATE, SYSDATE-3, SYSDATE+3 FROM DUAL;

-- 날짜 - 날짜 : 
SELECT ENAME, HIREDATE, SYSDATE - HIREDATE FROM EMP;

SELECT SYSDATE, TO_DATE('22-08-19')-SYSDATE FROM EMP;

-- ROUND, TRUNC 날짜 적용

SELECT ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL;

-- NEXT_DAY 함수 : 현재 날짜 다음의 지정한 요일에 해당하는 날짜 리턴
-- 일 월 화 수 목 금 토
-- 1  2  3  4 5  6  7
SELECT NEXT_DAY(SYSDATE, '토') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '월'), NEXT_DAY(SYSDATE,2) FROM DUAL;

-- LAST_DAY : 해당월의 마지막 날짜 리턴

SELECT LAST_DAY('20/02/01') FROM  DUAL;

-- ROUND, TRUNC, CEIL, FLOOR, 

-- 문제

--1. 사원테이블에서 사원의 이름, 직업, 입사일, 근무일수 출력하기
-- 근무일수 버림 TRUNC

SELECT ENAME, JOB, HIREDATE 입사일, TRUNC(SYSDATE-HIREDATE) 근무일수 FROM EMP;

--2. 사원테이블에서 입사후 3개월을 수습기간이라고 가정할때 수습 종료일 출력하기

SELECT ENAME, JOB, HIREDATE 입사일, ADD_MONTHS(HIREDATE, 3) 수습종료일 FROM EMP;

-- 90일 이후가 수습 종료일
SELECT ENAME, JOB, HIREDATE 입사일, HIREDATE+90 수습종료일 FROM EMP;

--3. 사원테이블의 이름, 입사일, 휴가보상일 출력하기
-- 휴가 보상일: 입사월의 마지막 일자

SELECT ENAME, HIREDATE 입사일, LAST_DAY(HIREDATE) "휴가 보상일" FROM EMP;

-- 형변환 함수
-- 묵시적형변환 : 오라클이 자동으로 형변환

SELECT 1 + '1' FROM DUAL;   --ORALCE만 결과나옴
-- 'A'+1은 오류

-- TO_CHAR() : 숫자나 날짜형을 문자열로 변형
-- 날짜를 문자열로 변경
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT 1+TO_CHAR('123') FROM DUAL;

/*
   날짜 형식 문자
   yyyy : 연도를 4자리로 표시.
   yy   : 연도를 2자리로 표시.
   rrrr : 2000년 이후에 Y2K버그로 인해 추가된 연도 4자리로 표시.
   rr   : 2000년 이후에 Y2K버그로 인해 추가된 연도 2자리로 표시.
   year : 영문으로 년도 표시
   
   mm    : 월을 2자리로 표시
   mon   : 영문표시 할때 약자표시. FEB  한글은 상관없다
   month : 영문표시 할때 전체 월 표시. 한글은 상관없다
   
   dd    : 일을 2자로 표시
   day   : 요일 표시. 
   ddth  : 몇번째 날짜인지 표시
   
   시간
   hh   : 하루 12시간.
   hh24 : 하루 24시간
   mi   : 분
   ss   : 초
   am   : 오전/오후
*/

SELECT SYSDATE, TO_CHAR(SYSDATE, 'RRRR-MM-DD HH:MI:SS AM DAY') FROM DUAL;

-- 학생의 이름과 생일을 YYYY-MM-DD 요일

SELECT NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD DAY') 생일 FROM STUDENT;


select to_char(sysdate, 'yyyy') 년도1,  to_char(sysdate, 'rrrr') 년도2,
       to_char(sysdate, 'yy') 년도3,    to_char(sysdate, 'year') 년도4,
       to_char(sysdate, 'rr') 년도5,
       to_char(sysdate, 'mm') 월1,
       to_char(sysdate, 'mon') 월2, --약자표시
       to_char(sysdate, 'month') 월3, 
       to_char(sysdate, 'dd') 일1, -- 일자
       to_char(sysdate, 'day') 일2, --요일
       to_char(sysdate, 'ddth') 일3, --
       to_char(sysdate, 'hh') 시간1, -- 1 ~ 12
       to_char(sysdate, 'hh24') 시간2, -- 0 ~ 23
       to_char(sysdate, 'mi') 분1,   -- 분
       to_char(sysdate, 'ss') 초1,   -- 초
       to_char(sysdate, 'am') AM     -- 오전,오후
    from dual;


-- 문제 
-- 금일 2022-08-16 12:03:%5 월요일

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY') FROM DUAL;


SELECT TO_CHAR(SYSDATE, 'YY-MM-DD HH:MI:SS DAY') FROM DUAL;

-- TO_CHAR(숫자, '형식문자') : 숫자를 형식화된 문자열 출력

select to_char(1234.56,'9999999') 숫자1, --정수 7자리. 반올림
       to_char(1234.56,'0999999') 숫자2, --정수 7자리 빈자리 0으로 채움
       to_char(12.3456,'$9999.99') 숫자3, -- $표시, 소숫점이하 2자리출력      
       to_char(12.3456,'9999.99') 숫자4,  -- 소숫점이하 2자리출력            
       to_char(1234.3456,'9,999.99') 숫자5 -- 세자리마다 , 표시하고 소숫점이하 2자리 출력
from dual;


-- 교수의 이름, 현재급여, 연봉 출력하기
-- 연봉은 급여*12 출력시 세자리마다, 표시하기

SELECT NAME, PAY, TO_CHAR(PAY*12, '99,999') FROM PROFESSOR;


-- TO_NUMBER

SELECT TO_NUMBER('12') + 10 FROM DUAL;

-- TO_DATE : 문자 -> 날짜형

SELECT TO_DATE('20220818', 'yyyymmdd') FROM DUAL;

-- '20220817' 날짜의 2022-08-17 수요일

SELECT TO_CHAR(TO_DATE('20220817', 'yyyymmdd'), 'yyyy-mm-dd DAY') FROM DUAL;


-- 문제
-- 교수테이블 입사일 2개월 후 다음달 1일이 정식 입사일로 한다.
-- 교수의 이름 입사일, 정식입사일 출력
-- 단 정식입사일의 요일도 표시하기
SELECT NAME, HIREDATE, TO_CHAR(ADD_MONTHS(HIREDATE, 3) - (TO_NUMBER(SUBSTR(HIREDATE,7,2)) - 1), 'YYYY-MM-DD DAY') 정식입사일
FROM PROFESSOR;


SELECT NAME, HIREDATE, TO_CHAR(LAST_DAY(ADD_MONTHS(HIREDATE, 2)) + 1, 'YYYY-MM-DD DAY') 정식입사일
FROM PROFESSOR;

-- 일반함수
-- nvl : null 값을 다른 값으로 변환하는 함수   NVL(컬럼, 다른 값) 
-- 교수의 이름, 연봉(급여*12+보너스) 출력하기

SELECT NAME, PAY*12+BONUS 연봉 FROM PROFESSOR
WHERE BONUS IS NOT NULL
UNION
SELECT NAME, PAY*12 연봉 FROM PROFESSOR
WHERE BONUS IS NULL;
--  NVL(BONUS, 0) : BONUS 컬럼의 값이 NULL인 경우 0으로 값을 치환
--                  NULL이 아닌 경우 BONUS 값 그대로
SELECT NAME, PAY*12+NVL(BONUS,0) 연봉 FROM PROFESSOR;

-- 문제
-- 1. 학생의 이름과 지도교수번호(PROFNO)

SELECT NAME, NVL(PROFNO,9999) FROM STUDENT;

-- 2. 부서 테이블 (department)에서 부서코드와 부서명

SELECT DEPTNO, DNAME, NVL(BUILD, '건물없음') FROM DEPARTMENT;

-- 교수의 이름, 급여, 보너스, 성과급 출력
-- 성과급 : 보너스가 있는 경우 보너스 *3
-- 

SELECT NAME, PAY, NVL(BONUS, 0), NVL(BONUS*3, 50) FROM PROFESSOR;

-- 조건함수: DECODE
-- DECODE(컬럼명, 값, 참, 거짓)
-- 교수 테이블에서 교수이름, 학과번호, 학과명 출력하기
SELECT * FROM PROFESSOR;

SELECT NAME, DEPTNO, DECODE(DEPTNO, 101, '컴퓨터공학', '기타학과') 학과명 FROM PROFESSOR;

-- 102인 경우 멀티미디어
-- 201인 경우 기계공학
-- 그 외는 기타

SELECT NAME, DEPTNO, DECODE(DEPTNO, 101, '컴퓨터공학', 102, '멀티미디어학과', 201, '기계공학', '기타학과') 학과명  FROM PROFESSOR;

-- 문제
-- 1. 학생의 주민번호 7번째 자리가 1, 3인 경우는 남자, 2,4인 경우는 여자로 출력하기
-- 학생의 이름, 주민번호, 성별 조회하기

SELECT * FROM STUDENT;

SELECT NAME, JUMIN, DECODE(MOD(SUBSTR(JUMIN, 7,1), 2), '1' , '남자', '0', '여자') 성별 FROM STUDENT;
SELECT NAME, JUMIN, DECODE(SUBSTR(JUMIN, 7,1), '1' , '남자', '2', '여자', '3', '남자', '4', '여자') 성별 FROM STUDENT;


SELECT NAME, TEL, DECODE(SUBSTR(TEL, 1, INSTR(TEL, ')')-1), '02', '서울', '051', '부산', '055', '울산', '기타') 지역 FROM STUDENT
ORDER BY 지역;

-- CASE 구문 : 조건문. DECODE 함수와 같은 기능, 범위 지정 가능

SELECT NAME, TEL,
  CASE SUBSTR(TEL, 1, INSTR(TEL,')')-1)
    WHEN '02' THEN '서울'
    WHEN '051' THEN '부산'
    WHEN '055' THEN '울산'
    ELSE '기타' END 지역명
FROM STUDENT;


-- 학생의 주민번호 7자리가 1,3인경우는 남자, 2,4인경우는 여자로 출력

SELECT NAME, JUMIN,
  CASE SUBSTR(JUMIN,7,1)
    WHEN '1' THEN '남자'
    WHEN '2' THEN '여자'
    WHEN '3' THEN '남자'
    WHEN '4' THEN '여자' END 성별
FROM STUDENT;

SELECT NAME, JUMIN, 
  CASE 
   WHEN SUBSTR(JUMIN,7,1) IN (1,3) THEN '남자'
   WHEN SUBSTR(JUMIN,7,1) IN (2,4) THEN '여자'
  END
  FROM STUDENT;

-- 문제
-- 학생의 생일이 1~3월인 경우 1분기, 4~6월 2분기, 7~9월 3분기, 10~12월 4분기 출생분기
-- 학생의 이름, 주민번호, 출생분기를 출력
-- 단 생일은 주민번호 기준으로 한다.

SELECT NAME, JUMIN,
  CASE 
    WHEN SUBSTR(JUMIN,3,2) IN ('01', '02', '03') THEN '1분기'
    WHEN SUBSTR(JUMIN,3,2) IN ('04', '05', '06') THEN '2분기'
    WHEN SUBSTR(JUMIN,3,2) IN ('07', '08', '09') THEN '3분기'
    WHEN SUBSTR(JUMIN,3,2) IN ('10', '11', '12') THEN '4분기' END 출생분기
FROM STUDENT
ORDER BY 3;

--2. BIRTHDAY 기준으로 출력

SELECT NAME, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY,
  CASE 
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '01' AND '03' THEN '1분기'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '04' AND '06' THEN '2분기'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '07' AND '09' THEN '3분기'
    WHEN SUBSTR(BIRTHDAY,4,2) BETWEEN '10' AND '12' THEN '4분기' END 출생분기
FROM STUDENT;













