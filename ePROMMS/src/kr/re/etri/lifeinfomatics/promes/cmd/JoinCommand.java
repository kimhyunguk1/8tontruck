package kr.re.etri.lifeinfomatics.promes.cmd;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.ProtectorInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class JoinCommand implements Command {

	private String next = "";

	public JoinCommand(String next) {
		this.next = next;

	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String name = req.getParameter("_name");
			name = Util.toString(name);
			String id = req.getParameter("_id");
			id = Util.toString(id);
			String pw = req.getParameter("_pw").toLowerCase();
			String type = req.getParameter("_type");
			String eMail = req.getParameter("_email1").toLowerCase() + "@" + req.getParameter("_email2").toLowerCase();
//			String hp = req.getParameter("_hp1") + "-" + req.getParameter("_hp2") + "-" + req.getParameter("_hp3");
			String hp = req.getParameter("_hp2");
			String receiptSMS = req.getParameter("_receiptSMS");

			String timeListStr = req.getParameter("_timeList");
			String protectorsStr = req.getParameter("_protectors");
			String pillBoxsStr = req.getParameter("_pillBoxs");

			String company = req.getParameter("_company");
			String companyPh = req.getParameter("_companyPh");
			String addr = req.getParameter("_addr");
			String gender = req.getParameter("_gender");
			gender = Util.toString(gender);
			String age = req.getParameter("_age");

			UserInfo userInfo = new UserInfo();
			userInfo.setName(name);
			userInfo.setId(id);
			userInfo.setPw(pw);
			userInfo.setType(type.toUpperCase());
			userInfo.setE_mail(eMail);
			userInfo.setHp(hp);
			userInfo.setSms(Boolean.valueOf(receiptSMS));
			userInfo.setAge(age);
			userInfo.setGender(gender);

			if (timeListStr != null && !timeListStr.equals("")) {
				timeListStr = Util.toString(timeListStr);
				ArrayList<String> timeList = Util.split("/", timeListStr);
				userInfo.setTime(timeList);
			}

			if (protectorsStr != null && !protectorsStr.equals("")) {
				protectorsStr = Util.toString(protectorsStr);
				userInfo.setProtectorsStr(protectorsStr);
				protectorsStr = protectorsStr.replace("[", "");
				ArrayList<String> protectorList = Util.split("]", protectorsStr);
				ArrayList<ProtectorInfo> protectors = ProtectorInfo.split(protectorList);
				userInfo.setProtectors(protectors);
			}

			if (pillBoxsStr != null && !pillBoxsStr.equals("")) {
				pillBoxsStr = Util.toString(pillBoxsStr);
				pillBoxsStr = pillBoxsStr.replace("[", "");
				ArrayList<String> pillBoxList = Util.split("]", pillBoxsStr);
				ArrayList<PillBoxInfo> pillBoxs = PillBoxInfo.split(pillBoxList);
				pillBoxsStr = pillBoxsStr.replace("]", "");
				userInfo.setPillBoxsStr(pillBoxsStr);
				userInfo.setPillBoxs(pillBoxs);
			}
			if (company != null && !company.equals("")) {
				company = Util.toString(company);
			}
			if (addr != null && !addr.equals("")) {
				addr = Util.toString(addr);
			}
			userInfo.setCompany(company);
			userInfo.setPh(companyPh);
			userInfo.setAddr(addr);

			UserManager.getInstance().addUserInfo(userInfo);

			Log.out.debug(userInfo.toString());
			req.setAttribute("result", String.valueOf(true));
			req.setAttribute("beforePage", "Join");
			req.setAttribute("msg", "Join Completed.");
			return next;
		} catch (Exception ex) {
			Log.out.error(ex.getMessage());
			req.setAttribute("result", String.valueOf(false));
			req.setAttribute("beforePage", "Join");
			req.setAttribute("msg", ex.getMessage());
			return next;
		}
	}
}
