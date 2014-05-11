package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class LoadSearchUserInfoListCommand implements Command {

	private String next = "";

	public LoadSearchUserInfoListCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String type = req.getParameter("_type");
			String grade = req.getParameter("grade");
			req.setAttribute("type", type);
			
			if(grade != null){
    			if(grade.equals("incharge")){
    				return "home/incharge/searchUser.jsp";
    			}
			}
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
