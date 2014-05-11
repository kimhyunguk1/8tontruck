package kr.re.etri.lifeinfomatics.promes.data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortInterface;


/**
 * @author ������
 * �������
 */
public class RecvPill {

	private String recvPill_no;			// ������� ��ȣ
	private String patient_no;			// ȯ�� ��ȣ
	private String management_no;		// ������ ��ȣ				
	private String recvDueDate;			// ���࿹����
	private String recvDate;			// ������
	private String medicperiod;			// ���࿹���Ⱓ
	
	public String getRecvPill_no() {
		return recvPill_no;
	}

	public void setRecvPill_no(String recvPill_no) {
		this.recvPill_no = recvPill_no;
	}

	public String getPatient_no() {
		return patient_no;
	}

	public void setPatient_no(String patient_no) {
		this.patient_no = patient_no;
	}

	public String getManagement_no() {
		return management_no;
	}

	public void setManagement_no(String management_no) {
		this.management_no = management_no;
	}

	public String getRecvDueDate() {
		return recvDueDate;
	}

	public void setRecvDueDate(String recvDueDate) {
		this.recvDueDate = recvDueDate;
	}

	public String getRecvDate() {
		return recvDate;
	}

	public void setRecvDate(String recvDate) {
		this.recvDate = recvDate;
	}

	public String getMedicperiod() {
		return medicperiod;
	}

	public void setMedicperiod(String medicperiod) {
		this.medicperiod = medicperiod;
	}
	public String toString() {
		String str = "";
		str += "===================== RecvPill Info ==================";
		str += "recvPill_no : " + recvPill_no + "\n";
		str += "patient_no : " + patient_no + "\n";
		str += "management_no : " + management_no + "\n";
		str += "recvDueDate : " + recvDueDate + "\n";
		str += "recvDate : " + recvDate + "\n";
		str += "medicperiod : " + medicperiod + "\n";
		str += "================================================================";
		return str;
	}
	
}
