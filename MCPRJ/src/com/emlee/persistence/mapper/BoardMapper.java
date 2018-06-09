package com.emlee.persistence.mapper;

import java.util.List;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.fileDTO;
import com.emlee.DTO.joinDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.config.Mapper;

@Mapper("BoardMapper")
public interface BoardMapper {

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

	userDTO getUserNum(String team_no) throws Exception;

	userDTO getUserTeamSearchNum(userDTO uDTO) throws Exception;

	List<userDTO> getUserTeamSearchPage(userDTO uDTO) throws Exception;

	List<userDTO> getUserTeamPaging(userDTO uDTO) throws Exception;

	boardDTO getBoardNum(String team_no) throws Exception;

	boardDTO getboardSearchNum(boardDTO bDTO) throws Exception;

	List<boardDTO> getboardSearchPage(boardDTO bDTO) throws Exception;

	List<boardDTO> getboardPaging(boardDTO bDTO) throws Exception;

	manageDTO getTeamNum() throws Exception;

	manageDTO getTeamSearchNum(manageDTO mDTO) throws Exception;

	List<manageDTO> getTeamSearchPage(manageDTO mDTO) throws Exception;

	List<manageDTO> getTeamPaging(manageDTO mDTO) throws Exception;

}
