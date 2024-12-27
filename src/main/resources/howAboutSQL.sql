create database howAbout;
use howAbout;

CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    x INT,
    y INT
);

select * from locations;
delete from locations where id=3;

CREATE TABLE addrlocations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    x INT,
    y INT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\longlatList.csv'
INTO TABLE addrlocations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(address, longitude, latitude, x, y);

SHOW VARIABLES LIKE 'secure_file_priv';



create table aboutMember(
	userName varchar(16) ,
    userId varchar(50) primary key,
    userPw varchar(30),
    userTel char(12),
    userAddr varchar(30),
    nx int,
    ny int,
    userDate char(10),
    userEmail varchar(100) unique,
    enabled boolean,
    iconName text
);

alter table aboutMember change userEamil userEmail varchar(100) unique;

CREATE TABLE email_tokens (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL
);

drop table aboutMember;
drop table aboutReview;
select * from aboutMember;
delete from aboutMember;
delete from aboutReview;



update aboutMember set enabled=true where userId='tree1234';

update aboutMember set enabled=true where userId="admin";

create table aboutReview(
	userId varchar(50),
    reviewText varchar(500),
    reviewDate char(10),
    millisId bigint primary key,
    placeID varchar(30),
    iconName text,
    foreign key (userId) references aboutMember(userId) on delete cascade
);

ALTER TABLE aboutPlace
ADD COLUMN updateNum INT AUTO_INCREMENT PRIMARY KEY;

insert into aboutReview values('admin', '12345', '2024-12-12', '111111111111', '1000047063', 'icon.jpg');
insert into aboutReview values('admin', '1235', '2024-12-12', '11111111111', '1000047063', 'icon.jpg');
insert into aboutReview values('admin', '145', '2024-12-12', '111111111', '1000047063', 'icon.jpg');

ALTER TABLE aboutPlace
ADD COLUMN mainMenu varchar(50);

select * from aboutReview where placeID='1812156221';

drop table aboutReview;
select * from aboutReview;

create table Place(
	addressName text,
    roadAddress text,
    placeName text,
    category text,
    categoryAll text,
    phone text,
    placeUrl text,
    placeID varchar(30) primary key,
    longitude text,
    latitude text
);

create table aboutWishList(
	userId varchar(50),
    placeId varchar(50),
    placeName text,
    foreign key (userId) references aboutMember(userId) on delete cascade
);

select * from aboutWishList;
select * from place;
delete from place;

create table PlaceTime(
	placeID varchar(30),
    num int auto_increment primary key,
    worktime text,
    foreign key (placeID) references Place(placeID)
);

create table PlaceMenu(
	placeID varchar(30),
    num int auto_increment primary key,
    menuName text,
    menuPrice text,
    foreign key (placeID) references Place(placeID)
);

select * from place limit 50000;
select * from placetime;
select * from placemenu;
drop table place;
drop table placetime;
drop table placemenu;


create table aboutPlace(
	juso text,
    jibun text,
    category varchar(20),
    title varchar(50),
    status varchar(10),
    foodCategory varchar(20),
    latitude double,
    longitude double,
    updateNum INT AUTO_INCREMENT PRIMARY KEY
);
select count(*) from aboutPlace where category='숙박업' or category='일반야영장업';
select * from aboutPlace limit 3343;
select * from aboutPlace where juso LIKE "%마산합포구 삼호로 35 (산호동)";
select distinct category from aboutPlace;
select distinct foodCategory from aboutPlace;
select * from aboutPlace where category="모범음식점";
select * from aboutPlace where title="수장고";
select * from aboutPlace where updateNum='2';

select count(*) from aboutPlace;
select * from aboutPlace;

select * from aboutPlace where updateNum=4;

update aboutPlace set foodCategory="일반음식점" where foodCategory IN ('일반조리판매','기타 휴게음식점','고속도로','백화점','일식','한식','탕류(보신용)','복어취급','중국식','외국음식전문점(인도,태국등)','기타','식육(숯불구이)','패스트푸드','패밀리레스트랑','경양식','통닭(치킨)','');

select * from aboutPlace where juso="abc";
select count(*) from aboutPlace where CAST(latitude AS CHAR) LIKE '35.2193%' AND CAST(longitude AS CHAR) LIKE '128.6752%';

select count(*) from aboutPlace;
-- drop table aboutPlace;

delete from aboutPlace where jibun='경상남도 창원시 마산회원구 양덕로 160';

SELECT YEAR(STR_TO_DATE(userDate, '%Y/%m/%d')) AS year, MONTH(STR_TO_DATE(userDate, '%Y/%m/%d')) AS month FROM aboutMember;


