package com.emlee.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * �궇吏� 愿��젴 �븿�닔 紐⑥쓬
 */
public class DateUtil {

	//�궇吏� �몴�떆 �삎�떇�쑝濡� �뜲�씠�꽣 媛��졇�삤湲�
	public static String getDate(String str) {
		SimpleDateFormat formatter = new SimpleDateFormat(str, Locale.KOREA);
		Date currentTime = new Date();
		String res = formatter.format(currentTime);

		return res;
	}
	
	//�삤�뒛 �뀈 媛��졇�삤湲�
	public static String getTodayYYYY() {
		return getDate("yyyy");
		
	}
	
	//�삤�뒛 �썡 媛��졇�삤湲�
	public static String getTodayMM() {
		return getDate("MM");
		
	}
	
	//�삤�뒛 �궇 媛��졇�삤湲�
	public static String getTodayDD() {
		return getDate("dd");
		
	}
}