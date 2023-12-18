package com.spring.javaProjectS.service;

import com.spring.javaProjectS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberidCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public int setMemberDeleteUpdate(String mid);


	public int setNewPwd(String pwd, String mid);

	public int setMemberInforUpdate(MemberVO vo);



}