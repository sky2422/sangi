--2022-02-25
drop table PLAYER_TBL;
drop table RECORD_TBL;

create table PLAYER_TBL(
PLAYER_NO NUMBER NOT NULL PRIMARY KEY,
PLAYER_NAME VARCHAR2(20) NOT NULL,
TEAM_NO NUMBER,
PLAYER_PHONE VARCHAR2(14),
PLAYER_BIRTH DATE,
PLAYER_EMAIL VARCHAR2(50),
BACK_NO NUMBER
);



insert into PLAYER_TBL values(10001,'김유신',10,'01011112222','80/08/10','ab@naver.com',15);
insert into PLAYER_TBL values(10002,'강감찬',10,'01022223333','81/07/10','cd@daum.net',20);
insert into PLAYER_TBL values(10003,'홍길동',10,'01033334444','80/03/20','ef@gmail.com',21);
insert into PLAYER_TBL values(10004,'이순신',10,'01044445555','82/11/20','',5);

select PLAYER_NO,PLAYER_NAME,TEAM_NO,PLAYER_PHONE,to_char(PLAYER_BIRTH,'yy/mm/dd') as PLAYER_BIRTH,PLAYER_EMAIL,BACK_NO
from PLAYER_TBL;

create table RECORD_TBL(
RECORD_NO NUMBER NOT NULL PRIMARY KEY,
PLAYER_NO NUMBER,
MATCH_NO NUMBER,
P_TIME NUMBER(3),
PLAYER_SCORE NUMBER(2),
YELLOW_CARD NUMBER(2),
RED_CARD NUMBER(2)
);

insert into RECORD_TBL values(1,10001,111,5,0,0,0);
insert into RECORD_TBL values(2,10002,111,90,1,0,1);
insert into RECORD_TBL values(3,10003,111,90,0,2,0);
insert into RECORD_TBL values(4,10004,111,45,2,0,0);
insert into RECORD_TBL values(5,10005,111,45,0,0,0);
insert into RECORD_TBL values(6,10001,112,90,1,0,0);
insert into RECORD_TBL values(7,10002,112,90,1,0,0);
insert into RECORD_TBL values(8,10003,112,90,0,1,0);
insert into RECORD_TBL values(9,10004,112,90,1,1,0);
insert into RECORD_TBL values(10,10005,112,90,0,0,1);
insert into RECORD_TBL values(11,10001,113,45,3,2,1);
insert into RECORD_TBL values(12,10002,113,90,1,1,0);
insert into RECORD_TBL values(13,10003,113,45,2,1,0);
insert into RECORD_TBL values(14,10004,113,45,0,0,0);
insert into RECORD_TBL values(15,10005,113,45,0,0,0);

--테스트 위해 추가함
insert into RECORD_TBL values(16,10004,113,90,1,1,1);--이순신 득점,YELLOW_CARD,RED_CARD 추가
                                                     --=>김유신과 같게

select* from PLAYER_TBL;
select* from RECORD_TBL;

select nvl(max(PLAYER_NO),10000)+1 from PLAYER_TBL;

--select.jsp------------------------------------------------------------
--[1]
select * from PLAYER_TBL;
--[2] sql 함수 사용
select PLAYER_NO,PLAYER_NAME,TEAM_NO, 
substr(PLAYER_PHONE,1,3)||'-'||substr(PLAYER_PHONE,4,4)||'-'||substr(PLAYER_PHONE,8,4),
BACK_NO, to_char(PLAYER_BIRTH,'mm/dd'),
nvl(PLAYER_EMAIL,' ')--''은 null과 같다
from PLAYER_TBL
order by BACK_NO asc;
--[2] 정규식 함수 사용
/* https://gent.tistory.com/221 참조
-- 오라클 ----
REGEXP_REPLACE(PLAYER_PHONE, '(문자열앞3자리)(나머지문자열)(문자열뒤4자리)', '\1-\2-\3')
핸드폰 번호는 [3자리 + (3자리 또는 4자리) + 4자리] 의 형식

-- java : \1-\2-\3에서 특수문자(\)인식하기 위해 앞에 \추가(이스케이프 문자) ----
REGEXP_REPLACE(PLAYER_PHONE, '(문자열앞3자리)(나머지문자열)(문자열뒤4자리)', '\\1-\\2-\\3')
 */
