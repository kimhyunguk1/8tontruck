package kr.re.etri.lifeinfomatics.promes.mgr;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class ImageSrcManager {
	private static ImageSrcManager instance =null;
	
	
	public String ReturnImgsrc(String pillboxId, String Day){
		
		
		String filename = pillboxId +"_" + Day + ".gif";
		filename = Util.toString(filename);		
		
		String realPath = Define.REAL_PATH;
		File fi = new File("c:/images/"+filename);
		
		File dir = new File(realPath + "/images/takenImage/");
		if(!dir.isDirectory())
			dir.mkdir();
		File fo1 = new File(dir.getPath()+"/"+filename);
		File fo = new File(realPath + "/images/takenImage/"+filename);
		
		
		if(fi.isFile()){
			if(fo.isFile()){
				return "/PromesService/images/takenImage/"+filename;
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
    				
    				return "/PromesService/images/takenImage/"+filename;
    			
    			} catch(Exception e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    				return null;
    			}
			}
		}else{
			return "";
		}		
	}
	
	public static ImageSrcManager getInstance(){
		if(instance == null){
			instance = new ImageSrcManager();			
		}
		return instance;
	}

}
