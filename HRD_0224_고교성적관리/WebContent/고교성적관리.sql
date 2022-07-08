--고교성적관리 2022-02-24
drop table examtbl_1;
drop table examtbl_2;
drop table examtbl_3;

create table examtbl_1(
syear char(1) not null,
sclass char(2) not null,
sno char(2) not null,
sname varchar2(20),
birth char(8),
gender char(1),
tel1 char(3),
tel2 char(4),
tel3 char(4),
primary key(syear, sclass, sno)
);

insert into EXAMTBL_1 values('1','01','01','김학생','20020101','F','010','1234','1001');
insert into EXAMTBL_1 values('1','01','02','이학생','20020201','M','010','1234','1002');
insert into EXAMTBL_1 values('1','01','03','박학생','20020301','M','010','1234','1003');
insert into EXAMTBL_1 values('1','02','01','조학생','20020401','M','010','1234','1004');
insert into EXAMTBL_1 values('1','02','02','유학생','20020501','M','010','1234','1005');
insert into EXAMTBL_1 values('1','02','03','여학생','20020601','M','010','1234','1006');
insert into EXAMTBL_1 values('1','03','01','남학생','20020701','F','010','1234','1007');
insert into EXAMTBL_1 values('1','03','02','황학생','20020801','F','010','1234','1008');
insert into EXAMTBL_1 values('1','03','03','전학생','20020901','F','010','1234','1009');

select * from EXAMTBL_1;

create table examtbl_2(
syear char(1) not null,
sclass char(2) not null,
tname varchar2(20),--교사명
primary key(syear,sclass)
);

insert into EXAMTBL_2 values('1','01','김교사');
insert into EXAMTBL_2 values('1','02','이교사');
insert into EXAMTBL_2 values('1','03','박교사');

select * from EXAMTBL_2;

create table examtbl_3(
syear char(1) not null,
sclass char(2) not null,
sno char(2) not null,
kor number(3) check (kor between 0 and 100),
--kor number(3) check (0<=kor and kor<=100),
eng number(3) check (eng between 0 and 100),
math number(3) check (math between 0 and 100),
primary key(syear,sclass,sno)
);

insert into EXAMTBL_3 values('1','01','01','50','50','50');
insert into EXAMTBL_3 values('1','01','02','60','40','100');
insert into EXAMTBL_3 values('1','01','03','70','70','70');
insert into EXAMTBL_3 values('1','02','01','80','80','80');
insert into EXAMTBL_3 values('1','02','02','50','50','50');
insert into EXAMTBL_3 values('1','02','03','40','90','80');
insert into EXAMTBL_3 values('1','03','01','80','60','90');
insert into EXAMTBL_3 values('1','03','02','90','80','70');
insert into EXAMTBL_3 values('1','03','03','70','70','70');

commit;

select * from EXAMTBL_3;

--select.jsp-[문제-1]학생등록 후 성적등록 안하면 '성적조회안되도록 함', ※총점수합계, 총점수평균 따로
--[방법-1] , where(중복 제거안함->별칭 사용): syear(학년),sclass(반),sno(번호)로 조인
--[1]
select e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math
from examtbl_1 e1, examtbl_3 e3
where e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno;

--[2]
select e1.syear||'_'||e1.sclass||'_'||e1.sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 e1, examtbl_3 e3
where e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno
group by e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math
order by e1.syear, e1.sclass, e1.sno asc;

--[방법-2] NATURAL JOIN : 중복제거->별칭 사용안함, 조인조건 필요없음
--[1]
select syear, sclass, sno, sname, gender, kor, eng, math
from examtbl_1 NATURAL JOIN examtbl_3;

--[2]
select syear||'_'||sclass||'_'||sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 NATURAL JOIN examtbl_3
--where e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno
group by syear, sclass, sno, sname, gender, kor, eng, math
order by syear, sclass, sno asc;

--select.jsp : 총점수합계, 총점수평균 따로
select sum(kor), sum(eng), sum(math),
round(avg(kor),1), round(avg(eng),1), round(avg(math),1) 
from examtbl_3;
-----------------------------------------------------------------------------
--select.jsp-[문제-2]학생등록 후 성적등록 안해도 '성적조회되도록 함', ※총점수합계, 총점수평균 따로
--[방법-1] , where(중복 제거안함->별칭 사용): syear(학년),sclass(반),sno(번호)로 조인
--[1]
select e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math
from examtbl_1 e1, examtbl_3 e3
where e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno;

