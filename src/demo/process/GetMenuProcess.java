package demo.process;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.apache.catalina.util.URLEncoder;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

public class GetMenuProcess {
	
	private String ACCESS_TOKEN = "";
	
	/*private String APPID = "wxc15c225ecbea19a6";
	
	private String APPSECRET = "b94fe9ef5633794d375d2c28669c4d16";*/
	
	private String APPID = "wx55391f180ce42fba";
	
	private String APPSECRET = "fbf458adc9914abd675909b91577f9e5";

	public String getMenuResult() {
		
		if (ACCESS_TOKEN.isEmpty()) {
			ACCESS_TOKEN = getAccessToken();
		}
		
		String apiUrl = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token="+ACCESS_TOKEN;
        /** 发送httpget请求 */  
        HttpGet request = new HttpGet(apiUrl);
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
        /** 请求失败处理 */  
        if(null==result){ 
            return "获取MENU失败，请稍后重试。";
        }
        try {  
            JSONObject json = new JSONObject(result); 
            //result = URLDecoder.decode(json.get("menu").toString(),"GB2312"); 编码有问题 TODO
            //result = URLDecoder.decode(json.get("menu").toString(),"UTF-8");
            result = json.get("menu").toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }/* catch (UnsupportedEncodingException e)
        	e.printStackTrace();
        }*/
		return result;
	}
	
	public String delMenu() {
		
		if (ACCESS_TOKEN.isEmpty()) {
			ACCESS_TOKEN = getAccessToken();
		}
		
		String apiUrl = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token="+ACCESS_TOKEN;
        /** 发送httpget请求 */  
        HttpGet request = new HttpGet(apiUrl);
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
        /** 请求失败处理 */  
        if(null==result){ 
            return "删除当前使用的自定义菜单失败，请稍后重试。";
        }
		return result;
	}
	
	public String createMenu() {
		
		if (ACCESS_TOKEN.isEmpty()) {
			ACCESS_TOKEN = getAccessToken();
		}
		
		String apiUrl = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+ACCESS_TOKEN;
        /** 发送HttpPost请求 */  
       HttpPost request = new HttpPost(apiUrl);
       request.setHeader("Content-Type", "application/json;charset=utf-8");
       request.setHeader("Accept", "application/json;charset=utf-8");
  
       //String jsonStr1 = "{'button' : [{ 'type' : 'click', 'name' : 'SIM卡简介', 'key' : 'V1001_TODAY_MUSIC'},"
       	//	+ "{'name':'预约购买','sub_button':[{'type':'view','name':'订单信息','url':'http://www.soso.com/'},{'type':'view','name':'在线预约','url':'http://v.qq.com/'}]}]}";
       String jsonStr1 = "{'button' : [{ 'type' : 'view', 'name' : 'SIM卡激活', 'url' : 'http://service.ocn.ne.jp/mobile/one/visitor/zh-CHS/apn/'},"
          		+ "{'name':'预约购买','sub_button':[{'type':'view','name':'订单信息','url':'http://localhost:8080/GRCRM_2015/searchbytelno.jsp'},{'type':'view','name':'在线预约','url':'http://localhost:8080/GRCRM_2015/simcardinfo.jsp'}]},"
                + "{ 'type' : 'view', 'name' : '联系我们', 'url' : 'http://www.grids.com.cn/homepagecd/cn/contact.jsp'}]}";

       JSONObject postJson = new JSONObject();
       JSONObject btn1 = null; 
       try {
    	   btn1 = new JSONObject(jsonStr1);
       } catch (JSONException e) {
           e.printStackTrace();
       }
       
/*        JSONObject postJson = new JSONObject();
        JSONObject btn1 = new JSONObject();
        btn1.put("type", "click");
        btn1.put("name", "今日歌曲");
        btn1.put("key", "V1001_TODAY_MUSIC");*/
        
        //postJson.add("button", btn1);
        String result = "";  
        try {
        	StringEntity input = new StringEntity(btn1.toString(),"UTF-8");
        	input.setContentType("application/json;charset=utf-8");
        	request.setEntity(input);
            HttpResponse response = HttpClients.createDefault().execute(request);
            if(response.getStatusLine().getStatusCode()==200){  
                result = EntityUtils.toString(response.getEntity());
            } else {
            	System.out.println("error liuchang");
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();
        } catch (Exception e) {  
            e.printStackTrace();
        }
        /** 请求失败处理 */  
        if(null==result){ 
            return "获取MENU失败，请稍后重试。";
        }
        try {  
            JSONObject json = new JSONObject(result); 
            result = json.getString("menu");
        } catch (JSONException e) {
            e.printStackTrace();
        }
		return result;
	}
	
	
	public String getAccessToken () {
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
		return result;
	}
}
