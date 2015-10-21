package demo.process;

import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;

import demo.util.MD5Util;

public class WxSign {

	private static String characterEncoding = "UTF-8";
	  
	  @SuppressWarnings("rawtypes")
	  public static String createSign(SortedMap<Object,Object> parameters,String key) throws NoSuchAlgorithmException{ 
	    StringBuffer sb = new StringBuffer(); 
	    Set es = parameters.entrySet();//所有参与传参的参数按照accsii排序（升序） 
	    Iterator it = es.iterator(); 
	    while(it.hasNext()) { 
	      Map.Entry entry = (Map.Entry)it.next(); 
	      String k = (String)entry.getKey(); 
	      Object v = entry.getValue(); 
	      if(null != v && !"".equals(v)  
	          && !"sign".equals(k) && !"key".equals(k)) { 
	        sb.append(k + "=" + v + "&"); 
	      } 
	    } 
	    sb.append("key=" + key);
	    String sign = MD5Util.MD5Encode(sb.toString(),"").toUpperCase(); 
	    return sign; 
	  }
	    
	  public static String getNonceStr() throws NoSuchAlgorithmException {
	    Random random = new Random();
	    return MD5Util.MD5Encode(String.valueOf(random.nextInt(10000)),"");
	  }
	  
	  public static String getTimeStamp() {
	    return String.valueOf(System.currentTimeMillis() / 1000);
	  }
}
