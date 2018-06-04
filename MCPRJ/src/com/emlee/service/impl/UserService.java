package com.emlee.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.keyDTO;
import com.emlee.DTO.manageDTO;
import com.emlee.DTO.userDTO;
import com.emlee.persistence.mapper.UserMapper;
import com.emlee.service.IUserService;

@Service("UserService")
public class UserService implements IUserService {
		
	@Resource(name="UserMapper")
	private UserMapper userMapper;

	@Override
	public int getUserid(userDTO uDTO) throws Exception {
		return userMapper.getUserid(uDTO);
	}

	@Override
	public int insertJoin(userDTO uDTO) throws Exception {
		return userMapper.insertJoin(uDTO);
	}

	@Override
	public userDTO getUserInfo(userDTO uDTO) throws Exception {
		return userMapper.getUserInfo(uDTO);
	}

	@Override
	public int updateEmailConfirm(userDTO uDTO) throws Exception {
		return userMapper.updateEmailConfirm(uDTO);
	}

	@Override
	public int insertKey(keyDTO kDTO) throws Exception {
		return userMapper.insertKey(kDTO);
	}

	@Override
	public keyDTO getEmailKey(keyDTO kDTO) throws Exception {
		return userMapper.getEmailKey(kDTO);
	}

	@Override
	public userDTO getIdSearch(userDTO uDTO) throws Exception {
		return userMapper.getIdSearch(uDTO);
	}

	@Override
	public userDTO getPassword(userDTO uDTO) throws Exception {
		return userMapper.getPassword(uDTO);
	}

	@Override
	public int updatePassword(userDTO pDTO) throws Exception {
		return userMapper.updatePassword(pDTO);
	}

	@Override
	public List<userDTO> getUserList() throws Exception {
		return userMapper.getUserList();
	}

	@Override
	public userDTO getUserDetail(userDTO uDTO) throws Exception {
		return userMapper.getUserDetail(uDTO);
	}

	@Override
	public int deleteUser(userDTO uDTO) throws Exception {
		return userMapper.deleteUser(uDTO);
	}

	@Override
	public int updateUser(userDTO uDTO) throws Exception {
		return userMapper.updateUser(uDTO);
	}

	@Override
	public List<boardDTO> getRegList(String user_no) throws Exception {
		return userMapper.getRegList(user_no);
	}

	@Override
	public List<boardDTO> getRegSearch(boardDTO bDTO) throws Exception {
		return userMapper.getRegSearch(bDTO);
	}

	@Override
	public List<userDTO> getUserSearch(userDTO uDTO) throws Exception {
		return userMapper.getUserSearch(uDTO);
	}

	@Override
	public List<userDTO> getGenderData() throws Exception {
		return userMapper.getGenderData();
	}

	@Override
	public List<userDTO> getTeamData() throws Exception {
		return userMapper.getTeamData();
	}

	@Override
	public List<userDTO> getGTData() throws Exception {
		return userMapper.getGTData();
	}

	@Override
	public List<userDTO> getAgeData() throws Exception {
		return userMapper.getAgeData();
	}

	@Override
	public List<userDTO> getAddrData() throws Exception {
		return userMapper.getAddrData();
	}

	@Override
	public List<userDTO> getRegData() throws Exception {
		return userMapper.getRegData();
	}

	@Override
	public List<boardDTO> getBoardData() throws Exception {
		return userMapper.getBoardData();
	}

	@Override
	public userDTO getUserNum() throws Exception {
		return userMapper.getUserNum();
	}

	@Override
	public manageDTO getManageNum() throws Exception {
		return userMapper.getManageNum();
	}

	@Override
	public boardDTO getBoardNum() throws Exception {
		return userMapper.getBoardNum();
	}

	@Override
	public List<userDTO> getUserPaging(userDTO uDTO) throws Exception {
		return userMapper.getUserPaging(uDTO);
	}

	@Override
	public userDTO getUserSearchNum(userDTO sDTO) throws Exception {
		return userMapper.getUserSearchNum(sDTO);
	}

	@Override
	public List<userDTO> getUserSearchPage(userDTO uDTO) throws Exception {
		return userMapper.getUserSearchPage(uDTO);
	}

	@Override
	public List<boardDTO> getRegPaging(boardDTO bDTO) throws Exception {
		return userMapper.getRegPaging(bDTO);
	}

	@Override
	public boardDTO getRegSearchNum(boardDTO sDTO) throws Exception{
		return userMapper.getRegSearchNum(sDTO);
	}

	@Override
	public List<boardDTO> getRegSearchPage(boardDTO uDTO) throws Exception{
		return userMapper.getRegSearchPage(uDTO);
	}

	@Override
	public boardDTO getRegNum(String user_no) throws Exception {
		return userMapper.getRegNum(user_no);
	}
		
}