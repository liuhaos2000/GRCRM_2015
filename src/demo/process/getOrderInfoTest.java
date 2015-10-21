package demo.process;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.xml.bind.DataBindingException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

public class getOrderInfoTest {
	
	private static String APPID = "wxc15c225ecbea19a6";
	
	private static String APPSECRET = "b94fe9ef5633794d375d2c28669c4d16";

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		GetOrderInfoProcess orderinfopro = new GetOrderInfoProcess();
		String info = orderinfopro.execute();
		
		
	/*	String jsonStr = "{'button' : [{ 'type' : 'click', 'name' : '今日歌曲', 'key' : 'V1001_TODAY_MUSIC'},{'name':'菜单','sub_button':[{'type':'view','name':'搜索','url':'http://www.soso.com/'},{'type':'view','name':'视频','url':'http://v.qq.com/'},{'type':'click','name':'赞一下我们','key':'V1001_GOOD'}]}]}";
		JSONObject postJson = new JSONObject(jsonStr);
		System.out.println(postJson.get("button"));
		String str = "{'access_token':'caLRZw7aLLWPmKrTXnGkJpEigv5MpxhU_eYNY9Ec46Bu4HuimgyJZ7Mt4eK_GXbBjqUVQC8sHvOluP8RdJqJ0gb6O-Vsx5rYhDSxP4_wYoo','expires_in':7200}";
		JSONObject jsonTest = new JSONObject(str);
		System.out.println(jsonTest.get("access_token"));
		
		
		System.out.println(jsonStr);
		System.out.println(URLEncoder.encode(jsonStr,"UTF-8"));
		System.out.println(URLDecoder.decode(jsonStr,"UTF-8"));
		
		System.out.println(getAccessToken());*/
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
		return result;
	}
}
