package com.emlee.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.emlee.DTO.boardDTO;
import com.emlee.DTO.keyDTO;
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
		
}