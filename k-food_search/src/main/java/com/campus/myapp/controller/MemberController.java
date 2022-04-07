package com.campus.myapp.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.campus.myapp.service.MemberService;
import com.campus.myapp.vo.MemberVO;

@RestController
public class MemberController {
	@Inject
	MemberService service;
	
	//�α���
	@PostMapping("/member/loginOk")
	public ResponseEntity<String> loginOk(MemberVO vo, HttpSession session){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("content-Type","text/html; charset=utf-8");
		try {
			MemberVO rVo = service.login(vo);
			if(rVo!=null) {//�α��μ���
				session.setAttribute("logId", rVo.getUserid());
				session.setAttribute("logName", rVo.getUsername());
				session.setAttribute("logType", rVo.getUsertype());
				session.setAttribute("logStatus", "Y");
				
				String msg = "<script>alert('�α��� ����!!!!');location.href='/';</script>";
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			}else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			//�α��ν���
			String msg = "<script>alert('�α��� ����!!!!!');history.back();</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);
			
		}
		return entity;
	}
	//�α׾ƿ�
	@GetMapping("/member/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	//������������ �̵�.
	@GetMapping(value = {"/member/mypage", "member/memberEdit"})
	public ModelAndView mypage(HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		MemberVO vo =service.memberSelect(userid);
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo",vo);
		mav.setViewName("member/memberEdit");
		return mav;
	}
	
	//ȸ����������(2)���� �̵�.
		@PostMapping("/member/memberEdit2")
		public ModelAndView memberEdit2(HttpSession session) {
			String userid = (String)session.getAttribute("logId");
			MemberVO vo =service.memberSelect(userid);
			ModelAndView mav = new ModelAndView();
			mav.addObject("vo",vo);
			mav.setViewName("member/memberEdit2");
			return mav;
		}

	//ȸ������������ �̵�.
	@GetMapping("/member/memberBook")
	public ModelAndView memberBook() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/memberBook");
		return mav;
	}
	//ȸ������������ �̵�.
	@GetMapping("/member/memberReview")
	public ModelAndView memberReview() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/memberReview");
		return mav;
	}
	//ȸ�����ã�������� �̵�.
	@GetMapping("/member/memberFavor")
	public ModelAndView memberFavor() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/memberFavor");
		return mav;
	}

	
	//��ü������ �̵�.
	@GetMapping("/member/myrestaurant")
	public ModelAndView myrestaurant() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/myrestaurant");
		return mav;
	}
}
