DROP TABLE tbl_product;
DROP TABLE tbl_worklist;
DROP TABLE tbl_process;

create table tbl_product(
p_code Char(4) not null Primary key,
p_name Varchar2(20),
p_size Varchar2(40),
p_type Varchar2(20),
p_price NUMBER(7)
);

--select.jsp
select p_code, p_name, p_size, p_type, to_char(p_price, 'L99,999')
from tbl_product;


insert into tbl_product values('A001','A-1형 소형박스', '100 X 110 X 50','A골판지', 5000);
insert into tbl_product values('A002','A-2형 소형박스', '100 X 110 X 70','A골판지', 6000);
insert into tbl_product values('A003','A-3형 소형박스', '100 X 110 X 100','A골판지',7000);
insert into tbl_product values('B001','B-1형 중형박스', '150 X 130 X 50','B골판지', 10000);
insert into tbl_product values('B002','B-2형 중형박스', '150 X 130 X 70','B골판지', 11000);
insert into tbl_product values('B003','B-3형 중형박스', '150 X 130 X 100','B골판지', 13000);
insert into tbl_product values('C001','C-1형 대형박스', '180 X 150 X 50','C골판지', 15000);
insert into tbl_product values('C002','C-2형 대형박스', '180 X 150 X 70','C골판지', 17000);
insert into tbl_product values('C003','C-3형 대형박스', '180 X 150 X 100','C골판지', 20000);

select * table tbl_product;

create table tbl_worklist(
w_workno Char(8) not null Primary key,
p_code Char(4),
w_quantity Number(5),
w_workdate Date
);

insert into tbl_worklist values('20190001', 'A001', 100, '19/11/01');
insert into tbl_worklist values('20190002', 'A002', 150, '19/11/01');
insert into tbl_worklist values('20190003', 'A003', 200, '19/11/01');
insert into tbl_worklist values('20190004', 'B001', 250, '19/11/02');
insert into tbl_worklist values('20190005', 'B002', 100, '19/11/02');
insert into tbl_worklist values('20190006', 'B003', 150, '19/11/02');
insert into tbl_worklist values('20190007', 'A001', 100, '19/11/03');
insert into tbl_worklist values('20190008', 'A002', 150, '19/11/03');
insert into tbl_worklist values('20190009', 'A003', 200, '19/11/03');

create table tbl_process(
w_workno Char(8) not null Primary key,
p_p1 Char(1),
p_p2 Char(1),
p_p3 Char(1),
p_p4 Char(1),
p_p5 Char(1),
p_p6 Char(1),
w_lastdate Char(8),
w_lasttime Char(4)
);

