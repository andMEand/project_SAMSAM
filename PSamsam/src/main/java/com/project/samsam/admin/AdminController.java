package com.project.samsam.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.samsam.member.Biz_memberVO;
import com.project.samsam.member.BoardlistVO;
import com.project.samsam.member.CommentListVO;
import com.project.samsam.member.MemberSV;
import com.project.samsam.member.MemberVO;
import com.project.samsam.simport.Payed_listVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminSV adminSV;
	@Autowired
	private MemberSV memberSV;
	
	//TEST PAGE
	@RequestMapping(value = "/test.me")
	public String test() {
		
		return "NewFile1";
	}
	
	@RequestMapping(value = "/todo_select.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> todo_select() {
		Map<String, Object> map = new HashMap<String,Object>();
		ArrayList<Todo_listVO> todolist = adminSV.select_todo();
		
		if(todolist != null) {
			map.put("todolist", todolist);
		}
		
		return map;
	}
	
	@RequestMapping(value = "/todo_insert.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, String> todo_insert(@RequestBody Todo_listVO todo) {
		System.out.println("todo:" + todo.getTo_do());	
		Map<String, String> map = new HashMap<String,String>();
		int res = adminSV.insert_todo(todo);
		if(res == 1) {
			map.put("result", "success");
		}else {
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value = "/todo_update.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, String> todo_update(@RequestBody Todo_listVO todo) {
		System.out.println("todo:" + todo.getTo_do());	
		Map<String, String> map = new HashMap<String,String>();
		int res = adminSV.update_todo(todo);
		if(res == 1) {
			map.put("result", "success");
		}else {
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value = "/todo_delete.do", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, String> todo_delete(@RequestBody Todo_listVO todo) {
		System.out.println("todo:" + todo);	
		Map<String, String> map = new HashMap<String,String>();
		int res = adminSV.delete_todo(todo);
		if(res == 1) {
			map.put("result", "success");
		}else {
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value = "/admin_main.me")
	public String admin_main() {
		
		return "YM/admin_member";
	}
	
	@RequestMapping(value = "/search_member.do" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public ArrayList<MemberVO> search_member(@RequestBody Search_paramsVO svo) {
		System.out.println("date:" + svo.getFromDate() + "to" + svo.getToDate());
		System.out.println("분류1:" + svo.getMember_grade() + "분류2:" + svo.getMember_grade1() + svo.getMember_grade2()+svo.getMember_grade3());
		System.out.println("keyword:"+svo.getKeyword());
		ArrayList<MemberVO> mvo = adminSV.serach_member(svo);
		
		return mvo;
	}
	
	@RequestMapping(value = "/member_detail.do" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String,Object> member_detail(@RequestBody String Jemail) {
		String email = Jemail.substring(Jemail.indexOf("\"")+1, Jemail.lastIndexOf("\""));
		System.out.println("전달받은email : "+ email);
		
		Map<String,Object> map = new HashMap<String,Object>();
		MemberVO mvo = memberSV.selectMember(email);
		if(mvo != null) {
			map.put("MemberVO", mvo);
		}
		Biz_memberVO bvo = memberSV.selectBizMember(email);
		if(bvo != null) {
			map.put("Biz_memberVO", bvo);
		}
		ArrayList<BoardlistVO> blvo = memberSV.getWriteList(email);
		if(blvo != null) {
			map.put("Boardlist", blvo);
		}
		ArrayList<CommentListVO> cvo = memberSV.getWriteComment(email);
		if( cvo != null) {
		map.put("Commentlist", cvo);
		}
		return map;
	}
	
	@RequestMapping(value = "/auth_confirm.do" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Integer> auth_confirm(@RequestBody String Jemail) {
		String email = Jemail.substring(Jemail.indexOf("\"")+1, Jemail.lastIndexOf("\""));
		System.out.println("전달받은email : "+ email);
		
		Map<String,Integer> map = new HashMap<String, Integer>();
		int mem_update = adminSV.update_confirm(email);
		int res = adminSV.auth_confirm(email);
		map.put("result", res);
		
		return map;
	}
	
	@RequestMapping(value = "/auth_return.do" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Integer> auth_return(@RequestBody String Jemail) {
		String email = Jemail.substring(Jemail.indexOf("\"")+1, Jemail.lastIndexOf("\""));
		System.out.println("전달받은email : "+ email);
		
		Map<String,Integer> map = new HashMap<String, Integer>(); 
		int res = adminSV.auth_return(email);
		map.put("result", res);
		
		return map;
	}
	
	@RequestMapping(value = "/admin_pay.me")
	public String admin_pay(Model model) {
		ArrayList<Payed_listVO> plist = adminSV.getPay_list();
		
		model.addAttribute("Pay_list", plist);
		
		return "YM/admin_pay";
	}
}