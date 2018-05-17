package com.emlee.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * http �쟾�넚�떆, �엯�젰�릺�뒗 遺덈웾 臾몄옄(�빐�궧, html �떒�뼱 �벑) 泥섎━瑜� �쐞�빐 �궗�슜
 * */
public final class UrlFilter extends HttpServletRequestWrapper {
	 
    public UrlFilter(HttpServletRequest servletRequest) {
        super(servletRequest);
    }
 
    public String[] getParameterValues(String parameter) {
 
      String[] values = super.getParameterValues(parameter);
      if (values==null)  {
                  return null;
          }
      int count = values.length;
      
      String[] encodedValues = new String[count];
      
      for (int i = 0; i < count; i++) {
                 encodedValues[i] = cleanXSS(values[i]);
       }
      
      return encodedValues;
      
    }
 
    public String getParameter(String parameter) {
    	
          String value = super.getParameter(parameter);
          
          if (value == null) {
                 return null;
                  }
          
          return cleanXSS(value);
          
    }
 
    public String getHeader(String name) {
    	
        String value = super.getHeader(name);
        
        if (value == null)
            return null;
        
        return cleanXSS(value);
 
    }
 
    private String cleanXSS(String value) {
                //You'll need to remove the spaces from the html entities below
        value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
        value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
        value = value.replaceAll("'", "& #39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("script", "");
        
        return value;
        
    }
    
}