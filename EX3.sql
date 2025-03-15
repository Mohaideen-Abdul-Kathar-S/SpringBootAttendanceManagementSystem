select EMPLOYEE_ID,FIRST_NAME,SALARY from HR.Employees where SALARY> (select sum(salary)/count(salary) from hr.Employees);


SELECT CUSTOMER_ID, ORDER_ID, ORDER_STATUS FROM Co.orders O WHERE ORDER_ID = ( SELECT MAX(O2.ORDER_ID) FROM Co.orders O2  WHERE O2.CUSTOMER_ID = O.CUSTOMER_ID );


SELECT CUSTOMER_ID FROM Co.customers O WHERE O.CUSTOMER_ID not in ( SELECT o2.CUSTOMER_ID FROM Co.orders O2);

select department_id, DEPARTMENT_NAME from Hr.DEPARTMENTS D where d.DEPARTMENT_ID = (select c.department_id from hr.Employees c group by c.department_ID order by count(c.EMPLOYEE_ID) desc FETCH FIRST 1 ROW ONLY);

select p.product_id,p.product_name from co.products p where p.product_id not in (select o.product_id from co.order_items o);

select s.student_id,s.first_name from ad.ad_student_details s where s.student_id In (select m.student_id from ad.ad_exam_results m where m.course_id=192 and marks >= (select avg(t.marks) from ad.ad_exam_results t where t.course_id=192));

select EMPLOYEE_ID,first_name,salary from hr.Employees order by salary desc fetch first 3 rows only;


create table officers(Oid integer primary key,sol integer,unsol integer,handled integer);
create table reports(rid integer primary key,rtype varchar2(20) not null,city varchar2(20) not null,location varchar2(20),vid varchar2(20),crimerid varchar2(20));
create table victime(vid integer primary key,vname varchar2(20));
create table crimers(cid integer primary key,cname varchar2(20),severity integer);
alter table reports add Oid integer not null;
alter table reports add sol integer;
alter table officers drop column handled;
alter table officers drop column unsol;
alter table officers drop column sol;
alter table officers add oname varchar2(20);
describe officers;
insert into officers values(101,'ramu');
insert into officers values(103,'rasu');
insert into officers values(106,'kavi');
insert into officers values(110,'khan');
describe crimers;
insert into crimers values(200,'frase',24);
insert into crimers values(202,'loosen',12);
insert into crimers values(210,'thani',28);
insert into crimers values(207,'rosen',18);
describe victime;
insert into victime values(302,'jegan');
insert into victime values(303,'jothi');
insert into victime values(310,'kamani');
insert into victime values(308,'vishu');
describe reports;
alter table reports modify vid integer;
alter table reports modify crimerid integer;
insert into reports values(401,'robbery','erode','perundurai',308,207,103,1);
insert into reports values(402,'robbery','erode','perundurai',310,null,101,null);
insert into reports values(403,'rape','chennai','tnager',302,null,103,null);
insert into reports values(404,'rape','erode','gagayam',308,210,106,1);
insert into reports values(405,'morder','coimbatore','pollachi',310,210,103,1);
insert into reports values(406,'morder','erode','perundurai',311,200,106,1);
insert into reports values(407,'rape','theni','varden',305,211,103,1);
select * from reports;

select * from officers o where o.oid In (select r.oid from reports r group by r.oid order by count(r.oid) desc fetch first 1 rows only);
select * from reports r1 where r1.city in (select r2.city from reports r2 group by r2.city order by count(r2.rid) desc fetch first 1 rows only) and r1.sol is null;
select r1.rtype, count(r1.rtype) fre from reports r1 group by r1.rtype order by count(r1.rtype) desc fetch first 1 row only;
select * from victime v where v.vid not in (select r.vid from reports r);

select * from officers where oid in (select r.oid from reports r group by r.oid having count(r.oid)=1)

select * from officers where oid in (select r.oid from reports r where r.crimerid in (select t.cid from crimers t where t.severity = (select max(c.severity) from crimers c)))

SELECT r.location  FROM reports r  GROUP BY r.location HAVING COUNT(r.location) >= (SELECT AVG(report_count) FROM (SELECT t.city, COUNT(t.rid) AS report_count FROM reports t GROUP BY t.city));
