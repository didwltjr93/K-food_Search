package com.campus.myapp.service;

import com.campus.myapp.vo.MemberVO;

public interface MemberService {
	//�α���
	public MemberVO login(MemberVO vo);
	
	//ȸ������(��)
	public MemberVO memberSelect(String userid);
		
	//ȸ����������(db)
	public int memberUpdate(MemberVO vo);

}
