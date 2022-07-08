--핼스 클럽 2022-05-16
drop table member_tbl;
drop sequence member_tbl_seq;

drop table apptrainer_tbl;
drop table trainer_tbl;


create table member_tbl(
memno char(4) not null primary key,
mname varchar2(20) not null,
maddress varchar2(50) not null,
joindate date not null,
gender char(1),
tel varchar2(15)
);

--memno CHAR(4)도 가능한지 확인 (NUMBER는 가능함)
create sequence member_tbl_seq
start with 1001
increment by 1
minvalue 1001;

insert into member_tbl values(member_tbl_seq.nextval,'김회원','경북 경산시 중방동','19/01/01','M','010-1234-1001');
insert into member_tbl values(member_tbl_seq.nextval,'이회원','경북 경산시 중산동','19/02/01','F','010-1234-1002');
insert into member_tbl values(member_tbl_seq.nextval,'박회원','경북 경산시 옥산동','19/03/01','M','010-1234-1003');
insert into member_tbl values(member_tbl_seq.nextval,'최회원','경북 경산시 삼북동','19/04/01','M','010-1234-1004');
insert into member_tbl values(member_tbl_seq.nextval,'조회원','경북 경산시 중앙동','19/05/01','F','010-1234-1005');
insert into member_tbl values(member_tbl_seq.nextval,'전회원','경북 경산시 중방동','19/06/01','M','010-1234-1006');
insert into member_tbl values(member_tbl_seq.nextval,'남회원','경북 경산시 삼북동','19/07/01','F','010-1234-1007');
insert into member_tbl values(member_tbl_seq.nextval,'여회원','경북 경산시 중산동','19/08/01','M','010-1234-1008');
insert into member_tbl values(member_tbl_seq.nextval,'정회원','경북 경산시 옥산동','19/09/01','F','010-1234-1009');


--insert into member_tbl values('1001','김회원','경북 경산시 중방동','19/01/01','M','010-1234-1001');
--insert into member_tbl values('1002','이회원','경북 경산시 중산동','19/02/01','F','010-1234-1002');
--insert into member_tbl values('1003','박회원','경북 경산시 옥산동','19/03/01','M','010-1234-1003');
--insert into member_tbl values('1004','최회원','경북 경산시 삼북동','19/04/01','M','010-1234-1004');
--insert into member_tbl values('1005','조회원','경북 경산시 중앙동','19/05/01','F','010-1234-1005');
--insert into member_tbl values('1006','전회원','경북 경산시 중방동','19/06/01','M','010-1234-1006');
--insert into member_tbl values('1007','남회원','경북 경산시 삼북동','19/07/01','F','010-1234-1007');
--insert into member_tbl values('1008','여회원','경북 경산시 중산동','19/08/01','M','010-1234-1008');
--insert into member_tbl values('1009','정회원','경북 경산시 옥산동','19/09/01','F','010-1234-1009');

select * from member_tbl;

create table apptrainer_tbl(
tno char(2) not null,
memno char(4) not null,
mname varchar2(20) not null,
ttime varchar2(30) not null,
primary key(tno,memno)
);

insert into apptrainer_tbl values('01','1004','최회원','09:00~12:00');
insert into apptrainer_tbl values('01','1007','남회원','09:00~12:00');
insert into apptrainer_tbl values('02','1002','이회원','12:00~15:00');
insert into apptrainer_tbl values('02','1005','조회원','12:00~15:00');
insert into apptrainer_tbl values('03','1003','박회원','15:00~18:00');
insert into apptrainer_tbl values('03','1006','전회원','15:00~18:00');
insert into apptrainer_tbl values('04','1008','여회원','18:00~21:00');
insert into apptrainer_tbl values('04','1009','정회원','18:00~21:00');
insert into apptrainer_tbl values('04','1001','김회원','18:00~21:00');

select * from apptrainer_tbl;

create table trainer_tbl(
tno char(2) not null primary key,
tname varchar2(20) not null,
hiredate date not null,
ttime varchar2(30) not null
);

insert into trainer_tbl values('01','김헬스','18/01/01','09:00~12:00');
insert into trainer_tbl values('02','이헬스','18/02/01','12:00~15:00');
insert into trainer_tbl values('03','박헬스','18/03/01','15:00~18:00');
insert into trainer_tbl values('04','최헬스','18/04/01','18:00~21:00');

--'05','강헬스'는 insert2.jsp 테스트를 위해 등록함
insert into trainer_tbl values('05','강헬스','22/05/16','09:00~12:00');
--delete from trainer_tbl where tno='05';

--'06','고헬스'는 insert2.jsp 테스트를 위해 등록함
insert into trainer_tbl values('06','고헬스','22/05/16','18:00~21:00');

select * from trainer_tbl;

select ttime from trainer_tbl;

-------------------------------------------------------------------
-- insert2.jsp 테스트를 위해
create table trainer_tbl(
tno char(2) not null primary key,
tname varchar2(20) not null,
hiredate date not null,
ttime varchar2(30)--null 허용
);

insert into trainer_tbl values('01','김헬스','18/01/01','');
insert into trainer_tbl values('02','이헬스','18/02/01','');
insert into trainer_tbl values('03','박헬스','18/03/01','');
insert into trainer_tbl values('04','최헬스','18/04/01','');

--'05','강헬스'는 select2.jsp 테스트를 위해 등록함
insert into trainer_tbl values('05','강헬스','22/05/16','');

select ttime from trainer_tbl;
-------------------------------------------------------------------

--select
select memno,mname,maddress,
to_char(joindate,'yyyy.mm.dd') joindate,
decode(gender,'M','남','F','여') gender,tel
from member_tbl;

--select2
--NATURAL JOIN(X) : 수강생이 없는 새 코치 표시 안됨
select tno,tname,ttime,count(*)
from trainer_tbl NATURAL JOIN apptrainer_tbl
group by tno,tname,ttime
order by tno;

--LEFT OUTER JOIN
--순서-1
select *
from trainer_tbl t LEFT OUTER JOIN apptrainer_tbl a
ON t.tno=a.tno;

--순서-2
select t.tno, tname , t.ttime, count(a.tno)
from trainer_tbl t LEFT OUTER JOIN apptrainer_tbl a
ON t.tno=a.tno
group by t.tno, tname, t.ttime
order by t.tno;


commit