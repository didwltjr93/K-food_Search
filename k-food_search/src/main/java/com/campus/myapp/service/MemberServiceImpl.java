package com.campus.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.campus.myapp.dao.MemberDAO;
import com.campus.myapp.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO dao;
	
	//�α���
	@Override
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	//ȸ������
	@Override
	public MemberVO memberSelect(String userid) {
		// TODO Auto-generated method stub
		return dao.memberSelect(userid);
	}

	//ȸ������
	@Override
	public int memberUpdate(MemberVO vo) {
		// TODO Auto-generated method stub
		return dao.memberUpdate(vo);
	}

}
