package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadTakenImageSrcCommand implements Command{

	public LoadTakenImageSrcCommand(String string) {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String execute(HttpServletRequest req) throws CommandException {
		// TODO Auto-generated method stub
		
		String filename = req.getParameter("_filename");
		filename = Util.toString(filename);		
		
		
		File fi = new File("c:/images/"+filename);
		String path = req.getSession().getServletContext().getRealPath("");		
		File fo = new File(path + "/images/takenImage/"+filename);
		
		
		if(fi.isFile()){
			if(fo.isFile()){
				//req.setAttribute("ImgSrc", "/PromesService/images/takenImage/"+filename);
				req.setAttribute("beforePage", "imgsrc");					
				req.setAttribute("msg", path + "/images/takenImage/"+filename);	
				return "home/common/result.jsp";
			}else{
    			try {
    				FileInputStream fis = new FileInputStream(fi);
    				FileOutputStream fos = new FileOutputStream(fo);
    				
    				FileChannel fcin = fis.getChannel();
    				FileChannel fcout = fos.getChannel();
    				long size=0;
    				size=fcin.size();
    				fcin.transferTo(0, size, fcout);
    				
    				fcout.close();
    				fcin.close();
    				fis.close();
    				fos.close();
    				
    				req.setAttribute("beforePage", "imgsrc");					
    				req.setAttribute("msg", path + "/images/takenImage/"+filename);	
    				return "home/common/result.jsp";
    			
    			} catch(Exception e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    				return "home/error.jsp";
    			}
			}
		}else{
			req.setAttribute("beforePage", "imgsrc");					
			req.setAttribute("msg", path + "/images/takenImage/"+filename);	
			return "home/common/result.jsp";
			
		}
		
	}
	

}
