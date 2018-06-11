package com.emlee.persistence.mapper;

import java.util.List;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.informationDTO;
import com.emlee.DTO.keyDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.config.Mapper;


@Mapper("UserMapper")
public interface UserMapper {
	
	int getUserid(userDTO uDTO) throws Exception;

	int insertJoin(userDTO uDTO) throws Exception;

	userDTO getUserInfo(userDTO uDTO) throws Exception;

	int updateEmailConfirm(userDTO uDTO) throws Exception;

	int insertKey(keyDTO kDTO) throws Exception;

	keyDTO getEmailKey(keyDTO kDTO) throws Exception;

	userDTO getIdSearch(userDTO uDTO) throws Exception;

	userDTO getPassword(userDTO uDTO) throws Exception;

	int updatePassword(userDTO pDTO) throws Exception;

	List<userDTO> getUserList() throws Exception;

	userDTO getUserDetail(userDTO uDTO) throws Exception;

	int deleteUser(userDTO uDTO) throws Exception;

	int updateUser(userDTO uDTO) throws Exception;

	List<boardDTO> getRegList(String user_no) throws Exception;

	List<boardDTO> getRegSearch(boardDTO bDTO) throws Exception;

	List<userDTO> getUserSearch(userDTO uDTO) throws Exception;

	List<userDTO> getGenderData() throws Exception;

	List<userDTO> getTeamData() throws Exception;

	List<userDTO> getGTData() throws Exception;

	List<userDTO> getAgeData() throws Exception;

	List<userDTO> getAddrData() throws Exception;

	List<userDTO> getRegData() throws Exception;

	List<boardDTO> getBoardData() throws Exception;

	userDTO getUserNum() throws Exception;

	manageDTO getManageNum() throws Exception;

	boardDTO getBoardNum() throws Exception;

	List<userDTO> getUserPaging(userDTO uDTO) throws Exception;

	userDTO getUserSearchNum(userDTO sDTO) throws Exception;

	List<userDTO> getUserSearchPage(userDTO uDTO) throws Exception;

	List<boardDTO> getRegPaging(boardDTO bDTO) throws Exception;

	boardDTO getRegSearchNum(boardDTO sDTO) throws Exception;

	List<boardDTO> getRegSearchPage(boardDTO uDTO) throws Exception;

	boardDTO getRegNum(String user_no) throws Exception;

	List<informationDTO> getInfo(informationDTO iDTO) throws Exception;

	List<informationDTO> getinformation(informationDTO iDTO) throws Exception;

	List<informationDTO> getMonth(informationDTO iDTO) throws Exception;

	List<informationDTO> getTheme(informationDTO iDTO) throws Exception;

}