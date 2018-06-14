package com.emlee.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.fileDTO;
import com.emlee.DTO.joinDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.service.IBoardService;
import com.emlee.util.CmmUtil;
import com.emlee.util.SHA256;
import com.emlee.util.TextUtil;

@Controller
public class BoardController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "BoardService")
	private IBoardService boardService;

	@RequestMapping(value="/boardC", method=RequestMethod.GET)
	public String boardC(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardC start!!!");
		log.info(getClass() + "boardC end!!!");
		return "board/boardC";
	}
	@RequestMapping(value="/boardL", method=RequestMethod.GET)
	public String boardL(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardL start!!!");
		
		String check = "F";
		
		log.info("check : " + check);
		
		String team_no = "0";
		
		List<boardDTO> bList = boardService.getBoardList(team_no);
		
		if(bList == null) {
			bList = new ArrayList<boardDTO>();
		}
		
		boardDTO cDTO = boardService.getBoardNum(team_no);
		
		session.setAttribute("check", check);
		model.addAttribute("bList", bList);
		model.addAttribute("cDTO", cDTO);
		
		bList = null;
		
		log.info(getClass() + "boardL end!!!");
		return "board/boardL";
	}
	@RequestMapping(value="/teamBoardL", method=RequestMethod.GET)
	public String teamboardL(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamboardL start!!!");
		
		String check = CmmUtil.nvl((String)session.getAttribute("check"));
		String team_no = CmmUtil.nvl((String) session.getAttribute("session_team_no"));
		
		log.info("check : " + check);
		log.info("team_no : " + team_no);
		
		List<boardDTO> bList = boardService.getBoardList(team_no);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_no(team_no);
		mDTO = boardService.getTeam(mDTO);
		
		String tName = mDTO.getTeam_name();
		
		log.info("team_name = " + tName);
		
		if(bList == null) {
			bList = new ArrayList<boardDTO>();
		}
		
		boardDTO cDTO = boardService.getBoardNum(team_no);
		
		model.addAttribute("bList", bList);
		model.addAttribute("tName", tName);	
		model.addAttribute("cDTO", cDTO);
		bList = null;
		
		log.info(getClass() + "teamboardL end!!!");
		return "board/boardL";
	}
	@RequestMapping(value="/boardC_proc", method=RequestMethod.POST)
	public String boardCproc(HttpServletRequest req, HttpServletResponse res,
				@RequestParam("file") MultipartFile f, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardCproc start!!!");
		
		String user_no = CmmUtil.nvl((String)session.getAttribute("session_user_no"));
		String reg_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
		String bcheck = CmmUtil.nvl((String)session.getAttribute("check"));
		String team_no = "";
		if(bcheck.equals("F")){
			team_no = "0"; //자유게시판 팀번호는 0
		}else if(bcheck.equals("T")){
			team_no = CmmUtil.nvl((String)session.getAttribute("session_team_no"));
		}
		String title = CmmUtil.nvl(req.getParameter("title"));
		String content = CmmUtil.nvl(req.getParameter("content"));
		String notice = CmmUtil.nvl(req.getParameter("notice"));
		String check = CmmUtil.nvl(req.getParameter("check")); //1이면 파일 없음 2이면 파일있음
		if (notice == "") {
			notice = "N";
		}
		String file = "";
		if (check.equals("1")) {
			file = "N";
		} else {
			if (!f.isEmpty()) {
				file = "Y";
			} else {
				file = "N";
			}
		}
		
		log.info("f : " + f);
		log.info("user_no : " + user_no);
		log.info("reg_name : " + reg_name);
		log.info("team_no : " + team_no);
		log.info("title : " + title);
		log.info("content : " + content);
		log.info("notice : " + notice);
		log.info("file : " + file);
		log.info("check : " + check);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setReg_no(user_no);
		bDTO.setReg_name(reg_name);
		bDTO.setTeam_no(team_no);
		bDTO.setTitle(title);
		bDTO.setContent(content);
		bDTO.setNotice_check(notice);
		bDTO.setFile_check(file);
		
		int re = boardService.insertBoard(bDTO);
		boardDTO fDTO = boardService.getBoardNo(bDTO);
		
		String board_no = fDTO.getBoard_no();
		log.info("board_no : " + board_no);
		
		if(re != 0) {
			if(file.equals("Y")){
			fileProc(f, req, model, board_no, team_no, user_no, "c");
			}else{
				model.addAttribute("msg", "글이 등록되었습니다.");
				model.addAttribute("url", "/boardR.do?board_no="+board_no);
			}
		}else{
			model.addAttribute("msg", "글 등록에 실패하였습니다.");
			model.addAttribute("url", "/boardC.do");
		}
		
		log.info(getClass() + "boardCproc end!!!");
		return "/alert";
	}
	public String fileProc(@RequestParam(value="f") MultipartFile file,
			HttpServletRequest req, Model model, String board_no, String team_no, String user_no, String check) throws Exception {
		log.info(getClass() + "file start!!!");
		
		log.info("file : " + file);
		log.info("board_no : " + board_no);
		log.info("user_no : " + user_no);
		log.info("team_no : " + team_no);
		log.info("check : " + check);
		
		// 현재 날짜 불러오기
	      long time = System.currentTimeMillis();
	      SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
	      String strDate = dayTime.format(new Date(time));

	      // 파일 저장 경로
	      String savePath = req.getSession().getServletContext().getRealPath("file");

	      String originalFileName = file.getOriginalFilename();
	      String onlyFileName = originalFileName.substring(0, originalFileName.indexOf(".")); // fileName
	      String extention = originalFileName.substring(originalFileName.indexOf(".")); // .jpg

	      String rename = SHA256.SHA256_encode(onlyFileName) + "_" + strDate + extention;
	      String fullPath = savePath + "\\" + rename;

	      log.info("저장 경로 : " + savePath);
	      log.info("파일명+타입 : " + originalFileName);
	      log.info("파일명: " + onlyFileName);
	      log.info("타입: " + extention);
	      log.info("바뀐 이름 : " + rename);
	      log.info("전체 경로 : " + fullPath);
	      
	            byte[] bytes = file.getBytes();
	            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(fullPath)));
	            String fileSize = String.valueOf(bytes.length);
	            log.info(fileSize);
	            stream.write(bytes);
	            stream.close();

	            fileDTO f = new fileDTO();
	            f.setFile_name(onlyFileName);
	            f.setFile_path(fullPath);
	            f.setFile_rename(rename);
	            f.setFile_size(fileSize);
	            f.setFile_type(extention);
	            f.setOri_name(originalFileName);
	            f.setSave_path(savePath);
	            f.setReg_no(user_no);
	            f.setBoard_no(board_no);
	            f.setTeam_no(team_no);
	            int r = boardService.insertFile(f);

	            if(r != 0){
	            	if(check.equals("c")){
			            model.addAttribute("msg", "글 등록에 성공하였습니다!");
			            model.addAttribute("url", "/boardR.do?board_no="+board_no);
	            	}else{
	            		model.addAttribute("msg", "글 수정에 성공하였습니다!");
			            model.addAttribute("url", "/boardR.do?board_no="+board_no);
	            	}
	            }else{
	            model.addAttribute("msg", "글 등록에 실패하였습니다...");
	            model.addAttribute("url", "/boardC.do");
	            }
		
		log.info(getClass() + "file end!!!");
		return "/alert";
	}
	@RequestMapping(value="/boardR", method=RequestMethod.GET)
	public String boardR(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardR start!!!");
		
		String board_no =CmmUtil.nvl(req.getParameter("board_no"));
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		String check = "";
		log.info("board_no : " + board_no);
		log.info("team_no : " + team_no);
		
		if(team_no.equals("")){
			check = CmmUtil.nvl((String)session.getAttribute("check"));
		}else if(team_no.equals("0")){
			check = "F";
		}else{
			check = "T";
		}
		
		log.info("check : " + check);
		
		boardDTO bDTO = new boardDTO(); //상세 가져오기용
		boardDTO cDTO = new boardDTO(); //조회수 올리기용
		fileDTO fDTO = new fileDTO(); //파일 가져오기용
		
		cDTO.setBoard_no(board_no);
		boardService.updateCnt(cDTO);
		log.info("조회수 증가!!!");
		
		bDTO.setBoard_no(board_no);
		bDTO = boardService.getBoard(bDTO);
		if(bDTO == null) {
			bDTO = new boardDTO();
		}
		fDTO.setBoard_no(board_no);
		fDTO = boardService.getFile(fDTO);
		if(fDTO == null) {
			fDTO = new fileDTO();
		}
		model.addAttribute("bDTO", bDTO);
		model.addAttribute("fDTO", fDTO);
		
		log.info(getClass() + "boardR end!!!");
		return "board/boardR";
	}
	@RequestMapping(value = "/down")
	public void file_down(HttpSession session, HttpServletRequest req, HttpServletResponse response, Model model) throws Exception {
	 log.info(this.getClass() + ".file_down start!!!!");
	 
	 String file_no = CmmUtil.nvl(req.getParameter("file_no"));
	 String ori_name=CmmUtil.nvl(req.getParameter("ori_name"));
	 String file_path = CmmUtil.nvl(req.getParameter("file_path"));
	 
	 log.info("file_no : " + file_no);
	 log.info("ori_name : " + ori_name);
	 log.info("file_path : " + file_path);
	 
	 byte fileByte[] = FileUtils.readFileToByteArray(new File(file_path));
     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(ori_name,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

	 log.info(this.getClass() + ".file_down end!!!!");
 }
	@RequestMapping(value="/boardD", method=RequestMethod.GET)
	public String boardD(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardD start!!!");
		
		String board_no = CmmUtil.nvl(req.getParameter("board_no"));
		String check = CmmUtil.nvl((String)session.getAttribute("check"));
		String user_id = CmmUtil.nvl((String)session.getAttribute("session_user_id"));
		
		log.info("board_no : " + board_no);
		log.info("check : " + check);
		log.info("user_id : " + user_id);
		
		boardDTO bDTO = new boardDTO();
		fileDTO fDTO = new fileDTO();
		
		bDTO.setBoard_no(board_no);
		int re = boardService.deleteBoard(bDTO);
		
		if(re != 0) {
			fDTO.setBoard_no(board_no);
			boardService.deleteFile(fDTO);
			log.info("파일 삭제 성공");
			model.addAttribute("msg", "글이 삭제되었습니다.");
			if(check.equals("T")){
				model.addAttribute("url", "/teamL.do");
			}else{
				model.addAttribute("url", "/boardL.do");
			}
			
		}else{
			model.addAttribute("msg", "글 삭제에 실패하였습니다.");
			model.addAttribute("url", "/boardR.do?board_no="+board_no);
		}
		
		log.info(getClass() + "boardD end!!!");
		return "/alert";
	}
	@RequestMapping(value="/boardU", method=RequestMethod.GET)
	public String boardU(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardU start!!!");
		
		String board_no =CmmUtil.nvl(req.getParameter("board_no"));
		log.info("board_no : " + board_no);
		
		boardDTO bDTO = new boardDTO(); //상세 가져오기용
		fileDTO fDTO = new fileDTO(); //파일 가져오기용
		
		bDTO.setBoard_no(board_no);
		bDTO = boardService.getBoard(bDTO);
		if(bDTO == null) {
			bDTO = new boardDTO();
		}
		fDTO.setBoard_no(board_no);
		fDTO = boardService.getFile(fDTO);
		if(fDTO == null) {
			fDTO = new fileDTO();
		}
		model.addAttribute("bDTO", bDTO);
		model.addAttribute("fDTO", fDTO);
		
		log.info(getClass() + "boardU end!!!");
		return "board/boardU";
	}
	@RequestMapping(value="/boardU_proc", method=RequestMethod.POST)
	public String boardUproc(HttpServletRequest req, HttpServletResponse res,
				@RequestParam("file") MultipartFile f, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "boardUproc start!!!");
		
		String board_no = CmmUtil.nvl(req.getParameter("board_no"));
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		String user_no = CmmUtil.nvl((String)session.getAttribute("session_user_no"));
		String title = CmmUtil.nvl(req.getParameter("title"));
		String content = CmmUtil.nvl(req.getParameter("content"));
		String notice = CmmUtil.nvl(req.getParameter("notice"));
		String check = CmmUtil.nvl(req.getParameter("check")); //1이면 파일 없음 2이면 파일있음
		if (notice == "") {
			notice = "N";
		}
		String file = "";
		if (check.equals("1")) {
			file = "N";
		} else {
			if (!f.isEmpty()) {
				file = "Y";
			} else {
				file = "N";
			}
		}
		
		log.info("f : " + f);
		log.info("team_no : " + team_no);
		log.info("board_no : " + board_no);
		log.info("user_no : " + user_no);
		log.info("title : " + title);
		log.info("content : " + content);
		log.info("notice : " + notice);
		log.info("file : " + file);
		log.info("check : " + check);
		
		boardDTO bDTO = new boardDTO();
		fileDTO fDTO = new fileDTO();
		
		bDTO.setBoard_no(board_no);
		bDTO.setChg_no(user_no);
		bDTO.setTitle(title);
		bDTO.setContent(content);
		bDTO.setNotice_check(notice);
		bDTO.setFile_check(file);
		
		fDTO.setBoard_no(board_no);
		
		if(check.equals("1")) {
				boardService.deleteFile(fDTO);
				log.info("파일 삭제 성공이닷!");
		}
		
		int re = boardService.updateBoard(bDTO);
		
		if (re != 0) {
			if (file.equals("Y")) {
				boardService.deleteFile(fDTO);
				log.info("파일 삭제 성공");
				fileProc(f, req, model, board_no, team_no, user_no, "u");
			} else {
				model.addAttribute("msg", "글이 수정되었습니다.");
				model.addAttribute("url", "/boardR.do?board_no=" + board_no);
			}
		} else {
			model.addAttribute("msg", "글 수정에 실패하였습니다.");
			model.addAttribute("url", "/boardU.do?board_no=" + board_no);
		}
		
		log.info(getClass() + "boardUproc end!!!");
		return "/alert";
	}
	@RequestMapping(value="/teamL", method=RequestMethod.GET)
	public String teamL(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamL start!!!");
		
		String user_id = CmmUtil.nvl((String)session.getAttribute("session_user_id"));
		String auth = CmmUtil.nvl((String)session.getAttribute("session_auth"));
		
		log.info("user_id : " + user_id);
		log.info("auth : " + auth);
		
		manageDTO cDTO = boardService.getTeamNum();
		
		
		if(user_id.equals("admin")){

			List<manageDTO> mList = boardService.getTeamList();
			
			if(mList == null) {
				mList = new ArrayList<manageDTO>();
			}
			
			model.addAttribute("mList", mList);
			model.addAttribute("cDTO", cDTO);
			
			return "board/ateamL";
		}else{
			if(auth.equals("U") || auth.equals("UD")){
				
				List<manageDTO> mList = boardService.getTeamList();
				
				if(mList == null) {
					mList = new ArrayList<manageDTO>();
				}
				
				model.addAttribute("mList", mList);
				model.addAttribute("cDTO", cDTO);
				
				return "board/uteamL";
			}else{
				session.setAttribute("check", "T");
				model.addAttribute("url", "/teamBoardL.do");
				return "/url";
			}
		}
	}
	@RequestMapping(value="/teamC", method=RequestMethod.GET)
	public String teamC(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamC start!!!");
		
		log.info(getClass() + "teamC end!!!");
			return "board/teamC";
	}
	@RequestMapping(value="/teamI", method=RequestMethod.GET)
	public String teamI(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamI start!!!");
		
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		
		log.info("team_no : " + team_no);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_no(team_no);
		
		mDTO = boardService.getTeam(mDTO);
		
		model.addAttribute("mDTO", mDTO);
		
		log.info(getClass() + "teamI end!!!");
			return "board/teamI";
	}
	@RequestMapping(value="/teamU", method=RequestMethod.GET)
	public String teamU(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamU start!!!");
		
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		
		log.info("team_no : " + team_no);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_no(team_no);
		
		mDTO = boardService.getTeam(mDTO);
		
		model.addAttribute("mDTO", mDTO);
		
		log.info(getClass() + "teamU end!!!");
			return "board/teamU";
	}
	@RequestMapping(value="/teamUL", method=RequestMethod.GET)
	public String teamUL(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamUL start!!!");
		
		String team_no = (String) session.getAttribute("session_team_no");
		log.info("team_no : " + team_no);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_no(team_no);
		mDTO = boardService.getTeam(mDTO);
		if(mDTO == null){
			mDTO = new manageDTO();
		}
		String team_name = mDTO.getTeam_name();
		
		userDTO uDTO = new userDTO();
		uDTO = boardService.getUser(team_no);
		if(uDTO == null) {
			uDTO = new userDTO();
		}
		
		List<userDTO> uList = boardService.getUserList(team_no);
		if(uList == null) {
			uList = new ArrayList<userDTO>();
		}
		
		userDTO cDTO = boardService.getUserNum(team_no);
		
		model.addAttribute("uList", uList);
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("cDTO", cDTO);
		model.addAttribute("team_name", team_name);
		
		log.info(getClass() + "teamUL end!!!");
			return "board/teamUL";
	}
	@RequestMapping(value="/teamR", method=RequestMethod.GET)
	public String teamR(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamR start!!!");
		
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		
		log.info("team_no : " + team_no);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_no(team_no);
		mDTO = boardService.getTeam(mDTO);
		
		if(mDTO == null) {
			mDTO = new manageDTO();
		}
		
		model.addAttribute("mDTO", mDTO);
		
		log.info("team_name : " + mDTO.getTeam_name());
		
		log.info(getClass() + "teamR end!!!");
			return "board/teamR";
	}
	@RequestMapping(value="/teamC_proc", method=RequestMethod.POST)
	public String teamC_proc(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamC_proc start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		String user_name = (String) session.getAttribute("session_user_name");
		String name = CmmUtil.nvl(req.getParameter("team_name"));
		String team_name = TextUtil.exchangeEscapeNvl(name);
		String join = CmmUtil.nvl(req.getParameter("join_form"));
		String join_form = "";
		String memo = CmmUtil.nvl(req.getParameter("team_memo"));
		String team_memo = "";
		if(memo.equals("")){
			team_memo = team_name+"에 환영합니다.";
		}else{
			team_memo = TextUtil.exchangeEscapeNvl(memo);
		}
		
		if(join.equals("A")){
			join_form = "자동 승인";
		}else{
			join_form = "리더 승인";
		}
		
		log.info("user_no : " + user_no);
		log.info("user_name : " + user_name);
		log.info("team_name : " + team_name);
		log.info("join_form : " + join_form);
		log.info("team_memo : " + team_memo);
		
		manageDTO mDTO = new manageDTO();
		
		mDTO.setLeader_no(user_no);
		mDTO.setLeader_name(user_name);
		mDTO.setTeam_name(team_name);
		mDTO.setJoin_form(join_form);
		mDTO.setTeam_memo(team_memo);
		mDTO.setReg_no(user_no);
		
		int re = boardService.insertTeam(mDTO);
		
		if(re != 0) {
			//변경된 정보 세션 올리기
			mDTO = boardService.getTeamNo(mDTO);
			String team_no = mDTO.getTeam_no();
			log.info("team_no : " + team_no);
			session.setAttribute("session_team_no", team_no);
			session.setAttribute("session_auth", "UA");
			//회원 권한, 팀번호 수정
			userDTO uDTO = new userDTO();
			uDTO.setAuth("UA");
			uDTO.setUser_no(user_no);
			uDTO.setTeam_no(team_no);
			boardService.updateUserTeam(uDTO);
			model.addAttribute("msg", "동호회가 개설되었습니다.");
			model.addAttribute("url", "/teamL.do");
		}else{
			model.addAttribute("msg", "동호회 개설에 실패하였습니다.");
			model.addAttribute("url", "/teamC.do");
		}
		
		log.info(getClass() + "teamC_proc end!!!");
			return "/alert";
	}
	@RequestMapping(value="/nameCheck", method=RequestMethod.POST)
	public String nameCheck(@RequestParam(value = "team_name") String team_name, HttpServletResponse res) throws Exception{
		log.info(getClass() + "nameCheck start!!!");
		
		team_name = CmmUtil.nvl(team_name);
		log.info("team_name : " + team_name);
		
		manageDTO mDTO = new manageDTO();
		mDTO.setTeam_name(team_name);
		
		int check = boardService.getTeamName(mDTO);
		System.out.println("check : " + check);
		
		res.getWriter().print(check);
		res.getWriter().flush();
		res.getWriter().close();
		
		log.info(getClass() + "nameCheck end!!!");
			return "board/teamC";
	}
	@RequestMapping(value="/teamI_proc", method=RequestMethod.POST)
	public String teamI_proc(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamI_proc start!!!");
		
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		String memo = CmmUtil.nvl(req.getParameter("join_memo"));
		String join_memo = "";
		String join_form = CmmUtil.nvl(req.getParameter("join_form"));
		String user_no = (String) session.getAttribute("session_user_no");
		String join_check = "";
		
		if(memo.equals("")){
			join_memo = "잘 부탁드립니다.";
		}else{
			join_memo = TextUtil.exchangeEscapeNvl(memo);
		}
		
		if(join_form.equals("자동 승인")){
			join_check = "O";
			boardService.updateTeamUp(team_no);
		}else{
			join_check = "X";
		}
		
		log.info("team_no : " + team_no);
		log.info("join_memo : " + join_memo);
		log.info("join_check : " + join_check);
		log.info("user_no : " + user_no);
		
		joinDTO jDTO = new joinDTO();
		
		jDTO.setTeam_no(team_no);
		jDTO.setJoin_check(join_check);
		jDTO.setJoin_memo(join_memo);
		jDTO.setUser_no(user_no);
		
		int re = boardService.insertJoin(jDTO);
		
		if(re != 0) {
			session.setAttribute("session_team_no", team_no);
			String auth = "";
			//가입 방식에 따라 권한 다르게 주어서 팀번호와 권한 수정하고 세션올리기
			if(join_check.equals("O")){
				//자동승인 UU
				session.setAttribute("session_auth", "UU");
				auth = "UU";
			}else{
				//리더승인 UD
				session.setAttribute("session_auth", "UD");
				auth = "UD";
			}
			//회원 권한, 팀번호 수정
			userDTO uDTO = new userDTO();
			uDTO.setUser_no(user_no);
			uDTO.setTeam_no(team_no);
			uDTO.setAuth(auth);
			boardService.updateUserTeam(uDTO);
			model.addAttribute("msg", "동호회 가입이 완료되었습니다.");
			model.addAttribute("url", "/teamL.do");
		}else{
			model.addAttribute("msg", "동호회 가입에 실패하였습니다.");
			model.addAttribute("url", "/teamI.do?team_no="+team_no);
		}
		
		log.info(getClass() + "teamI_proc end!!!");
			return "/alert";
	}
	@RequestMapping(value="/joinD", method=RequestMethod.GET)
	public String joinD(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "joinD start!!!");
		
		String team_no = (String) session.getAttribute("session_team_no");
		String user_no = CmmUtil.nvl(req.getParameter("user_no"));
		String no = (String) session.getAttribute("session_user_no");
		if(user_no.equals("")){
			user_no = no;
		}
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		uDTO.setUser_no(user_no);
		uDTO.setTeam_no("0");
		uDTO.setAuth("U");
		boardService.updateUserTeam(uDTO);
		
		if(user_no.equals(no)){
			session.setAttribute("session_auth", "U");
			session.setAttribute("session_team_no", "0");
		}
		joinDTO jDTO = new joinDTO();
		jDTO.setUser_no(user_no);
		
		boardService.deleteJoin(jDTO);
		boardService.updateTeamDwon(team_no);
		
		model.addAttribute("url", "/teamL.do");
		
		log.info(getClass() + "joinD end!!!");
			return "/url";
	}
	@RequestMapping(value="/joinDD", method=RequestMethod.GET)
	public String joinDD(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "joinDD start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		uDTO.setUser_no(user_no);
		uDTO.setTeam_no("0");
		uDTO.setAuth("U");
		boardService.updateUserTeam(uDTO);
		
		session.setAttribute("session_auth", "U");
		session.setAttribute("session_team_no", "0");
		joinDTO jDTO = new joinDTO();
		jDTO.setUser_no(user_no);
		
		boardService.deleteJoin(jDTO);
		
		model.addAttribute("url", "/teamL.do");
		
		log.info(getClass() + "joinDD end!!!");
			return "/url";
	}
	@RequestMapping(value="/teamU_proc", method=RequestMethod.POST)
	public String teamU_proc(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamU_proc start!!!");
		
		String user_no = (String) session.getAttribute("session_user_no");
		String team_no = (String) session.getAttribute("session_team_no");
		String team_name = CmmUtil.nvl(req.getParameter("team_name"));
		String join = CmmUtil.nvl(req.getParameter("join_form"));
		String join_form = "";
		String memo = CmmUtil.nvl(req.getParameter("team_memo"));
		String team_memo = "";
		if(memo.equals("")){
			team_memo = team_name+"에 환영합니다.";
		}else{
			team_memo = TextUtil.exchangeEscapeNvl(memo);
		}
		if(join.equals("A")){
			join_form = "자동 승인";
		}else{
			join_form = "리더 승인";
		}
		
		log.info("user_no : " + user_no);
		log.info("team_no : " + team_no);
		log.info("team_name : " + team_name);
		log.info("join_form : " + join_form);
		log.info("team_memo : " + team_memo);
		
		manageDTO mDTO = new manageDTO();
		
		mDTO.setTeam_no(team_no);
		mDTO.setJoin_form(join_form);
		mDTO.setTeam_memo(team_memo);
		mDTO.setChg_no(user_no);
		
		int re = boardService.updateTeam(mDTO);
		
		if(re != 0) {
			model.addAttribute("msg", "동호회 정보가 수정되었습니다.");
			model.addAttribute("url", "/teamR.do?team_no="+team_no);
		}else{
			model.addAttribute("msg", "동호회 수정에 실패하였습니다.");
			model.addAttribute("url", "/teamU.do?team_no="+team_no);
		}
		
		log.info(getClass() + "teamU_proc end!!!");
			return "/alert";
	}
	@RequestMapping(value="/teamD", method=RequestMethod.GET)
	public String teamD(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamD start!!!");
		
		String auth = (String) session.getAttribute("session_auth");
		String team_no = CmmUtil.nvl(req.getParameter("team_no"));
		
		log.info("auth : " + auth);
		log.info("team_no : " + team_no);
		
		userDTO uDTO = new userDTO();
		uDTO.setTeam_no(team_no);
		uDTO.setAuth("U");
		boardService.deleteTeamDrop(team_no); //팀 삭제(manageDTO)
		boardService.updateTeamDrop(uDTO); //해당 팀에 등록되어있는 사람 정보 변경(userDTO)
		boardService.deleteTeamBoard(team_no); //글 삭제(boardDTO)
		boardService.deleteTeamFile(team_no); //파일 삭제(fileDTO)
		
		if(auth.equals("UA")){
			session.setAttribute("session_auth", "U");
			session.setAttribute("session_team_no", "0");
		}
		model.addAttribute("url", "/teamL.do");
		
		log.info(getClass() + "teamD end!!!");
			return "/url";
	}
	@RequestMapping(value="/teamUR", method=RequestMethod.GET)
	public String teamUR(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamUR start!!!");
		
		String user_no = CmmUtil.nvl(req.getParameter("user_no"));
		log.info("user_no : " + user_no);
		
		userDTO uDTO = new userDTO();
		uDTO = boardService.getJoinUser(user_no);
		if(uDTO == null){
			uDTO = new userDTO();
		}
		
		joinDTO jDTO = new joinDTO();
		jDTO = boardService.getJoin(user_no);
		if(jDTO == null){
			jDTO = new joinDTO();
		}
		
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("jDTO", jDTO);
		
		log.info(getClass() + "teamUR end!!!");
		return "board/teamUR";
	}
	@RequestMapping(value="/teamAdd", method=RequestMethod.GET)
	public String teamAdd(HttpServletRequest req, HttpServletResponse res, Model model, HttpSession session) throws Exception{
		log.info(getClass() + "teamAdd start!!!");
		
		String user_no =CmmUtil.nvl(req.getParameter("user_no"));
		log.info("user_no : " + user_no);
		
		boardService.updateAuth(user_no);
		boardService.updateJoinCheck(user_no);

		model.addAttribute("url", "/teamUL.do");
		
		log.info(getClass() + "teamAdd end!!!");
		return "/url";
	}
	@RequestMapping(value="/teamSearch")
	public @ResponseBody List<manageDTO> teamSearch(@RequestParam(value="search") String search, HttpSession session) throws Exception {
		log.info(getClass()  + "teamSearch start!!!");
		log.info("search : " + search);
		
		manageDTO mDTO = new manageDTO();
		
		mDTO.setSearch("%"+search+"%");
		
		List<manageDTO> mList = boardService.getTeamSearch(mDTO);
		
		log.info(getClass() + "teamSearch end!!!");
		return mList;
	}
	@RequestMapping(value="/teamUserSearch")
	public @ResponseBody List<userDTO> teamUserSearch(@RequestParam(value="search") String search, HttpSession session) throws Exception {
		log.info(getClass()  + "teamUserSearch start!!!");
		
		String team_no = (String) session.getAttribute("session_team_no");
		
		log.info("team_no : " + team_no);
		log.info("search : " + search);
		
		userDTO uDTO = new userDTO();
		
		uDTO.setTeam_no(team_no);
		uDTO.setSearch("%"+search+"%");
		
		List<userDTO> uList = boardService.getTeamUserSearch(uDTO);
		
		log.info(getClass() + "teamUserSearch end!!!");
		return uList;
	}
	@RequestMapping(value="/boardSearch")
	public @ResponseBody List<boardDTO> boardSearch(@RequestParam(value="search") String search, HttpSession session) throws Exception {
		log.info(getClass()  + "boardSearch start!!!");
		
		String check = (String) session.getAttribute("check");
		String team_no = "";
		
		if(check.equals("F")){
			team_no = "0";
		}else{
			team_no = (String) session.getAttribute("session_team_no");
		}
		
		log.info("check : " + check);
		log.info("team_no : " + team_no);
		log.info("search : " + search);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setTeam_no(team_no);
		bDTO.setSearch("%"+search+"%");
		
		List<boardDTO> bList = boardService.getboardSearch(bDTO);
		
		log.info(getClass() + "boardSearch end!!!");
		return bList;
	}
	
	@RequestMapping(value="/userTeamSearchNum")
	public @ResponseBody int userSearchNum(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "userTeamSearchNum start!!!");
		String team_no = (String) session.getAttribute("session_team_no");
		
		log.info("team_no : " + team_no);
		log.info("search : " + search);

		userDTO uDTO = new userDTO();
		
		uDTO.setTeam_no(team_no);
		uDTO.setSearch("%"+search+"%");
		
		uDTO = boardService.getUserTeamSearchNum(uDTO);
		
		int num = Integer.parseInt(uDTO.getData());
		log.info("num : " + num);
		log.info(getClass() + "userTeamSearchNum end!!!");
		return num;
	}
	@RequestMapping(value="/userTeamSearchPaging")
	public @ResponseBody List<userDTO> userSearchPaging(@RequestParam(value="search") String search, @RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "userTeamSearchPaging start!!!");
		String team_no = (String) session.getAttribute("session_team_no");
		
		log.info("team_no : " + team_no);
		log.info("search : " + search);
		log.info("num : " + num);
		
		userDTO uDTO = new userDTO();
		uDTO.setTeam_no(team_no);
		uDTO.setSearch("%"+search+"%");
		num = (num * 10) - 10;
		uDTO.setNum(num);
		
		List<userDTO> uList = boardService.getUserTeamSearchPage(uDTO);
		
		log.info(getClass() + "userTeamSearchPaging end!!!");
		return uList;
	}
	@RequestMapping(value="/userTeamPagin")
	public @ResponseBody List<userDTO> userPaging(@RequestParam(value="num") int num, HttpSession session) throws Exception {
		log.info(getClass()  + "userTeamPagin start!!!");
		String team_no = (String) session.getAttribute("session_team_no");
		
		log.info("team_no : " + team_no);
		log.info("num : " + num);
		
		userDTO uDTO = new userDTO();
		
		num = (num * 10) - 10;
		
		uDTO.setTeam_no(team_no);
		uDTO.setNum(num);
		
		List<userDTO> uList = boardService.getUserTeamPaging(uDTO);
		
		log.info(getClass() + "userTeamPagin end!!!");
		return uList;
	}
	@RequestMapping(value="/boardSearchNum")
	public @ResponseBody int boardSearchNum(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "boardSearchNum start!!!");
		
		String check = (String) session.getAttribute("check");
		String team_no = "";
		
		if(check.equals("F")){
			team_no = "0";
		}else{
			team_no = (String) session.getAttribute("session_team_no");
		}
		
		log.info("check : " + check);
		log.info("team_no : " + team_no);
		log.info("search : " + search);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setTeam_no(team_no);
		bDTO.setSearch("%"+search+"%");
		
		bDTO = boardService.getboardSearchNum(bDTO);
		
		int num = Integer.parseInt(bDTO.getData());
		
		log.info(getClass() + "boardSearchNum end!!!");
		return num;
	}
	@RequestMapping(value="/boardSearchPaging")
	public @ResponseBody List<boardDTO> boardSearchPaging(@RequestParam(value="search") String search, @RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "boardSearchPaging start!!!");
		
		String check = (String) session.getAttribute("check");
		String team_no = "";
		
		if(check.equals("F")){
			team_no = "0";
		}else{
			team_no = (String) session.getAttribute("session_team_no");
		}
		
		log.info("check : " + check);
		log.info("team_no : " + team_no);
		log.info("search : " + search);
		log.info("num : " + num);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setTeam_no(team_no);
		bDTO.setSearch("%"+search+"%");
		num = (num * 10) - 10;
		bDTO.setNum(num);
		
		List<boardDTO> bList = boardService.getboardSearchPage(bDTO);
		
		log.info(getClass() + "boardSearchPaging end!!!");
		return bList;
	}
	@RequestMapping(value="/boardPaging")
	public @ResponseBody List<boardDTO> boardPaging(@RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "boardPaging start!!!");
		
		String check = (String) session.getAttribute("check");
		String team_no = "";
		
		if(check.equals("F")){
			team_no = "0";
		}else{
			team_no = (String) session.getAttribute("session_team_no");
		}
		
		log.info("check : " + check);
		log.info("team_no : " + team_no);
		log.info("num : " + num);
		
		boardDTO bDTO = new boardDTO();
		
		bDTO.setTeam_no(team_no);
		num = (num * 10) - 10;
		bDTO.setNum(num);
		
		List<boardDTO> bList = boardService.getboardPaging(bDTO);
		
		log.info(getClass() + "boardPaging end!!!");
		return bList;
	}
	
	@RequestMapping(value="/teamSearchNum")
	public @ResponseBody int teamSearchNum(@RequestParam(value="search") String search, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "teamSearchNum start!!!");
		
		log.info("search : " + search);
		
		manageDTO mDTO = new manageDTO();
		
		mDTO.setSearch("%"+search+"%");
		
		mDTO = boardService.getTeamSearchNum(mDTO);
		
		int num = Integer.parseInt(mDTO.getData1());
		
		log.info(getClass() + "teamSearchNum end!!!");
		return num;
	}
	@RequestMapping(value="/teamSearchPaging")
	public @ResponseBody List<manageDTO> teamSearchPaging(@RequestParam(value="search") String search, @RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "teamSearchPaging start!!!");
		
		log.info("search : " + search);
		log.info("num : " + num);
		
		manageDTO mDTO = new manageDTO();
		
		mDTO.setSearch("%"+search+"%");
		num = (num * 10) - 10;
		mDTO.setData(num);
		
		List<manageDTO> mList = boardService.getTeamSearchPage(mDTO);
		
		log.info(getClass() + "teamSearchPaging end!!!");
		return mList;
	}
	@RequestMapping(value="/teamPaging")
	public @ResponseBody List<manageDTO> teamPaging(@RequestParam(value="num") int num, Model model, HttpSession session) throws Exception {
		log.info(getClass()  + "teamPaging start!!!");
		
		log.info("num : " + num);
		
		manageDTO mDTO = new manageDTO();
		
		num = (num * 10) - 10;
		mDTO.setData(num);
		
		List<manageDTO> mList = boardService.getTeamPaging(mDTO);
		
		log.info(getClass() + "teamPaging end!!!");
		return mList;
	}
}
