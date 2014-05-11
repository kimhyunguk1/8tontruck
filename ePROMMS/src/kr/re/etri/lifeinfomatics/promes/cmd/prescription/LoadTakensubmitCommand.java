package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadTakensubmitCommand implements Command{
	
	private String next = "";
	
	public LoadTakensubmitCommand(String next) {
		// TODO Auto-generated constructor stub
		this.next = next;
	}
	

	public String execute(HttpServletRequest req) throws CommandException{
		try{
			String prescriptionId = req.getParameter("_prescriptionId");
			String userId = req.getParameter("_userId");
			String hospital = req.getParameter("_hospital");
			String confirmday = req.getParameter("_confirmday");			
			String filename = req.getParameter("_filename");
			
			prescriptionId = Util.toString(prescriptionId);
			userId = Util.toString(userId);
			hospital = Util.toString(hospital);
			confirmday = Util.toString(confirmday);
			filename = Util.toString(filename);
			
			filename = filename+".gif";
			
			ArrayList<ScheduleInfo> dayschedule = ScheduleManager.getInstance().getSchedules(userId, prescriptionId, confirmday, confirmday, hospital);
			ScheduleInfo schedule = dayschedule.get(0);
			ScheduleManager.getInstance().updatTakenstatus(userId, schedule.getHospital(), schedule.getId(), schedule.getPrescription_id());
			
			File fi = new File("c:/images/"+filename);

			String path = req.getSession().getServletContext().getRealPath("");
			
			File fo = new File(path + "/images/takenImage/"+filename);
			
			if(fi.isFile())
				fi.delete();
			if(fo.isFile())
				fo.delete();
			
			String ori_path="c:/images/"+filename.substring(0,8)+"/";
			File f = new File(ori_path);
			String[] flist = f.list();
			if(flist == null){
				
			}else{							
    			for(int i=0; i<flist.length; i++){				
    				if(flist[i].startsWith(filename.substring(0, 17))){
    					f = new File(ori_path + flist[i]);	
    					if(f.isFile())
    						f.delete();
    				}
    			}	
			}
			
			req.setAttribute("beforePage", "Takenconfirm");	
			
			
			req.setAttribute("msg", confirmday.substring(0, 4)+"년 "+ confirmday.subSequence(4, 6)+"월 "+confirmday.substring(6, 8)+"일 "+ "복용완료 하였습니다.");	
			
			return "home/common/result.jsp";
		}catch(Exception ex){
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
		
	}

}
