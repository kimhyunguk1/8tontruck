package kr.re.etri.lifeinfomatics.promes.data;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

import kr.re.etri.lifeinfomatics.promes.util.Log;

/**
 * @author ������
 * �����Ȳ
 */
public class MedicationState {
	private String medicState_no;		// �����Ȳ��ȣ
	private String patient_no;			// ȯ�ڹ�ȣ
	private String management_no;		// ������ȣ
	private String recvpill_no;			// ���������ȣ
	private String alarmstart;			// ���࿹�����۽ð�
	private String alarmend;			// ���࿹������ð�
	private String state;				// ���࿩��
	private Date medicationtime;		// ��������ð�

	public String getMedicState_no() {
		return medicState_no;
	}

	public void setMedicState_no(String medicState_no) {
		this.medicState_no = medicState_no;
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

	public String getRecvpill_no() {
		return recvpill_no;
	}

	public void setRecvpill_no(String recvpill_no) {
		this.recvpill_no = recvpill_no;
	}

	public String getAlarmstart() {
		return alarmstart;
	}

	public void setAlarmstart(String alarmstart) {
		this.alarmstart = alarmstart;
	}

	public String getAlarmend() {
		return alarmend;
	}

	public void setAlarmend(String alarmend) {
		this.alarmend = alarmend;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getMedicationtime() {
		return medicationtime;
	}

	public void setMedicationtime(Date medicationtime) {
		this.medicationtime = medicationtime;
	}
}