select PLAYER_NO,PLAYER_NAME,TEAM_NO, 
--substr(PLAYER_PHONE,1,3)||'-'||substr(PLAYER_PHONE,4,4)||'-'||substr(PLAYER_PHONE,8,4),
REGEXP_REPLACE(PLAYER_PHONE, '(.{3})(.+)(.{4})', '\1-\2-\3'),--★★자바 : 특수문자(\) 인식하기 위해 \를 앞에 추가(이스케이프 문자)
BACK_NO, to_char(PLAYER_BIRTH,'mm/dd'),
nvl(PLAYER_EMAIL,' ')--''은 null과 같다
from PLAYER_TBL
order by BACK_NO asc;

--update.jsp------------------------------------------------------------
select PLAYER_NO,PLAYER_NAME,TEAM_NO, PLAYER_PHONE,
to_char(PLAYER_BIRTH,'yyyy-mm-dd') as PLAYER_BIRTH, 
NVL(substr(PLAYER_EMAIL,1,INSTR(PLAYER_EMAIL,'@',1)-1),' ') AS PLAYER_EMAIL1, 
NVL(substr(PLAYER_EMAIL,INSTR(PLAYER_EMAIL,'@',1)+1),'naver.com') AS PLAYER_EMAIL2,
BACK_NO
from PLAYER_TBL
where PLAYER_NO=10004;
------------------------------------------------------------------------


--select2.jsp-----------------------------------------------------------
--위쪽 표
--[1]
select * from RECORD_TBL;

--[2]
select MATCH_NO, sum(PLAYER_SCORE), sum(YELLOW_CARD), sum(RED_CARD)
from RECORD_TBL
group by MATCH_NO
order by 1;

--아래쪽 최우수 선수
select PLAYER_NO,sum(PLAYER_SCORE)
from PLAYER_TBL natural join RECORD_TBL
group by PLAYER_NO;

select max(sum(PLAYER_SCORE))
from PLAYER_TBL natural join RECORD_TBL
group by PLAYER_NO;           

--★select2.jsp(최종-1)--가장 잘됨
select PLAYER_NO, player_name, sum(PLAYER_SCORE), sum(YELLOW_CARD),sum(RED_CARD),
rank() over(order by sum(PLAYER_SCORE) desc,sum(RED_CARD) asc,sum(YELLOW_CARD) asc) as rank
from player_tbl natural join RECORD_TBL
group by PLAYER_NO, player_name
order by 6,5,4,1;

----select2_1.jsp(최종-2)
select B.PLAYER_NO, B.player_name, A.score, A.YELLOW_CARD, A.RED_CARD, A.rank
from (select PLAYER_NO, player_name, sum(PLAYER_SCORE) score, sum(YELLOW_CARD) YELLOW_CARD ,sum(RED_CARD) RED_CARD,
             rank() over(order by sum(PLAYER_SCORE) desc,sum(RED_CARD) asc,sum(YELLOW_CARD) asc) as rank
      from player_tbl natural join RECORD_TBL
      group by PLAYER_NO, player_name) A join player_tbl B
on (A.PLAYER_NO = B.PLAYER_NO)
order by A.rank, A.RED_CARD, A.YELLOW_CARD, B.PLAYER_NO;--asc 생략

--select2_1.jsp(최종-2) : natural join으로 통일함
select PLAYER_NO, player_name, score, YELLOW_CARD, RED_CARD, rank
from (select PLAYER_NO, player_name, sum(PLAYER_SCORE) score, sum(YELLOW_CARD) YELLOW_CARD ,sum(RED_CARD) RED_CARD,
             rank() over(order by sum(PLAYER_SCORE) desc,sum(RED_CARD) asc,sum(YELLOW_CARD) asc) as rank
      from player_tbl natural join RECORD_TBL
      group by PLAYER_NO, player_name) natural join player_tbl 
order by rank, RED_CARD, YELLOW_CARD,PLAYER_NO;--asc 생략

