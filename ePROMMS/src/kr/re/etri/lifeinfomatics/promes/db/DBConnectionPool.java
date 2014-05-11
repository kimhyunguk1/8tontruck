package kr.re.etri.lifeinfomatics.promes.db;

import java.sql.*;
import java.util.*;

import org.apache.commons.dbcp.*;
import org.apache.commons.pool.*;
import org.apache.commons.pool.impl.*;

/**
 * 
 * <p>
 * Title: 지능형 MMC 시스템
 * </p>
 * 
 * <p>
 * Description: DB Connection 처리 클래스,DBCP를 이용하여 DB Connection을 생성한다.
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2003~2008 MetaBiz, All rights reserved
 * </p>
 * 
 * <p>
 * Company: MetaBiz, Inc.
 * </p>
 * 
 * @author not attributable
 * @version 1.0
 */
public class DBConnectionPool implements DBConnectionMgr {
	private DBConstants _dbConstants = null;

	public DBConnectionPool() {
	}

	public DBConnectionPool(DBConstants dbConstants) throws Exception {
		initialize(dbConstants);
	}

	public void initialize(DBConstants dbConstants) throws Exception {
		_dbConstants = dbConstants;

		try {
			Class.forName(_dbConstants.driver);
		} catch (ClassNotFoundException ex) {
			throw ex;
		}

		// 커넥션 풀로 사용할 commons-collections의 genericOjbectPool을 생성합니다.
		GenericObjectPool connPool = new GenericObjectPool(null);
		connPool.setMaxActive(_dbConstants.maxActive);
		connPool.setMaxIdle(_dbConstants.maxIdle);
		connPool.setMaxWait(_dbConstants.maxWait);

		// 풀이 커넥션을 생성하는데 사용하는 DriverManagerConnectionFactory를 생성합니다.
		Properties dbProps = new Properties();
		dbProps.put("user", _dbConstants.username);
		dbProps.put("password", _dbConstants.password);
		dbProps.put("encoding", _dbConstants.encoding);
		ConnectionFactory connFactory = new DriverManagerConnectionFactory(_dbConstants.url, dbProps);

		// ConnectionFactory의 래퍼 클래스인 PoolableConnectionFactory를 생성한다
		PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connFactory, connPool, null, null, _dbConstants.defaultReadOnly, _dbConstants.defaultAutoCommit);

		DriverManager.registerDriver(new org.apache.commons.dbcp.PoolingDriver());

		PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
		// 풀 이름을 지정하고 풀에 등록한다.
		driver.registerPool(_dbConstants.poolName, connPool);

	}

	/**
	 * AutoCommit이 true인 ConnectionResource를 반환한다.
	 * 
	 * @return ConnectionResource
	 * @throws Exception
	 */
	public ConnectionResource getConnectionResource() throws Exception {
		return this.getConnectionResource(true);
	}

	/**
	 * AutoCommit이 false인 ConnectionResource를 반환한다. - commit 실행에 주의해야 함.
	 * 
	 * @param autoCommit
	 *            boolean
	 * @return ConnectionResource
	 * @throws Exception
	 */
	public ConnectionResource getConnectionResource(boolean autoCommit) throws Exception {
		if (_dbConstants == null) {
			throw new Exception("First, initialize driver!");
		}

		Connection conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:" + _dbConstants.poolName);
		return new ConnectionResource(conn, autoCommit);
	}

	public void statusDBConnection() {
		try {
			PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
			ObjectPool connectionPool = driver.getConnectionPool(_dbConstants.poolName);
			System.out.println("numActive:" + connectionPool.getNumActive() + ", numIdle:" + connectionPool.getNumIdle());
		} catch (UnsupportedOperationException ex) {
			ex.printStackTrace();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}

	}

	public void finalize() {
		try {
			PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
			driver.closePool(_dbConstants.poolName);
			DriverManager.deregisterDriver(driver);
			driver = null;

			_dbConstants = null;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

}
