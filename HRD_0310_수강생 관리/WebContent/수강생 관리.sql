drop table STUDENT_TBL_01;
drop table SUBJECT_TBL_01;
drop table REGISTER_TBL_01;

--unique:null('')값은 허용하지만 동일한 값이 저장되는 것만은 허용하지 않음:동일한 값 저장시 '무결성 제약조건'에 위반되어 저장안됨
CREATE TABLE STUDENT_TBL_01(
STUDENT_NO NUMBER NOT NULL PRIMARY KEY,--수강생번호
STUDENT_NAME VARCHAR2(20 BYTE) NOT NULL,
STUDENT_ADDR VARCHAR2(100 BYTE),
STUDENT_PHONE VARCHAR2(14 BYTE),
STUDENT_BIRTH DATE,
STUDENT_EMAIL VARCHAR2(50 BYTE),
STUDENT_ID VARCHAR2(12 BYTE) unique,
STUDENT_PW VARCHAR2(50 BYTE)
);

INSERT INTO STUDENT_TBL_01 VALUES(201801,'이기자','경산시 진량읍','0112223333','01/09/26','abc@naver.com','','');
INSERT INTO STUDENT_TBL_01 VALUES(201802,'김을동','대구시 수성구 수성1가','0104445555','97/05/19','asd@chol.net','','');
INSERT INTO STUDENT_TBL_01 VALUES(201803,'김희선','제주도 제주시 외나무골','0541112222','02/09/06','qwe@gmail.com','','');

select * from STUDENT_TBL_01;

CREATE TABLE SUBJECT_TBL_01(
SUBJECT_SEQ VARCHAR2(10 BYTE) NOT NULL PRIMARY KEY,
SUBJECT_STARTDATE DATE,
SUBJECT_ENDDATE DATE,
SUBJECT_NAME VARCHAR2(50 BYTE),
SUBJECT_DESC CLOB,--대용량 데이터 타입
SUBJECT_TEACHER VARCHAR2(12 BYTE)
);

INSERT INTO SUBJECT_TBL_01 VALUES('C001','18/09/01','18/09/21','자바프로그래밍','','P04');
INSERT INTO SUBJECT_TBL_01 VALUES('C002','18/09/05','18/09/26','안드로이드 프로그래밍','','P02');
INSERT INTO SUBJECT_TBL_01 VALUES('D001','18/10/01','18/10/21','HTML/CSS','','P04');
INSERT INTO SUBJECT_TBL_01 VALUES('D002','18/10/01','18/10/10','운영체제','','P02');

select * from SUBJECT_TBL_01;

CREATE TABLE REGISTER_TBL_01(
REGISTER_SEQ NUMBER NOT NULL PRIMARY KEY,
STUDENT_NO NUMBER,
SUBJECT_SEQ VARCHAR2(10 BYTE),
REGISTER_DATE DATE,
REGISTER_STATUS CHAR(1 BYTE) DEFAULT 0
);

CREATE SEQUENCE REGISTER_SEQ
start with 1
increment by 1
minvalue 1;

INSERT INTO REGISTER_TBL_01 VALUES(REGISTER_SEQ.nextval,201801,'C001','18/08/30',0);
INSERT INTO REGISTER_TBL_01 VALUES(REGISTER_SEQ.nextval,201802,'C001','18/08/30',0);
INSERT INTO REGISTER_TBL_01 VALUES(REGISTER_SEQ.nextval,201801,'D001','18/09/02',1);
INSERT INTO REGISTER_TBL_01 VALUES(REGISTER_SEQ.nextval,201803,'D001','18/09/02',2);
INSERT INTO REGISTER_TBL_01 VALUES(REGISTER_SEQ.nextval,201803,'D002','18/09/03',1);
--INSERT INTO REGISTER_TBL_01 VALUES(1,201801,'C001','18/08/30',0);
--INSERT INTO REGISTER_TBL_01 VALUES(2,201802,'C001','18/08/30',0);
--INSERT INTO REGISTER_TBL_01 VALUES(3,201801,'D001','18/09/02',1);
--INSERT INTO REGISTER_TBL_01 VALUES(4,201803,'D001','18/09/02',2);
--INSERT INTO REGISTER_TBL_01 VALUES(5,201803,'D002','18/09/03',1);

