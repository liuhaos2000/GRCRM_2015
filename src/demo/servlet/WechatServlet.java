package demo.servlet;  
  
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import demo.entity.ReceiveXmlEntity;
import demo.javabean.UserInfo;
import demo.process.GetUserInfo;
import demo.process.ReceiveXmlProcess;
import demo.process.WechatProcess;
import demo.util.SHA1;
/** 
 * 微信服务端收发消息接口 
 *  
 * @author pamchen-1 
 *  
 */  
public class WechatServlet extends HttpServlet {  
  
    /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1140202829587508149L;
	
	private String Token = "grcrm2015";
	/** 
     * The doGet method of the servlet. <br> 
     *  
     * This method is called when a form has its tag value method equals to get. 
     *  
     * @param request 
     *            the request send by the client to the server 
     * @param response 
     *            the response send by the server to the client 
     * @throws ServletException 
     *             if an error occurred 
     * @throws IOException 
     *             if an error occurred 
     */  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        request.setCharacterEncoding("UTF-8");  
        response.setCharacterEncoding("UTF-8");  
  
        /** 读取接收到的xml消息 */  
        StringBuffer sb = new StringBuffer();  
        InputStream is = request.getInputStream();  
        InputStreamReader isr = new InputStreamReader(is, "UTF-8");  
        BufferedReader br = new BufferedReader(isr);  
        String s = "";  
        while ((s = br.readLine()) != null) {  
            sb.append(s);  
        }  
        String xml = sb.toString(); //次即为接收到微信端发送过来的xml数据  
  
		///////////////////////////
		/** 解析xml数据 */  
		ReceiveXmlEntity xmlEntity = new ReceiveXmlProcess().getMsgEntity(xml); 
		String openid = xmlEntity.getFromUserName();
		try {
		GetUserInfo.insertToUserTable(openid);
		} catch (Exception e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
		}
		
		UserInfo ui = new UserInfo();
		ui.setOpenid(openid);		
		ServletContext application = ServletActionContext.getServletContext();
		application.setAttribute("openid",ui);
		
		//////////////////////////

        String result1 = "";  
        /** 判断是否是微信接入激活验证，只有首次接入验证时才会收到echostr参数，此时需要把它直接返回 */  
        String echostr = request.getParameter("echostr");
        System.out.println("echostr" + echostr);
        if (echostr != null && echostr.length() > 1) {
        	result1 = access(request, response);
        	//result = echostr;
        } else {
            //正常的微信处理流程  
            try {
				result1 = new WechatProcess().processWechatMag(request,response,xml);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        if (null != result1) {
            try {
                OutputStream os = response.getOutputStream();  
                os.write(result1.getBytes("UTF-8")); 
                os.flush();  
                os.close();  
            } catch (Exception e) {  
                e.printStackTrace();
            } 
        }
    }  
  
    /** 
     * The doPost method of the servlet. <br> 
     *  
     * This method is called when a form has its tag value method equals to 
     * post. 
     *  
     * @param request 
     *            the request send by the client to the server 
     * @param response 
     *            the response send by the server to the client 
     * @throws ServletException 
     *             if an error occurred 
     * @throws IOException 
     *             if an error occurred 
     */  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    }  
  
    
	/**
	 * 验证URL真实性
	 * 
	 * @author morning
	 * @date 2015年2月17日 上午10:53:07
	 * @param request
	 * @param response
	 * @return String
	 */
	private String access(HttpServletRequest request, HttpServletResponse response) {
		// 验证URL真实性
		System.out.println("进入验证access");
		String signature = request.getParameter("signature");// 微信加密签名
		String timestamp = request.getParameter("timestamp");// 时间戳
		String nonce = request.getParameter("nonce");// 随机数
		String echostr = request.getParameter("echostr");// 随机字符串
		List<String> params = new ArrayList<String>();
		params.add(Token);
		params.add(timestamp);
		params.add(nonce);
		// 1. 将token、timestamp、nonce三个参数进行字典序排序
		Collections.sort(params, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		// 2. 将三个参数字符串拼接成一个字符串进行sha1加密
		String temp = SHA1.encode(params.get(0) + params.get(1) + params.get(2));
		System.out.println(params.get(0) + params.get(1) + params.get(2));
		System.out.println("temp" + temp);
		System.out.println("temp" + signature);
		if (temp.equals(signature)) {
			try {
				response.getWriter().write(echostr);
				System.out.println("成功返回 echostr：" + echostr);
				return echostr;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println("失败 认证");
		return null;
	}
} 