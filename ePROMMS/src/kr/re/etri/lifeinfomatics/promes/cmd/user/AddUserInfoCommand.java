package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.ProtectorInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.data.PatientInfo;
import kr.re.etri.lifeinfomatics.promes.data.ManagerInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class AddUserInfoCommand implements Command {

	private String next = "";

	public AddUserInfoCommand(String next) {
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
				System.err.println(pillBoxsStr);
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
	
			
			//new
			if(type.toUpperCase().equals("PATIENT")) {
    			PatientInfo patientInfo = new PatientInfo();
    			
    			patientInfo.setPatientNo(id); //환자번호를 입력받아서 넣는것으로 바꿔야함. 테스트로 ID 똑같이 넣음.
    			patientInfo.setName(name);
    			patientInfo.setId(id);
    			patientInfo.setPw(pw);
    			patientInfo.setGender("1"); //수정요
    			patientInfo.setBirth("1983.03.17"); //수정요
    			patientInfo.setAddress("대구시 북구 산격"); //수정요
    			patientInfo.setPhone(hp); //수정요
    			patientInfo.setMobile(hp);
    			patientInfo.setSms(Boolean.valueOf(receiptSMS));
    			patientInfo.setManagerID("dhong"); //메니져아이디 넣는것으로 바꿔야함.
    			
    			UserManager.getInstance().addPatientInfo(patientInfo);
    			
			} //new
			else if(type.toUpperCase().equals("DOCTOR")) {
	    			ManagerInfo managerInfo = new ManagerInfo();
	    			
	    			managerInfo.setId(id);
	    			managerInfo.setName(name);	    			
	    			managerInfo.setPw(pw);
	    			managerInfo.setPhone(hp); //수정요
	    			managerInfo.setMobile(hp);
	    			managerInfo.setRegDate("2011.01.01"); //수정요
	    			managerInfo.setPermission("1"); //수정요
	    			managerInfo.setOrgNo("1"); //수정요
	    			
	    			UserManager.getInstance().addManagerInfo(managerInfo);
			}
			
			// req.setAttribute("msg", "사용자가 추가 되었습니다.");
			// Hashtable<String, String> userCountHash = UserManager.getInstance().getUserCount();
			// req.setAttribute("userCountHash", userCountHash);
			// req.setAttribute("type", type);
			Log.out.debug(userInfo.toString());
			req.setAttribute("result", String.valueOf(true));
			req.setAttribute("type", type);
			req.setAttribute("beforePage", "AddUser");
			req.setAttribute("msg", "Join Completed.");
			
			return next;
		} catch (Exception ex) {
			Log.out.error(ex.getMessage());
			req.setAttribute("result", String.valueOf(false));
			req.setAttribute("beforePage", "AddUser");
			req.setAttribute("msg", ex.getMessage());
			return next;
		}
	}
}