select * from REGISTER_TBL_01;
commit;
-------------------------------------------------------------------

--select.jsp(이름,연락처,생년월일만 유효성 검사) - 조인 이용 [방법-1] 
--[1].NATURAL JOIN [문제점] : 수강생 등록하고 수강신청하지 않은 학생의 정보는 테이블에 표시X
select STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') AS STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW, count(STUDENT_NO)
from STUDENT_TBL_01 NATURAL JOIN REGISTER_TBL_01--"STUDENT_NO(수강생 번호)"로 조인 후 중복제거하므로 별칭 사용안함
GROUP BY STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, 
STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;

--[2]LEFT OUTER JOIN ~ USING 이용하여 '왼쪽 테이블의 null값 표시'
--[2-1] 
select *
from STUDENT_TBL_01 LEFT OUTER JOIN REGISTER_TBL_01
USING(STUDENT_NO);--중복제거하여 별칭 사용안함(편리)

--[2-2].[문제발생]:수강생 등록하고 수강신청하지 않은 학생의 정보는 표시되나 수강신청하지 않았음에도 수강과목수가 1이 나옴
select STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') AS STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW, 
count(STUDENT_NO)--[문제발생]
from STUDENT_TBL_01 LEFT OUTER JOIN REGISTER_TBL_01
USING(STUDENT_NO)
GROUP BY STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, 
STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;

--[3]. [문제 해결법-1] 
select STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') AS STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW, 
--count(STUDENT_NO)--[문제발생]:수강생 등록하고 수강신청하지 않은 학생의 정보는 표시되나 수강신청하지 않았음에도 수강과목수가 1이 나옴
count(REGISTER_SEQ)--[문제 해결법-1] : 수강과목수 0(이유?REGISTER_SEQ는 REGISTER_TBL의 PK이므로...)
from STUDENT_TBL_01 LEFT OUTER JOIN REGISTER_TBL_01
USING(STUDENT_NO)
GROUP BY STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, 
STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;

--[3]. [문제 해결법-2] 
select s.STUDENT_NO, STUDENT_NAME,STUDENT_ADDR,STUDENT_PHONE,
to_char(STUDENT_BIRTH,'yyyy/mm/dd') as STUDENT_BIRTH, 
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW,
COUNT(case when s.STUDENT_NO=r.STUDENT_NO then 1 end) as count--★★수정
FROM STUDENT_TBL_01 s LEFT OUTER JOIN REGISTER_TBL_01 r
ON s.STUDENT_NO=r.STUDENT_NO
GROUP BY s.STUDENT_NO, STUDENT_NAME,STUDENT_ADDR,STUDENT_PHONE,
STUDENT_BIRTH, 
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;

--[3]. [문제 해결법-3] LEFT OUTER JOIN ~ ON을 이용하여 중복을 제거하지 않고 각 테이블의 STUDENT_NO를 살려야 함
select s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') AS STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW, 
count(r.STUDENT_NO)--★★ 주의 : REGISTER_TBL의 STUDENT_NO
from STUDENT_TBL_01 s LEFT OUTER JOIN REGISTER_TBL_01 r
ON s.STUDENT_NO=r.STUDENT_NO--중복제거되지 않아 별칭 사용함(불편하나 정확한 결과 나옴)
GROUP BY s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, 
STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;

--[4]. 마지막으로 NULL은 공백으로 표시
select s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') AS STUDENT_BIRTH,
nvl(STUDENT_EMAIL,' ') as STUDENT_EMAIL, 
nvl(STUDENT_ID,' ') as STUDENT_ID,
nvl(STUDENT_PW,' ') as STUDENT_PW,
count(r.STUDENT_NO)
from STUDENT_TBL_01 s LEFT OUTER JOIN REGISTER_TBL_01 r
ON s.STUDENT_NO=r.STUDENT_NO--중복제거되지 않아 별칭 사용함(불편하나 정확한 결과 나옴)
GROUP BY s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, 
STUDENT_BIRTH,
STUDENT_EMAIL, STUDENT_ID, STUDENT_PW
ORDER BY 8 ASC, 1 DESC;
-------------------------------------------------------------------

