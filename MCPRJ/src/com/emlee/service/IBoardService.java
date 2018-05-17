package com.emlee.service;

import java.util.List;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.fileDTO;
import com.emlee.DTO.joinDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;

public interface IBoardService {

	List<boardDTO> getBoardList(String team_no) throws Exception;

	int insertBoard(boardDTO bDTO) throws Exception;

	boardDTO getBoardNo(boardDTO bDTO) throws Exception;

	int insertFile(fileDTO f) throws Exception;

	boardDTO getBoard(boardDTO bDTO) throws Exception;

	void updateCnt(boardDTO cDTO) throws Exception;

	fileDTO getFile(fileDTO fDTO) throws Exception;

	int deleteBoard(boardDTO bDTO) throws Exception;

	void deleteFile(fileDTO fDTO) throws Exception;

	int updateBoard(boardDTO bDTO) throws Exception;

	List<manageDTO> getTeamList() throws Exception;

	List<userDTO> getNumList() throws Exception;

	manageDTO getTeam(manageDTO mDTO) throws Exception;

	int getTeamName(manageDTO mDTO) throws Exception;

	int insertTeam(manageDTO mDTO) throws Exception;

	void updateUserTeam(userDTO uDTO) throws Exception;

	manageDTO getTeamNo(manageDTO mDTO) throws Exception;

	int insertJoin(joinDTO jDTO) throws Exception;

	void deleteJoin(joinDTO jDTO) throws Exception;

	int updateTeam(manageDTO mDTO) throws Exception;

	void deleteTeamDrop(String team_no) throws Exception;

	void updateTeamDrop(userDTO uDTO) throws Exception;

	void deleteTeamBoard(String team_no) throws Exception;

	void deleteTeamFile(String team_no) throws Exception;

	userDTO getUser(String team_no) throws Exception;

	List<userDTO> getUserList(String team_no) throws Exception;

	userDTO getJoinUser(String user_no) throws Exception;

	joinDTO getJoin(String user_no) throws Exception;

	void updateAuth(String user_no) throws Exception;

	void updateJoinCheck(String user_no) throws Exception;

	void updateTeamUp(String team_no) throws Exception;

	void updateTeamDwon(String team_no) throws Exception;

	List<manageDTO> getTeamSearch(manageDTO mDTO) throws Exception;

	List<userDTO> getTeamUserSearch(userDTO uDTO) throws Exception;

	List<boardDTO> getboardSearch(boardDTO bDTO) throws Exception;

}
