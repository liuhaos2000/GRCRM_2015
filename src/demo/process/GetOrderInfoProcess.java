package demo.process;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GetOrderInfoProcess extends ActionSupport{

	private String telno = "";
	
	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}
	
	public String execute() throws Exception{

		final long serialVersionUID = 7620009925942346125L;  
		
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("telno", telno);
		  
        return "success";

	}

}
