package demo.process;

import java.util.SortedMap;
import java.util.TreeMap;

import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;
import com.thoughtworks.xstream.XStream;

import demo.javabean.WxPaySendData;

public class UnifiedorderService {
	private final static Logger logger = LoggerFactory.getLogger(UnifiedorderService.class);
    
	  public static String unifiedOrder(WxPaySendData data,String key){
	    //统一下单支付
	    String returnXml = null;
	    try {
	      //生成sign签名
//	      SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
//	      parameters.put("appid", data.getAppid()); 
//	      parameters.put("attach", data.getAttach());
//	      parameters.put("body", data.getBody());
//	      parameters.put("mch_id", data.getMch_id());
//	      parameters.put("nonce_str", data.getNonce_str());
//	      parameters.put("notify_url", data.getNotify_url());
//	      parameters.put("out_trade_no", data.getOut_trade_no());
//	      parameters.put("total_fee", data.getTotal_fee());
//	      parameters.put("trade_type", data.getTrade_type());
//	      parameters.put("spbill_create_ip", data.getSpbill_create_ip());
//	      parameters.put("openid", data.getOpenid());
//	      parameters.put("device_info", data.getDevice_info());
//	      logger.info("SIGN:"+WxSign.createSign(parameters,key));
//	      data.setSign(WxSign.createSign(parameters,key));
//	      XStream xs = new XStream(new DomDriver("UTF-8",new XmlFriendlyNameCoder("-_", "_")));
//	      xs.alias("xml", WxPaySendData.class);
//	      String xml = xs.toXML(data);
//	      logger.info("统一下单xml为:\n" + xml);
//	      HttpClientUtil util = HttpClientUtil.getInstance();
//	      returnXml = util.doPostForString("https://api.mch.weixin.qq.com/pay/unifiedorder", null, xml);
//	      logger.info("返回结果:" + returnXml);
	    } catch (Exception e) {
	      e.printStackTrace();
	    } 
	    return returnXml;
	  }
}
