package com.campus.myapp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;


public class LoginInterceptor implements HandlerInterceptor {
	//��Ʈ�ѷ��� ȣ��Ǳ� ���� ����� �޼ҵ�
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		//false�� ���ϵǸ� - �α������� ������
		//true�� ���ϵǸ� - �ش���Ʈ�ѷ��� �̵�
		
		//request��ü���� session��ü ������
		HttpSession session = request.getSession();
		
		// �α��� ���±��ϱ�
		String logStatus = (String)session.getAttribute("logStatus");
		System.out.println(logStatus);
		
		if(logStatus!=null && logStatus.equals("Y")) { // �α��εǾ�����
			return true;
		} else { // �α��� �ȵȰ��
			response.sendRedirect("/member/login");
			return false;
		}
	}
}
