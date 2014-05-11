package kr.re.etri.lifeinfomatics.promes.config;

import java.io.*;
import java.net.*;
import java.util.*;

import kr.re.etri.lifeinfomatics.promes.util.Log;

public class Constants {
	public static final String DB_PROP_PATH = "conf/db.properties";
	public static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	public static String DB_URI = "jdbc:oracle:thin:@localhost:1521:PROMES";
	public static String USER_ID = "";
	public static String USER_PW = "";
	public static String WEB_PATH = "";
	
	public static String SMS_ID = "";
	public static String SMS_PW = "";
	public static String SMS_IP = "";
	public static int SMS_PORT = 0;
	
	public static String ADMIN_ID = "";

	public static void initialize() throws Exception {

		File conts = new File(Constants.class.getResource("Constants.class").getPath());

		String contsFullPath = conts.getAbsolutePath();

		File cur = new File(".");
		System.out.println("Current Dir : " + cur.getCanonicalPath());
		
		Constants.WEB_PATH = contsFullPath.substring(0, contsFullPath.indexOf("classes"));
		Constants.WEB_PATH = URLDecoder.decode(WEB_PATH);
//		String classPath = System.Web.HttpUtility.UrlEncode(Constants.class.getResource("Constants.class").getPath(), System.TextEncoding.GetEncoding("euc-kr"));
//		String contsFullPath = System.Web,HttpUtility.UrlDecode.decode(classPath) ;
//
//		Constants.WEB_PATH = contsFullPath.substring(0, contsFullPath.indexOf("classes"));

		
		
		
		System.out.println("==================================================");
		System.out.println("Home : " + Constants.WEB_PATH);
		System.out.println("==================================================");

		// /***********************************************************************************
		// * Data Base
		// ***********************************************************************************/
//		Constants.WEB_PATH = Constants.WEB_PATH.replaceAll("%20", " ");
		File file = new File(Constants.WEB_PATH, "../conf/db.properties");
//		File file = new File("./webapps/PromesService/conf/db.properties");

		Properties props = new Properties();
		props.load(new FileInputStream(file));
		Constants.DB_DRIVER = props.getProperty("driver");
		Constants.DB_URI = props.getProperty("url");
		Constants.USER_ID = props.getProperty("username");
		Constants.USER_PW = props.getProperty("password");

		System.out.println("DB_DRIVER = " + Constants.DB_DRIVER);
		System.out.println("DB_URI = " + Constants.DB_URI);
		System.out.println("USER_ID = " + Constants.USER_ID);
		System.out.println("USER_PW = " + Constants.USER_PW);
		System.out.println("==================================================");
		
		// /***********************************************************************************
		// * Data Base
		// ***********************************************************************************/
		File file2 = new File(Constants.WEB_PATH, "../conf/config.properties");
		Properties props2 = new Properties();
		props2.load(new FileInputStream(file2));
		
		Constants.ADMIN_ID = props2.getProperty("id");
		
		Constants.SMS_ID = props2.getProperty("smsid");
		Constants.SMS_PW = props2.getProperty("smspw");
		Constants.SMS_IP = props2.getProperty("smsip");
		Constants.SMS_PORT = Integer.parseInt(props2.getProperty("smsport"));

		System.out.println("SMS_ID = " + Constants.SMS_ID);
		System.out.println("SMS_PW = " + Constants.SMS_PW);
		System.out.println("SMS_IP = " + Constants.SMS_IP);
		System.out.println("SMS_PORT = " + Constants.SMS_PORT);
		System.out.println("==================================================");
	}
}
