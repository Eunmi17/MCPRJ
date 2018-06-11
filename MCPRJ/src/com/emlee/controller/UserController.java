package com.emlee.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.informationDTO;
import com.emlee.DTO.keyDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.service.IUserService;
import com.emlee.util.CmmUtil;
import com.emlee.util.MailKey;
import com.emlee.util.SHA256;
import com.emlee.util.TextUtil;
	
@Controller
public class UserController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name = "UserService")
	private IUserService userService;
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String main(HttpServletRequest request, HttpServletResponse response, 
					Model model, HttpSession session) throws Exception {
		log.info(getClass() + "main start!!!");
		
		String log_user = CmmUtil.nvl((String)session.getAttribute("session_user_id"));
		
		log.info("log_user : " + log_user);
		
		userDTO u = userService.getUserNum();
		manageDTO m = userService.getManageNum();
		boardDTO b = userService.getBoardNum();
		
		log.info("u :" + u.getData());
		log.info("m :" + m.getNum());
		log.info("b :" + b.getData());
		
		if(log_user.equals("admin")){
			log.info(this.getClass() + "admin_main end!!!");
			model.addAttribute("u", u);
			model.addAttribute("m", m);
			model.addAttribute("b", b);
			return "/amain";
		}else if(log_user.equals("")){
			model.addAttribute("msg", "회원만 볼 수 있는 페이지 입니다. 로그인 해주세요");
			model.addAttribute("url", "/login.do");
			log.info(this.getClass() + "not main end!!!");
			return "/alert";
		}else{
			log.info(this.getClass() + "user_main end!!!");
			model.addAttribute("u", u);
			model.addAttribute("m", m);
			model.addAttribute("b", b);
			return "/umain";
		}
	}
	
	@RequestMapping(value="home", method=RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletResponse response, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "home start!!!");
		log.info(getClass() + "home end!!!");
		return "home/home";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, 
			Model model) throws Exception {
		log.info(getClass() + "login start!!!");
		log.info(getClass() + "login end!!!");
		return "home/login";
	}
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(HttpServletRequest request, HttpServletResponse response, 
			Model model) throws Exception {
		log.info(getClass() + "join start!!!");
		log.info(getClass() + "join end!!!");
		return "home/join";
	}
	@RequestMapping(value = "/idSearch", method = RequestMethod.GET)
	public String idSearch(HttpServletRequest request, HttpServletResponse response, 
			Model model) throws Exception {
		log.info(getClass() + "idSearch start!!!");
		log.info(getClass() + "idSearch end!!!");
		return "home/idSearch";
	}
	@RequestMapping(value = "/passwordReset", method = RequestMethod.GET)
	public String passwordReset(HttpServletRequest request, HttpServletResponse response, 
			Model model) throws Exception {
		log.info(getClass() + "passwordReset start!!!");
		log.info(getClass() + "passwordReset end!!!");
		return "home/passwordReset";
	}
	@RequestMapping(value = "/join_proc", method = RequestMethod.POST)
	public String join_proc(HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		log.info(getClass() + "join_proc start!!!");
		
		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String password = CmmUtil.nvl(SHA256.SHA256_encode(request.getParameter("password")));
		String user_name = CmmUtil.nvl(request.getParameter("user_name"));
		String day = CmmUtil.nvl(request.getParameter("day"));
		String genders = CmmUtil.nvl(request.getParameter("gender"));
		String gender = "";
		String post = CmmUtil.nvl(request.getParameter("post"));
		String add1 = CmmUtil.nvl(request.getParameter("addr1"));
		String add2 = CmmUtil.nvl(request.getParameter("addr2"));
		String addr1 = TextUtil.exchangeEscapeNvl(add1);
		String addr2 = TextUtil.exchangeEscapeNvl(add2);
		String email = CmmUtil.nvl(request.getParameter("email"));
		
		if(genders.equals("1")){
			gender = "남자";
		}else{
			gender = "여자";
		}
		
		log.info("user_id : " + user_id);
		log.info("password : " + password);
		log.info("user_name : " + user_name);
		log.info("day : " + day);
		log.info("gender : " + gender);
		log.info("post : " + post);
		log.info("addr 1 : " + addr1);
		log.info("addr 2 : " + addr2);
		log.info("email : " + email);
		
		userDTO uDTO = new userDTO();
		
		//회원가입
		uDTO.setUser_id(user_id);
		uDTO.setPassword(password);
		uDTO.setUser_name(user_name);
		uDTO.setDay(day);
		uDTO.setGender(gender);
		uDTO.setPost(post);
		uDTO.setAddr1(addr1);
		uDTO.setAddr2(addr2);
		uDTO.setEmail(email);
		int re = userService.insertJoin(uDTO);
		
		if (re != 0) {
			model.addAttribute("msg", "MS에 오신걸 환영합니다");
			model.addAttribute("url", "/login.do");
		}else{
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "/join.do");
		}
		log.info(getClass() + "join_proc end!!!");
		return "/alert";
	}
	@RequestMapping(value = "/emailEx", method = RequestMethod.POST)
	public void emailEx(@RequestParam(value = "user_email") String email, HttpServletResponse response) throws Exception {
		log.info(this.getClass() + "emailEx start!!");
		
		String keynum = new MailKey().getKey(5, false);
		keyDTO kDTO = new keyDTO();
		kDTO.setEmail(email);
		kDTO.setKeynum(keynum);
		
		log.info("keynum : " + keynum);
		log.info("email : " + email);
		

		int re = userService.insertKey(kDTO);
		log.info("인증 DB 넣기 OK");
		
		//이메일 인증 url 발송
		String setfrom = "dldmsal1123@gmail.com";
		String tomail = email;
		String title = "'Mountain Climbing' 인증 메일";
		StringBuffer contents = new StringBuffer();
		contents.append("인증번호 <br/>")
				.append("<h2>")
				.append(keynum)
				.append("</h2>");
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		messageHelper.setFrom(setfrom);		//송신자를 생략하면 정상작동 안함
		messageHelper.setTo(tomail);		//수신자 메일
		messageHelper.setSubject(title);	//메일 제목은 생략 가능
		messageHelper.setText(contents.toString(), true);	//메일 내용
		mailSender.send(message);
		
		response.getWriter().print(re);
		response.getWriter().flush();
		response.getWriter().close();
		
		log.info(this.getClass() + "emailEx end!!");
	}
	@RequestMapping(value="/keyCheck", method=RequestMethod.POST)
    public void keyCheck(@RequestParam(value = "user_email") String email, @RequestParam(value = "email_key") String keynum,
    		HttpServletResponse response) throws Exception{
		log.info(this.getClass() + ".keyCheck start");
		
		log.info("email : " + email);
		log.info("key : " + keynum);
		
		keyDTO kDTO = new keyDTO();
		
		kDTO.setEmail(email);
		kDTO.setKeynum(keynum);
		
		kDTO = userService.getEmailKey(kDTO);

		response.getWriter().print(kDTO);
		response.getWriter().flush();
		response.getWriter().close();
		
		log.info(this.getClass() + "ketCheck end!!!");
	}
    @RequestMapping(value="/NECheck", method=RequestMethod.POST)
    public void NECheck(@RequestParam(value = "user_email") String email, @RequestParam(value = "user_name") String user_name,
    		HttpServletResponse response) throws Exception{
		log.info(this.getClass() + ".NECheck start");
		
		log.info("user_name : " + user_name);
		log.info("email : " + email);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_name(user_name);
		uDTO.setEmail(email);
		
		uDTO = userService.getIdSearch(uDTO);

		response.getWriter().print(uDTO);
		response.getWriter().flush();
		response.getWriter().close();
		
		log.info("머라고 넘어갈까 : " + uDTO);
		
		log.info(this.getClass() + "NECheck end!!!");
	}
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public void idCheck(@RequestParam(value = "user_id") String user_id, HttpServletResponse response) throws Exception {
		log.info(this.getClass() + "idCheck start!!");
				
		user_id = CmmUtil.nvl(user_id);
		log.info(user_id);

		userDTO uDTO = new userDTO();
		uDTO.setUser_id(user_id);
		
		int check = userService.getUserid(uDTO);
		System.out.println("check : " + check);
		
		response.getWriter().print(check);
		response.getWriter().flush();
		response.getWriter().close();
		
		log.info(this.getClass() + "idCheck end!!");
	}
	@RequestMapping(value = "/login_proc", method = RequestMethod.POST)
	public String login_proc(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session)
			throws Exception {
		log.info(this.getClass() + "login_proc start!!!");
		
		String user_id = req.getParameter("user_id");
		String password = SHA256.SHA256_encode(req.getParameter("password"));
		
		log.info(this.getClass() + "user_id : " + user_id);
		log.info(this.getClass() + "password : " + password);
		
		userDTO uDTO = new userDTO();
		uDTO.setUser_id(user_id);
		uDTO.setPassword(password);
		
		uDTO = userService.getUserInfo(uDTO);
		//팀번호 이용해서 팀이름 얻어와서 세션에 올리기
		if(uDTO != null) {
			session.setAttribute("session_user_no", uDTO.getUser_no());
			session.setAttribute("session_user_name", uDTO.getUser_name());
			session.setAttribute("session_user_id", uDTO.getUser_id());
			session.setAttribute("session_team_no", uDTO.getTeam_no());
			session.setAttribute("session_auth", uDTO.getAuth());
			log.info(this.getClass() + "login_proc end!!!	성공");
			return "home/home";
		}else{
			model.addAttribute("msg", "아이디 혹은 비밀번호가 잘못됬습니다. 다시 확인해주세요");
			model.addAttribute("url", "/login.do");
			log.info(this.getClass() + "login_proc end!!!	실패");
			return "/alert";
		}
	}
	@RequestMapping(value = "/logout")
	public String logout(Model model, HttpSession session) throws Exception{
		log.info(getClass() + "logout start!!!");
		
		session.setAttribute("session_user_no", "");
		session.setAttribute("session_user_name", "");
		session.setAttribute("session_user_id", "");
		session.setAttribute("session_team_no", "");
		session.setAttribute("session_auth", "");
		
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "home.do");
		
		log.info(getClass() + "logout end!!!");
		return "/alert";
	}
	@RequestMapping(value = "/idSearch_Proc")
	public String idSearch_Proc(HttpServletRequest req, HttpServletResponse res, Model model)
		throws Exception {
		
		log.info(this.getClass() + "idSearch_proc start!!!");
		
		String user_name = req.getParameter("user_name");
		String email = req.getParameter("email");
		
		log.info("user_name : " + user_name);
		log.info("email : " + email);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_name(user_name);
		uDTO.setEmail(email);
		
		uDTO = userService.getIdSearch(uDTO);
		
		if (uDTO != null) {
			model.addAttribute("msg", "회원님의 아이디는 [ " + uDTO.getUser_id() + " ] 입니다.");
			model.addAttribute("url", "/login.do");
		}else{
			model.addAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다. 다시 확인해주세요.");
			model.addAttribute("url", "/idSearch.do");
		}
		
		log.info(this.getClass() + "idSearch_proc end!!!");
		
		return "/alert";
	}
	@RequestMapping(value = "/reset_proc")
	public String pwreset(HttpServletRequest req, HttpServletResponse res, Model model)
		throws Exception {
		log.info(getClass() + "reset_pw start!!!");
		
		String user_id = CmmUtil.nvl(req.getParameter("user_id"));
		String email = CmmUtil.nvl(req.getParameter("email"));
		String password = CmmUtil.nvl(SHA256.SHA256_encode(req.getParameter("password")));
		
		log.info("id : " + user_id);
		log.info("email : " + email);
		log.info("pw : " + password);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_id(user_id);
		uDTO.setEmail(email);
		
		uDTO = userService.getPassword(uDTO);
		
		if (uDTO != null) {
			
			userDTO pDTO = new userDTO();
			
			pDTO.setUser_id(user_id);
			pDTO.setPassword(password);
			
			int re = userService.updatePassword(pDTO);
			
			if(re != 0) {
				model.addAttribute("msg", "비밀번호가 변경되었습니다.");
				model.addAttribute("url", "/login.do");
			}else{
				model.addAttribute("msg", "비밀번호변경에 실패하였습니다.");
				model.addAttribute("url", "/passwordReset.do");
			}

		}else{
			model.addAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다. 다시 확인해주세요");
			model.addAttribute("url", "/passwordReset.do");
		}
		
		log.info(getClass() + "reset_pw end!!!");
		return "/alert";
	}
	@RequestMapping(value="userList", method=RequestMethod.GET)
	public String userList(HttpServletRequest re, HttpServletResponse res, HttpSession session, Model model ) throws Exception {
		log.info(getClass() + "userList start!!!");
		
		List<userDTO> uList = userService.getUserList();
		if(uList == null) {
			uList = new ArrayList<>();
		}
		
		userDTO cDTO = userService.getUserNum();
		
		model.addAttribute("uList", uList);
		model.addAttribute("cDTO", cDTO);
		
		log.info(getClass() + "userList end!!!");
		return "userList";
	}
	@RequestMapping(value="userDetail", method=RequestMethod.GET)
	public String userDetail(HttpServletRequest re, HttpServletResponse res, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "userDetail start!!!");
		
		String user_no = CmmUtil.nvl(re.getParameter("user_no"));
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_no(user_no);
		
		uDTO = userService.getUserDetail(uDTO);
		if (uDTO == null) {
			uDTO = new userDTO();
		}
		model.addAttribute("uDTO", uDTO);
		log.info("uDTO : " + uDTO.getDay());
		
		log.info(getClass() + "userDetail end!!!");
		return "userDetail";
	}
	@RequestMapping(value="userUpdate", method=RequestMethod.GET)
	public String userUpdate(HttpServletRequest re, HttpServletResponse res, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "userUpdate start!!!");
		
		String user_no = CmmUtil.nvl(re.getParameter("user_no"));
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_no(user_no);
		
		uDTO = userService.getUserDetail(uDTO);
		if (uDTO == null) {
			uDTO = new userDTO();
		}
		model.addAttribute("uDTO", uDTO);
		
		log.info(getClass() + "userUpdate end!!!");
		return "userUpdate";
	}
	@RequestMapping(value="userDrop", method=RequestMethod.GET)
	public String userDrop(HttpServletRequest req, HttpServletResponse res, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "userDrop start!!!");
		
		String user_no = CmmUtil.nvl(req.getParameter("user_no"));
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		uDTO.setUser_no(user_no);
		
		int re = userService.deleteUser(uDTO);
		
		if(re != 0) {
			session.setAttribute("session_user_no", "");
			session.setAttribute("session_user_id", "");
			session.setAttribute("session_team_no", "");
			session.setAttribute("session_auth", "");
			model.addAttribute("msg", "탈퇴되었습니다.");
			model.addAttribute("url", "/home.do");
		}else{
			model.addAttribute("msg", "탈퇴에 실패하였습니다.");
			model.addAttribute("url", "/userDetail.do?user_no="+user_no);
		}
		
		log.info(getClass() + "userDrop end!!!");
		return "/alert";
	}
	@RequestMapping(value="userup_proc", method=RequestMethod.POST)
	public String update_proc(HttpServletRequest re, HttpServletResponse res, HttpSession session, Model model) throws Exception {
		log.info(getClass() + "update_proc start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		String day = CmmUtil.nvl(re.getParameter("day"));
		String genders = CmmUtil.nvl(re.getParameter("gender"));
		String gender = "";
		String post = CmmUtil.nvl(re.getParameter("post"));
		String add1 = CmmUtil.nvl(re.getParameter("addr1"));
		String add2 = CmmUtil.nvl(re.getParameter("addr2"));
		String addr1 = TextUtil.exchangeEscapeNvl(add1);
		String addr2 = TextUtil.exchangeEscapeNvl(add2);
		
		if(genders.equals("1")){
			gender = "남자";
		}else{
			gender = "여자";
		}
		
		log.info("user_no : " + user_no);
		log.info("day : " + day);
		log.info("gender : " + gender);
		log.info("post : " + post);
		log.info("addr1 : " + addr1);
		log.info("addr2 : " + addr2);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setUser_no(user_no);
		uDTO.setDay(day);
		uDTO.setGender(gender);
		uDTO.setPost(post);
		uDTO.setAddr1(addr1);
		uDTO.setAddr2(addr2);
		
		int r = userService.updateUser(uDTO);
		
		if (r != 0) {
			model.addAttribute("msg", "회원 정보가 수정되었습니다.");
			model.addAttribute("url", "/userDetail.do?user_no="+user_no);
		}else{
			model.addAttribute("msg", "회원 정보 수정에 실패했습니다.");
			model.addAttribute("url", "/userUpdate.do?user_no="+user_no);
		}
		
		log.info(getClass() + "update_proc end!!!");
		return "/alert";
	}
	@RequestMapping(value="/regList", method=RequestMethod.GET)
	public String regList(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "regList start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		
		List<boardDTO> bList = userService.getRegList(user_no);
		
		if(bList == null) {
			bList = new ArrayList<boardDTO>();
		}
		boardDTO cDTO = userService.getRegNum(user_no);
		
		model.addAttribute("bList", bList);
		model.addAttribute("cDTO", cDTO);
		
		bList = null;
		
		log.info(getClass() + "regList end!!!");
		return "/regList";
	}
	@RequestMapping(value="/regSearch")
	public @ResponseBody List<boardDTO> regSearch(@RequestParam(value="search") String search, HttpSession session) throws Exception {
		log.info(getClass()  + "regSearch start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		
		log.info("search : " + search);
		log.info("user_no : " + user_no);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setSearch("%"+search+"%");
		bDTO.setReg_no(user_no);
		
		List<boardDTO> bList = userService.getRegSearch(bDTO);
		
		log.info(getClass() + "regSearch end!!!");
		return bList;
	}
	@RequestMapping(value="/userSearch")
	public @ResponseBody List<userDTO> userSearch(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "userSearch start!!!");
		log.info("search : " + search);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setSearch("%"+search+"%");
		
		List<userDTO> uList = userService.getUserSearch(uDTO);
		
		log.info(getClass() + "userSearch end!!!");
		return uList;
	}
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String chart(HttpServletRequest request, HttpServletResponse response, 
			Model model) throws Exception {
		log.info(getClass() + "chart start!!!");
		log.info(getClass() + "chart end!!!");
		return "/chart";
	}
	@RequestMapping(value="genderData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> genderData() throws Exception {
		log.info(getClass() + "genderData start!!!");
		
		List<userDTO> gList = userService.getGenderData();
		
		log.info(getClass() + "genderData end!!!");
		return gList;
	}
	
	@RequestMapping(value="teamData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> teamData() throws Exception {
		log.info(getClass() + "teamData start!!!");
		
		List<userDTO> tList = userService.getTeamData();
		
		log.info(getClass() + "teamData end!!!");
		return tList;
	}
	
	@RequestMapping(value="GTData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> GTData() throws Exception {
		log.info(getClass() + "GTData start!!!");
		
		List<userDTO> gtList = userService.getGTData();
		
		log.info(getClass() + "GTData end!!!");
		return gtList;
	}
	
	@RequestMapping(value="ageData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> ageData() throws Exception {
		log.info(getClass() + "ageData start!!!");
		
		List<userDTO> aList = userService.getAgeData();
		
		log.info(getClass() + "ageData end!!!");
		return aList;
	}
	
	@RequestMapping(value="addrData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> addrData() throws Exception {
		log.info(getClass() + "addrData start!!!");
		
		List<userDTO> aList = userService.getAddrData();
		
		log.info(getClass() + "addrData end!!!");
		return aList;
	}
	
	@RequestMapping(value="regData", method=RequestMethod.POST)
	public @ResponseBody List<userDTO> regData() throws Exception {
		log.info(getClass() + "regData start!!!");
		
		List<userDTO> rList = userService.getRegData();
		
		log.info(getClass() + "regData end!!!");
		return rList;
	}
	
	@RequestMapping(value="boardData", method=RequestMethod.POST)
	public @ResponseBody List<boardDTO> boardData() throws Exception {
		log.info(getClass() + "boardData start!!!");
		
		List<boardDTO> bList = userService.getBoardData();
		
		log.info(getClass() + "boardData end!!!");
		return bList;
	}
	
	@RequestMapping(value="api", method=RequestMethod.GET)
	public String api(HttpServletRequest request, HttpServletResponse response, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "api start!!!");
		
		request.setCharacterEncoding("UTF-8");
		String nm = TextUtil.exchangeEscapeNvl(CmmUtil.nvl(request.getParameter("nm")));
		String hght = CmmUtil.nvl(request.getParameter("hght"));
		
		log.info("nm : " + nm);
		log.info("hght : " + hght);
		
		model.addAttribute("nm", nm);
		model.addAttribute("hght", hght);
		
		log.info(getClass() + "api end!!!");
		return "/api";
	}
	
	@RequestMapping(value="apiMain", method=RequestMethod.GET)
	public String apiMain(HttpServletRequest request, HttpServletResponse response, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "apiMain start!!!");
		
		String no = CmmUtil.nvl(request.getParameter("no"));
		
		if(no.equals("")){
			no = "1";
		}
		
		log.info("no : " + no);
		
		model.addAttribute("no", no);
		
		log.info(getClass() + "apiMain end!!!");
		return "/apiMain";
	}
	
	@RequestMapping(value="apiSearch", method=RequestMethod.GET)
	public String apiSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "apiSearch start!!!");
		request.setCharacterEncoding("UTF-8");
		String nm = CmmUtil.nvl(request.getParameter("nm"));
		nm = URLDecoder.decode(nm, "UTF-8");
		String no = CmmUtil.nvl(request.getParameter("no"));

		if(no.equals("")){
			no = "1";
		}
		
		log.info("nm : " + nm);
		log.info("no : " + no);
		
		model.addAttribute("nm", nm);
		model.addAttribute("no", no);
		
		log.info(getClass() + "apiSearch end!!!");
		return "/apiSearch";
	}
	
	@RequestMapping(value="/userPaging")
	public @ResponseBody List<userDTO> userPaging(@RequestParam(value="num") int num, HttpSession session) throws Exception {
		log.info(getClass()  + "userPaging start!!!");
		log.info("num : " + num);
		
		userDTO uDTO = new userDTO();
		
		num = (num * 10) - 10;
		
		uDTO.setNum(num);
		
		List<userDTO> uList = userService.getUserPaging(uDTO);
		
		log.info(getClass() + "userPaging end!!!");
		return uList;
	}
	
	@RequestMapping(value="/userSearchNum")
	public @ResponseBody int userSearchNum(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "userSearchNum start!!!");
		log.info("search : " + search);
		
		userDTO sDTO = new userDTO();
		sDTO.setSearch("%"+search+"%");
		sDTO = userService.getUserSearchNum(sDTO);
		
		int num = Integer.parseInt(sDTO.getData());
		
		log.info(getClass() + "userSearchNum end!!!");
		return num;
	}
	
	@RequestMapping(value="/userSearchPaging")
	public @ResponseBody List<userDTO> userSearchPaging(@RequestParam(value="search") String search, @RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "userSearchPaging start!!!");
		log.info("search : " + search);
		log.info("num : " + num);
		
		userDTO uDTO = new userDTO();
		uDTO.setSearch("%"+search+"%");
		num = (num * 10) - 10;
		uDTO.setNum(num);
		
		List<userDTO> uList = userService.getUserSearchPage(uDTO);
		
		log.info(getClass() + "userSearchPaging end!!!");
		return uList;
	}
	
	@RequestMapping(value="/regPaging")
	public @ResponseBody List<boardDTO> regPaging(@RequestParam(value="num") int num, HttpSession session) throws Exception {
		log.info(getClass()  + "regPaging start!!!");
		String reg_no = (String) session.getAttribute("session_user_no");
		
		log.info("reg_no : " + reg_no);
		log.info("num : " + num);
		
		boardDTO bDTO = new boardDTO();
		
		num = (num * 10) - 10;
		
		bDTO.setReg_no(reg_no);
		bDTO.setNum(num);
		
		List<boardDTO> bList = userService.getRegPaging(bDTO);
		
		log.info(getClass() + "regPaging end!!!");
		return bList;
	}
	
	@RequestMapping(value="/regSearchNum")
	public @ResponseBody int regSearchNum(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "regSearchNum start!!!");
		String reg_no = (String) session.getAttribute("session_user_no");
		
		log.info("reg_no : " + reg_no);
		log.info("reg : " + search);
		
		boardDTO sDTO = new boardDTO();
		sDTO.setSearch("%"+search+"%");
		sDTO.setReg_no(reg_no);
		sDTO = userService.getRegSearchNum(sDTO);
		
		int num = Integer.parseInt(sDTO.getData());
		
		log.info(getClass() + "userSearchNum end!!!");
		return num;
	}
	
	@RequestMapping(value="/regSearchPaging")
	public @ResponseBody List<boardDTO> regSearchPaging(@RequestParam(value="search") String search, @RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "regSearchPaging start!!!");
		String reg_no = (String) session.getAttribute("session_user_no");
		
		log.info("user_no : " + reg_no);
		log.info("search : " + search);
		log.info("num : " + num);
		
		boardDTO uDTO = new boardDTO();
		uDTO.setSearch("%"+search+"%");
		num = (num * 10) - 10;
		uDTO.setNum(num);
		uDTO.setReg_no(reg_no);
		
		List<boardDTO> bList = userService.getRegSearchPage(uDTO);
		
		log.info(getClass() + "userSearchPaging end!!!");
		return bList;
	}
	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String testhome(HttpServletRequest request, HttpServletResponse response, HttpSession session,
					Model model) throws Exception {
		log.info(getClass() + "test start!!!");
		int num = 0;
		String log_user = CmmUtil.nvl((String)session.getAttribute("session_user_id"));
		
		log.info("log_user : " + log_user);
		
		userDTO u = userService.getUserNum();
		manageDTO m = userService.getManageNum();
		boardDTO b = userService.getBoardNum();
		
		log.info("u :" + u.getData());
		log.info("m :" + m.getNum());
		log.info("b :" + b.getData());
		
		informationDTO iDTO = new informationDTO();
		iDTO.setNum(num);
		
		List<informationDTO> iList = userService.getInfo(iDTO);
		
		model.addAttribute("iList", iList);
		model.addAttribute("u", u);
		model.addAttribute("m", m);
		model.addAttribute("b", b);
		
		log.info(getClass() + "test end!!!");
		return "/test";
	}
	
	@RequestMapping(value="/information")
	public @ResponseBody List<informationDTO> information(@RequestParam(value="no") String no, HttpSession session) throws Exception {
		log.info(getClass()  + "information start!!!");
		log.info("no : " + no);
		
		informationDTO iDTO = new informationDTO();
		
		iDTO.setNo(no);
		
		List<informationDTO> iList = userService.getinformation(iDTO);
		
		log.info(getClass() + "information end!!!");
		return iList;
	}
	
	@RequestMapping(value="/infoPaging")
	public @ResponseBody List<informationDTO> infoPaging(@RequestParam(value="num") int num, HttpSession session) throws Exception {
		log.info(getClass()  + "infoPaging start!!!");
		num = (num - 1) * 5;
		log.info("num : " + num);
		
		informationDTO iDTO = new informationDTO();
		iDTO.setNum(num);
		
		List<informationDTO> iList = userService.getInfo(iDTO);
		
		log.info(getClass() + "infoPaging end!!!");
		return iList;
	}

}