package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.sun.org.apache.xml.internal.serializer.utils.Utils;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadModifyUserInfoCommand implements Command {

	private String next = "";

	public LoadModifyUserInfoCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String tmpNext = "";
			String id = req.getParameter("userId");
			id = Util.toString(id);
			UserInfo userInfo = UserManager.getInstance().getUserInfo(id);
			String pillBoxsStr = userInfo.getPillBoxsStr();
			if (pillBoxsStr != null && !pillBoxsStr.equals("")) {
				ArrayList<PillBoxInfo> pillBoxs = PillBoxManager.getInstance().getPillBoxListToPillBoxStr(pillBoxsStr);
				userInfo.setPillBoxs(pillBoxs);
			}
			req.setAttribute("userInfo", userInfo);
			if (userInfo.getType().equals(Define.USER_ADMIN)) {
				tmpNext = "home/management/modifyManagement.jsp";
			}
			else {
				tmpNext = "home/user/modifyUser.jsp";
			}
			return tmpNext;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
