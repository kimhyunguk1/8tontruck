package kr.re.etri.lifeinfomatics.promes.util;

import java.io.*;
import java.net.*;

import kr.re.etri.lifeinfomatics.promes.config.Constants;

public class SMSClient {
	protected Socket socket;
	private int port = 0;

	private String destination = null;
	private DataOutputStream out;
	private DataInputStream in;
	private String ID = null;
	private String PW = null;

	public SMSClient() {
		this.port = Constants.SMS_PORT;
		this.destination = Constants.SMS_IP;
		this.ID = Constants.SMS_ID;
		this.PW = Constants.SMS_PW;
	}

	public void connect() throws Exception {
		socket = new Socket(destination, port);
		socket.setSoTimeout(5000);
		out = new DataOutputStream(socket.getOutputStream());
		in = new DataInputStream(socket.getInputStream());
	}

	public void disconnect() throws Exception {
		in.close();
		out.close();
		socket.close();

	}

	public String sendURL(String callNo, String Url, String msg) throws IOException {
		String result = "", msgid = "";
		int i = 0;
		if (Url.length() > 50)
			return "";
		String dst = callNo.substring(0, 3);
		if (dst.equals("019") || dst.equals("011")) {
			return "";
		}

		out.writeBytes("05");
		out.writeBytes("173 ");
		out.writeBytes(fillSpace(ID, 10));
		out.writeBytes(fillSpace(PW, 10));
		out.writeBytes(fillSpace(callNo, 11));
		out.writeBytes(fillSpace(Url, 50));
		out.writeBytes(fillSpace(" ", 12));
		out.writeBytes(fillSpace(msg, 80));
		out.flush();

		boolean inputExist = true;

		do {
			try {
				byte buffer[] = new byte[2];
				for (i = 0; i < 2; i++)
					buffer[i] = in.readByte();
				String msgType = new String(buffer);
				byte temp[] = new byte[4];
				for (i = 0; i < 4; i++)
					temp[i] = in.readByte();
				String sLen = new String(temp);
				sLen = sLen.trim();

				int nLen = Integer.valueOf(sLen).intValue();
				buffer = new byte[nLen];

				if (msgType.equals("02")) {
					inputExist = false;

					for (i = 0; i < nLen; i++)
						buffer[i] = in.readByte();
					result = new String(buffer);

					// result.substring(0,2) 이 아래와 같이 00 이면 성공
					// 02 이면 인증실패
					// 98 이면 아이하트 서버 내부 오류
					// 99 이면 보낸신 메시지 포멧에러
					if (result.substring(0, 2).equals("00"))
						msgid = result.substring(13);
					else
						msgid = "";
				}
				else if (msgType.equals("03")) {

					for (i = 0; i < nLen; i++)
						buffer[i] = in.readByte();
					result = new String(buffer);
					out.writeBytes("04");
					out.writeBytes("12  ");
					out.writeBytes("00");
					out.writeBytes(result.substring(2));
					out.flush();

				}

			} catch (EOFException e) {
				inputExist = false;

			} catch (InterruptedIOException e) {

			}
		} while (inputExist);
		return msgid.trim();
	}

	public String sendMsg(String callNo, String callBack, String caller, String msg) throws IOException {

		String result = "";
		String msgid = "";
		int i = 0;
		out.writeBytes("01");
		out.writeBytes("144 ");
		out.writeBytes(fillSpace(ID, 10));
		out.writeBytes(fillSpace(PW, 10));
		out.writeBytes(fillSpace(callNo, 11));
		out.writeBytes(fillSpace(callBack, 11));
		out.writeBytes(fillSpace(caller, 10));
		out.writeBytes(fillSpace(" ", 12));
		out.writeBytes(fillSpace(msg, 80));
		out.flush();

		boolean inputExist = true;

		do {
			try {
				byte buffer[] = new byte[2];
				for (i = 0; i < 2; i++)
					buffer[i] = in.readByte();
				String msgType = new String(buffer);
				byte temp[] = new byte[4];
				for (i = 0; i < 4; i++)
					temp[i] = in.readByte();
				String sLen = new String(temp);
				sLen = sLen.trim();

				int nLen = Integer.valueOf(sLen).intValue();
				buffer = new byte[nLen];

				if (msgType.equals("02")) {
					inputExist = false;

					for (i = 0; i < nLen; i++)
						buffer[i] = in.readByte();
					result = new String(buffer);
					msgid = result;
				}
				else if (msgType.equals("03")) {

					for (i = 0; i < nLen; i++)
						buffer[i] = in.readByte();
					result = new String(buffer);
					out.writeBytes("04");
					out.writeBytes("12  ");
					out.writeBytes("00");
					out.writeBytes(result.substring(2));
					out.flush();
				}

			} catch (EOFException e) {
				inputExist = false;

			} catch (InterruptedIOException e) {

			}
		} while (inputExist);
		return msgid.trim();
	}

	public String fillSpace(String text, int size) {
		int diff = size - text.length();
		if (diff > 0) {
			for (int i = 0; i < diff; i++)
				text += " ";
		}
		else {
			StringBuffer sb = new StringBuffer(text);
			sb.setLength(size);
			text = sb.toString();
		}

		return text;
	}

}
