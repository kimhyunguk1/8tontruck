package kr.re.etri.lifeinfomatics.promes.util;

import java.io.*;
import javax.xml.parsers.*;

import kr.re.etri.lifeinfomatics.promes.config.Constants;

import org.apache.commons.lang.SystemUtils;
import org.apache.log4j.*;

/**
 * 
 * <p>
 * Title: R/U-EDT Pro
 * </p>
 * 
 * <p>
 * Description:
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2003 ~ 2008 MetaBiz, All rights reserved
 * </p>
 * 
 * <p>
 * Company: MetaBiz Inc.
 * </p>
 * 
 * @author Context Aware Team (Roh, Si-Deuk)
 * @version 1.0
 */
public class Log {
	public static Logger out = null;
	public static boolean out_debugEnabled = true;
	public static boolean out_infoEnabled = true;

	/**
	 * 로그를 초기화 한다.
	 */
	public static void initialize() {
		try {
			LogManager.shutdown();

			PatternLayout layout = new PatternLayout();
			layout.setConversionPattern("{%d{yyyy-MM-dd HH:mm:ss}}(%C{1}:%L) [%5p] %m%n");
			ConsoleAppender consoleAppender = new ConsoleAppender(layout);

			Log.out = Logger.getRootLogger();
			Log.out.addAppender(consoleAppender);
			
//			File pmDir = new File(SystemUtils.USER_DIR, "/logs");
			File pmDir = new File(Constants.WEB_PATH, "../logs");
			
			if (!pmDir.exists()) {
				pmDir.mkdir();
			}
			File pmLog = new File(pmDir.getPath(), "PROMES.log");

			RollingFileAppender rollingFileAppender = null;
			try {
				rollingFileAppender = new RollingFileAppender(layout, pmLog.getAbsolutePath(), true);
			} catch (IOException ex) {
				ex.printStackTrace();
			}
			rollingFileAppender.setMaxBackupIndex(3);
			rollingFileAppender.setMaxFileSize("3MB");
			Log.out.addAppender(rollingFileAppender);
			Log.out.setLevel(Level.DEBUG);

		} catch (FactoryConfigurationError ex) {
			if (out == null) {
				out = Logger.getRootLogger();
			}
		}
	}

	public static void main(String[] args) {
		Log.initialize();
		Log.out.info("asdfadf");
	}
}