--select2_2.jsp(최종):골수만 본다면
select PLAYER_NO,PLAYER_NAME,sum(PLAYER_SCORE)
from PLAYER_TBL natural join RECORD_TBL
group by PLAYER_NO,PLAYER_NAME
                      -- = (select max(sum(PLAYER_SCORE))   = 1개값만
having sum(PLAYER_SCORE) = (select max(sum(PLAYER_SCORE)) -- IN(값 여러개) IN 사용 가능
                             from PLAYER_TBL natural join RECORD_TBL
                             group by PLAYER_NO);

--select2_3.jsp(최종):골수가 같으면 레드카드(적은 순)->엘로우 카드(적은 순)
select PLAYER_NO,PLAYER_NAME,sum(PLAYER_SCORE),sum(YELLOW_CARD),sum(RED_CARD)
from PLAYER_TBL natural join RECORD_TBL
group by PLAYER_NO,PLAYER_NAME
having sum(PLAYER_SCORE) = (select max(sum(PLAYER_SCORE))
                             from PLAYER_TBL natural join RECORD_TBL
                             group by PLAYER_NO)
order by sum(PLAYER_SCORE) desc, sum(RED_CARD) asc, sum(YELLOW_CARD) asc;  
--문제점:골수와 레드카드수,엘로우카드수가 모두 같으면 문제 발생함. 해결해야 함.

--select2_4.jsp(최종)
select PLAYER_NO,sum(PLAYER_SCORE) tosc,
rank() over (order by sum(PLAYER_SCORE) desc, sum(YELLOW_CARD),sum(RED_CARD)) rank
from RECORD_TBL
group by PLAYER_NO;
								
select PLAYER_NO,PLAYER_NAME,total_PLAYER_SCORE
from PLAYER_TBL natural join (select PLAYER_NO,sum(PLAYER_SCORE) as total_PLAYER_SCORE,
								rank() over (order by sum(PLAYER_SCORE) desc, sum(YELLOW_CARD),sum(RED_CARD)) rank
								from RECORD_TBL
								group by  PLAYER_NO)	
where rank=1;


--select2_5.jsp:골수만 본다면. 문제점:1등이 여러명 나오면->자바로 처리
select PLAYER_NO, PLAYER_NAME, max(PLAYER_SCORE2) as PLAYER_SCORE3, 
--max할 필요없음:홍명보의 sum(PLAYER_SCORE)값이 1개이므로
rank() over(order by max(PLAYER_SCORE2) desc) as rank2
from (	select PLAYER_NO, PLAYER_NAME, sum(PLAYER_SCORE) as PLAYER_SCORE2
		from PLAYER_TBL natural join RECORD_TBL		
		group by PLAYER_NO, PLAYER_NAME)
--where rownum = 1 --1등이 하나일 때만 사용
group by PLAYER_NO, PLAYER_NAME
--having rank2 = 1 --사용불가:결과 안나옴
order by 3 DESC, 1; 

--select2_5.jsp(최종):골수만 본다면. 문제점:1등이 여러명 나오면->자바로 처리
select PLAYER_NO, PLAYER_NAME, PLAYER_SCORE2, 
--max할 필요없음:홍명보의 sum(PLAYER_SCORE)값이 1개이므로
rank() over(order by PLAYER_SCORE2 desc) as rank2
from (	select PLAYER_NO, PLAYER_NAME, sum(PLAYER_SCORE) as PLAYER_SCORE2
		from PLAYER_TBL natural join RECORD_TBL		
		group by PLAYER_NO, PLAYER_NAME)
group by PLAYER_NO, PLAYER_NAME,PLAYER_SCORE2 --PLAYER_SCORE2를 그룹에 추가함
order by 3 DESC, 1; 

--IN을 사용하게 되면 서브쿼리의 결과 값과 같은 값을 갖는 모든 데이터를 조회함. 
--같은 항목이 한개인 것만 조회를 할 경우에는 '='을 사용하고 
--여러개일 경우에는 'IN'을 사용.

--[having과 where의 차이]
--1. where
--select * from 테이블명 where 조건절
--항상 from 뒤에 존재하며 비교연산자들을 사용해 조건을 줄 수 있다.

--2.having
--select * from 테이블명 group by 필드명 having 조건절
--항상 group by 뒤에 존재하며 마찬가지로 비교연산자들을 사용해 조건을 준다.

--3. 차이점
--where은 기본적인 조건절로서 우선적으로 모든 필드를 조건에 둘 수 있다. 
--하지만 having은 group by 된 이후 특정한 필드로 그룹화 되어진 새로운 테이블에 조건을 줄 수 있다.

--예를 들어
--1)
--select name, count(*) as cnt 
--from  테이블
--where name='홍길동' 
--group by name; 

--2)
--select name, count(*) as cnt 
--from 테이블 
--group by name 
--having count(*)>1;

