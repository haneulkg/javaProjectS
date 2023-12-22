package com.spring.javaProjectS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS.dao.MemberDAO;
import com.spring.javaProjectS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberidCheck(String mid) {
		return memberDAO.getMemberidCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		vo.setPhoto("noimage.jpg");
		
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public int setMemberDeleteUpdate(String mid) {
		return memberDAO.setMemberDeleteUpdate(mid);
	}

	@Override
	public int setNewPwd(String pwd, String mid) {
		return memberDAO.setNewPwd(pwd, mid);
	}

	@Override
	public int setMemberInforUpdate(MemberVO vo) {
		return memberDAO.setMemberInforUpdate(vo);
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String pwd) {
		memberDAO.setMemberPasswordUpdate(mid, pwd);
	}

	@Override
	public List<MemberVO> getMemberEmailSearch(String email) {
		return memberDAO.getMemberEmailSearch(email);
	}


}
