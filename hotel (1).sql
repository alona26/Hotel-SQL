-- מגישות:
-- אלונה רוזנר 315638155
-- מליסא סוזן גבאי 342687878
CREATE DATABASE hotel;
USE hotel;
/******************** CREATE TABLE ********************/
CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL
);
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(50) NOT NULL,
    street_num INT,
    city_id INT,
    FOREIGN KEY (city_id)
        REFERENCES city (city_id)
        ON UPDATE CASCADE
);
CREATE TABLE customer (
    id_customer INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone CHAR(10) NOT NULL,
      address_id INT,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON UPDATE CASCADE
);
create table job(
id_job int primary key AUTO_INCREMENT,
name_job VARCHAR(10) NOT NULL
);
CREATE TABLE worker (					
    id_worker INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone CHAR(10) NOT NULL,
          address_id INT,
    FOREIGN KEY (address_id)
        REFERENCES address (address_id)
        ON UPDATE CASCADE,
        id_job int,
         FOREIGN KEY (id_job)
        REFERENCES job (id_job)
        ON UPDATE CASCADE
);
CREATE TABLE invitation (
    id_invitation INT PRIMARY KEY AUTO_INCREMENT,
	date_invitation datetime not null default now(),
  price_invitation INT,
    date_end DATE,
    date_start DATE,
    
    id_customer INT,
    FOREIGN KEY (id_customer)
        REFERENCES customer (id_customer)
        ON UPDATE CASCADE,
        
    id_worker INT,
    FOREIGN KEY (id_worker)
        REFERENCES worker (id_worker)
        ON UPDATE CASCADE,
		check (date_invitation <= date_start),
        check (date_start <= date_end)
       
);
CREATE TABLE building(
	id_building INT PRIMARY KEY AUTO_INCREMENT,
    name_building varchar(10)
);
CREATE TABLE type_room (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    num_bed INT,
    price INT, 
    type_name VARCHAR(50) /* zougui, jaccouzi, penthaouse, messiba, moul hayam */
);
CREATE TABLE room (
    id_room INT PRIMARY KEY auto_increment ,
    num_floor INT,
	id_building INT,
    FOREIGN KEY (id_building)
        REFERENCES building (id_building),
    type_id INT,
    FOREIGN KEY (type_id)
        REFERENCES type_room (type_id)
        ON UPDATE CASCADE 
);
ALTER TABLE room AUTO_INCREMENT = 1;
CREATE TABLE clean_room (
    id_clean INT PRIMARY KEY AUTO_INCREMENT,
    start_clean DATETIME default NULL,
    end_clean DATETIME default NULL,
    id_worker INT,
    FOREIGN KEY (id_worker)
        REFERENCES worker (id_worker),
    id_room INT,
    FOREIGN KEY (id_room)
        REFERENCES room (id_room)
);
CREATE TABLE status_room (
    FOREIGN KEY (id_room)
        REFERENCES room (id_room)
        on delete cascade,
        date_update DATE,
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    id_room INT,
    status_name varchar(20) ,
    
    CHECK (status_name IN('not_availble','wait_clean','availble'))
);
CREATE TABLE invitation_room (
	id_invitation_room INT PRIMARY KEY auto_increment,
    id_invitation INT,
    FOREIGN KEY (id_invitation)
        REFERENCES invitation (id_invitation),
        
         id_room INT,
    FOREIGN KEY (id_room)
        REFERENCES room (id_room)
);
/******************** CREATE INSERT RECORDS ********************/
INSERT INTO city(city)
VALUES	("PARIS"),
		("TEL AVIV"),
        ("NEW YORK"),
        ("LOS ANGOLES"),
        ("MIAMI"),
        ("SINGAPOUR"),
        ("EVEN YEHUDA"),
        ("LONDON"),
        ("BARCELONE"),
        ("MOSKU");
