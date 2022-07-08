--커피숍 회원관리 2022-05-11
DROP TABLE member_tbl;
DROP SEQUENCE member_tbl_seq;
DROP TABLE sale_tbl;
DROP TABLE sale_tbl2;
DROP TABLE coffee_tbl;
DROP TABLE coffee_tbl2;

CREATE TABLE member_tbl(
CUSTNO NUMBER NOT NULL PRIMARY KEY,
CUSTNAME VARCHAR(20),
GENDER CHAR(1),
PHONE VARCHAR2(13),
ADDRESS VARCHAR(60),
JOINDATE DATE,
GRADE CHAR(1),
CITY CHAR(2)
);

create sequence member_tbl_seq
start with 10001
increment by 1
minvalue 10001;

INSERT INTO member_tbl values(member_tbl_seq.nextval,'김행복','F','010-1111-2222','서울 동대문구 휘경1동','2015-12-02','A','01');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'이축복','M','010-1111-3333','서울 동대문구 휘경2동','2015-12-06','B','01');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'장믿음','F','010-1111-4444','울릉군 울릉읍 독도1리','2015-10-01','B','30');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'최사랑','M','010-1111-5555','울릉군 울릉읍 독도2리','2015-11-13','A','30');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'진평화','F','010-1111-6666','제주도 제주시 외나무골','2015-12-25','B','60');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'차공단','M','010-1111-7777','제주도 제주시 외나무골','2015-12-11','C','60');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'전진주','M','010-1111-8888','대구 수성구 고산1동','2015-11-03','A','90');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'중고차','M','010-1111-9999','대구 수성구 고산2동','2015-09-23','A','90');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'상수리','F','010-1111-0000','대구 수성구 고산3동','2015-12-03','B','90');
INSERT INTO member_tbl values(member_tbl_seq.nextval,'외다리','F','010-1111-1111','대구 수성구 사월동','2015-10-30','C','90');

CREATE TABLE sale_tbl(
CUSTNO NUMBER NOT NULL,
SALENO NUMBER NOT NULL PRIMARY KEY,
AMOUNT NUMBER,
PRICE NUMBER,
PCODE VARCHAR2(4),
SDATE DATE
);

INSERT INTO sale_tbl values(10001,1001,5,15000,'A001','19/01/01');
INSERT INTO sale_tbl values(10002,1002,5,20000,'A002','19/01/02');
INSERT INTO sale_tbl values(10003,1003,5,30000,'A003','19/01/03');
INSERT INTO sale_tbl values(10004,1004,4,20000,'A004','19/01/04');
INSERT INTO sale_tbl values(10005,1005,5,15000,'A001','19/01/05');
INSERT INTO sale_tbl values(10006,1006,1,4000,'A002','19/01/06');
INSERT INTO sale_tbl values(10001,1007,2,12000,'A003','19/01/07');
INSERT INTO sale_tbl values(10002,1008,3,15000,'A004','19/01/08');
INSERT INTO sale_tbl values(10003,1009,4,12000,'A001','19/01/09');
INSERT INTO sale_tbl values(10004,1010,5,20000,'A002','19/01/10');
INSERT INTO sale_tbl values(10005,1011,6,36000,'A003','19/01/11');
INSERT INTO sale_tbl values(10006,1012,7,35000,'A004','19/01/12');
--상품단가 수정 전
CREATE TABLE coffee_tbl(
PCODE VARCHAR(4) NOT NULL primary key,
PNAME VARCHAR(60) NOT NULL,
PCOST NUMBER
);

INSERT INTO coffee_tbl values('A001','아메리카노', 3000);
INSERT INTO coffee_tbl values('A002','카푸치노', 4000);
INSERT INTO coffee_tbl values('A003','카페모카', 6000);
INSERT INTO coffee_tbl values('A004','카라멜마끼야또', 5000);

--상품단가 수정 후(문제에는 없지만 문제를 풀기 위해 직접 생성)
CREATE TABLE coffee_tbl2(
PCODE VARCHAR(4) NOT NULL primary key,
PNAME VARCHAR(60) NOT NULL,
PCOST NUMBER
);

INSERT INTO coffee_tbl2 values('A001','아메리카노', 3000);
INSERT INTO coffee_tbl2 values('A002','카푸치노', 4000);
INSERT INTO coffee_tbl2 values('A003','카페모카', 6000);
INSERT INTO coffee_tbl2 values('A004','카라멜마끼야또', 5000);