insert into tbl_process values('20190001', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '0930');
insert into tbl_process values('20190002', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '1030');
insert into tbl_process values('20190003', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '1130');
insert into tbl_process values('20190004', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1330');
insert into tbl_process values('20190005', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1430');
insert into tbl_process values('20190006', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1530');
insert into tbl_process values('20190007', 'Y', 'Y', 'Y', 'Y', 'N', 'N', '20191003', '1630');
insert into tbl_process values('20190008', 'Y', 'Y', 'Y', 'Y', 'N', 'N', '20191003', '1730');


SELECT * FROM tbl_product;
SELECT * FROM tbl_worklist;
SELECT * FROM tbl_process;

--select2.jsp : substr(컴럼명,시작index,가져올 개수)  sql의 index는 1부터 시작
select substr(w_workno,1,4)||'-'||substr(w_workno,5,4),
p_code,p_name,p_size,p_type,w_quantity,
to_char(w_workdate,'yyyy-mm-dd')
from tbl_product natural join tbl_worklist;


--select3.jsp(방법-1)
--순서-1
select *
from TBL_PROCESS pc left outer join TBL_WORKLIST w
on (pc.w_workno=w.w_workno);

--순서-2
--★TBL_PROCESS에 "작업공정등록"이 되므로 pc.w_workno만 사용가능 (w.w_workno은 사용하면 안됨)
select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno,
w.p_code, --"제품명"은 TBL_PRODUCT와 join하여 나중에 추가할 예정임
decode(p_p1,'Y','완료','N','~','') as p_p1,
decode(p_p2,'Y','완료','N','~','') as p_p2,
decode(p_p3,'Y','완료','N','~','') as p_p3,
decode(p_p4,'Y','완료','N','~','') as p_p4,
decode(p_p5,'Y','완료','N','~','') as p_p5,
decode(p_p6,'Y','완료','N','~','') as p_p6,
--to_char(수나 '날짜', '형식') : w_lastdate는 char(문자)이므로 바로 사용불가
--[방법-1] : substr() 사용하여 부분문자열로 분리 후 결합
substr(w_lastdate,1,4)||'-'||substr(w_lastdate,5,2)||'-'||substr(w_lastdate,7,2) as w_lastdate,
substr(w_lasttime,1,2)||':'||substr(w_lasttime,3,2) as w_lasttime
from TBL_PROCESS pc left outer join TBL_WORKLIST w
on (pc.w_workno=w.w_workno);


--순서-3 : "제품명"은 TBL_PRODUCT와 join하여 추가함
--★TBL_PROCESS에 "작업공정등록"이 되므로 pc.w_workno만 사용가능 (w.w_workno은 사용하면 안됨)
select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno,
w.p_code, 
p_name, -- (순서-3)제품명 추가함
decode(p_p1,'Y','완료','N','~','') as p_p1,
decode(p_p2,'Y','완료','N','~','') as p_p2,
decode(p_p3,'Y','완료','N','~','') as p_p3,
decode(p_p4,'Y','완료','N','~','') as p_p4,
decode(p_p5,'Y','완료','N','~','') as p_p5,
decode(p_p6,'Y','완료','N','~','') as p_p6,
--to_char(수나 '날짜', '형식') : w_lastdate는 char(문자)이므로 바로 사용불가
--[방법-1] : substr() 사용하여 부분문자열로 분리 후 결합
substr(w_lastdate,1,4)||'-'||substr(w_lastdate,5,2)||'-'||substr(w_lastdate,7,2) as w_lastdate,
substr(w_lasttime,1,2)||':'||substr(w_lasttime,3,2) as w_lasttime
from TBL_PROCESS pc left outer join TBL_WORKLIST w
on (pc.w_workno=w.w_workno)--USING(w_workno)
left outer join TBL_PRODUCT pd
on (w.p_code=pd.p_code)--USING(p_code)
order by 1 asc;

--select3.jsp(방법-2)
--순서-3 : "제품명"은 TBL_PRODUCT와 join하여 추가함
--★TBL_PROCESS에 "작업공정등록"이 되므로 pc.w_workno만 사용가능 (w.w_workno은 사용하면 안됨)
select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno,
w.p_code, 
p_name, -- (순서-3)제품명 추가함
decode(p_p1,'Y','완료','N','~','') as p_p1,
decode(p_p2,'Y','완료','N','~','') as p_p2,
decode(p_p3,'Y','완료','N','~','') as p_p3,
decode(p_p4,'Y','완료','N','~','') as p_p4,
decode(p_p5,'Y','완료','N','~','') as p_p5,
decode(p_p6,'Y','완료','N','~','') as p_p6,
--to_char(수나 '날짜', '형식') : w_lastdate는 char(문자)이므로 바로 사용불가
--[방법-1] : substr() 사용하여 부분문자열로 분리 후 결합
--substr(w_lastdate,1,4)||'-'||substr(w_lastdate,5,2)||'-'||substr(w_lastdate,7,2) as w_lastdate,
--substr(w_lasttime,1,2)||':'||substr(w_lasttime,3,2) as w_lasttime
--[방법-2] : w_lastdate는 char(문자) -> date(날짜)로 변경 -> to_char() 함수 사용함
to_char(to_date(w_lastdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') as w_lastdate,
to_char(to_date(w_lasttime, 'HH24:MI'), 'HH24:MI') as w_lasttime
from TBL_PROCESS pc,  TBL_WORKLIST w, TBL_PRODUCT pd
where pc.w_workno=w.w_workno(+) AND w.p_code=pd.p_code(+)
order by 1 asc;



--1. to_char(수 또는 날짜, '문자형식'):수 또는 날짜를 '문자'로 변환
create table testtochar(
testdate date,--날짜
testnum number(10)--숫자
);

insert into testtochar values('19/10/10',20191010);

select * from testtochar;

select  
to_char(testdate,'yyyy-mm-dd'),--날짜->문자
to_char(testnum,'L999,999,999'),--수->문자
to_char(testnum,'L000,000,000'),--수->문자 : 자리수에 없는 부분은 0으로 채움
to_char(12345.678,'L9999999.99')--자리수가 맞지 않으면 ########로 표현됨
--소수 세째자리에서 반올림하여 둘째 자리까지 표현
from testtochar;

select  
to_char(testdate,'yyyy-mm-dd'),--날짜->문자
to_char(TO_DATE(testnum,'YYYYMMDD'),'yyyy-mm-dd')--수->날짜->날짜 형식의 문자
from testtochar;


--SELECT TO_CHAR(SAL),
--TO_CHAR(SAL, '$99,999'),  -- 자리를 정리해 주는 역할
--LTRIM( TO_CHAR(SAL, 'L99,999') ),  
--LTRIM( TO_CHAR(SAL, 'L09,999') ),
--LTRIM( TO_CHAR(SAL, 'L00,000') ),
--LTRIM( TO_CHAR(SAL, 'L99,999.00') )
--FROM TBL_NEWSAWON; 

--<<결과>>
--5000      $5,000             ￦5,000          
--￦05,000     ￦05,000       ￦5,000.00

drop table test;

create table test(
testno Varchar2(4),
price Varchar2(20)
);

insert into test values('0001', '12345.678');
insert into test values('0002', '   12345.678');