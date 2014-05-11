package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class DeleteUserInfoCommand implements Command {

	private String next = "";

	public DeleteUserInfoCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userIdListStr = req.getParameter("userIdList");
			userIdListStr = Util.toString(userIdListStr);
			String type = req.getParameter("type");

			ArrayList<String> userIdList = Util.split(",", userIdListStr);

			ArrayList<String> failureIdList = UserManager.getInstance().deleteUserInfo(type.toUpperCase(), userIdList);
			if (failureIdList.size() == 0) {
				req.setAttribute("msg", "delete");
			}
			else {
				String tmpIdList = "";
				for (int i = 0; i < failureIdList.size(); i++) {
					tmpIdList += failureIdList.get(i);
					if (failureIdList.size() != i + 1) {
						tmpIdList += ", ";
					}
				}
				String msg = "[ " + tmpIdList + " ]\\n the registered box can not be deleted.";
				
				req.setAttribute("msg", msg);
			}

			req.setAttribute("beforePage", "DeleteUser");

		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("beforePage", "DeleteUser");
			req.setAttribute("msg", ex.getMessage());
		}
		return next;
	}
}
