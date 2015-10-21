/**
 * 
 */
/**
 * @author GRCRM
 *
 */
package demo.dao;

import java.util.Date;

public class transferinformation {
    private int       orderid;
    public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	private int        shopid;
    public int getShopid() {
		return shopid;
	}
	public void setShopid(int shopid) {
		this.shopid = shopid;
	}
	private int       productid ;
    public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	private String    transferamount;
    public String getTransferamount() {
		return transferamount;
	}
	public void setTransferamount(String transferamount) {
		this.transferamount = transferamount;
	}
	private String    remainingamount;
    public String getRemainingamount() {
		return remainingamount;
	}
	public void setRemainingamount(String remainingamount) {
		this.remainingamount = remainingamount;
	}
	private String    status;
    public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	private Date      madeday;
    public Date getMadeday() {
		return madeday;
	}
	public void setMadeday(Date madeday) {
		this.madeday = madeday;
	}
	private String    maker;
    public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	private Date    updatedday;
    public Date getUpdatedday() {
		return updatedday;
	}
	public void setUpdatedday(Date updatedday) {
		this.updatedday = updatedday;
	}
	private String    updater;
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
   
   
}