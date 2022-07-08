drop table movie_1;
drop table movie_2;
drop table movie_3;

create table movie_1(
me_id VARCHAR2(12) NOT NULL PRIMARY KEY,
me_pass VARCHAR2(15) NOT NULL,
me_name VARCHAR2(20) NOT NULL,
gender CHAR(1),
birth DATE,
address VARCHAR2(100),
tel VARCHAR2(13)
);

insert into movie_1 
values('kus1','sin1','김유신','M','2004-02-29','경북 경산시 중방동','010-1111-2222');
insert into movie_1 
values('sgj2','joo2','신경주','M','2002-06-18','대구시 수성구 만촌동','010-2222-1111');
insert into movie_1 
values('ymg3','me3','양미경','F','2000-01-01','경북 경산시 남천면','010-3333-4444');
insert into movie_1 
values('kjs4','soo4','김지수','F','2005-11-22','경북 경산시 진량읍','010-4444-3333');
insert into movie_1 
values('jsw5','jang5','장선우','M','1999-12-31','대구시 수성구 사월동','010-5555-6666');
insert into movie_1 
values('gig6','go6','고인규','M','2002-06-24','경북 영천시 금호읍','010-6666-5555');
insert into movie_1 
values('bsy7','year7','박시연','F','2008-08-28','경북 경산시 와촌읍','010-7777-9999');

select* from movie_1;

create table movie_2(
me_id VARCHAR2(12) NOT NULL,
me_pass VARCHAR2(15) NOT NULL,
mo_name VARCHAR2(50) NOT NULL,
rm_date DATE NOT NULL
);



insert into movie_2 values('kus1','sin1','겨울왕국2','2019-11-25');
insert into movie_2 values('kus1','sin1','늑대아이','2019-09-20');
insert into movie_2 values('sgj2','joo2','겨울왕국2','2019-11-24');
insert into movie_2 values('ymg3','me3','김복동','2019-08-15');
insert into movie_2 values('ymg3','me3','썸머워즈','2019-08-22');
insert into movie_2 values('kjs4','soo4','겨울왕국2','2019-11-28');
insert into movie_2 values('jsw5','jang5','김복동','2019-08-14');
insert into movie_2 values('gig6','go6','늑대아이','2019-09-20');
insert into movie_2 values('bsy7','year7','늑대아이','2019-09-25');
insert into movie_2 values('bsy7','year7','시간을 달리는 소녀','2019-01-20');

select* from movie_2;

create table movie_3(
mo_no NUMBER NOT NULL,
mo_name VARCHAR2(50) NOT NULL,
mo_poster VARCHAR2(20),
mo_limit VARCHAR2(20) NOT NULL,
mo_date DATE,
mo_memo VARCHAR2(100),
PRIMARY KEY(mo_no, mo_name)
);

--sequence 생성----------------------------------------------------
create sequence movie_3_seq
start with 1
increment by 1
minvalue 1;

insert into movie_3 
values(movie_3_seq.nextval,'겨울왕국2','겨울왕국.jsp','전체 관람가','2019-11-21','애니메이션 겨울왕국 2탄');
insert into movie_3 
values(movie_3_seq.nextval,'늑대아이','늑대아이.jsp','전체 관람가','2019-09-13','애니메이션 늑대아이');
insert into movie_3 
values(movie_3_seq.nextval,'김복동','김복동.jsp','12세 관람가','2019-08-08','위안부 피해자 고 김복동 할머니를 취재한 다큐멘터리');
insert into movie_3 
values(movie_3_seq.nextval,'시간을 달리는 소녀','시달소.jsp','전체 관람가','2019-01-14','애니메이션 시간을 달리는 소녀');
insert into movie_3 
values(movie_3_seq.nextval,'썸머워즈','썸머워즈.jsp','전체 관람가','2019-08-13','애니메이션  썸머 워즈');
insert into movie_3 
values(movie_3_seq.nextval,'눈의 여왕4','눈여왕.jsp','전체 관람가','2019-12-24','애니메이션 눈의 여왕 4탄');

select* from movie_3;


---select.jsp(방법-1)-----------------------------------------------
select me_id, me_name, mo_name
from MOVIE_1 natural join MOVIE_2;--me_id로 조인

select me_id, me_name, mo_name, mo_limit, count(me_id)
from MOVIE_3 natural join (select me_id, me_name, mo_name
							from MOVIE_1 natural join MOVIE_2)--mo_name로 조인
group by me_id, me_name, mo_name, mo_limit
order by 2 asc;--asc 생략가능

select me_id, me_name, mo_name, mo_limit, count(me_id)
from (select me_id, me_name, mo_name
	  from MOVIE_1 natural join MOVIE_2) natural join MOVIE_3 
group by me_id, me_name, mo_name, mo_limit
order by 2 asc;--asc 생략가능

---select.jsp(방법-2)-----------------------------------------------
select me_id, me_name, mo_name, mo_limit, count(me_id)
from MOVIE_1 natural join MOVIE_2 natural join MOVIE_3
group by me_id, me_name, mo_name, mo_limit
order by 2 asc;--asc 생략가능

---select2.jsp-----------------------------------------------------
select mo_name, mo_limit, count(mo_name)
from MOVIE_2 natural join MOVIE_3
group by mo_name, mo_limit
order by 3 desc, 1 desc;--순서 주의