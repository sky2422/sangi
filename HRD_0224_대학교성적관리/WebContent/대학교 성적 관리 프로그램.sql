drop table student_tbl;
drop table grade_tbl;
drop table score_tbl;

CREATE TABLE student_tbl(
studno NUMBER NOT NULL,
syear CHAR(2) NOT NULL,
sname VARCHAR2(20) NOT NULL,
address VARCHAR2(100) NOT NULL,
gender CHAR(1) NOT NULL,
tel VARCHAR2(30) NOT NULL,
idnum CHAR(14) UNIQUE,
PRIMARY KEY(studno,syear)
);

INSERT INTO student_tbl VALUES(1001,'04','김학생','경북 경산시 중방동','F','010-1234-1001','970101-2000001');
INSERT INTO student_tbl VALUES(1002,'04','이학생','경북 경산시 중산동','M','010-1234-1002','970201-1000001');
INSERT INTO student_tbl VALUES(2001,'03','최학생','경북 경산시 옥산동','M','010-1234-1003','980301-1000001');
INSERT INTO student_tbl VALUES(2002,'03','박학생','경북 경산시 삼북동','F','010-1234-1004','980401-2000001');
INSERT INTO student_tbl VALUES(3001,'02','유학생','대구 광역시 수성구','M','010-1234-1005','990501-1000001');
INSERT INTO student_tbl VALUES(3002,'02','전학생','대구 광역시 달서구','M','010-1234-1006','990601-1000001');
INSERT INTO student_tbl VALUES(4001,'01','남학생','대구 광역시 북구','M','010-1234-1007','000701-3000001');
INSERT INTO student_tbl VALUES(4002,'01','여학생','대전 광역시 유성구','F','010-1234-1008','000801-4000001');
INSERT INTO student_tbl VALUES(4003,'01','정학생','경북 경산시 중앙동','F','010-1234-1009','000901-4000001');

select* from student_tbl;

CREATE TABLE grade_tbl(
grade CHAR(1) NOT NULL,
loscore NUMBER NOT NULL,
hiscore NUMBER NOT NULL
);

INSERT INTO grade_tbl VALUES('A',90,100);
INSERT INTO grade_tbl VALUES('B',80,89);
INSERT INTO grade_tbl VALUES('C',70,79);
INSERT INTO grade_tbl VALUES('D',60,69);
INSERT INTO grade_tbl VALUES('F',0,59);

select* from grade_tbl;

CREATE TABLE score_tbl(
studno NUMBER NOT NULL,
syear CHAR(2) NOT NULL,
m_subject1 NUMBER check(m_subject1 between 0 and 100),
--m_subject1 NUMBER check(0<=m_subject1 and m_subject1<=100),
m_subject2 NUMBER check(m_subject2 between 0 and 100),
m_subject3 NUMBER check(m_subject3 between 0 and 100),
s_subject1 NUMBER check(s_subject1 between 0 and 100),
s_subject2 NUMBER check(s_subject2 between 0 and 100),
PRIMARY KEY(studno,syear)
);

INSERT INTO score_tbl VALUES(1001,'04',80,90,50,20,80);
INSERT INTO score_tbl VALUES(1002,'04',70,80,80,70,30);
INSERT INTO score_tbl VALUES(2001,'03',80,80,80,70,90);
INSERT INTO score_tbl VALUES(2002,'03',90,80,90,70,50);
INSERT INTO score_tbl VALUES(3001,'02',70,60,70,70,70);
INSERT INTO score_tbl VALUES(3002,'02',90,50,70,80,90);
INSERT INTO score_tbl VALUES(4001,'01',90,80,90,90,80);
INSERT INTO score_tbl VALUES(4002,'01',70,60,90,50,80);
INSERT INTO score_tbl VALUES(4003,'01',60,80,90,50,40);

--check constraint (SYSTEM.SYS_C007215) violated 
--INSERT INTO score_tbl VALUES(4004,'01',200,80,90,50,40);