--[2]
select e1.syear||'_'||e1.sclass||'_'||e1.sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 e1, examtbl_3 e3
where e1.syear=e3.syear(+) and e1.sclass=e3.sclass(+) and e1.sno=e3.sno(+)
group by e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math
order by e1.syear, e1.sclass, e1.sno asc;

--[방법-2] LEFT OUTER JOIN~ON: 중복제거 안함->별칭 사용, 조인조건 필요
select e1.syear||'_'||e1.sclass||'_'||e1.sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 e1 LEFT OUTER JOIN examtbl_3 e3
ON e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno--조인조건
group by e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math
order by e1.syear, e1.sclass, e1.sno asc;

--[방법-3] LEFT OUTER JOIN~USING: 중복제거->별칭 사용 안함, 조인조건 필요없음
--null 처리를 java로
select syear||'_'||sclass||'_'||sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 LEFT OUTER JOIN examtbl_3
USING(syear, sclass, sno)--조인조건
group by syear, sclass, sno, sname, gender, kor, eng, math
order by syear, sclass, sno asc;

--[방법-3] LEFT OUTER JOIN~USING: 중복제거->별칭 사용 안함, 조인조건 필요없음
--null 처리를 NVL 함수로
--※ NVL(to_char(kor),' ')에서 to_char()함수사용 이유?
--  NVL(문자,' ')    NVL(숫자,0) 처럼 
--  문자는 문자와 매칭      숫자는 숫자와 매칭해야 하므로  
select syear||'_'||sclass||'_'||sno, sname, 
decode(gender,'M','남','F','여') as gender, 
NVL(to_char(kor),' '), NVL(to_char(eng),' '), NVL(to_char(math),' '),
NVL(to_char(sum(kor+eng+math)),' ') as totalsum,
NVL(to_char(round(sum(kor+eng+math)/3,1)),' ') as totalavg
from examtbl_1 LEFT OUTER JOIN examtbl_3
USING(syear, sclass, sno)--조인조건
group by syear, sclass, sno, sname, gender, kor, eng, math
order by syear, sclass, sno asc;

--select.jsp : 총점수합계, 총점수평균 따로
select sum(kor), sum(eng), sum(math),
round(avg(kor),1), round(avg(eng),1), round(avg(math),1) 
from examtbl_3;
-----------------------------------------------------------------------------
--select.jsp-[문제-2]학생등록 후 성적등록 안해도 '성적조회되도록 함', 
--※총점수합계, 총점수평균 같이
select syear||'_'||sclass||'_'||sno, sname, 
decode(gender,'M','남','F','여') as gender, 
kor, eng, math,
sum(kor+eng+math) as totalsum,
round(sum(kor+eng+math)/3,1) as totalavg
from examtbl_1 LEFT OUTER JOIN examtbl_3
USING(syear, sclass, sno)--조인조건
group by syear, sclass, sno, sname, gender, kor, eng, math
--order by syear, sclass, sno asc

UNION

select --"총점수합계"  ""는 오류
null, null, '총점수합계', sum(kor), sum(eng), sum(math), null, null
from examtbl_3

UNION

select
null, null, '총점수평균', round(avg(kor),1), round(avg(eng),1), round(avg(math),1), null, null
from examtbl_3;

-----------------------------------------------------------------------------
--select2.jsp----------------------------------------------------------------
select syear, sclass, tname, 
sum(kor),sum(eng),sum(math),
round(avg(kor),1), round(avg(eng),1), round(avg(math),1)
from examtbl_2 NATURAL JOIN examtbl_3
group by syear, sclass, tname
order by syear asc, sclass asc;

--AVG 함수는 null값을 제외하고 연산하는데,
--null 값을 포함해서 평균을 계산해야 하는 경우에는 NVL 함수를 사용하여
--AVG(NVL(kor,0)) 형태로 null 값을 치환해야 정확한 값이 계산됩니다.
select syear, sclass, tname, 
sum(kor),sum(eng),sum(math),
round(AVG(NVL(kor,0)),1), round(AVG(NVL(eng,0)),1), round(AVG(NVL(math,0)),1)
from examtbl_2 NATURAL JOIN examtbl_3
group by syear, sclass, tname
order by syear asc, sclass asc;















