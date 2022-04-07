package com.campus.myapp.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.campus.myapp.vo.MemberVO;

@Mapper
@Repository
public interface MemberDAO {
	//�α���
	public MemberVO login(MemberVO vo);
	
	//ȸ������(��)
	public MemberVO memberSelect(String userid);
	
	//ȸ����������(db)
	public int memberUpdate(MemberVO vo);
		
}
