/* 20220816 내용
  trunc 버림
  sysdate 현재날짜
  round 반오림
  add_months 날짜 기준 추가개월뒤에 날짜 
  months_between 두 날짜 사이의 개월
  next_day(날짜,요일) : 다음 돌아올 해당 요일 날짜값 리턴     요일: 일 월 화 수 목 금 토 = 1 2 3 4 5 6 7
  last_day : last_Day(날짜) 날짜의 월의 마지막 날짜 리턴
  
  
  to_char 날짜->문자열 yyyy mm dd 
          숫자->문자열 '99,999'로 세자리마다 쉼표
  to_number
  to_date
  
  nvl
  decode
  
  case when : when으로 조건 조건 나열
  ex)
        case 조건
          when 값1 then 리턴1
          when 값2 then 리턴2
          when 값3 then 리턴3
                  .
                  .
                  .
          when 값 then 리턴N end alias from 테이블  
*/
SELECT * FROM STUDENT;

SELECT GRADE, DEPTNO1, COUNT(*) FROM STUDENT
GROUP BY GRADE, DEPTNO1;

/*
  그룹함수: 복수행 함수
           여러행에 대한 정보를 조회하는 함수
  COUNT() : 레코드 건수, NULL갑 제외           

*/


-- 교수 테이블에서 교수 전체의 인원수와 교수중 보너스 받는 교수의 인원수

SELECT COUNT(*) 전체인원수, COUNT(BONUS) 받는인원, COUNT(*)-COUNT(BONUS) 없는인원  FROM PROFESSOR;

-- 학생의 전체인원수와 지도교수가 배정된 인원수, 지도교수가 없는 인원수

SELECT * FROM STUDENT;
SELECT COUNT(*) 총인원, COUNT(PROFNO) 지도교수배정인원, COUNT(*)-COUNT(PROFNO) 지도교수미지정인원 FROM STUDENT;


-- 학년별 학생의 인원수 조회

SELECT GRADE, COUNT(*) FROM STUDENT
GROUP BY GRADE
ORDER BY GRADE;

-- 학과(DEPTNO1)별 인원수 조회
-- GROUP BY: 컬럼의 값을 기준으로 레코드를 그룹화
--           그룹함수와 컬럼의 값을조회하기 위해서는 반드시 조회든느 컬럼으로 GROUP BY를 설정해줘야함

SELECT DEPTNO1, COUNT(*) FROM STUDENT
GROUP BY DEPTNO1
ORDER BY DEPTNO1;

-- 학년별, 전체인원수, 지도교수가 배정된 인원수를 조회

SELECT GRADE || '학년' 학년, COUNT(*) 전체인원수, COUNT(PROFNO) 지도교수배정인원 FROM STUDENT
GROUP BY GRADE
ORDER BY 학년;

-- 교수 중 직급(POSITION)별 교수의 인원수 조회하기
-- 인원수가 많은 순으로 정렬하기

SELECT POSITION, COUNT(*) FROM PROFESSOR
GROUP BY POSITION
ORDER BY COUNT(*) DESC;

-- SUM 합계 , AVG 평균
-- 교수들에게 지급되는 전체 급여, 급여 평균 합계
-- 급여평균이 많은 순으로 정렬

SELECT DEPTNO 학과번호, SUM(PAY) 급여지출총액, ROUND(AVG(PAY)) 급여지출평균 FROM PROFESSOR
GROUP BY DEPTNO
ORDER BY 3 DESC;


-- 부서별 인원수, 급여평균, 보너스평균

SELECT DEPTNO, COUNT(*) 인원수, AVG(PAY) 급여평균, AVG(NVL(BONUS,0)) 보너스평균 FROM PROFESSOR
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- 모든 그룹함수는 NULL은 제외하고 실행

-- 1. 학생이 학년별 키와 몸무게 평균값, 학년별로 정렬

SELECT GRADE, AVG(HEIGHT) 키평균, AVG(WEIGHT) 몸무게평균 FROM STUDENT
GROUP BY GRADE
ORDER BY GRADE;

-- 2. 교수들에 지급되는 부서별 연봉의 합과 평균 구하기
-- 연봉: 급여*12+보너스
-- 평균: 반올림, 세자리마다 쉼표 표시

SELECT DEPTNO, TO_CHAR(SUM(PAY*12+NVL(BONUS,0)), '99,999') 연봉합계, TO_CHAR(ROUND(AVG(PAY*12+NVL(BONUS,0))), '99,999') 연봉평균, COUNT(*) FROM PROFESSOR
GROUP BY DEPTNO;


-- MAX, MIN : 최대값 최소값

SELECT MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT;

-- 학과별 평균키 큰키 작은키

SELECT DEPTNO1, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY DEPTNO1
ORDER BY DEPTNO1;

-- HAVING 구문: 그룹함수의 족너문
-- 학년별 학생 중 키가 가장 큰 학생의 키와 작은 학생의 키, 평균키를 조회
-- 평균키가 170이상인 학년
SELECT GRADE, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY GRADE
HAVING AVG(HEIGHT) >= 170;

