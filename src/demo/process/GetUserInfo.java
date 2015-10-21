package demo.process;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import demo.javabean.OrderInfo;

public class GetUserInfo{

    private static String APPID = "wx55391f180ce42fba";
	
	private static String APPSECRET = "fbf458adc9914abd675909b91577f9e5";
	
	public static void insertToUserTable(String opeid) throws Exception{

		final long serialVersionUID = 7620009925942346125L;  
		 
		List ddwhoneList = new ArrayList();
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/weixin?"
				+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
		Statement stmt = null;
		ResultSet rs = null;
		String result = ""; 
		try{
		  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
		  conn = (Connection) DriverManager.getConnection(url);
		  
		  // �f�[�^�x�[�X�ɑ΂��鏈��
		  stmt = (Statement) conn.createStatement();
		  
		  
		  ////////////////////////
		  String url1 = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+APPID+"&secret="+APPSECRET;
			HttpGet request = new HttpGet(url1);
	         
	        try {
	            HttpResponse response = HttpClients.createDefault().execute(request);
	            if(response.getStatusLine().getStatusCode()==200){  
	                result = EntityUtils.toString(response.getEntity());  
	            }  
	        } catch (ClientProtocolException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }
	        try {  
	            JSONObject json = new JSONObject(result);
	            System.out.println("获取到的凭证 access_token:" + json.getString("access_token"));
	            System.out.println("凭证有效时间，单位：秒 expires_in:" + json.get("expires_in"));
	            result = json.getString("access_token");
	        } catch (JSONException e) {  
	            e.printStackTrace();  
	        }
	        
	        String url2 = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + result + "&openid="+ opeid;
	        HttpGet request1 = new HttpGet(url2);
	        String result1 = "";
	        String nickname = "";
	        String sex = "";
	        String address = "";
	        String language = "";
	        try {
	            HttpResponse response1 = HttpClients.createDefault().execute(request1);
	            if(response1.getStatusLine().getStatusCode()==200){  
	                result1 = EntityUtils.toString(response1.getEntity());  
	            }  
	        } catch (ClientProtocolException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }
	        try {  
	            JSONObject json1 = new JSONObject(result1);
	            String city = json1.get("city").toString();
	            nickname = json1.get("nickname").toString();
	            sex = json1.get("sex").toString();
	            language = json1.get("language").toString();
	            String province = json1.get("province").toString();
	            String country = json1.get("country").toString();
	            
	            city = new String(city.getBytes("ISO8859-1"), "UTF-8"); 
				 nickname = new String(nickname.getBytes("ISO8859-1"), "UTF-8"); 
				 sex = new String(sex.getBytes("ISO8859-1"), "UTF-8");
				 if(sex.equals("1")){
					 sex = "男";
				 }else{
					 sex = "女"; 
				 }
				 
				 language = new String(language.getBytes("ISO8859-1"), "UTF-8");
				 if(language.equals("zh_CN")){
					 language = "汉语";
				 }
				 province = new String(province.getBytes("ISO8859-1"), "UTF-8");
				 country = new String(country.getBytes("ISO8859-1"), "UTF-8");
				 
				 address = country + province + city;
				 
	        } catch (JSONException e) {  
	            e.printStackTrace();  
	        }
		  ////////////////////////
		  
		  String sql = "insert into weixin.userinfo(userid,sex,address,language,shortname) values('"  + opeid + "','"  + sex + "','" + address + "','"  + language + "','" + nickname+ "')";
		  stmt.execute(sql);
		  
		}catch (SQLException e){
			e.printStackTrace();
		}catch (Exception e) {
            e.printStackTrace();
        } finally {
        	conn.close();
        }
		

	}

}
