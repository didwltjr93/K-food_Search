package com.campus.myapp.service;

import java.util.List;

import com.campus.myapp.vo.RestaurantVO;
import com.campus.myapp.vo.memberVO;

public interface RestaurantService {
	// ���������������� ���Ը�� ����
	public List<RestaurantVO> restaurantList(RestaurantVO vo);
	// ���������������� ���԰˻�
	public List<RestaurantVO> getSearchList(RestaurantVO vo);
		
	public int restaurantInsert(RestaurantVO vo);
	public List<RestaurantVO> restaurantMyList(String userid);
	public int restaurantDel (int resno);
	public RestaurantVO restaurantUpdateList(int resno);
	public int maxResno ();
	public String restarantImgDel(int resno);
	public int restaurantUpdateOk(RestaurantVO vo);
	
	//���� Ŭ���� ���������������� �ش� ������ ���Ը�ϸ� ���̰� �ϱ�.
	public List<RestaurantVO> restaurantList_world(memberVO mVO);
}
