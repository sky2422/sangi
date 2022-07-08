drop table member;
drop table grade;
drop table buy;

create table member(
memno CHAR(4) NOT NULL PRIMARY KEY,
name VARCHAR2(30) NOT NULL,
address VARCHAR2(100) NOT NULL,
hiredate DATE,
gender CHAR(1),
tel1 CHAR(3),
tel2 CHAR(4),
tel3 CHAR(4)
);

-----------select.jsp----------------------------------------
--[방법-1] CASE ~ END + 별칭
select memno, name, address, 
to_char(hiredate,'yyyy.mm.dd.') AS hiredate, 
--CASE gender when 'M' then '남' when 'F' then '여' END AS gender, 
CASE gender when 'M' then '남' else '여' END AS gender,
tel1, tel2, tel3
from member
order by memno;

--[방법-2] DECODE() 함수  + 별칭
select memno, name, address, 
to_char(hiredate,'yyyy.mm.dd.') AS hiredate, 
DECODE(gender, 'M','남', 'F','여') AS gender, 
tel1, tel2, tel3
from member
order by memno;

--[가장 빠른 방법] DECODE() 함수 
select memno, name, address, 
to_char(hiredate,'yyyy.mm.dd.'), 
DECODE(gender, 'M','남', 'F','여'), 
tel1, tel2, tel3
from member
order by memno;

-----------update.jsp----------------------------------------
select memno, name, address,
to_char(hiredate,'yyyy-mm-dd') AS hiredate,
gender,--'M' 또는 'F'
tel1, tel2, tel3
from member
where memno='1001';

--빠른 방법 : INDEX 번호 이용
select memno, name, address,
to_char(hiredate,'yyyy-mm-dd'),
gender,--'M' 또는 'F'
tel1, tel2, tel3
from member
where memno='1001';

--[문제]에서 sequence 생성--------------------------------------------------
create sequence member_seq
start with 1001
increment by 1
minvalue 1001;

--insert into member 
--VALUES(member_seq.nextval,'김고객','경북 경산시 중방동','02/01/01','F','010','1234','1001');
------------------------------------------------------------------------
insert into member 
VALUES('1001','김고객','경북 경산시 중방동','02/01/01','F','010','1234','1001');
insert into member 
VALUES('1002','이고객','경북 경산시 삼북동','02/02/01','M','010','1234','1002');
insert into member 
VALUES('1003','박고객','경북 경산시 옥산동','02/03/01','M','010','1234','1003');
insert into member 
VALUES('1004','조고객','대구 광역시 달서구','02/04/01','M','010','1234','1004');
insert into member 
VALUES('1005','유고객','대전 광역시 유성구','02/05/01','M','010','1234','1005');
insert into member 
VALUES('1006','여고객','대구 광역시 수성구','02/06/01','M','010','1234','1006');
insert into member 
VALUES('1007','남고객','충남 금산군 중도리','02/07/01','F','010','1234','1007');
insert into member 
VALUES('1008','황고객','서울 특별시 관악구','02/08/01','F','010','1234','1008');
insert into member 
VALUES('1009','전고객','서울 특별시 강서구','02/09/01','F','010','1234','1009');

select * from member;

delete * from member where memno='1012';
delete * from member where memno='1013';
delete * from member where memno='1014';
delete * from member where memno='1015';
delete * from member where memno='1016';
delete * from member where memno='1017';
delete * from member where memno='1018';



create table grade(
memgrade NUMBER(1) NOT NULL,
loprice NUMBER(30) NOT NULL,
hiprice NUMBER(30) NOT NULL
);

insert into grade VALUES(1,150001,500000);--VIP
insert into grade VALUES(2,100001,150000);--Gold
insert into grade VALUES(3,50001,100000);--Silver
insert into grade VALUES(4,1,50000);--Normal

select * from grade;


create table buy(
memno CHAR(4) NOT NULL,
prodno CHAR(4) NOT NULL,
product VARCHAR2(20) NOT NULL,
price NUMBER(30),
bno NUMBER(30),
PRIMARY KEY(memno,prodno)
);

insert into buy VALUES('1009','0001','긴 바지',30000,4);
insert into buy VALUES('1009','0002','점퍼',100000,1);
insert into buy VALUES('1006','0004','긴팔 셔츠',25000,1);
insert into buy VALUES('1006','0002','점퍼',100000,1);
insert into buy VALUES('1005','0003','반팔 셔츠',20000,3);
insert into buy VALUES('1002','0003','반팔 셔츠',20000,2);
insert into buy VALUES('1002','0004','긴팔 셔츠',25000,1);
insert into buy VALUES('1001','0004','긴팔 셔츠',25000,1);
insert into buy VALUES('1001','0005','긴팔 후드티',23000,2);