--select.jsp(이름,연락처,생년월일만 유효성 검사) - 서브쿼리 이용 [방법-2]
--[1]
select student_no, count(student_no) as subject_count
from register_tbl_01
group by student_no;
		
--[2]
select student_no, student_name, to_char(student_birth,'yyyy/mm/dd') as student_birth, 
student_phone, student_email, student_id, student_pw, subject_count
from student_tbl_01 LEFT OUTER JOIN (
									 select student_no, count(student_no) as subject_count
									 from register_tbl_01
									 group by student_no
									 ) 
USING(student_no)
order by subject_count asc , student_name asc;


--select2.jsp - [방법-1] NATURAL join------------------------------
--월별 신청 현황
--[1]
select *
from REGISTER_TBL_01;

--[2]
select to_char(REGISTER_DATE,'yyyy/mm'), count(STUDENT_NO)
from REGISTER_TBL_01
--group by REGISTER_DATE--'년월일'하나의 그룹으로 (주의)=>결과가 다라짐
group by to_char(REGISTER_DATE,'yyyy/mm')--'년월'하나의 그룹으로
order by 1;


--수강신청정보조회:방법-1(decode 이용)
--[1]
select *
from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01;--STUDENT_NO로 조인

--[2]
select REGISTER_SEQ, STUDENT_NO, STUDENT_NAME, 과목명, REGISTER_DATE,
decode(REGISTER_STATUS,'0','신청','1','완료','2','취소')
from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01;--STUDENT_NO(수강생번호)로 조인

--[3]
select REGISTER_SEQ, STUDENT_NO, STUDENT_NAME, SUBJECT_NAME, REGISTER_DATE,
decode(REGISTER_STATUS,'0','신청','1','완료','2','취소')
from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01--STUDENT_NO(수강생번호)로 조인
NATURAL join SUBJECT_TBL_01--SUBJECT_SEG(과목번호)로 조인
order by 1 desc;

--수강신청정보조회:방법-2(CASE~END 이용)
select REGISTER_SEQ, STUDENT_NO, STUDENT_NAME, SUBJECT_NAME, REGISTER_DATE,
--decode(REGISTER_STATUS,'0','신청','1','완료','2','취소')
CASE REGISTER_STATUS
when '0' then '신청'
when '1' then '완료'
when '2' then '취소'
END as REGISTER_STATUS
from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01--STUDENT_NO(수강생번호)로 조인
NATURAL join SUBJECT_TBL_01--SUBJECT_SEG(과목번호)로 조인
order by 1 desc;

--select2.jsp - [방법-2] join ~ USING-------------------------------------------
--수강신청정보조회
select register_seq, 
'(' || student_no || ')' || student_name as student_no_name,--★★이 부분도 [방법-1]과 다름
subject_name, register_date, 
decode(register_status, '0', '신청', '1', '완료', '2', '취소') as register_status
from register_tbl_01 join student_tbl_01 USING(student_no)
join subject_tbl_01 USING(subject_seq)
order by register_seq desc;

--updateDelete.jsp(방법-1)----------------------------------------
--★★REGEXP_SUBSTR('문자열', '[^구분자]+', 1, 가져올 순번, 'i')
--java의 String 메서드 중 split()과 비슷  (예)String.split("@") 리턴타입 String[]
--i : 대소문자를 구분할 필요가 없다면 'i'옵션 사용을 지정. 구분하려면 생략
select REGEXP_SUBSTR('A|B|C|D|E', '[^|]+', 1, 3, 'i') from dual;--C

select REGEXP_SUBSTR('A@B@C', '[^@]+', 1, 1) from dual;--A
select REGEXP_SUBSTR('A@B@C', '[^@]+', 1, 2) from dual;--B
select REGEXP_SUBSTR('A@B@C', '[^@]+', 1, 3) from dual;--C

----i : 대소문자를 구분할 필요가 없다.(구분자 : B 또는 b )
select REGEXP_SUBSTR('@b#B%', '[^B]+', 1, 1, 'i') from dual;--@
select REGEXP_SUBSTR('@b#B%', '[^B]+', 1, 2, 'i') from dual;--#
select REGEXP_SUBSTR('@b#B%', '[^B]+', 1, 3, 'i') from dual;--%

