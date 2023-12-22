package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberidCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public int setMemberDeleteUpdate(@Param("mid") String mid);

	public int setNewPwd(@Param("pwd") String pwd, @Param("mid") String mid);

	public int setMemberInforUpdate(@Param("vo") MemberVO vo);

	public void setMemberPasswordUpdate(@Param("mid") String mid,@Param("pwd") String pwd);

	public List<MemberVO> getMemberEmailSearch(@Param("email") String email);


}