--1)의 경우는 where 조건절에 맞는 정보를 우선적으로 들고와서 group by로 그룹화 하고

--2)의 경우는 group by로 그룹화 한 상태에서 having 조건절에 맞는 정보를 들고 오고 
--★이때 having 조건절에 이용할 컬럼은 select 뒤에 반드시 명시 되어야 한다.

--예를들어 동물 테이블이 있고 이름이 존재하고 2번 이상 나온 이름들을 그룹짓고 싶다면

--select NAME, count(NAME) as count
--from ANIMAL_INS
--group by NAME
--having NAME is not null and count(NAME) > 1;
--그룹을 지은 후 having을 사용해 조건을 줘야 한다.
-------------------------------------------------------------------------

--★서브쿼리는 사용빈도가 높으니 확실하게 습득하도록 합니다.
--[서브쿼리의 사용 IN, EXISTS]
--1.IN
--SELECT * FROM AMT_MST_TEST T1 
--WHERE T1.SALARY IN (SELECT S1.SALARY 
--                    FROM AMT_MST_TEST S1 LEFT JOIN DEPT_MST_TEST S2 
--                    ON (S2.DEPT_CD = S1.DEPT_CD) 
--                    WHERE S2.DEPT_NM_KOR = '마케팅부서')

--서브쿼리의 결과값은 1800, 2200, 3000만원. 
--여기에 IN을 사용하게 되면 서브쿼리의 결과 값과 같은 값을 갖는 모든 데이터를 조회함. 
--같은 항목이 한개인 것만 조회를 할 경우에는 '='을 사용하고 
--여러개일 경우에는 'IN'을 사용.
--IN의 부정은 NOT IN 을 사용합니다. 
--NOT IN을 사용하면 서브쿼리의 결과 값과 같지 않은 데이터가 출력

--2.EXISTS:'존재하다' 즉 WHERE문에서 존재하면 '참', 존재하지 않는다면 '거짓'
--EXISTS의 부정은 NOT EXISTS 을 사용합니다. 
--NOT EXISTS을 사용하면 서브쿼리의 결과값이 존재하지 않는경우 출력하지 않고, 존재한다면 출력.
------------------------------------------------------------------------------

--[그룹 함수를 중첩해서 사용하는 경우]

--select department_id 부서번호, max(avg(salary)) 최대평균, min(avg(salary)) 최소평균
--from employees
--group by department_id;

--ORA-00937: not a single-group group function
--00937. 00000 -  "not a single-group group function"

--부서번호를 그룹화 했음에도 불구하고 위의 예제의 경우 에러가 발생한다.

--max(avg()), min(avg())는 평균값의 최대 값과 최소 값이므로 어떤 컬럼으로 그룹을 하던 
--결과는 최대 값 하나 최소 값 하나이다. 
--그러나 부서번호의 경우 부서별로 그룹을 묶었기 때문에 값이 여러 개이다.
--다시 정리하면,
--일단 위의 예제는 부서별로 그룹을 묶었다. 10, 20, 30, … 각 부서마다 그룹으로 묶인 것이다.
--그 후 그룹별로 사원들 급여의 평균 값을 구한다.
--각 그룹별로 평균 값 중에서 최대 값과 최소 값을 구했다. 각각 결과는 하나이다.
--select절에 부서번호를 기술했기 때문에 화면에 출력할 때는 그룹으로 묶인 부서들도 보여주어야 한다.
--현재는 어느 부서의 최대평균, 최소평균인지는 모른다. 단지 평균값들 중에 최대, 최소가 무엇인지만 검색된 상황이다. 각 부서별로 하나의 행을 차지하고 있을텐데 특정 부서의 옆에 최대평균, 최소평균을 같이 출력한다면 마치 그 부서의 최대평균과 최소평균인 것처럼 보이기 때문에 잘못된 정보가 되버린다. 그래서 이런 상황이 나오지 않도록 예제처럼 SQL문을 작성할 경우 에러로 인식되게 한 것이다.


--해결법:department_id 부서번호 삭제
--select max(avg(salary)) 최대평균, min(avg(salary)) 최소평균
--from employees
--group by department_id;

--정리하면 그룹 함수가 중첩된 경우 GROUP BY절에 기술한 컬럼도 출력할 수 없다.
--------------------------------------------------------------------------



				   