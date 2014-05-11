package kr.re.etri.lifeinfomatics.promes.cmd.user;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.DoctorList;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class AddUserPharmacistCommand implements Command {

	private String next = "";

	public AddUserPharmacistCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {

			ArrayList<DoctorList> doctorList = UserManager.getInstance().getDoctorInfoList();

			req.setAttribute("doctorList", doctorList);
			return next;
			
		} catch (Exception ex) {
			Log.out.error(ex.getMessage());
			req.setAttribute("result", String.valueOf(false));
			req.setAttribute("beforePage", "AddUserPharmacist");
			req.setAttribute("msg", ex.getMessage());
			return next;
		}
	}
}