CREATE TABLE sale_tbl2(
CUSTNO NUMBER NOT NULL,
SALENO NUMBER NOT NULL PRIMARY KEY,
AMOUNT NUMBER,
PRICE NUMBER,
PCODE VARCHAR2(4),
SDATE DATE
);

INSERT INTO sale_tbl2 values(10001,1001,5,15000,'A001','19/01/01');
INSERT INTO sale_tbl2 values(10002,1002,5,20000,'A002','19/01/02');
INSERT INTO sale_tbl2 values(10003,1003,5,30000,'A003','19/01/03');
INSERT INTO sale_tbl2 values(10004,1004,4,20000,'A004','19/01/04');
INSERT INTO sale_tbl2 values(10005,1005,5,15000,'A001','19/01/05');
INSERT INTO sale_tbl2 values(10006,1006,1,4000,'A002','19/01/06');
INSERT INTO sale_tbl2 values(10001,1007,2,12000,'A003','19/01/07');
INSERT INTO sale_tbl2 values(10002,1008,3,15000,'A004','19/01/08');
INSERT INTO sale_tbl2 values(10003,1009,4,12000,'A001','19/01/09');
INSERT INTO sale_tbl2 values(10004,1010,5,20000,'A002','19/01/10');
INSERT INTO sale_tbl2 values(10005,1011,6,36000,'A003','19/01/11');
INSERT INTO sale_tbl2 values(10006,1012,7,35000,'A004','19/01/12');

--select.jsp---------------------------------------------
select CUSTNO,CUSTNAME,
decode(GENDER,'M','남자','F','여자') as GENDER,
PHONE,ADDRESS,
to_char(JOINDATE, 'yyyy-mm-dd') as JOINDATE,
decode(GRADE,'A','VIP','B','일반','C','직원') as GRADE,
CITY
from member_tbl
ORDER BY 1 ASC;--ASC 생략가능

--update.jsp---------------------------------------------
select CUSTNO,CUSTNAME,GENDER,PHONE,ADDRESS,
to_char(JOINDATE, 'yyyy-mm-dd') as JOINDATE,
GRADE,CITY
from member_tbl
where CUSTNO=10001;

--select2.jsp : 자바로 처리-----------------------------------------------
SELECT PCODE,PNAME,PCOST FROM coffee_tbl;
SELECT PCODE,PNAME,PCOST FROM coffee_tbl2;

--select2_2.jsp :sql로 처리 ---------------------------------------------
select c2.PCODE, c2.PNAME, c2.PCOST 
FROM coffee_tbl c1 JOIN coffee_tbl2 c2
ON c1.PCODE=c2.PCODE AND c1.PNAME=c2.PNAME AND c1.PCOST<>c2.PCOST;--다르다 != <>
--WHERE 검색조건;









SELECT c2.PCODE, c2.PNAME, c2.PCOST 
FROM coffee_tbl c1 JOIN coffee_tbl2 c2
ON c1.PCODE=c2.PCODE AND c1.PNAME=c2.PNAME AND c1.PCOST<>c2.PCOST;--다르다 != <>
--WHERE 검색조건; 

--select3.jsp(추가된 모든 커피목록 표시=즉 회원이 구매하지 않은 커피목록도 표시되도록 하기)---
--1.JOIN~WHERE 조인조건
select c.PNAME, c.PCOST,
nvl(sum(s.AMOUNT),0),--nvl(to_char(sum(s.AMOUNT),'999,999,999'),' '),
nvl(to_char(sum(s.AMOUNT)*c.PCOST,'L999,999,999'),' ')
--nvl(to_char(sum(PRICE),'L999,999,999'),' ')
from coffee_tbl c, sale_tbl s--중복 제거하지 않으므로 별칭 사용함
where c.PCODE=s.PCODE--조인조건
group by PNAME, PCOST
order by 4;

--2.LEFT OUTER JOIN~WHERE 조인조건
select c.PNAME, c.PCOST,
nvl(sum(s.AMOUNT),0),--nvl(to_char(sum(s.AMOUNT),'999,999,999'),' '),
nvl(to_char(sum(s.AMOUNT)*c.PCOST,'L999,999,999'),' ')
--nvl(to_char(sum(PRICE),'L999,999,999'),' ')
from coffee_tbl c, sale_tbl s--중복 제거하지 않으므로 별칭 사용함
where c.PCODE=s.PCODE(+)--조인조건
group by PNAME, PCOST
order by 4 DESC;