INSERT INTO address( street, street_num, city_id)
VALUES	("DIZINGOF", 122, 1),
		("GORDON", 55, 2),
		("BEN GURION", 100, 3),
		("HENRITTA SZOLD", 4, 4),
		("MITZPE", 89, 5),
		("TOUVAL", 10, 6),
		("ARLOZOROV", 7, 7),
		("BOGRASHOV", 65, 8),
		("DAVID HAMELEH", 55, 9),
		("HARAV KOOK", 122, 8),
		("PINKAS", 7, 3),
		("YTSHAK RABIN", 32, 10),
		("MENAHEM BEGIN", 1, 1),
		("MOSHE DAYAN", 38, 1),
		("HAGANA", 33, 2),
		("HERTZL", 90, 4),
		("ALOUF SADE", 21, 6),
		("EINSTEIN", 66, 9),
		("YEROUSHALIM", 55, 5),
        ("CHAMPS ELYSEES", 100, 1);
INSERT INTO job(name_job)
VALUES	("cleaner"),
		("reception");
INSERT INTO customer(first_name, last_name, address_id, phone )
VALUES	("AFNAN", "HALIFA", 1, "0528129969"),
		("TALI", "BARON", 2, "0506271057"),
		("TAL", "COHEN", 3, "0506217342"),
		("LEA", "BIRK", 4, "0545555620"),
		("YOSSI", "BAHAR", 5, "0504773027"),
		("MOUHAMED", "MAADJNA", 6 , "0527773444"),
		("ROTEM", "SARI", 7 , "0504333180"),
		("HAGUIT", "RAHMANI", 8, "0528889004"),
		("OR", "AVNION", 9, "0547219030"),
		("TALI", "HAZUM", 10, "0509466420");

INSERT INTO worker(first_name, last_name, address_id, phone,id_job)
VALUES	("DINAPRIMARY", "PROPS", 11, "0523705783",1),
		("YOSSI", "SAKA", 12, "0527216090",2),
		("EDEN", "POLITKIN", 13, "0528334075",1),
		("LIGAL", "YEHZKEL", 15, "0545927677",2),
		("SAKIS", "RAMZI", 16, "0505554895",1),
		("AVISHAF", "BEN NATAN", 17, "0546224640",1),
		("ASSAD", "FADI", 18, "0543050355",2),
		("SHIMON", "AMIR", 19, "0505935523",1),
		("NIR", "ELFASSA", 14, "0507843015",2),
		("YARON", "DANIEL", 20, "0546889022",1);
        
INSERT INTO invitation(date_invitation , date_end , date_start, id_customer, id_worker)
VALUES	("2019-07-06 13:47:36",  "2020-09-08", "2020-08-09", 2, 5),
		("2020-01-26 10:00:00",  "2020-10-02", "2020-10-01", 2, 5),
		("2019-12-21 23:47:36",  "2020-01-10", "2020-01-01", 1, 9),
		("2005-05-05 14:45:16",  "2021-08-30", "2021-07-26", 4, 10),
		("2016-08-15 00:55:36",  "2016-12-16", "2016-12-14", 10, 2),
		("2019-07-06 13:47:36",  "2019-07-19", "2019-07-17", 3, 2),
		("2009-05-12 06:12:36",  "2009-11-30", "2009-08-16", 4, 6),
		("2017-02-28 09:47:36",  "2017-03-28", "2017-03-01", 9, 7),
		("2009-04-30 12:47:36",  "2009-06-12", "2009-06-04", 5, 3),
		("2019-12-21 13:47:36",  "2020-01-10", "2020-01-01", 9, 8);
INSERT INTO building(name_building)
VALUES	("Premium"),
		("Palas"),
		("Spa"),
		("Vip"),
		("Gold"),
		("Silver"),
		("Club"),
		("Grand"),	
		("Explora"),
		("Lighthouse");

INSERT INTO type_room(num_bed, price, type_name)
VALUES	(4, 50, "FAMILLY"),
		(1, 100, "PRESIDENTIAL"),
		(2, 100, "DOUBLE"),
		(1, 80, "VIEW SEA"),
		(1, 20, "TERRACE"),
		(1, 5, "BASIC");
        
INSERT INTO room(num_floor,id_building, type_id)
VALUES	(1,1,2),
		(1,2,5),
		(1,3,5),
		(2,1,5),
		(2,2,6),
		(2,3,5),
		(1,4,5),
		(2,4,5),
		(1,5,4),
		(1,6,4);