commit;

select* from student_tbl;
select* from grade_tbl;
select* from score_tbl;

select nvl(max(studno),1000)+1 as studno from student_tbl;
select nvl(min(syear),01) as syear from student_tbl;

--select.jsp(과목총점과 과목평균 따로)-------------------------------------------
--학번으로 JOIN : 학생등록과 성적등록이 되어야 표시
select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,
(m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2) AS sumscore,
ROUND((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5,1) AS avgscore
from student_tbl NATURAL JOIN score_tbl--중복제거
order by studno asc;

--학생등록은 했지만 성적등록은 안해도 학생 표시
select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,
(m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2) AS sumscore,
ROUND((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5,1) AS avgscore
from student_tbl LEFT OUTER JOIN score_tbl--중복제거
USING(studno)
order by studno asc;

--과목총점
select SUM(m_subject1),SUM(m_subject2),SUM(m_subject3),SUM(s_subject1),SUM(s_subject2)
from score_tbl;

--과목평균
select ROUND(AVG(m_subject1),1),ROUND(AVG(m_subject2),1),ROUND(AVG(m_subject3),1),ROUND(AVG(s_subject1),1),ROUND(AVG(s_subject2),1)
from score_tbl;

--select.jsp(과목총점과 과목평균 함께)-------------------------------------------
--[1]
select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,
m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2 as total,
round((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5, 1) as avg
from student_tbl left outer join score_tbl 
using(studno)

UNION ALL

select null, '과목 총점', 
sum(m_subject1) as m_subject1, sum(m_subject2) as m_subject2, sum(m_subject3) as m_subject3,
sum(s_subject1) as s_subject1, sum(s_subject2) as s_subject2, 
null, null
from score_tbl

UNION ALL

select null, '과목 평균', 
round(avg(m_subject1),1) as m_subject1, round(avg(m_subject2),1) as m_subject2, round(avg(m_subject3),1) as m_subject3, 
round(avg(s_subject1),1) as s_subject1, round(avg(s_subject2),1) as s_subject2, 
null, null
from score_tbl;

--[2]
SELECT * FROM
		(select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,
		m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2 as total,
		round((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5, 1) as avg
		from student_tbl left outer join score_tbl 
		using(studno)
		
		UNION ALL
		
		select null, '과목 총점', 
		sum(m_subject1) as m_subject1, sum(m_subject2) as m_subject2, sum(m_subject3) as m_subject3,
		sum(s_subject1) as s_subject1, sum(s_subject2) as s_subject2, 
		null, null
		from score_tbl
		
		UNION ALL
		
		select null, '과목 평균', 
		round(avg(m_subject1),1) as m_subject1, round(avg(m_subject2),1) as m_subject2, round(avg(m_subject3),1) as m_subject3, 
		round(avg(s_subject1),1) as s_subject1, round(avg(s_subject2),1) as s_subject2, 
		null, null
		from score_tbl)
ORDER BY studno ASC;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
/* sum과 count함수 비교 설명
sum(컬럼명 number) : 컬럼에 해당하는 전체 합계
count() : 테이블에 데이터가 몇 건이 존재하는지 확인
                         ★ count(*)만 null 포함
*/
drop table test;
create table test(
name varchar2(5),
salary number,
dept varchar2(10),
commission number
);

insert into test values('test1',1000,'d1','');
insert into test values('test2',1000,'d1','');
insert into test values('test3',2000,'','');
insert into test values('test4',1000,'d2','');
insert into test values('test5',2000,'d2','');
insert into test values('test6','','d2','');

select * from test;

select count(*), --6 : 테이블 전체 행수(null 포함)
count(dept),-- 5 : 컬럼 행수(null 제외)
count(NVL(dept,0)),--6 : null을 0으로 변경
count(DISTINCT dept)--2 : null제외, 중복 제외
from test;

select --sum(*),--★★sum(반드시 컬럼명(number) 입력)
sum(salary),--7000(null 제외)
sum(NVL(salary,0)),--7000 : null을 0으로 변경
sum(DISTINCT salary)--3000 : null제외, 중복 제외
from test;

select count(commission), sum(commission)
from test;--0    null

/*
COUNT(1,null,1,null) -> COUNT(1,1) : 행수 2
  SUM(1,null,1,null) ->   SUM(1,1) : 더하면 2


COUNT(3,null,4,null) -> COUNT(3,4) : 행수 2
  SUM(3,null,4,null) ->   SUM(3,4) : 더하면 7
  
만약  모든 데이터가 null이면
COUNT(null, null) -> 행수 0
SUM(null, null) -> NULL 

★★ 따라서 아래 SQL문은 COUNT 대신 SUM 사용 가능
그러나 SUM 결과로 NULL 이 나올 수 있으므로 NULL 처리해줘야 함
*/

--select2.jsp : 'grade 테이블' 사용안함 ------------------------
--성적 우수자 : 90이상
--SUM 이용 : 반드시 else 0 추가
--[1]
select CASE when m_subject1>=90 then 1 else 0 END,
CASE when m_subject2>=90 then 1 else 0 END,
CASE when m_subject3>=90 then 1 else 0 END,
CASE when s_subject1>=90 then 1 else 0 END,
CASE when s_subject2>=90 then 1 else 0 END
from score_tbl;

--[2] ★★주의 : SUM 대신 COUNT 사용하면 행의 수를 구하므로 잘못된 결과(전부 9를 표시)
select SUM(CASE when m_subject1>=90 then 1 else 0 END),
SUM(CASE when m_subject2>=90 then 1 else 0 END),
SUM(CASE when m_subject3>=90 then 1 else 0 END),
SUM(CASE when s_subject1>=90 then 1 else 0 END),
SUM(CASE when s_subject2>=90 then 1 else 0 END)
from score_tbl;

--COUNT 이용
--[1]
select CASE when m_subject1>=90 then 1 END,
CASE when m_subject2>=90 then 1 END,
CASE when m_subject3>=90 then 1 END,
CASE when s_subject1>=90 then 1 END,
CASE when s_subject2>=90 then 1 END
from score_tbl;

--[2] ★★주의 : SUM 대신 COUNT 사용하면 행의 수를 구하므로 잘못된 결과(전부 9를 표시)
select COUNT(CASE when m_subject1>=90 then 1 END),
COUNT(CASE when m_subject2>=90 then 1 END),
COUNT(CASE when m_subject3>=90 then 1 END),
COUNT(CASE when s_subject1>=90 then 1 END),
COUNT(CASE when s_subject2>=90 then 1 END)
from score_tbl;

--재수강 대상자 : 60미만
--SUM 이용 : 반드시 else 0 추가
--[1]
select CASE when m_subject1<60 then 1 else 0 END,
CASE when m_subject2<60 then 1 else 0 END,
CASE when m_subject3<60 then 1 else 0 END,
CASE when s_subject1<60 then 1 else 0 END,
CASE when s_subject2<60 then 1 else 0 END
from score_tbl;

--[2] ★★주의 : SUM 대신 COUNT 사용하면 행의 수를 구하므로 잘못된 결과(전부 9를 표시)
select SUM(CASE when m_subject1<60 then 1 else 0 END),
SUM(CASE when m_subject2<60 then 1 else 0 END),
SUM(CASE when m_subject3<60 then 1 else 0 END),
SUM(CASE when s_subject1<60 then 1 else 0 END),
SUM(CASE when s_subject2<60 then 1 else 0 END)
from score_tbl;

--COUNT 이용
--[1]
select CASE when m_subject1<60 then 1 else 0 END,
CASE when m_subject2<60 then 1 else 0 END,
CASE when m_subject3<60 then 1 else 0 END,
CASE when s_subject1<60 then 1 else 0 END,
CASE when s_subject2<60 then 1 else 0 END
from score_tbl;

--[2] ★★주의 : SUM 대신 COUNT 사용하면 행의 수를 구하므로 잘못된 결과(전부 9를 표시)
select COUNT(CASE when m_subject1<60 then 1 else 0 END),
COUNT(CASE when m_subject2<60 then 1 else 0 END),
COUNT(CASE when m_subject3<60 then 1 else 0 END),
COUNT(CASE when s_subject1<60 then 1 else 0 END),
COUNT(CASE when s_subject2<60 then 1 else 0 END)
from score_tbl;

--select2.jsp : [방법-1] 'grade 테이블' 사용함(SQL문으로 처리) ------------------------

--1.COUNT 사용
select '성적우수자' as subject,

COUNT(
CASE 
when m_subject1
	 between (select loscore from grade_tbl where grade = 'A')
	 and (select hiscore from grade_tbl where grade = 'A') 
then 1 
END) as m_subject1,

COUNT(case when m_subject2
between (select loscore from grade_tbl where grade = 'A') 
and (select hiscore from grade_tbl where grade = 'A') then 1 end) as m_subject2,

COUNT(case when m_subject3
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 end) as m_subject3,

COUNT(case when s_subject1 
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 end) as s_subject1,

COUNT(case when s_subject2
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 end) as s_subject2

from score_tbl

UNION ALL

select '재수강대상자' as subject,
COUNT(case when m_subject1 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 end) as m_subject1,

COUNT(case when m_subject2 
between (select loscore from grade_tbl where grade = 'F') 
and (select hiscore from grade_tbl where grade = 'F') then 1 end) as m_subject2,

COUNT(case when m_subject3 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 end) as m_subject1,

COUNT(case when s_subject1 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 end) as s_subject1,

COUNT(case when s_subject2 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 end) as s_subject2

from score_tbl;

--2.SUM 사용 : SUM 결과로 NULL 이 나올 수 있으므로 NULL 처리해줘야 함
--NULL 처리 방법 : else 0 추가
select '성적우수자' as subject,

SUM(
CASE 
when m_subject1
	 between (select loscore from grade_tbl where grade = 'A')
	 and (select hiscore from grade_tbl where grade = 'A') 
then 1 else 0
END) as m_subject1,

SUM(case when m_subject2
between (select loscore from grade_tbl where grade = 'A') 
and (select hiscore from grade_tbl where grade = 'A') then 1 else 0 end) as m_subject2,

SUM(case when m_subject3
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 else 0 end) as m_subject3,

SUM(case when s_subject1 
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 else 0 end) as s_subject1,

SUM(case when s_subject2
between (select loscore from grade_tbl where grade = 'A')
and (select hiscore from grade_tbl where grade = 'A') then 1 else 0 end) as s_subject2

from score_tbl

UNION ALL

select '재수강대상자' as subject,
SUM(case when m_subject1 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 else 0 end) as m_subject1,

SUM(case when m_subject2 
between (select loscore from grade_tbl where grade = 'F') 
and (select hiscore from grade_tbl where grade = 'F') then 1 else 0 end) as m_subject2,

SUM(case when m_subject3 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 else 0 end) as m_subject1,

SUM(case when s_subject1 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 else 0 end) as s_subject1,

SUM(case when s_subject2 
between (select loscore from grade_tbl where grade = 'F')
and (select hiscore from grade_tbl where grade = 'F') then 1 else 0 end) as s_subject2

from score_tbl;
-----------------------------------------------------------------------------
--select2.jsp : [방법-2] 'grade 테이블' 사용함(java로 처리) ------------------------
--java의 ResultSetMetaData 사용
--성적 우수자 
select count(*)
from score_tbl join grade_tbl--비등가조인
ON(m_subject1 BETWEEN loscore AND hiscore)
WHERE grade='A';

--재수강 대상자
select count(*)
from score_tbl join grade_tbl--비등가조인
ON(m_subject1 BETWEEN loscore AND hiscore)
WHERE grade='F';







