--1. 2022년 8월 11일 부터 2023년 1월 16일까지 
--개월수를 반올림해서 소숫점이하 한자리로 출력하기

SELECT ROUND(MONTHS_BETWEEN('2023-01-16', '2022-08-11'), 1) 개월 FROM DUAL;

--2. 교수테이블에서 교수명과 입사일, 현재연봉 3%인상 후 연봉을 출력하기
--  단 연봉은 pay * 12로 하고, 인상후 연봉은 소숫점 이하 삭제함
SELECT NAME,
       HIREDATE,
       PAY*12 현재연봉,
       TRUNC(PAY*12*1.03) "3%인상후 연봉" FROM PROFESSOR;

--3. EMP 테이블에서 사원이름, 입사일, 근무개월수, 현재까지 근무일수를 출력하기
--     근무개월수는 소숫점이하 1자리로 반올림하여 출력하고, 근무일수는 버림하여 정수로 출력하기.
--     단, 근무일수가 많은 사람 순으로 정렬하여 출력하기

SELECT ENAME,
       HIREDATE,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE), 1) 근무개월수,
       TRUNC(SYSDATE-HIREDATE) 근무일수 FROM EMP
ORDER BY 근무일수 DESC;

--4. EMP 테이블에서 10번 부서원의 현재까지의 근무 월수를 계산하여  출력하여라.
--    근무월수는 반올림하여 정수로 출력하기

SELECT * FROM EMP;

SELECT ENAME, DEPTNO,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) 근무월수 FROM EMP
WHERE DEPTNO = 10;

--5.  교수이름, 입사일, 입사년도의 휴가보상일, 올해의 휴가보상일 출력하기
--    휴가보상일 : 입사월의 마지막 일자 


SELECT NAME,
       HIREDATE,
       LAST_DAY(HIREDATE),
       LAST_DAY(TO_DATE(CONCAT(TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(HIREDATE, 'MMDD')))) 올해휴가 FROM PROFESSOR;
/*
SELECT NAME, HIREDATE, LAST_DAY(ADD_MONTHS(HIREDATE, (TRUNC((SYSDATE-HIREDATE)/365)*12))) FROM PROFESSOR;
SELECT NAME, HIREDATE, LAST_DAY(HIREDATE) "입사월보상일",  LAST_DAY(ADD_MONTHS(HIREDATE, (ROUND((SYSDATE-HIREDATE)/365)*12))) 올해휴가보상일 FROM PROFESSOR;
*/

SELECT NAME, hiredate, last_day(hiredate) 입사년도휴가보상일,
             last_day(to_date(to_char(sysdate,'yyyy') || to_char(hiredate,'mmdd'),'yyyymmdd'))  "올해의휴가보상일" 
FROM professor;

--6. 교수테이블에서 2000년 이전에 입사한 교수명과 입사일, 현재연봉
--  10%인상 후 연봉을 출력하기
--  단 연봉은 pay * 12로 하고, 인상후 연봉은 소숫점 이하 삭제함
--  연봉, 인상후연봉 출력시 천단위로 구분하여 ,를 넣어 출력하기

SELECT NAME, HIREDATE, TO_CHAR(PAY*12, '99,999') 연봉, TO_CHAR(FLOOR(PAY*12*1.1), '99,999') 인상후연봉 FROM PROFESSOR
WHERE TO_CHAR(HIREDATE,'YYYY') < 2000;

--7. 교수의 이름, 부서번호와, 교수의 이름이 김도형이면 '석좌교수후보' 출력하고,
--   김도형 교수가 아니면 '출마안함' 출력하기

SELECT NAME, DEPTNO, DECODE(NAME, '김도형', '석좌교수후보', '출마안함') 출마여부 FROM PROFESSOR;

--8. 학생의 이름과, 체중 ,키 ,비만도를 출력하기
--  비만도 :( (실제체중 - 표준체중) / 표준체중 ) * 100
--  표준체중 : (키 - 100) * 0.9
--  비만도 10미만 은 '정상'
--        10 ~ 20미만  '과체중'
--        20이상 '비만' 으로 출력하기

SELECT NAME, WEIGHT 체중, HEIGHT 키, ROUND(((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100) BMI,
  CASE 
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 < 10 THEN '정상'
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 >=10 AND ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 < 20 THEN '과체중'
    WHEN ((WEIGHT - (HEIGHT-100)*0.9)/(HEIGHT-100)*0.9)*100 >=20 THEN '비만' END 비만도
FROM STUDENT;


--9. 학생을 3개 팀으로 분류하기 위해 학번을 3으로 나누어 
--   나머지가 0이면 'A팀', 1이면 'B팀', 2이면 'C팀'으로 
--   분류하여 학생 번호, 이름, 학과 번호, 팀 이름을 출력하여라

SELECT STUDNO, NAME, DEPTNO1, MOD(STUDNO,3),DECODE(MOD(STUDNO,3), '0', 'A팀', '1', 'B팀', '2', 'C팀') 팀이름 FROM STUDENT;

SELECT STUDNO, NAME, DEPTNO1,
       CASE MOD(STUDNO,3)
          WHEN 0 THEN 'A팀'
          WHEN 1 THEN 'B팀'
          WHEN 2 THEN 'C팀' END 팀이름 FROM STUDENT;

--10. 학생의 이름, 지도 교수 번호를 출력하여라. 
--   단, 지도 교수가 배정되지 않은 학생은 지도교수 번호를 
--   0000으로 출력하여라

SELECT NAME, NVL(TO_CHAR(PROFNO), '0000') FROM STUDENT;

-- 강사님 코드
SELECT NAME, TO_CHAR(NVL(PROFNO, 0), '0999') FROM STUDENT;

--11.주민등록번호를 기준으로 학생들의 이름, 사용자 아이디,
--   생년월일을 출력하여라. 
--   단, 사용자 아이디는 소문자로, 생년월일은 '1985/02/01' 형식으로 출력하여라

SELECT NAME, LOWER(ID), TO_CHAR(BIRTHDAY, 'YYYY/MM/DD') FROM STUDENT;

SELECT NAME, LOWER(ID), TO_CHAR(TO_DATE(SUBSTR(JUMIN,1,6)), 'YYYY/MM/DD') FROM STUDENT;



--12. 학생 테이블에서 이름, 키, 키의 범위에 따라 A, B, C ,D등급을 출력하기
--    160 미만 : A등급
--    160 ~ 169까지 : B등급
--    170 ~ 179까지 : C등급
--    180이상       : D등급

SELECT NAME, HEIGHT, 
  CASE
    WHEN HEIGHT < 160 THEN 'A등급'
    WHEN HEIGHT >= 160 AND HEIGHT <170 THEN 'B등급'
    WHEN HEIGHT >= 170 AND HEIGHT <180 THEN 'C등급'
    WHEN HEIGHT >= 180 THEN 'D등급' END 키등급
FROM STUDENT;
