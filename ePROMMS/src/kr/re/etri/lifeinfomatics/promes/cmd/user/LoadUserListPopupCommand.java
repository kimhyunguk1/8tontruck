package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.sun.xml.internal.fastinfoset.Decoder;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadUserListPopupCommand implements Command {

	private String next = "";

	public LoadUserListPopupCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String name = req.getParameter("_userName");
//			name = Util.toString(name);
			name = new String(name.getBytes("8859_1"), "utf-8");
			
			String pageIdx = req.getParameter("_pageIdx");
			String target = req.getParameter("_target");
			String sortType = req.getParameter("_sortType");
			String sortCourse = req.getParameter("_sortCourse");

			if (pageIdx == null || pageIdx.equals("")) {
				pageIdx = "1";
			}
			int pageNum = Integer.parseInt(pageIdx);

			ArrayList<UserInfo> tmpUserList = UserManager.getInstance().getUserInfoToName(name);

			ArrayList<Object> objList = new ArrayList<Object>();
			if (sortType != null && !sortType.equals("")) {
				objList = Util.sort(tmpUserList, sortType, sortCourse);
			}
			else {
				for (UserInfo userInfo : tmpUserList) {
					objList.add(userInfo);
				}
			}
			
			int maxPageIdx = (objList.size() / 5) + 1;
			ArrayList<UserInfo> userList = new ArrayList<UserInfo>();
			int num = (pageNum - 1) * 5;
			int maxNum = 0;
			if (maxPageIdx > pageNum) {
				maxNum = num + 5;
			}
			else {
				maxNum = objList.size();
			}

			for (int i = num; i < maxNum; i++) {
				userList.add((UserInfo)objList.get(i));
			}

			req.setAttribute("userList", userList);
			req.setAttribute("userName", name);
			req.setAttribute("target", target);
			req.setAttribute("pageIdx", pageIdx);
			req.setAttribute("maxPageIdx", String.valueOf(maxPageIdx));
			req.setAttribute("sortType", sortType);
			req.setAttribute("sortCourse", sortCourse);
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
