package com.emlee.util;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class AES256Util {

	 public static byte[] ivBytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	 private static String key = "Super_Developers";
	 
	 /**
	  * �씪諛� 臾몄옄�뿴�쓣 吏��젙�맂 �궎瑜� �씠�슜�븯�뿬 AES256 �쑝濡� �븫�샇�솕
	  * @param  String - �븫�샇�솕 ���긽 臾몄옄�뿴
	  * @param  String - 臾몄옄�뿴 �븫�샇�솕�뿉 �궗�슜�맆 �궎
	  * @return String - key 濡� �븫�샇�솕�맂  臾몄옄�뿴 
	  * @exception 
	  */
	 public static String strEncode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
	  
	  byte[] textBytes = str.getBytes("UTF-8");
	  AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
	  SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
	  Cipher cipher = null;
	  cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	  cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
	  return Base64.encodeBase64String(cipher.doFinal(textBytes));
	 }

	 
	 
	 /**
	  * �븫�샇�솕�맂 臾몄옄�뿴�쓣 吏��젙�맂 �궎瑜� �씠�슜�븯�뿬 AES256 �쑝濡� 蹂듯샇�솕
	  * @param  String - 蹂듯샇�솕 ���긽 臾몄옄�뿴
	  * @param  String - 臾몄옄�뿴 蹂듯샇�솕�뿉 �궗�슜�맆 �궎
	  * @return String - key 濡� 蹂듯샇�솕�맂  臾몄옄�뿴 
	  * @exception 
	  */ 
	 public static String strDecode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
	  
	  byte[] textBytes = Base64.decodeBase64(str);
	  //byte[] textBytes = str.getBytes("UTF-8");
	  AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
	  SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
	  Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	  cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
	  return new String(cipher.doFinal(textBytes), "UTF-8");
	 }
	 
	}