package com.emlee.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.fileDTO;
import com.emlee.DTO.joinDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.persistence.mapper.BoardMapper;
import com.emlee.service.IBoardService;

@Service("BoardService")
public class BoardService implements IBoardService{

	@Resource(name="BoardMapper")
	private BoardMapper boardMapper;

	@Override
	public List<boardDTO> getBoardList(String team_no) throws Exception {
		return boardMapper.getBoardList(team_no);
	}

	@Override
	public int insertBoard(boardDTO bDTO) throws Exception {
		return boardMapper.insertBoard(bDTO);
	}

	@Override
	public boardDTO getBoardNo(boardDTO bDTO) throws Exception {
		return boardMapper.getBoardNo(bDTO);
	}

	@Override
	public int insertFile(fileDTO f) throws Exception {
		return boardMapper.insertFile(f);
	}

	@Override
	public boardDTO getBoard(boardDTO bDTO) throws Exception {
		return boardMapper.getBoard(bDTO);
	}

	@Override
	public void updateCnt(boardDTO cDTO) throws Exception {
		boardMapper.updateCnt(cDTO);
	}

	@Override
	public fileDTO getFile(fileDTO fDTO) throws Exception {
		return boardMapper.getFile(fDTO);
	}

	@Override
	public int deleteBoard(boardDTO bDTO) throws Exception {
		return boardMapper.deleteBoard(bDTO);
	}

	@Override
	public void deleteFile(fileDTO fDTO) throws Exception {
		boardMapper.deleteFile(fDTO);
	}

	@Override
	public int updateBoard(boardDTO bDTO) throws Exception {
		return boardMapper.updateBoard(bDTO);
	}

	@Override
	public List<manageDTO> getTeamList() throws Exception {
		return boardMapper.getTeamList();
	}

	@Override
	public List<userDTO> getNumList() throws Exception {
		return boardMapper.getNumList();
	}

	@Override
	public manageDTO getTeam(manageDTO mDTO) throws Exception {
		return boardMapper.getTeam(mDTO);
	}

	@Override
	public int getTeamName(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamName(mDTO);
	}

	@Override
	public int insertTeam(manageDTO mDTO) throws Exception {
		return boardMapper.insertTeam(mDTO);
	}

	@Override
	public void updateUserTeam(userDTO uDTO) throws Exception {
		boardMapper.updateUserTeam(uDTO);
	}

	@Override
	public manageDTO getTeamNo(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamNo(mDTO);
	}

	@Override
	public int insertJoin(joinDTO jDTO) throws Exception {
		return boardMapper.insertJoin(jDTO);
	}

	@Override
	public void deleteJoin(joinDTO jDTO) throws Exception {
		boardMapper.deleteJoin(jDTO);
	}

	@Override
	public int updateTeam(manageDTO mDTO) throws Exception {
		return boardMapper.updateTeam(mDTO);
	}

	@Override
	public void deleteTeamDrop(String team_no) throws Exception {
		boardMapper.deleteTeamDrop(team_no);
	}

	@Override
	public void updateTeamDrop(userDTO uDTO) throws Exception {
		boardMapper.updateTeamDrop(uDTO);
	}

	@Override
	public void deleteTeamBoard(String team_no) throws Exception {
		boardMapper.deleteTeamBoard(team_no);
	}

	@Override
	public void deleteTeamFile(String team_no) throws Exception {
		boardMapper.deleteTeamFile(team_no);
	}

	@Override
	public userDTO getUser(String team_no) throws Exception {
		return boardMapper.getUser(team_no);
	}

	@Override
	public List<userDTO> getUserList(String team_no) throws Exception {
		return boardMapper.getUserList(team_no);
	}

	@Override
	public userDTO getJoinUser(String user_no) throws Exception {
		return boardMapper.getJoinUser(user_no);
	}

	@Override
	public joinDTO getJoin(String user_no) throws Exception {
		return boardMapper.getJoin(user_no);
	}

	@Override
	public void updateAuth(String user_no) throws Exception {
		boardMapper.updateAuth(user_no);
	}

	@Override
	public void updateJoinCheck(String user_no) throws Exception {
		boardMapper.updateJoinCheck(user_no);
	}

	@Override
	public void updateTeamUp(String team_no) throws Exception {
		boardMapper.updateTeamUp(team_no);
	}

	@Override
	public void updateTeamDwon(String team_no) throws Exception {
		boardMapper.updateTeamDwon(team_no);
	}

	@Override
	public List<manageDTO> getTeamSearch(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamSearch(mDTO);
	}

	@Override
	public List<userDTO> getTeamUserSearch(userDTO uDTO) throws Exception {
		return boardMapper.getTeamUserSearch(uDTO);
	}

	@Override
	public List<boardDTO> getboardSearch(boardDTO bDTO) throws Exception {
		return boardMapper.getboardSearch(bDTO);
	}

	@Override
	public userDTO getUserNum(String team_no) throws Exception {
		return boardMapper.getUserNum(team_no);
	}

	@Override
	public userDTO getUserTeamSearchNum(userDTO uDTO) throws Exception {
		return boardMapper.getUserTeamSearchNum(uDTO);
	}

	@Override
	public List<userDTO> getUserTeamSearchPage(userDTO uDTO) throws Exception {
		return boardMapper.getUserTeamSearchPage(uDTO);
	}

	@Override
	public List<userDTO> getUserTeamPaging(userDTO uDTO) throws Exception {
		return boardMapper.getUserTeamPaging(uDTO);
	}

	@Override
	public boardDTO getBoardNum(String team_no) throws Exception {
		return boardMapper.getBoardNum(team_no);
	}

	@Override
	public boardDTO getboardSearchNum(boardDTO bDTO) throws Exception {
		return boardMapper.getboardSearchNum(bDTO);
	}

	@Override
	public List<boardDTO> getboardSearchPage(boardDTO bDTO) throws Exception {
		return boardMapper.getboardSearchPage(bDTO);
	}

	@Override
	public List<boardDTO> getboardPaging(boardDTO bDTO) throws Exception {
		return boardMapper.getboardPaging(bDTO);
	}

	@Override
	public manageDTO getTeamNum() throws Exception {
		return boardMapper.getTeamNum();
	}

	@Override
	public manageDTO getTeamSearchNum(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamSearchNum(mDTO);
	}

	@Override
	public List<manageDTO> getTeamSearchPage(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamSearchPage(mDTO);
	}

	@Override
	public List<manageDTO> getTeamPaging(manageDTO mDTO) throws Exception {
		return boardMapper.getTeamPaging(mDTO);
	}
	
}
