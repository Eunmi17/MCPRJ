package com.emlee.util;
import java.text.DecimalFormat;

public class TextUtil {
	public static String exchangeEscape(String value){
		value = value.replaceAll("& lt;", "<").replaceAll("& gt;", ">");
        value = value.replaceAll("& #40;", "\\(").replaceAll("& #41;", "\\)");
        value = value.replaceAll("& #39;", "'");
        return value;
	}
	public static String exchangeEscape2(String value){
		value = value.replaceAll("&lt;br /&gt;", "<br>");
        value = value.replaceAll("&amp;nbsp;", "&nbsp;");
        value = value.replaceAll("&amp;ucirc;", "&ucirc;");
        value = value.replaceAll("&amp;aring;", "&aring;");
        value = value.replaceAll("&amp;atilde;", "&atilde;");
        value = value.replaceAll("&amp;acirc;", "&acirc;");
        value = value.replaceAll("&lt;strong&gt;", "<strong>");
        value = value.replaceAll("&lt;/strong&gt;", "</strong>");
        return value;
	}
	public static String replaceBr(String str){
		str = str.replaceAll("\n", "</br>");
		return str;
	}	
	public static String exchangeEscapeNvl(String value){
		value = CmmUtil.nvl(value);
		value = exchangeEscape(value);
		return value;
	}
	
	public static String addComma(int value){
		DecimalFormat df = new DecimalFormat("#,##0");
		return df.format(value);
	}
	
	public static String addComma(String value){
		return addComma(Integer.parseInt(value));
	}	
	
}
