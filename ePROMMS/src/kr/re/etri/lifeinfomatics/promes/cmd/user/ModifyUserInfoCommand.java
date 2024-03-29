package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class ModifyUserInfoCommand implements Command {

	private String next = "";

	public ModifyUserInfoCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String name = req.getParameter("_name");
			name = Util.toString(name);
			String id = req.getParameter("_id");
			id = Util.toString(id);
			String pw = Util.toLowerCase(req.getParameter("_pw"));
			String type = req.getParameter("_type");
			String eMail = Util.toLowerCase(req.getParameter("_email1")) + "@" + Util.toLowerCase(req.getParameter("_email2"));
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

			UserInfo userInfo = UserManager.getInstance().getUserInfo(id);

			UserInfo newUserInfo = new UserInfo();
			newUserInfo.setName(name);
			newUserInfo.setId(id);
			newUserInfo.setPw(pw);
			newUserInfo.setType(type.toUpperCase());
			newUserInfo.setE_mail(eMail);
			newUserInfo.setHp(hp);
			newUserInfo.setSms(Boolean.valueOf(receiptSMS));

			if (timeListStr != null && !timeListStr.equals("")) 
			{
				timeListStr = Util.toString(timeListStr);
				ArrayList<String> timeList = Util.split("/", timeListStr);
				newUserInfo.setTime(timeList);
			}

			if (protectorsStr != null && !protectorsStr.equals("")) 
			{
				protectorsStr = Util.toString(protectorsStr);
			}
			newUserInfo.setProtectorsStr(protectorsStr);

			if (pillBoxsStr != null && !pillBoxsStr.equals("")) 
			{
				pillBoxsStr = Util.toString(pillBoxsStr);
				pillBoxsStr = pillBoxsStr.replace("[", "");
				ArrayList<String> pillBoxList = Util.split("]", pillBoxsStr);
				ArrayList<PillBoxInfo> pillBoxs = PillBoxInfo.split(pillBoxList);
				newUserInfo.setPillBoxsStr(pillBoxsStr);
				newUserInfo.setPillBoxs(pillBoxs);
			}

			Hashtable<String, Object> pillBoxHash = checkPillBoxs(userInfo.getPillBoxsStr(), newUserInfo.getPillBoxs());
			ArrayList<String> delList = (ArrayList<String>) pillBoxHash.get("DEL");
			if (delList.size() > 0) {
				if (PillBoxManager.getInstance().checkUsePillBoxs(delList)) {
					//req.setAttribute("msg", "사용중인 약상자를 삭제 하였습니다. 확인하시길 바랍니다.");
					//return next;
				}
			}

			if (company != null && !company.equals("")) {
				company = Util.toString(company);
			}

			if (addr != null && !addr.equals("")) {
				addr = Util.toString(addr);
			}

			newUserInfo.setCompany(company);
			newUserInfo.setPh(companyPh);
			newUserInfo.setAddr(addr);
			newUserInfo.setGender(gender);
			newUserInfo.setAge(age);
			
			PrescriptionManager.getInstance().modifyPrescriptionPillBoxId(id,userInfo.getPillBoxsStr(), newUserInfo.getPillBoxs());
			UserManager.getInstance().modifyUserInfo(userInfo.getPillBoxsStr(),newUserInfo, pillBoxHash);			
			req.setAttribute("msg", "Modify Completed.");
			req.setAttribute("beforePage", "ModifyUser");
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("beforePage", "ModifyUser");
			req.setAttribute("msg", "Modify Fail.");
			return next;
		}
	}	

	public Hashtable<String, Object> checkPillBoxs(String oldPillBoxs, ArrayList<PillBoxInfo> newPillBoxs) {

		String newPillBoxIdStr = "";
		for (int i = 0; i < newPillBoxs.size(); i++) {
			PillBoxInfo pillBoxInfo = newPillBoxs.get(i);
			newPillBoxIdStr += pillBoxInfo.getId();
			if (i != newPillBoxs.size() - 1) {
				newPillBoxIdStr += "/";
			}
		}

		Hashtable<String, Object> pillBoxHash = new Hashtable<String, Object>();

		ArrayList<String> oldPillBoxList = Util.split("/", oldPillBoxs);

		ArrayList<PillBoxInfo> addList = new ArrayList<PillBoxInfo>();
		ArrayList<PillBoxInfo> updateList = new ArrayList<PillBoxInfo>();

		for (PillBoxInfo pillBoxInfo : newPillBoxs) {
			if (!oldPillBoxList.contains(pillBoxInfo.getId())) {
				addList.add(pillBoxInfo);
			}
			else {
				updateList.add(pillBoxInfo);
			}
		}

		ArrayList<String> delList = new ArrayList<String>();
		for (String pillBoxId : oldPillBoxList) {
			if (!newPillBoxIdStr.contains(pillBoxId)) {
				delList.add(pillBoxId);
			}
		}

		pillBoxHash.put("ADD", addList);
		pillBoxHash.put("UPDATE", updateList);
		pillBoxHash.put("DEL", delList);
		return pillBoxHash;
	}
}
