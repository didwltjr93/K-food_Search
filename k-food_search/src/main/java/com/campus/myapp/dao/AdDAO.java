package com.campus.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.campus.myapp.vo.AdVO;

@Mapper
@Repository
public interface AdDAO {

	// 관리자페이지에서 광고신청목록 보기
	public List<AdVO> adList(AdVO vo);
	// 광고신청처리(수정)
	public int adStatusChange(AdVO vo);
}
