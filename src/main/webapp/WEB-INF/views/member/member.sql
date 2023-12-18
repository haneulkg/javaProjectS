show tables;

create table member2 (
	idx      int not null auto_increment,	       -- 고유번호
	mid      varchar(30) not null,		   	       -- 회원 아이디(중복불허)
	pwd      varchar(100) not null,	   			 	   -- 회원 비밀번호(SHA256 암호화 처리)
	nickName varchar(20) not null,     			     -- 회원 별명(중복불허)
	name     varchar(20) not null,		   		     -- 회원 성명
	gender   char(2) not null default '남자',     -- 회원 성별
	birthday datetime default now(),	           -- 회원 생일
	tel      varchar(15),                        -- 전화번호 : 010-1234-5678
	address  varchar(100),						           -- 주소(다음 API 활용)
	email    varchar(60) not null,               -- 이메일(아이디/비밀번호 분실시에 사용) - 형식체크 필수
	homePage varchar(60),                    		 -- 홈페이지(블로그주소)
	job      varchar(20),					               -- 직업
	hobby    varchar(100),						           -- 취미
	photo    varchar(100) default 'noimage.jpg', -- 회원사진
	content  text,                               -- 회원소개
	userInfor char(3) default '공개',             -- 회원 정보 공개여부(공개/비공개)
	userDel   char(2) default 'NO',              -- 회원 탈퇴 신청여부 (NO:현재 활동중, OK:탈퇴신청중)
	point     int default 100,					 				 -- 회원 누적 포인트(가입포인트:100, 1회방문시:10증가, 1일 최대 50까지 허용, 물건구매시 100원당 1증가)
	level     int default 1,                     -- 회원 등급(0:관리자|1:준회원|2:정회원|3:우수회원|(4:운영자))
	visitCnt  int  default 0,                    -- 총 방문 횟수
	startDate datetime default now(),            -- 최초 가입일
	lastDate  datetime default now(),            -- 마지막 접속일
	todayCnt  int default 0,                     -- 오늘 방문한 횟수
	/* salt      char(8) not null			           -- 비밀번호 보안을 위한 salt*/
	/* primary key (idx, mid) -- 기본키(주키) : 중복불허 */
	primary key (idx),
	unique (mid)
);

drop table member2;

desc member2;

insert into member2 values (default,'admin','1234','관리자','관리맨','남자',default,'010-1111-2222','서울 / / /','haneulk4422@gmail.com','','학생','등산','noimage.jpg','',default,default,default,default,default,default,default,default);

select * from member2;

select *, timestampdiff(day,lastDate,now()) as deleteDiff from member2 order by idx desc limit 0,5;

/* 실시간 DB 채팅 테이블 설계 */
create table memberChat2 (
	idx 	  int not null auto_increment primary key,
	nickName  varchar(30) not null,
	chat	  varchar(100) not null
);

desc memberChat2;

select * from memberChat2 order by idx desc limit 50;