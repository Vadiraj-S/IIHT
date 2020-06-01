create  table  Passenger 
(
	passid int primary key,
	passname varchar(20),
	passemail varchar(20),
	passdob date
);

create table Flight
(
	flightid int primary key,
	flightsource varchar(20),
	flightdest varchar(20),
	flightdate date,
	flightseat int,
	ticketcost float
);

create table Booking
(
	bookingid int primary key,
	flightid int,
	bookdate date,
	foreign key(flightid) references Flight(flightid)
);

create table Booking_details
(
	bookingid int,
	passid int,
	primary key(bookingid,passid),
	foreign key(bookingid) references Booking(bookingid),
	foreign key(passid) references Passenger(passid)
);



Insert into Passenger values(1,'Rajesh','raj@y.com','1980-12-01');
Insert into Passenger values(2,'hira','hira@y.com','1939-11-11');
Insert into Passenger values(3,'sita','sita@y.com','1988-02-06');
Insert into Passenger values(4,'mica','mica@y.com','1973-09-18');
Insert into Passenger values(5,'elizabeth','eliza@y.com','1976-05-09');
Insert into Passenger values(6,'kaushik','kaushik@y.com','1955-08-08');
Insert into Passenger values(7,'Hema','hema@y.com','1955-10-23');

Insert into Flight values(1,'kol','hyd','2012-12-01 22:09:01.340',100,2000.00);
Insert into Flight values(2,'chen','hyd','2012-12-02 22:09:01.340',100,3000.00);
Insert into Flight values(3,'pune','kol','2012-12-02 22:09:01.340',100,2500.00);
Insert into Flight values(4,'bangalore','pune','2012-12-03 22:09:01.340',100,2300.00);
Insert into Flight values(5,'hyd','bangalore','2012-12-05 22:09:01.340',100,2600.00);
Insert into Flight values(6,'pune','hyd','2012-12-03 22:09:01.340',100,2000.00);
Insert into Flight values(7,'pune','kol','2012-12-04 22:09:01.340',100,2900.00);
Insert into Flight values(8,'kol','hyd','2012-12-06 22:09:01.340',100,3500.00);

Insert into Booking values(1,1,'2012-12-01');
Insert into Booking values(2,3,'2012-12-02');
Insert into Booking values(3,4,'2012-12-03');
Insert into Booking values(4,5,'2012-12-04');
Insert into Booking values(5,4,'2012-12-02');
Insert into Booking values(6,1,'2012-12-02');
Insert into Booking values(7,3,'2012-12-02');

Insert into Booking_details values(1,1);
Insert into Booking_details values(1,2);
Insert into Booking_details values(1,3);
Insert into Booking_details values(2,4);
Insert into Booking_details values(3,5);
Insert into Booking_details values(3,6);
Insert into Booking_details values(4,1);
Insert into Booking_details values(5,2);
Insert into Booking_details values(5,3);
Insert into Booking_details values(5,4);


--Queries--
1.	Select passname from passenger where passname like '_e%'

2.	Select passname from passenger where passdob=(select max(passdob) max from passenger);

3.	Select passname,passdob,floor(datediff(day, passdob, getdate()) / 365.25) from passenger;

4.	Select count(*) no_of_flights from flight where flightsource='kol'

6.	Select flightsource from flight where flightsource not in (select flightdest from flight);

7.	Select flightdate from flight where flightid=1 or flightid=4;

8.	Select flightid,count(b.passid) passcount from booking_details b inner join booking d on b.bookingid=d.bookingid group by flightid;

9.	Select passname,passdob,floor(datediff(day, passdob, getdate()) / 365.25)as age from passenger where floor(datediff(day, passdob, getdate()) / 365.25)>=60;

10.	Select bookingid from booking_details group by bookingid having count(passid)=( select max(c) from (select bookingid,count(passid) c from booking_details group by bookingid) a);

11.	Select b.bookingid,f.ticketcost total_fare from booking b inner join flight f on b.flightid=f.flightid

12.	Select flightdest from flight group by flightdest having count(*)=(select max(c) from (select count(*) c from flight group by flightdest)a);

13.	Select passname from passenger where passid in (select passid from booking_details group by passid having count(bookingid)>1);

14.	Select flightid,count(*) no_of_bookings from booking group by flightid;

15.	Select p.passname from passenger p,booking b,flight f,booking_details d where b.flightid='1' and f.flightdate=b.bookdate and d.passid=p.passid and b.bookingid=d.bookingid;

16.	Select flightid from flight where flightdest=flightsource;
