package kr.re.etri.lifeinfomatics.promes.db;

import java.util.*;


/**
 *
 * <p>Title: 지능형 MMC 시스템</p>
 *
 * <p>Description: DB 관련 상수 클래스</p>
 *
 * <p>Copyright: Copyright (c) 2003~2008 MetaBiz, All rights reserved</p>
 *
 * <p>Company: MetaBiz, Inc.</p>
 *
 * @author not attributable
 * @version 1.0
 */
public class DBConstants {
    /*
     ① driver : 사용할 jdbc driver의 class name
     ② url : jdbc driver의해 연결할 connection에 대한 url
     ③ username : connection을 연결할 사용자 이름
     ④ password : connection을 연결할 사용자 비밀번호
     ⑤ defaultAutoCommit : 풀에의해 생성된 커넥션의 auto-commit 상태
     ⑥ defaultReadOnly : 풀에의해 생성된 커넥션의 read-only 상태, jdbc에 따라 지원하지 않을수도 있다 (예 : informix)
     ⑦ maxActive : 커넥션풀의 Active한 커넥션의 최대 갯수
     ⑧ maxIdle : 커넥션풀의 idle한 커넥션의 최대 갯수
     ⑨ maxWait : 커넥션이 풀에 반납되기까지 기다리는 최대 시간 (millisecond)
     */
    public static final String DBCP_PARAM_driver = "driver";
    public static final String DBCP_PARAM_url = "url";
    public static final String DBCP_PARAM_username = "username";
    public static final String DBCP_PARAM_password = "password";
    public static final String DBCP_PARAM_defaultAutoCommit = "defaultAutoCommit";
    public static final String DBCP_PARAM_defaultReadOnly = "defaultReadOnly";
    public static final String DBCP_PARAM_maxActive = "maxActive";
    public static final String DBCP_PARAM_maxIdle = "maxIdle";
    public static final String DBCP_PARAM_maxWait = "maxWait";

    //- default properties -----------------------------------------------------
    public String driver = null;
    public String url = null;
    public String username = null;
    public String password = null;
    public String encoding = null;

    //- dbcp properties --------------------------------------------------------
    public boolean defaultAutoCommit = true;
    public boolean defaultReadOnly = false;
    public int maxActive = 30;
    public int maxIdle = 30;
    public long maxWait = 10000;

    public String poolName = null;

    private String str = "";

    private DBConstants() {
    }

    protected void setStr(String str) {
        this.str = str;
    }

    public static DBConstants makeDBConstants(Properties props) throws Exception {
        String driver = null;
        String url = null;
        String username = null;
        String password = null;
        String encoding = null;
        String poolName = null;
        int maxActive = 0;
        int maxIdle = 0;
        int maxWait = 0;
        boolean defaultAutoCommit = false;
        boolean defaultReadOnly = false;
        try {
            driver = props.getProperty("driver");
            url = props.getProperty("url");
            username = props.getProperty("username");
            password = props.getProperty("password");
            encoding = props.getProperty("encoding");
            poolName = props.getProperty("poolName");

            maxActive = Integer.parseInt(props.getProperty("maxActive"));
            maxIdle = Integer.parseInt(props.getProperty("maxIdle"));
            maxWait = Integer.parseInt(props.getProperty("maxWait"));
            defaultAutoCommit = Boolean.parseBoolean(props.getProperty("defaultAutoCommit"));
            defaultReadOnly = Boolean.parseBoolean(props.getProperty("defaultReadOnly"));

        } catch(Exception ex) {
            throw new Exception("DB Properties Loading Failure. =>" + ex.toString(), ex);
        }

        DBConstants dbCons = new DBConstants();
        dbCons.driver = driver;
        dbCons.url = url;
        dbCons.username = username;
        dbCons.password = password;
        dbCons.encoding = encoding;
        dbCons.poolName = poolName;
        dbCons.maxActive = maxActive;
        dbCons.maxIdle = maxIdle;
        dbCons.maxWait = maxWait;
        dbCons.defaultAutoCommit = defaultAutoCommit;
        dbCons.defaultReadOnly = defaultReadOnly;

        dbCons.setStr("[driver=" + driver +
            ",url=" + url +
            ",username=" + username +
            ",password=" + password +
            ",encoding=" + encoding +
            ",poolName=" + poolName +
            ",defaultAutoCommit=" + defaultAutoCommit +
            ",defaultReadOnly=" + defaultReadOnly +
            ",maxActive=" + maxActive +
            ",maxIdle=" + maxIdle +
            ",maxWait=" + maxWait + "]");

        return dbCons;

    }

    public static DBConstants makeDBConstants(String driver, String url, String username, String password) {

        DBConstants dbCons = new DBConstants();
        dbCons.driver = driver;
        dbCons.url = url;
        dbCons.username = username;
        dbCons.password = password;
        dbCons.setStr("[driver=" + driver +
            ",url=" + url +
            ",username=" + username +
            ",password=" + password + "]");

        return dbCons;
    }

    public static DBConstants makeDBConstants(String driver, String url, String username, String password, String poolName) {

        DBConstants dbCons = new DBConstants();
        dbCons.driver = driver;
        dbCons.url = url;
        dbCons.username = username;
        dbCons.password = password;
        dbCons.poolName = poolName;
        dbCons.setStr("[driver=" + driver +
            ",url=" + url +
            ",username=" + username +
            ",password=" + password +
            ",poolName=" + poolName + "]");

        return dbCons;
    }

    public static DBConstants makeDBConstants(String driver, String url, String username, String password, String encoding, String poolName) {

        DBConstants dbCons = new DBConstants();
        dbCons.driver = driver;
        dbCons.url = url;
        dbCons.username = username;
        dbCons.password = password;
        dbCons.encoding = encoding;
        dbCons.poolName = poolName;
        dbCons.setStr("[driver=" + driver +
            ",url=" + url +
            ",username=" + username +
            ",password=" + password +
            ",encoding=" + encoding +
            ",poolName=" + poolName + "]");

        return dbCons;
    }

    public static DBConstants makeDBConstants(String driver, String url, String username, String password, String encoding, String poolName,
        boolean defaultAutoCommit, boolean defaultReadOnly,
        int maxActive, int maxIdle, long maxWait) {

        DBConstants dbCons = new DBConstants();
        dbCons.driver = driver;
        dbCons.url = url;
        dbCons.username = username;
        dbCons.password = password;
        dbCons.encoding = encoding;
        dbCons.poolName = poolName;
        dbCons.defaultAutoCommit = defaultAutoCommit;
        dbCons.defaultReadOnly = defaultReadOnly;
        dbCons.maxActive = maxActive;
        dbCons.maxIdle = maxIdle;
        dbCons.maxWait = maxWait;
        dbCons.setStr("[driver=" + driver +
            ",url=" + url +
            ",username=" + username +
            ",password=" + password +
            ",encoding=" + encoding +
            ",poolName=" + poolName +
            ",defaultAutoCommit=" + defaultAutoCommit +
            ",defaultReadOnly=" + defaultReadOnly +
            ",maxActive=" + maxActive +
            ",maxIdle=" + maxIdle +
            ",maxWait=" + maxWait + "]");

        return dbCons;
    }

    public String toString() {
        //객체 생성 시 설정된 정보를 반환한다.
        return str;

    }

}
