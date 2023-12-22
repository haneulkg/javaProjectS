package com.spring.javaProjectS.service;

import java.util.List;

import com.spring.javaProjectS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberidCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public int setMemberDeleteUpdate(String mid);


	public int setNewPwd(String pwd, String mid);

	public int setMemberInforUpdate(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public List<MemberVO> getMemberEmailSearch(String email);


}
