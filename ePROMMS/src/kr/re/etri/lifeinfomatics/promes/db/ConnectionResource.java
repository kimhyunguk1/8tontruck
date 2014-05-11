package kr.re.etri.lifeinfomatics.promes.db;

import java.sql.*;

import org.apache.log4j.*;

public class ConnectionResource 
{
	private Connection connection = null;
	private Logger logger = null;

	public ConnectionResource(Connection connection) throws SQLException {
		this(connection, true);
	}

	public ConnectionResource(Connection connection, boolean autoCommit) throws SQLException {
		this.connection = connection;
		this.connection.setAutoCommit(autoCommit);
	}

	public Savepoint setSavepoint() throws SQLException {
		return this.connection.setSavepoint();
	}
	
	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public Connection getConnection() {
		return connection;
	}

	public boolean rollback() {
		if (connection != null) {
			try {
				connection.rollback();
				return true;

			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return false;
	}

	public boolean rollback(Savepoint point) {
		if (connection != null) {
			try {
				connection.rollback(point);
				return true;

			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return false;
	}

	public boolean commit() {
		if (connection != null) {
			try {
				connection.commit();
				return true;

			} catch (Exception ex) {
				if (logger != null) {
					logger.error("[ConnectionResource] commit failed: " + ex.toString(), ex);
				}
			}
		}
		return false;
	}

	public void release() {
		if (connection != null) {
			try {
				connection.close();
			} catch (Exception ex) {
				if (logger != null) {
					logger.error("[ConnectionResource] release failed 2 : " + ex.toString(), ex);
				}

			}
			connection = null;
		}
	}
}