/*
  SELECT 컬럼 FROM 테이블
  WHERE 조건문
  
  --------------------------------
  
  SELECT 컬럼 FROM 테이블
  GROUP BY 컬럼  -> 컬럼이 그룹화하는 기준
  HAVING 조건 -> 그룹함수의 조건문
  ORDER BY 컬럼||별명||컬럼순서  -> 컬럼을 기준으로 정렬 [ASC||DESC]
  
*/

-- 


SELECT CASE SUBSTR(JUMIN,7,1)  WHEN '1' THEN '남자' WHEN '2' THEN '여자' END 성별, MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) FROM STUDENT
GROUP BY SUBSTR(JUMIN,7,1);

-- 1. 주민번호를 기준으로 여학생의 최대키, 최소키, 평균키를 출력하기
SELECT CASE SUBSTR(JUMIN,7,1)  
          WHEN '1' THEN '남자'
          WHEN '2' THEN '여자' END 성별,
          MAX(HEIGHT), MIN(HEIGHT),
          AVG(HEIGHT)
FROM STUDENT
GROUP BY SUBSTR(JUMIN,7,1)
HAVING SUBSTR(JUMIN,7,1) = '2';

-- 여자 키만 출력
SELECT MAX(HEIGHT),
       MIN(HEIGHT),
       AVG(HEIGHT)
FROM STUDENT
WHERE SUBSTR(JUMIN,7,1) = '2';

-- 주민번호 기준 월별 인원
SELECT SUBSTR(JUMIN,3,2)||'월' 월, COUNT(*) 인원 FROM GOGAK
GROUP BY SUBSTR(JUMIN,3,2)
ORDER BY 월;
-- 주민번호 기준 성별 인원
SELECT DECODE(SUBSTR(JUMIN,7,1), 1, '남자', 2, '여자') 성별, COUNT(*) 인원 FROM GOGAK
GROUP BY SUBSTR(JUMIN,7,1)
ORDER BY 성별;
-- 두개같이 조회
SELECT SUBSTR(JUMIN,3,2)||'월' 월, DECODE(SUBSTR(JUMIN,7,1), 1, '남자', 2, '여자') 성별, COUNT(*) 인원 FROM GOGAK
GROUP BY SUBSTR(JUMIN,3,2), SUBSTR(JUMIN,7,1)
ORDER BY 월;



-- STDDEV() 표준편차 함수
-- VARIANCE() 분산

SELECT STDDEV(HEIGHT), STDDEV(WEIGHT), VARIANCE(HEIGHT), VARIANCE(WEIGHT) FROM STUDENT;

-- 전화번호의 지역번호 기준으로 학생수 출력하기

-- 1. 학생들의 전화번호의 지역번호 조회
SELECT SUBSTR(TEL,1,INSTR(TEL,')')-1) FROM STUDENT;

-- 2. 학생들의 전화번호 기준 지역번호 별로 인원 총합 구하기
SELECT SUBSTR(TEL,1,INSTR(TEL,')')-1), COUNT(*) FROM STUDENT
GROUP BY SUBSTR(TEL,1,INSTR(TEL,')')-1)
HAVING COUNT(*) >= 3;
--  지역번호별로 인원수 조회하기

SELECT COUNT(*) 합계,
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '02', 1, 0 )) "서울",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '031', 1, 0 )) "경기도",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '051', 1, 0 )) "부산",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '053', 1, 0 )) "대구",
  SUM(DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1), '055', 1, 0 )) "울산"
FROM STUDENT;

-- ROWNUM : 레코드 조회 순서
--          ORDER BY 구문 이전에 미리 불러오기떄문에 ORDER BY로 인해 ROWNUM값이 바뀌진 않음
-- ROWID : 레코드를 구분할 수 있는 고유의 ID
--         ROWID가 다른 경우는 다른 레코드임

SELECT NAME, GRADE, ROWNUM, ROWID FROM STUDENT;
-- 학생 정보를 5건만 조회하기
SELECT * FROM STUDENT WHERE ROWNUM < 6;
-- ROWNUM값이 6부터 조회하기 (불가능)
-- ROWNUM은 1번 조회할때 1부터 생기기떄문에 WHERE조건에 ROWNUM>6이란 조건을 다는 순간 값을 조회자체가 불가능

-- 학생이름, 학년, 레코드순서를 조회하기

SELECT NAME, GRADE, ROWNUM FROM STUDENT
ORDER BY NAME;

-- 학생의 학년별 인원수, 레코드 순서 조회하기(불가능)
SELECT GRADE, COUNT(*), ROWNUM FROM STUDENT
GROUP BY GRADE; /*결과 없음 실행오류*/

-- 레코드 순서와 학년별 인원수의 레코드 개수가 일치하지않아 학년별이란 그룹으로 나눌수없음

