package demo.process;

import java.io.IOException;




import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

public class GetCallbackIpProcess {
	
	private String ACCESS_TOKEN = "740uvW3KDjbMCKvsN_caCnU0_133HVJNqhzbMtU9PeXLBc4pA3MBzEdA9L8Dw4e-bPJARa_qOkMpEAwyl4ngUQ83yC5Kwm7UUe-A7b1Etn4";
	
	private String APPID = "wxc15c225ecbea19a6";
	
	private String APPSECRET = "b94fe9ef5633794d375d2c28669c4d16";

	public String getIpResult(){
		
		if (ACCESS_TOKEN.isEmpty()) {
			ACCESS_TOKEN = getAccessToken();
		}
		
		String apiUrl = "https://api.weixin.qq.com/cgi-bin/getcallbackip?access_token="+ACCESS_TOKEN;
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
            return "获取微信服务器IP失败，请稍后重试。";
        }
        try {  
            JSONObject json = new JSONObject(result); 
            //以code=100000为例，参考图灵机器人api文档  
            result = "获取微信服务器IP成功，IP为"+json.getString("ip_list");
        } catch (JSONException e) {
            // TODO Auto-generated catch block
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
