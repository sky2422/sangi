drop table USER_TBL_08;
drop table DEPT_AUTH_TBL_08;
drop table USER_AUTH_TBL_08;

--1. 사용자정보 명세서
create table USER_TBL_08(
USER_NO CHAR(5) NOT NULL PRIMARY KEY,--사용자번호
USER_NAME VARCHAR2(50) NOT NULL,--사용자명
USER_PW VARCHAR2(50),--암호
DEPT_NO CHAR(3),--소속부서번호
USER_GBN CHAR(2),--사용자구분
REG_DATE DATE--등록일자
);

--sequence 생성----------------------------------------------------
create sequence USER_TBL_08_seq
start with 10001
increment by 1
minvalue 1001;

insert into USER_TBL_08 
values(USER_TBL_08_seq.nextval,'홍길동','1111','A01','U1','18/01/10');
insert into USER_TBL_08 
values(USER_TBL_08_seq.nextval,'김유신','1111','A02','U1','18/02/10');
insert into USER_TBL_08 
values(USER_TBL_08_seq.nextval,'이순신','1111','','U2','18/03/10');

--insert into USER_TBL_08 values('10001','홍길동','1111','A01','U1','18/01/10');
--insert into USER_TBL_08 values('10002','김유신','1111','A02','U1','18/02/10');
--insert into USER_TBL_08 values('10003','이순신','1111','','U2','18/03/10');

select * from USER_TBL_08;

--2. 부서별 권한 정보 명세서
create table DEPT_AUTH_TBL_08(
DEPT_NO CHAR(3) NOT NULL,--부서번호
MENU_NO NUMBER NOT NULL,--메뉴번호
PRIMARY KEY(DEPT_NO,MENU_NO)
);

insert into DEPT_AUTH_TBL_08 values('A01',10);
insert into DEPT_AUTH_TBL_08 values('A01',11);
insert into DEPT_AUTH_TBL_08 values('A02',12);
insert into DEPT_AUTH_TBL_08 values('A02',13);

select * from DEPT_AUTH_TBL_08;

--3. 사용자별 권한 정보 명세서
create table USER_AUTH_TBL_08(
USER_NO CHAR(5) NOT NULL,--사용자번호
MENU_NO NUMBER,--메뉴번호
PRIMARY KEY(USER_NO,MENU_NO)
);

insert into USER_AUTH_TBL_08 values('10001',12);
insert into USER_AUTH_TBL_08 values('10003',13);

select * from USER_AUTH_TBL_08;

--select.jsp------------------------------------------------
select USER_NO, USER_NAME, 
NVL(decode(DEPT_NO,'A01','인사','A02','개발','B01','총무','B02','회계'),' ') as DEPT_NO, 
USER_GBN, 
to_char(REG_DATE,'yyyy/mm/dd') as REG_DATE
from USER_TBL_08;

--update.jsp------------------------------------------------
select USER_NO, USER_NAME, USER_PW, 
DEPT_NO, USER_GBN, 
to_char(REG_DATE,'yyyy/mm//dd') as REG_DATE
from USER_TBL_08
where USER_NO='10001';

--select2.jsp-----------------------------------------------
--NATURAL JOIN(x)-> OUTER JOIN(x) -> UNION 해결함

--합집합 UNION : 조회한 다수의 select문을 하나로 합치고 싶을 때()
--UNION ALL : 중북제거를 하지 않고 모두 합쳐서 보여줌
--★단, "컬럼의 개수"와 "각 컬럼의 데이터타입"이 같아야 함

--순서-1
select *
from USER_TBL_08 NATURAL JOIN DEPT_AUTH_TBL_08;--'부서번호'로 NATURAL JOIN

select *
from USER_TBL_08 NATURAL JOIN USER_AUTH_TBL_08;--'사용자번호'로 NATURAL JOIN

--순서-2
select *
from USER_TBL_08 NATURAL JOIN DEPT_AUTH_TBL_08--'부서번호'로 NATURAL JOIN
UNION
select *
from USER_TBL_08 NATURAL JOIN USER_AUTH_TBL_08;--'사용자번호'로 NATURAL JOIN

--순서-3
select USER_NO,USER_NAME,MENU_NO,decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 NATURAL JOIN DEPT_AUTH_TBL_08--'부서번호'로 NATURAL JOIN
UNION
select USER_NO,USER_NAME,MENU_NO,decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 NATURAL JOIN USER_AUTH_TBL_08;--'사용자번호'로 NATURAL JOIN


--차집합 MINUS, 교집합 INTERSECT
--차집합 MINUS (예)
--{도서를 주문하지 않은 고객} = {모든 고객} - {도서를 주문한 고객}
SELECT name -- 모든 고객명
FROM Customer
MINUS
SELECT name -- 주문한 고객명
FROM Customer
WHERE custid IN (SELECT custid FROM Orders);


--select2.jsp : OUTER JOIN으로 해결안됨
--left outer join ~ ON
select u.DEPT_NO, USER_NO, USER_NAME, MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u left outer join DEPT_AUTH_TBL_08 d
ON u.DEPT_NO = d.DEPT_NO;

select u.DEPT_NO, USER_NO, USER_NAME, MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u, DEPT_AUTH_TBL_08 d
WHERE u.DEPT_NO = d.DEPT_NO(+);

--right outer join ~ ON
select u.DEPT_NO, USER_NO, USER_NAME, MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u right outer join DEPT_AUTH_TBL_08 d
ON u.DEPT_NO = d.DEPT_NO;

select u.DEPT_NO, USER_NO,USER_NAME,MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u, DEPT_AUTH_TBL_08 d
WHERE u.DEPT_NO(+) = d.DEPT_NO;

--full outer join ~ ON
select u.DEPT_NO, USER_NO, USER_NAME, MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u full outer join DEPT_AUTH_TBL_08 d
ON u.DEPT_NO = d.DEPT_NO;

select u.DEPT_NO, USER_NO,USER_NAME,MENU_NO,
decode(MENU_NO,10,'부서관리',11,'사원관리',12,'기초정보관리',13,'급여계산')
from USER_TBL_08 u, DEPT_AUTH_TBL_08 d
WHERE u.DEPT_NO(+) = d.DEPT_NO(+);














