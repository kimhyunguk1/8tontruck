package kr.re.etri.lifeinfomatics.promes.cmd.user;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class UserInfoResultCommand implements Command {

	private String next = "";

	public UserInfoResultCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			req.setAttribute("userInfo", userInfo);
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
		}
		return next;

	}

}