INSERT INTO clean_room(start_clean,end_clean, id_worker,id_room)
VALUES	
		("2021-07-23 12:45:16", "2021-07-23 14:45:16",1, 10),
		("2020-11-11 05:48:16","2020-11-12 06:12:36", 5,2),
		("2019-12-03 10:12:16","2019-12-03 13:47:36", 4,9),
		("2009-04-14 09:05:16", NULL,7,8),
		("2016-01-30 12:10:16","2016-01-30 13:47:36", 4,6),
		("2020-11-11 06:02:16","2020-11-30 13:47:36", 9,5),
		("2016-03-04 14:10:16","2016-03-15 23:55:36", 8,4),
		("2020-09-30 10:35:06","2020-09-30 13:47:36", 6,3),
		("2017-02-28 05:45:16", "2017-02-28 09:47:36", 3,2),
		("2018-04-28 09:45:16","2018-04-29 13:47:36", 2,1);
        
INSERT INTO invitation_room(id_invitation,id_room)
VALUES	(1, 1),
(1, 2),
(2, 1),
(3, 5),
(4, 3),
(5, 4),
(6, 6),
(7, 7),
(8, 8),
(9, 10),
(10, 1);
INSERT INTO status_room(id_room,date_update,status_name)
VALUES	(1,"2015-03-04",'wait_clean'),
 (2,"2021-07-12",'availble'),
 (3,"2021-02-04",'availble'),
(4,"2017-09-04",'wait_clean'),
(5,"2021-07-26",'not_availble'),
(6,"2015-12-16",'wait_clean'),
(7,"2007-09-30",'wait_clean'),
 (8,"2021-7-12",'availble'),
(9,"2018-09-04",'wait_clean'),
(10,"2018-09-04",'wait_clean');
-- עידכון טבלת מחירים של ההזמנות
update invitation 
join
(select ir.id_invitation temperary_id, datediff(i.date_end , i.date_start) * sum(tr.price) final_price
from invitation i
inner join 
invitation_room ir on ir.id_invitation=i.id_invitation
inner join 
room r on ir.id_room=r.id_room
inner join 
type_room tr on tr.type_id=r.type_id
group by ir.id_invitation)t
set price_invitation=t.final_price where id_invitation=t.temperary_id
;

SELECT * FROM city;
SELECT * FROM address;
select * from building;
select * from clean_room;
select * from customer;
select * from invitation;
select * from invitation_room;
select * from room;
select * from status_room;
select * from type_room;
select * from job; 
select * from worker;
-- שאילתות 
-- רשימת חדרים ומצבם
select * from status_room;
-- 10 חדרים שהוזמנו הכי הרבה
SELECT id_room, count(id_room) as count FROM invitation_room GROUP BY id_room limit 10;
-- הצגת כל ההזמנות בשבועיים האחרונים
select * from invitation
where date_invitation between date_sub(now(),INTERVAL 2 WEEK) and now();
-- הצגת העובד שניקה הכי הרבה חדרים
select  worker.id_worker, worker.first_name, worker.last_name , count(clean_room.id_worker) counter
from clean_room
inner join 
worker on worker.id_worker=clean_room.id_worker
group by worker.id_worker
order by counter desc limit 1;
-- הצגת הזמנות פעילות והלקוח שהזמין
SELECT customer.first_name, customer.last_name, invitation.*
FROM customer
INNER JOIN invitation 
on invitation.id_customer=customer.id_customer
where 
invitation.date_start <= CURDATE() and invitation.date_end >= CURDATE()
ORDER BY customer.id_customer;
-- הצגת ללקוחות חוזרים (יותר מהזמנה אחת)
select  customer.*, count(invitation.id_customer) counter
from invitation
inner join 
customer on customer.id_customer=invitation.id_customer
group by customer.id_customer
having counter > 1 
;
-- הצגת הכנסות לפי חודש
select date_invitation, sum(price_invitation) sum_price 
 from invitation group by month(date_invitation) order by date_invitation;

