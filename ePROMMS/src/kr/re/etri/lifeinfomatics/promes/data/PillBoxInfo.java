package kr.re.etri.lifeinfomatics.promes.data;

import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.http.HttpSessionBindingEvent;

import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortInterface;

/**
 * 
 * Title: PROMES 2.0 Web
 * 
 * Description: 약상자 정보
 * 
 * Copyright: Copyright (c) 2009
 * 
 * Company: Metabiz
 * 
 * @author Roh is-deuk
 * @version 1.0
 */
public class PillBoxInfo implements SortInterface {

	private String id;
	private String type;
	private int containerNumber;
	private String regDate;

	// Web view
	private String prescriptionId;
	private ArrayList<String> useContainer = new ArrayList<String>();
	private String strtDate;
	private int totalDays = -1;
	private String direction;
	private String takenOrderproperties;
	private String status;

	public PillBoxInfo() {

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getContainerNumber() {
		return containerNumber;
	}

	public void setContainerNumber(int containerNumber) {
		this.containerNumber = containerNumber;
	}

	public String getRegDate() {
		return regDate;
	}

	public String getRegDateKor() {
		return Util.chageDate(regDate);
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getPrescriptionId() {
		return prescriptionId;
	}

	public void setPrescriptionId(String prescriptionId) {
		this.prescriptionId = prescriptionId;
	}

	public String getStrtDate() {
		return strtDate;
	}

	public void setStrtDate(String strtDate) {
		this.strtDate = strtDate;
	}

	public int getTotalDays() {
		return totalDays;
	}

	public void setTotalDays(int totalDays) {
		this.totalDays = totalDays;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public ArrayList<String> getUseContainer() {
		return useContainer;
	}

	public String getTakenOrderproperties() {
		return takenOrderproperties;
	}

	public void setTakenOrderproperties(String takenOrderproperties) {
		this.takenOrderproperties = takenOrderproperties;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUseContainerStr() {
		String useContainerStr = "";
		HashSet<String> keySet = new HashSet<String>();
		for (int i = 0; i < useContainer.size(); i++) {
			String key = useContainer.get(i);
			if (!keySet.contains(key)) {
				keySet.add(key);
				useContainerStr += key;
				useContainerStr += ", ";
			}
		}
	
		return useContainerStr.substring(0, useContainerStr.length() - 2);
		//return "";
	}

	public void setUseContainer(ArrayList<String> useContainer) {
		this.useContainer = useContainer;
	}

	public static PillBoxInfo split(String str) {
		PillBoxInfo pillBoxInfo = new PillBoxInfo();
		String[] strArr = str.split("/");
		pillBoxInfo.setId(strArr[0]);
		pillBoxInfo.setType(strArr[1]);
		pillBoxInfo.setContainerNumber(Define.getPillBoxContainerNum(strArr[1]));
		String date = strArr[2].replaceAll("년 |월 ", "-");
		date = date.replaceAll("일", "");
		pillBoxInfo.setRegDate(date);
		return pillBoxInfo;
	}

	public static ArrayList<PillBoxInfo> split(String[] strArr) {
		ArrayList<PillBoxInfo> pillBoxs = new ArrayList<PillBoxInfo>();
		for (int i = 0; i < strArr.length; i++) {
			PillBoxInfo pillBoxInfo = PillBoxInfo.split(strArr[i]);
			pillBoxs.add(pillBoxInfo);
		}
		return pillBoxs;
	}

	public static ArrayList<PillBoxInfo> split(ArrayList<String> strList) {
		ArrayList<PillBoxInfo> pillBoxs = new ArrayList<PillBoxInfo>();
		for (int i = 0; i < strList.size(); i++) {
			PillBoxInfo pillBoxInfo = PillBoxInfo.split(strList.get(i));
			pillBoxs.add(pillBoxInfo);
		}
		return pillBoxs;
	}

	public String getSortKey(String type) {
		String key = "";
		if (type.equals("PILLBOXID")) {
			key = this.id;
		}
		else if (type.equals("TYPE")) {
			key = this.type;
		}
		else if (type.equals("CONTAINER")) {
			key = this.getUseContainerStr();
		}
		else if (type.equals("PRESCRIPTIONID")) {
			key = this.prescriptionId;
			if(prescriptionId == null){
				key = "";
			}
		}
		else if (type.equals("STRTDATE")) {
			key = this.strtDate;
			if (key == null) {
				key = "";
			}
			key = key.replaceAll("- ", "");
		}
		else if (type.equals("TOTALDAYS")) {
			key = String.valueOf(this.totalDays);
		}
		else if (type.equals("DIRECTION")) {
			key = this.direction;
			if(direction == null){
				key = "";
			}
		}
		return key;
	}
	
	public boolean equals(Object obj) {
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		return obj.equals(this.id);
	}

	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}
	
}
