package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadSearchPrescriptionCommand implements Command{

	private String next = "";
	
	public LoadSearchPrescriptionCommand(String next){
		this.next = next;
	}
	
	public String execute(HttpServletRequest req) throws CommandException 
	{
		Calendar calendar = Calendar.getInstance();
		String userId = req.getParameter("_userId");
		userId = Util.toString(userId);
		String type = req.getParameter("_type");
		String userName= req.getParameter("_userName");
		userName = Util.toString(userName);
		String searchDate= req.getParameter("_searchDate");
		searchDate = Util.toString(searchDate);
		
		if (searchDate == null || searchDate.equals("")) {
			searchDate = Integer.toString(calendar.get(Calendar.YEAR)) + "�� ";
			if(Integer.toString(calendar.get(Calendar.MONTH)+1).length()<2){
				searchDate += "0"+Integer.toString(calendar.get(Calendar.MONTH)+1) + "�� ";
			}else{
				searchDate += Integer.toString(calendar.get(Calendar.MONTH)+1)+ "�� ";
			}
			if(Integer.toString(calendar.get(Calendar.DAY_OF_MONTH)).length() <2){
				searchDate += "0"+Integer.toString(calendar.get(Calendar.DAY_OF_MONTH))+ "�� ";
			}else{
				searchDate += Integer.toString(calendar.get(Calendar.DAY_OF_MONTH))+ "�� ";
			}
			
		}else{
			
			searchDate = searchDate.replace("��", "");
			searchDate = searchDate.replace("��", "");
			searchDate = searchDate.replace("��", "");
			searchDate = searchDate.trim();
		}
		req.setAttribute("userId", userId);
		req.setAttribute("userName", userName);
		req.setAttribute("searchDate", searchDate);
		if(type.equals(Define.USER_PHARMACIST) || type.equals(Define.USER_DOCTOR)|| type.equals(Define.USER_INCHARGE)|| type.equals(Define.USER_ADMIN))
		{
			return "home/prescription/searchPrescription.jsp";
		}
		else if (type.equals(Define.USER_MANAGER))
		{
			return "home/prescription/searchPrescription.jsp";
		}
		else
		{
			return "home/patient/searchPrescription.jsp";			
		}
	}
}