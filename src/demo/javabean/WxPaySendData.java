package demo.javabean;

public class WxPaySendData {
	private String appid;
	
	
	   private String mch_id;
	    private String nonce_str;
	    private String notify_url;
	    private String out_trade_no;
	    private String total_fee;
	    private String trade_type;
	    private String spbill_create_ip;
	    private String openid;
	    
	    
	/**
         * @return the mch_id
         */
        public String getMch_id() {
            return mch_id;
        }
        /**
         * @param mch_id the mch_id to set
         */
        public void setMch_id(String mch_id) {
            this.mch_id = mch_id;
        }
        /**
         * @return the nonce_str
         */
        public String getNonce_str() {
            return nonce_str;
        }
        /**
         * @param nonce_str the nonce_str to set
         */
        public void setNonce_str(String nonce_str) {
            this.nonce_str = nonce_str;
        }
        /**
         * @return the notify_url
         */
        public String getNotify_url() {
            return notify_url;
        }
        /**
         * @param notify_url the notify_url to set
         */
        public void setNotify_url(String notify_url) {
            this.notify_url = notify_url;
        }
        /**
         * @return the out_trade_no
         */
        public String getOut_trade_no() {
            return out_trade_no;
        }
        /**
         * @param out_trade_no the out_trade_no to set
         */
        public void setOut_trade_no(String out_trade_no) {
            this.out_trade_no = out_trade_no;
        }
        /**
         * @return the total_fee
         */
        public String getTotal_fee() {
            return total_fee;
        }
        /**
         * @param total_fee the total_fee to set
         */
        public void setTotal_fee(String total_fee) {
            this.total_fee = total_fee;
        }
        /**
         * @return the trade_type
         */
        public String getTrade_type() {
            return trade_type;
        }
        /**
         * @param trade_type the trade_type to set
         */
        public void setTrade_type(String trade_type) {
            this.trade_type = trade_type;
        }
        /**
         * @return the spbill_create_ip
         */
        public String getSpbill_create_ip() {
            return spbill_create_ip;
        }
        /**
         * @param spbill_create_ip the spbill_create_ip to set
         */
        public void setSpbill_create_ip(String spbill_create_ip) {
            this.spbill_create_ip = spbill_create_ip;
        }
        /**
         * @return the openid
         */
        public String getOpenid() {
            return openid;
        }
        /**
         * @param openid the openid to set
         */
        public void setOpenid(String openid) {
            this.openid = openid;
        }
    public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	private String attach;
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	private String body;
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}

	

}