select * from buy;

-----------select2.jsp(방법-1 : JOIN~ON)----------------------------------------
--[순서-1]
select memno, name, price, bno
from member NATURAL JOIN buy;--중복제거되어 별칭 사용X 


select memno, name, SUM(price*bno) as totalprice
from member NATURAL JOIN buy
group by memno, name;

--[순서-2]
--비등가 조인(JOIN~ON) 방법-1
select memgrade, 
memno, name, TO_CHAR(totalprice,'L999,999,999')--지역화폐단위(L)+천단위 구분쉼표
from grade JOIN (select memno, name, SUM(price*bno) as totalprice
				from member NATURAL JOIN buy
				group by memno, name)
ON (totalprice BETWEEN loprice AND hiprice)--비등가조인 조건
order by totalprice desc;


--비등가 조인(JOIN~ON) 방법-2
select memgrade, 
memno, name, TO_CHAR(totalprice,'L999,999,999')--지역화폐단위(L)+천단위 구분쉼표 
from grade JOIN (select memno, name, SUM(price*bno) as totalprice
				from member NATURAL JOIN buy
				group by memno, name)
ON (loprice <= totalprice AND totalprice <= hiprice)--비등가조인 조건
order by totalprice desc;


-----------select2.jsp(방법-2 : , WHERE)----------------------------------------
--[순서-1]
select memno, name, price, bno
from member NATURAL JOIN buy;--중복제거되어 별칭 사용X 


select memno, name, SUM(price*bno) as totalprice
from member NATURAL JOIN buy
group by memno, name;

--[순서-2]
--비등가 조인(JOIN~ON) 방법-1
select memgrade, 
memno, name, TO_CHAR(totalprice,'L999,999,999')--왼쪽공백제거(FM)+지역화폐단위(L)+천단위 구분쉼표 
from grade , (select memno, name, SUM(price*bno) as totalprice
				from member NATURAL JOIN buy
				group by memno, name)
WHERE (totalprice BETWEEN loprice AND hiprice)--비등가조인 조건
order by totalprice desc;


--비등가 조인(JOIN~ON) 방법-2
select memgrade, 
memno, name, TO_CHAR(totalprice,'L999,999,999')--지역화폐단위(L)+천단위 구분쉼표
from grade , (select memno, name, SUM(price*bno) as totalprice
				from member NATURAL JOIN buy
				group by memno, name)
WHERE (loprice <= totalprice AND totalprice <= hiprice)--비등가조인 조건
order by totalprice desc;


-----------select2.jsp(다른방법)----------------------------------------
--[방법-1] JOIN~ON
SELECT CASE when totalprice between (SELECT loprice FROM grade WHERE memgrade = 1) and (SELECT hiprice FROM grade WHERE memgrade = 1) then 'VIP'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 2) and (SELECT hiprice FROM grade WHERE memgrade = 2) then 'Gold'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 3) and (SELECT hiprice FROM grade WHERE memgrade = 3) then 'Silver'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 4) and (SELECT hiprice FROM grade WHERE memgrade = 4) then 'Normal' 
       END AS grade,
m.memno, name, TO_CHAR(totalprice,'L999,999,999')
FROM member m JOIN (SELECT memno, sum(price*bno) AS totalprice
                FROM buy
                GROUP BY memno) b
ON (m.memno = b.memno)
ORDER BY totalprice desc;

--[방법-2], WHERE
SELECT CASE when totalprice between (SELECT loprice FROM grade WHERE memgrade = 1) and (SELECT hiprice FROM grade WHERE memgrade = 1) then 'VIP'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 2) and (SELECT hiprice FROM grade WHERE memgrade = 2) then 'Gold'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 3) and (SELECT hiprice FROM grade WHERE memgrade = 3) then 'Silver'
            when totalprice between (SELECT loprice FROM grade WHERE memgrade = 4) and (SELECT hiprice FROM grade WHERE memgrade = 4) then 'Normal' 
       END AS grade,
m.memno, name, TO_CHAR(totalprice,'L999,999,999')
FROM member m, (SELECT memno, sum(price*bno) AS totalprice
                FROM buy
                GROUP BY memno) b
WHERE m.memno = b.memno
ORDER BY totalprice desc;











