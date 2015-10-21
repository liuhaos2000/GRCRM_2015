package demo.process;  
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import demo.entity.ReceiveXmlEntity;
import demo.process.GetOrderInfoProcess;
  
/** 
 * 微信xml消息处理流程逻辑类 
 * @author pamchen-1 
 * 
 */  
public class WechatProcess {  
    /** 
     * 解析处理xml、获取智能回复结果（通过图灵机器人api接口） 
     * @param xml 接收到的微信数据 
     * @return  最终的解析结果（xml格式数据） 
     * @throws Exception 
     */  
    public String processWechatMag(HttpServletRequest request, HttpServletResponse response, String xml) throws Exception{  
        /** 解析xml数据 */  
        ReceiveXmlEntity xmlEntity = new ReceiveXmlProcess().getMsgEntity(xml); 
          
        /** 以文本消息为例，调用图灵机器人api接口，获取回复内容 */  
        String result = "";  
        if("text".endsWith(xmlEntity.getMsgType())) {
            switch (xmlEntity.getContent()) {
	        	case "IP" : result = new GetCallbackIpProcess().getIpResult(); break;
	        	case "MENU" : result = new GetMenuProcess().getMenuResult(); break;
	        	case "SETMENU" : result = new GetMenuProcess().createMenu(); break;
	        	case "DELMENU" : result = new GetMenuProcess().delMenu(); break;
	        	default : result = new TulingApiProcess().getTulingResult(xmlEntity.getContent()); break;
	        }
        } else if ("event".endsWith(xmlEntity.getMsgType())) {
        	System.out.println(xmlEntity.getEvent());
        	System.out.println(xmlEntity.getEventKey());
        	if ("CLICK".equals(xmlEntity.getEvent())) {
            	switch (xmlEntity.getEventKey()) {
		        	//case "V1001_ORDER_INFO" : new GetOrderInfoProcess().getOrderInfo(request,response); break;
            	//case "V1001_TODAY_MUSIC" : Response.sendRedirect("http://www.baidu.com"); break;
		        	case "V1001_CONTACT_US" : result = "今日歌曲：推荐张杰《看月亮爬上来》"; break;
		        	default : result = "推送事件未匹配成功！请联系管理员！！"; break;
		        }
        	} else {
        		result = "感谢您对顾客通服务号的关注，请根据您的需求，点击下方菜单。如有任何问题或建议请随时联系客服。 \n" +
        				"(温馨提示:本系统正处于开发测试阶段，给您带来不便尽请谅解！)";
        	}
        }
          
        /** 此时，如果用户输入的是“你好”，在经过上面的过程之后，result为“你也好”类似的内容  
         *  因为最终回复给微信的也是xml格式的数据，所有需要将其封装为文本类型返回消息 
         * */  
        result = new FormatXmlProcess().formatXmlAnswer(xmlEntity.getFromUserName(), xmlEntity.getToUserName(), result);  
          
        return result;  
    }  
} 