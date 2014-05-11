package kr.re.etri.lifeinfomatics.promes.cmd;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class CheckIdCommand implements Command {

	private String next = "";

	public CheckIdCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String id = req.getParameter("_id");
			//id = Util.toString(id);

			boolean result = UserManager.getInstance().checkUserId(id);

			req.setAttribute("id", id);
			req.setAttribute("result", String.valueOf(result));
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
