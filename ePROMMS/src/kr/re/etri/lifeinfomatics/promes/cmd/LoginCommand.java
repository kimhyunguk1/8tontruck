package kr.re.etri.lifeinfomatics.promes.cmd;

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

/**
 * @author rsdlove
 * 
 */
public class LoginCommand implements Command {

	private String next = "";

	public LoginCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String id = req.getParameter("_userId");
			id = Util.toString(id);
			String pw = req.getParameter("_userPw").toLowerCase();
			UserInfo userInfo = UserManager.getInstance().getUserInfo(id, pw);

			if (userInfo == null) 
			{
				req.setAttribute("message", "Check ID and Password.");
				req.setAttribute("userId", id);
				return "index.jsp";
			}
			req.setAttribute("userInfo", userInfo);
			
			req.getSession().setAttribute("LoginuserInfo",userInfo);
			String type = userInfo.getType();
			if (type.equals(Define.USER_ADMIN)) {
				Hashtable<String, String> userCountHash = UserManager.getInstance().getUserCount();
				req.setAttribute("userCountHash", userCountHash);
				return "home/management/management.jsp";
			}
			else if (type.equals(Define.USER_PATIENT)) {
				Hashtable<String, String> countHash = PrescriptionManager.getInstance().getPatientPrescriptionCount(id);
				req.setAttribute("countHash", countHash);
				return "home/patient/patient.jsp";
			}
			else if (type.equals(Define.USER_PHARMACIST) || type.equals(Define.USER_DOCTOR) || type.equals(Define.USER_INCHARGE)) {
				int patientCount = UserManager.getInstance().getPatientCount(id);
				int TakenpatientCount = UserManager.getInstance().getTakenPatientCount(id);
				int prescriptionCount = PrescriptionManager.getInstance().getPharmacistPrescriptionCount(id);
				ArrayList<String> Complitelist = UserManager.getInstance().getTakeCompliteList(id);
				Hashtable<String, String> countHash = new Hashtable<String, String>();
				countHash.put("patient", String.valueOf(patientCount));
				countHash.put("Takenpatient", String.valueOf(TakenpatientCount));
				countHash.put("prescription", String.valueOf(prescriptionCount));
				req.setAttribute("countHash", countHash);
				req.setAttribute("Complitelist", Complitelist);
				return "home/prescription/prescription.jsp";
			}
			else if (type.equals(Define.USER_MANAGER))
			{				
				Hashtable<String, String> userCountHash = UserManager.getInstance().getUserCount();
				
				int patientCount = UserManager.getInstance().getPatientCount(id);				
				int prescriptionCount = PrescriptionManager.getInstance().getPharmacistPrescriptionCount(id);
				Hashtable<String, String> countHash = new Hashtable<String, String>();
				countHash.put("patient", String.valueOf(patientCount));				
				countHash.put("prescription", String.valueOf(prescriptionCount));				
				req.setAttribute("countHash", countHash);
				req.setAttribute("_userId", "lovena0410");
				req.setAttribute("_changeType", "PHARMACIST");
				req.setAttribute("userCountHash", userCountHash);
				return "home/manager/manager.jsp";
			}
			else 
			{
				req.setAttribute("message", "Check ID and Password.");
				return "home/error.jsp";
			}
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", "Login Fail");
			return "home/error.jsp";
		}
	}

}