----유효성 체크 시 : '이름, 연락처, 생년월일' 만 
----이외는 null값 처리해줘야 함
select STUDENT_NAME, 
nvl(STUDENT_ADDR,' ') as STUDENT_ADDR, 
STUDENT_PHONE, 
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') as STUDENT_BIRTH, 
nvl(REGEXP_SUBSTR(STUDENT_EMAIL, '[^@]+', 1, 1),' ') as STUDENT_EMAIL1,
REGEXP_SUBSTR(STUDENT_EMAIL, '[^@]+', 1, 2) as STUDENT_EMAIL2,
nvl(STUDENT_ID,' ') as STUDENT_ID, 
nvl(STUDENT_PW,' ') as STUDENT_PW
from STUDENT_TBL_01
where STUDENT_NO = 201803;

--updateDelete.jsp(방법-2)----------------------------------------
--sql의 index번호는 1부터 시작, java의  index번호는 0부터 시작

--1.SUBSTR() = 자바의 String의 substring("문자열", 시작index, 끝index+1)과 비슷
-- 함수 SUBSTR('문자열', '시작위치', 길이) 시작위치~길이만큼 자른다.
--    SUBSTR('문자열', '시작위치')      시작위치~끝까지 자른다.

--2.INSTR() = 자바의 String의 indexOf("java", "va")==2와 비슷
--  INSTR('문자열', '검색할 문자', 시작지점, n번째 검색단어) 함수는 찾는 문자의 위치를 반환
--  찾는 문자가 없으면 0을 반환함
--  찾는 단어의 앞글자의 index번호를 반환
--  기본으로 왼쪽부터 시작하여 우측방향으로 스캔함
--  시작지점에 음수를 쓸 경우 우측에서 시작하기 때문에 스캔방향이 좌측방향임

select INSTR('CORPORATE FLOOR', 'OR') AS idx from dual;--2

--단어의 앞글자 인덱스를 반환

--PO 단어를 찾아라
select INSTR('CORPORATE FLOOR', 'PO') AS idx from dual;--4

--6번째 부터 시작해서 해당 단어 OR 위치를 찾아라
select INSTR('CORPORATE FLOOR', 'OR', 6) AS idx from dual;--14

--2번째 부터 시작해서 나오는 값 중에 2번째 값의 위치를 찾아라
select INSTR('CORPORATE FLOOR', 'OR', 2, 2) AS idx from dual;--5

--우측에서 3번째 위치에서 시작해서 왼쪽방향으로 검색하고 2번째 나오는 값의 위치를 찾아라
select INSTR('CORPORATE FLOOR', 'OR', -3, 2) AS idx from dual;--2

----유효성 체크 시 : '이름, 연락처, 생년월일' 만 
----이외는 null값 처리해줘야 함
----(예)cm7777@naver.com : @의 index번호는 7
select STUDENT_NAME, 
nvl(STUDENT_ADDR,' ') as STUDENT_ADDR, 
STUDENT_PHONE, 
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') as STUDENT_BIRTH, 
nvl(SUBSTR(STUDENT_EMAIL, 1, INSTR(STUDENT_EMAIL,'@',1)-1),' ') as STUDENT_EMAIL1,
nvl(SUBSTR(STUDENT_EMAIL, 1, INSTR(STUDENT_EMAIL,'@',1)+1),'naver.com') as STUDENT_EMAIL2,
nvl(STUDENT_ID,' ') as STUDENT_ID, 
nvl(STUDENT_PW,' ') as STUDENT_PW
from STUDENT_TBL_01
where STUDENT_NO = 201803;


--updateDelete.jsp(방법-3) : STUDENT_EMAIL을 자바로 처리------
select STUDENT_NAME, 
nvl(STUDENT_ADDR,' ') as STUDENT_ADDR, 
STUDENT_PHONE, 
to_char(STUDENT_BIRTH, 'yyyy/mm/dd') as STUDENT_BIRTH,
STUDENT_EMAIL, 
nvl(STUDENT_ID,' ') as STUDENT_ID, 
nvl(STUDENT_PW,' ') as STUDENT_PW 
from STUDENT_TBL_01
where STUDENT_NO = 201803;











