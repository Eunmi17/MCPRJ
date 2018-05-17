package com.emlee.config;

import org.mybatis.spring.mapper.MapperScannerConfigurer;

public class MapperConfigurer extends MapperScannerConfigurer {

	/**
	 * 湲곕낯 �젙蹂�(anntationClass, sqlSessionFactoryBeanName)�쑝濡� �꽕�젙�븳�떎.
	 */
	public MapperConfigurer() {
		super.setAnnotationClass(Mapper.class);
		super.setSqlSessionFactoryBeanName("sqlSession");
	}
	
}
