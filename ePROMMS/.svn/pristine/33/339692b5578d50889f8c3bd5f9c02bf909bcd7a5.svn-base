package kr.re.etri.lifeinfomatics.promes.cmd.prescription;



import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;


import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadSearchInchargeCommand implements Command{

	private String next = "";
	
	public LoadSearchInchargeCommand(String next){
		this.next = next;
	}
	
	
	public String execute(HttpServletRequest req) throws CommandException 
	{
				
		try 
		{
			String searchValue = req.getParameter("_searchValue");
			StringBuilder str = new StringBuilder();
			
			ArrayList<UserInfo> userInfoList = UserManager.getInstance().getUserInfoList("incharge", "ID_NAME", searchValue);
			for(UserInfo rows :userInfoList){
				str.append(rows.getId());
				str.append(",");
				str.append(rows.getName());
				str.append(",");
				str.append(rows.getCompany());
				str.append("/");				
			}	
			
			return str.toString();
			
		}  catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
		
		
		

	}
}
