package demo.process;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonTest1 {
	
	private static String APPID = "wx55391f180ce42fba";
	
	private static String APPSECRET = "fbf458adc9914abd675909b91577f9e5";

	public static void main(String[] args) throws JSONException, UnsupportedEncodingException {
		// TODO Auto-generated method stub
	/*	String jsonStr = "{'button' : [{ 'type' : 'click', 'name' : '今日歌曲', 'key' : 'V1001_TODAY_MUSIC'},{'name':'菜单','sub_button':[{'type':'view','name':'搜索','url':'http://www.soso.com/'},{'type':'view','name':'视频','url':'http://v.qq.com/'},{'type':'click','name':'赞一下我们','key':'V1001_GOOD'}]}]}";
		JSONObject postJson = new JSONObject(jsonStr);
		System.out.println(postJson.get("button"));
		String str = "{'access_token':'caLRZw7aLLWPmKrTXnGkJpEigv5MpxhU_eYNY9Ec46Bu4HuimgyJZ7Mt4eK_GXbBjqUVQC8sHvOluP8RdJqJ0gb6O-Vsx5rYhDSxP4_wYoo','expires_in':7200}";
		JSONObject jsonTest = new JSONObject(str);
		System.out.println(jsonTest.get("access_token"));
		
		
		System.out.println(jsonStr);
		System.out.println(URLEncoder.encode(jsonStr,"UTF-8"));
		System.out.println(URLDecoder.decode(jsonStr,"UTF-8"));*/
		
		System.out.println(getAccessToken());
	}

	
	public static String getAccessToken () {
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+APPID+"&secret="+APPSECRET;
		HttpGet request = new HttpGet(url);
        String result = "";  
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
        String openid = "oEGioweWGjI2cCh1seidgP5yENW0";
        String url1 = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + result + "&openid="+openid;
        HttpGet request1 = new HttpGet(url1);
       
        String result1 = "";  
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
           /* System.out.println("获取到的凭证 access_token:" + json1.getString("openid"));*/
            String oid = json1.get("openid").toString();
            String city = json1.get("city").toString();
            String nickname = json1.get("nickname").toString();
            String sex = json1.get("sex").toString();
            String language = json1.get("language").toString();
            String province = json1.get("province").toString();
            String country = json1.get("country").toString();
         
           
				try {
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
					
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("凭证有效时间，单位：秒 expires_in1110:" + oid);
				System.out.println("凭证有效时间，单位：秒 expires_in1111:" + city);
				System.out.println("凭证有效时间，单位：秒 expires_in1112:" + nickname);
				System.out.println("凭证有效时间，单位：秒 expires_in1113:" + sex);
				System.out.println("凭证有效时间，单位：秒 expires_in1114:" + language);
				System.out.println("凭证有效时间，单位：秒 expires_in1115:" + province);
				System.out.println("凭证有效时间，单位：秒 expires_in1116:" + country);
            
        } catch (JSONException e) {  
            e.printStackTrace();  
        }
     
		return result1;
	}
}
