show tables;

create table user (
	idx 		int not null auto_increment primary key,
	mid			varchar(20) not null,
	name 		varchar(20) not null,
	age			int default 20,
	address varchar(10)
);

desc user;

select * from user;

insert into user values (default,"aaa","에이",23,"울산");
insert into user values (default,"bbb","비비",23,"부산");
insert into user values (default,"ccc","씨씨",23,"경주");
insert into user values (default,"ddd","디디",23,"괴산");
insert into user values (default,"eee","이이",23,"보은");

delete from user where idx = 7;
delete from user where idx = 6;

select * from user where name like '%이%' order by idx desc;
select * from user where name like concat('%','이','%') order by idx desc;