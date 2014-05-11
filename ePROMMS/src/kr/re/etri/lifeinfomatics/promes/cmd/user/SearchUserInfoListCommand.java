package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import com.sun.xml.internal.ws.util.StringUtils;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class SearchUserInfoListCommand implements Command {

	private String next = "";

	public SearchUserInfoListCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String tmpNext = "";

			String type = req.getParameter("type");
			String keyType = req.getParameter("_keyType");
			if(keyType == null || keyType.equals("")){
				keyType = "id";
			}
			
			String key = req.getParameter("_key");
			key = Util.toString(key);
			String sortType = req.getParameter("_sortType");
			String sortCourse = req.getParameter("_sortCourse");
			String pageIdx = req.getParameter("_pageIdx");
			String memberkind = req.getParameter("memberkind");
			if(memberkind == null)
				memberkind="";

			if (pageIdx == null || pageIdx.equals("")) {
				pageIdx = "1";
			}
			int pageNum = Integer.parseInt(pageIdx);

			ArrayList<UserInfo> tmpUserList = UserManager.getInstance().getUserInfoList(type, keyType, key);
//			tmpUserList.addAll(tmpUserList);
//			tmpUserList.addAll(tmpUserList);
//			tmpUserList.addAll(tmpUserList);
//			tmpUserList.addAll(tmpUserList);
			
			ArrayList<Object> objList = new ArrayList<Object>();
			if (sortType != null && !sortType.equals("")) {
				objList = Util.sort(tmpUserList, sortType, sortCourse);
			}
			else {
				for (UserInfo userInfo : tmpUserList) {
					objList.add(userInfo);
				}
			}
			
			int maxPageIdx = (objList.size() / 8) + 1;
			ArrayList<UserInfo> userList = new ArrayList<UserInfo>();
			int num = (pageNum - 1) * 8;
			int maxNum = 0;
			if (maxPageIdx > pageNum) {
				maxNum = num + 8;
			}
			else {
				maxNum = objList.size();
			}

			for (int i = num; i < maxNum; i++) {
				userList.add((UserInfo)objList.get(i));
			}

			Hashtable<String, String> userCountHash = UserManager.getInstance().getUserCount();
			
			if (type.equals(Define.USER_PATIENT)) {
				tmpNext = "home/management/patient.jsp";
			}
			else if (type.equals(Define.USER_PHARMACIST)) {
				tmpNext = "home/management/pharmacist.jsp";
			}
			else if (type.equals(Define.USER_DOCTOR)) {
				tmpNext = "home/management/doctor.jsp";
			}else if (type.equals(Define.USER_INCHARGE)) {
				tmpNext = "home/management/incharge.jsp";
//				tmpNext = "home/incharge/patient.jsp";
			}else {
				req.setAttribute("message", "사용자 Type 맞지 않습니다.\\n다시 로그인 하세요.");
				return "home/error.jsp";
			}
			if(memberkind.equals("incharge") )
				tmpNext = "home/incharge/patient.jsp";
			req.setAttribute("userCountHash", userCountHash);
			req.setAttribute("userList", userList);
			req.setAttribute("searchType", keyType);
			req.setAttribute("searchKey", Util.toWebString(key));
			req.setAttribute("pageIdx", pageIdx);
			req.setAttribute("maxPageIdx", String.valueOf(maxPageIdx));
			req.setAttribute("sortType", sortType);
			req.setAttribute("sortCourse", sortCourse);
			return tmpNext;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