-- פרוצדורות
-- עדכון תחילת\סיום ניקוי חדר- מעדכנת את הטבלאות הרלוונטיות.
-- INPUT: מספר חדר, מספר עובד , פעולה:התחלה\סוף
DELIMITER $$
CREATE procedure pro_clean_room(in_fun varchar(5) ,in_id_room int , in_id_worker int)
begin
DECLARE id_clean_start_update int;
DECLARE id_clean_end_update int;
case 
	when in_fun="start" then
		select id_clean into id_clean_start_update from clean_room where id_room=in_id_room and id_worker=in_id_worker and start_clean is null;
		update  clean_room set start_clean=now(),id_worker=in_id_worker where id_clean=id_clean_start_update;
	when in_fun="end" then 
		select id_clean into id_clean_end_update from clean_room where id_room=in_id_room and id_worker=in_id_worker and end_clean is null;
		update  clean_room set end_clean=now() where id_clean=id_clean_end_update;
        insert into status_room(date_update,id_room,status_name) 
        values(CAST( CURRENT_TIMESTAMP() AS Date ), in_id_room , "availble");
        end case;
end$$
DELIMITER ;
call pro_clean_room ("end",8,7);
select * from clean_room;


-- פרוצדורה
-- בכל הזמנה של חדר במלון- יש לשנות את הסטטוס החדר.
-- INPUT- מספר הזמנה
DELIMITER $$
CREATE procedure pro_update_status(in_id_invitation int)
BEGIN
DECLARE invitation_date_start date;
DECLARE invitation_date_end date;
select date_start into invitation_date_start from invitation where id_invitation=in_id_invitation;
select date_end into invitation_date_end from invitation where id_invitation=in_id_invitation;
  	IF invitation_date_start<=CAST( CURRENT_TIMESTAMP() AS Date ) 
 		and 
 		invitation_date_end>=CAST( CURRENT_TIMESTAMP() AS Date )
     then
		update status_room
		join(select room.id_room , invitation_room.id_invitation from status_room join room on
			room.id_room = status_room.id_room
		inner join invitation_room on
			invitation_room.id_room=room.id_room
            where invitation_room.id_invitation=in_id_invitation
            group by status_room.status_id 
            )t
        set  date_update=CAST( CURRENT_TIMESTAMP() AS Date ),
		status_name="not_availble" 
        where t.id_room=status_room.id_room;
	 END if;
       	IF (invitation_date_start>=CAST( CURRENT_TIMESTAMP() AS Date ) 
		and 
		invitation_date_end>=CAST( CURRENT_TIMESTAMP() AS Date ))
         or
         (invitation_date_start<=CAST( CURRENT_TIMESTAMP() AS Date ) 
 		and 
 		invitation_date_end<=CAST( CURRENT_TIMESTAMP() AS Date ))
    then
		update status_room
		join(select room.id_room , invitation_room.id_invitation from status_room join room on
			room.id_room = status_room.id_room
		inner join invitation_room on
			invitation_room.id_room=room.id_room
            where invitation_room.id_invitation=in_id_invitation
            group by status_room.status_id 
            )t
        set  date_update=CAST( CURRENT_TIMESTAMP() AS Date ),
		status_name="availble" 
        where t.id_room=status_room.id_room;
        END if;
        	IF invitation_date_end = CAST( CURRENT_TIMESTAMP() AS Date ) or 
 		(ADDDATE(invitation_date_end, INTERVAL 2 DAY) >= CAST( CURRENT_TIMESTAMP() AS Date )
        and
        invitation_date_end < CAST( CURRENT_TIMESTAMP() AS Date ))
     then
		update status_room
		join(select room.id_room , invitation_room.id_invitation from status_room join room on
			room.id_room = status_room.id_room
		inner join invitation_room on
			invitation_room.id_room=room.id_room
            where invitation_room.id_invitation=in_id_invitation
            group by status_room.status_id 
            )t
        set  date_update=CAST( CURRENT_TIMESTAMP() AS Date ),
		status_name="wait_clean" 
        where t.id_room=status_room.id_room;
        END if;
END$$
	DELIMITER ;

call pro_update_status(1);
call pro_update_status(6);
select * from status_room;
select * from invitation;
select * from invitation_room;
-- פונקציות
-- מחזירה מספר חדר
set global log_bin_trust_function_creators=1;

DELIMITER $$
CREATE FUNCTION
	room_status(in_id_room int) RETURNS varchar(20)
BEGIN
DECLARE a_room_status varchar(20) default 0;
SELECT 
	status_name 
INTO a_room_status FROM 
	status_room
WHERE 
	status_room.id_room=in_id_room;
RETURN a_room_status;

END$$
DELIMITER ;

SELECT room_status(1);










