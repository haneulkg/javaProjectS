show tables;

create table board2 (
	idx     int not null auto_increment,		-- 게시글 고유번호
	mid     varchar(30) not null,			    -- 게시글 작성자 아이디
	nickName varchar(30) not null,				-- 게시글 작성자 닉네임
	title   varchar(100) not null, 				-- 게시글 제목
	email   varchar(60),						-- 이메일주소
	homePage varchar(60),						-- 홈페이지(개인블로그) 주소
	content text not null,						-- 게시글 내용
	readNum int not null default 0,				-- 글 조회수
	hostIp  varchar(40) not null, 				-- 글 작성자 IP
	openSw  char(2) default 'OK',				-- 게시글 공개여부(OK:공개|NO:비공개)
	wDate   datetime default now(),				-- 글 작성한 날짜(시간)
	good    int default 0,						-- 좋아요 클릭 횟수 누적
	primary key(idx)
);

desc board2;

insert into board2 values (default,'admin','관리맨','게시판 서비스를 시작합니다.','kgksmf22@naver.com','','게시할 내용들을 입력해주세요.',default,'192.168.50.54',default,default,default);
select * from board2;
drop table board2;
/* 게시판에 댓글 달기 */
create table board2Reply (
	idx			 int not null auto_increment, -- 댓글의 고유번호
	boardIdx int not null,				  			-- 원본글(부모글)의 고유번호(왜래키로 설정)
	re_step  int not null,								-- 레벨(re_step값)에 따른 들여쓰기(계층번호)>부모댓글의:re_step=1|대댓글:부모의 re_step+1
	re_order int not null,								-- 댓글의 순서 결정 (부모댓글:1|대댓글:부모댓글보다 큰 대댓글의 re_order+1&자신의 re_order=부모re_order+1)
	mid 	   varchar(30) not null,		  	-- 댓글 작성자의 아이디
	nickName varchar(30) not null,		 	  -- 댓글 작성자의 닉네임
	wDate 	 datetime default now(),	 		-- 댓글 작성일
	hostIp   varchar(50) not null,		    -- 댓글 올린 PC의 고유 IP
	content  text not null,				        -- 댓글 내용
	primary key(idx),
 	foreign key(boardIdx) references board2(idx)
 	on update cascade					            -- 부모필드 수정할 경우:영향 받음
 	on delete restrict					  			  -- 부모필드 함부로 삭제 불가
);
desc board2Reply;
drop table board2Reply;
insert into board2Reply values (default,12,'admin','관리맨',default,'210.100.20.25','댓글');
insert into board2Reply values (default,12,'kimm','김',default,'200.130.20.25','ㅎㅇ');
insert into board2Reply values (default,8,'leee','이',default,'200.150.20.25','안녕');
select * from board2Reply where boardIdx=8
select * from board2Reply;

select b.*,br.nickName from board2 b, board2Reply br where b.idx=br.boardIdx;
select b.*,br.nickName,br.boardIdx from board2 b,(select * from board2Reply where boardIdx=8) br where b.idx=8;

select * from board2;

select * from board2 order by idx desc limit 0, 10;

select *,datediff(wDate, now()) from board2 order by idx desc limit 0, 10;

/* 댓글수 연습 */
-- 게시판(board)리스트화면에서 글제목옆 해당글의 댓글(boardReply)수를 출력하기
-- 전체 board테이블의 내용을 최신순으로 출력하기
select * from board2 order by idx desc;

-- board테이블 고유번호 18번에 해당하는 댓글테이블(boardReply)의 댓글수 구하기
select count(*) from board2Reply where boardIdx=8;

-- 앞의 예에서 원본글 고유번호(8)와 함께, 총 댓글의 갯수는 replyCnt란 변수로 출력하시오
select boardIdx,count(*) as replyCnt from board2Reply where boardIdx=8;

-- 앞의 예제에 이어서, 원본글을 쓴 닉네임도 함께 출력하기(닉네임은 부모테이블에서 가져와서 출력하기)
select boardIdx,count(*) as replyCnt,(select nickName from board where idx=8) as nickName from boardReply where boardIdx=8;

-- 앞의 내용을 부모관점(board)에서 처리하기
-- 18번 게시글의 mid와 닉네임을 출력하기
select mid,nickName from board where idx=8;

-- 앞에 이어서 닉네임을 자식(댓글테이블)에서 가져와서 보여주기
select mid,(select nickName from boardReply where boardIdx=8 limit 1) as nickName from board where idx=8;

-- 부모글(원본글)에 해당하는 자식글(댓글)의 갯수를 부모글과 함께 출력하기
select *,(select count(*) from boardReply where boardIdx=8) as replyCnt from board where idx=8;

/* new.gif를 24시간동안만 보여주기 위한 처리하기 */
select *,timestampdiff(hour, wDate, now()) from board order by idx desc limit 0, 10;

/* 이전글|다음글 꺼내오기 */
select * from board where idx = 8; -- 현재글
select * from board where idx < 8 order by idx desc limit 1; -- 이전글
select * from board where idx > 8 order by idx limit 1; -- 다음글

/* 날짜 함수 연습 */
select now();
/* date_add() - datetime형식비교 */
select now() as 오늘날짜, date_add(now(), interval 1 day);   -- 하루 후
select now() as 오늘날짜, date_add(now(), interval -1 day);  -- 하루 전
select now() as 오늘날짜, date_add(now(), interval 10 hour); -- 10시간 후
select now() as 오늘날짜, date_add(now(), interval -10 hour) as preHour; -- 10시간 후

/* date_sub() - datetime형식비교 */
select now() as 오늘날짜, date_sub(now(), interval 1 day);   -- 하루 전
select now() as 오늘날짜, date_sub(now(), interval -1 day);  -- 하루 후

/* board테이블에 적용 */
-- 게시글 중 하루전에 올라온 글만 보여주기
select wDate, date_sub(now(), interval 1 day) from board;
select substring(wDate,1,10), substring(date_sub(now(), interval 1 day),1,10) from board;
select idx,nickName,wDate from board;
select idx,nickName,wDate from board where substring(wDate,1,10) = substring(date_sub(now(), interval 1 day),1,10);

/* 날짜차이 계산 : DATEDIFF(시작날짜,마지막날짜) - int형식비교 */
select datediff('2023-11-14', now());
select datediff(now(), wDate) from board;
select datediff(wDate, now()) from board;
select idx,nickName,wDate

select timestampdiff(hour, now(), wDate) from board;
select timestampdiff(day, now(), wDate) from board;

/* 날짜형식(date_format(날짜형식, 포맷)) : 년도4자리(%Y)|월(%m)|일(%d), 시간(%H)|분(%i) */
select wDate, date_format(wDate, '%Y-%m-%d') from board;
select wDate, date_format(wDate, '%Y-%m-%d %H:%i') from board;

/* ---------------------------------------------------- */

select * from board2 order by idx desc limit 0,5;
select *,datediff(wDate, now()) as day_diff from board2 order by idx desc limit 0,15;

select *,datediff(wDate, now()) as day_diff,
	timestampdiff(hour, wDate, now()) as hour_diff
	from board2 order by idx desc limit 0,15;
