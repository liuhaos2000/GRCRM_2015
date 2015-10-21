package demo.process;

import demo.javabean.WxPaySendData;

public class WxPayProcess {
	
	public static void main(String[] args) throws Exception {
	WxPaySendData data = new WxPaySendData();
    data.setAppid("wx55391f180ce42fba");
    data.setAttach("微信支付");
    data.setBody("微信公众号支付");
    /*data.setMch_id(WxPayConfig.MCHID);
    data.setNonce_str(nonceStr);
    data.setNotify_url(WxPayConfig.NOTIFY_URL);
    data.setOut_trade_no(tradeNo);
    data.setTotal_fee((int)(fee*100));//单位：分
    data.setTrade_type("JSAPI");
    data.setSpbill_create_ip(ip);
    data.setOpenid(at.getOpenid());
    String returnXml = UnifiedorderService.unifiedOrder(data,WxPayConfig.KEY);
    WxPayReturnData reData = new WxPayReturnData();
    XStream xs1 = new XStream(new DomDriver());
    xs1.alias("xml", WxPayReturnData.class);
    reData = (WxPayReturnData) xs1.fromXML(returnXml);
*/

}
}
