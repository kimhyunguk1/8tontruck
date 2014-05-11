package kr.re.etri.lifeinfomatics.promes.db;

import java.sql.*;
import java.util.*;

import kr.re.etri.lifeinfomatics.promes.config.Constants;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class DBManager {

	private DBConnectionMgr _dbConnMgr = null;
	private String _name = "";
	private static DBManager instance = null;

	public static DBManager createDBManager(String name, DBConnectionMgr dbConnMgr) throws Exception {
		DBManager dbMgr = new DBManager(name, dbConnMgr);
		return dbMgr;
	}

	private DBManager(String name, DBConnectionMgr dbConnMgr) {
		_name = name;
		_dbConnMgr = dbConnMgr;
	}

	public static void initialize() {
		DBConstants dbConsPool = DBConstants.makeDBConstants(Constants.DB_DRIVER, Constants.DB_URI, Constants.USER_ID, Constants.USER_PW, "KSC5601", "promes");
		DBConnectionPool dbConn = null;
		try {
			dbConn = new DBConnectionPool(dbConsPool);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		try {
			DBManager dbManager = DBManager.createDBManager("promes", dbConn);
			instance = dbManager;
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

	public void setDBConnectionMgr(DBConnectionMgr dbConnMgr) {
		_dbConnMgr = dbConnMgr;
	}

	public void removeDBConnectionMgr() {
		if (_dbConnMgr != null) {
			_dbConnMgr.finalize();
		}
		_dbConnMgr = null;
	}

	public void printStatus() {
		if (_dbConnMgr != null) {
			_dbConnMgr.statusDBConnection();
		}
	}

	public ConnectionResource getConnection() throws Exception {
		return this.getConnection(true);
	}

	public ConnectionResource getConnection(boolean autoCommit) throws Exception {
		ConnectionResource connResource = _dbConnMgr.getConnectionResource(autoCommit);
		return connResource;
	}

	public ArrayList<ArrayList<Object>> toArrayListSet(ResultSet result) throws Exception {
		ArrayList<ArrayList<Object>> rowData = new ArrayList<ArrayList<Object>>();

		ArrayList<Object> columData = null;
		ResultSetMetaData rsmd = result.getMetaData();
		int cols = rsmd.getColumnCount();
		while (result.next()) {
			columData = new ArrayList<Object>();
			for (int i = 1; i <= cols; i++) {
				Object col = result.getObject(i);
				if (col == null) {
					col = "";
				}

				columData.add(col);

			}
			rowData.add(columData);
		}

		return rowData;
	}

	public ArrayList<ArrayList<Object>> executeQuery(String sql) throws Exception {
		ConnectionResource connResource = _dbConnMgr.getConnectionResource();
		Statement stat = null;
		ResultSet rs = null;
		try {
			stat = connResource.getConnection().createStatement();

			rs = stat.executeQuery(sql);
			ArrayList<ArrayList<Object>> result = toArrayListSet(rs);
			return result;

		} catch (SQLException ex) {
			throw ex;

		} finally {
			rs.close();
			stat.close();
			connResource.release();
			connResource = null;
		}
	}

	public ArrayList<ArrayList<Object>> executeQuery(ConnectionResource connResource, String sql) throws Exception 
	{
		connResource = _dbConnMgr.getConnectionResource();
		Statement stat = null;
		ResultSet rs = null;
		try {
			stat = connResource.getConnection().createStatement();

			rs = stat.executeQuery(sql);
			ArrayList<ArrayList<Object>> result = toArrayListSet(rs);
			return result;

		} catch (SQLException ex) {
			throw ex;
		} finally {
			rs.close();
			stat.close();
			connResource.release();
			connResource = null;
		}
	}

	public boolean updateQuery(String sql) throws Exception {
		ConnectionResource connResource = _dbConnMgr.getConnectionResource();
		Statement state = null;
		try {
			state = connResource.getConnection().createStatement();
			state.execute(sql);

			return true;

		} catch (SQLException ex) {
			throw ex;

		} finally {
			state.close();
			connResource.release();
			connResource = null;
		}
	}

	public boolean updateQuery(String sql, String args[]) throws Exception {
		ConnectionResource connResource = _dbConnMgr.getConnectionResource();

		PreparedStatement pstate = connResource.getConnection().prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			pstate.setString(i + 1, args[i]);
		}

		try {
			pstate.execute();
			return true;

		} catch (SQLException ex) {
			throw ex;

		} finally {
			pstate.close();
			connResource.release();
			connResource = null;
		}
	}

	public boolean updateQuery(ConnectionResource connResource, String sql) throws Exception 
	{
		connResource = _dbConnMgr.getConnectionResource();
		Statement state = null;
		
		try
		{
    		state = connResource.getConnection().createStatement();
    		state.execute(sql);
		}
		catch (Exception e)
		{
			throw e;
		}
		finally 
		{
			state.close();
			connResource.release();
			connResource = null;
		}
		return true;
	}

	public int excuteUpdate(ConnectionResource connResource, String sql) throws Exception {
		connResource = _dbConnMgr.getConnectionResource();
		Statement state = null;
		try
		{
    		state = connResource.getConnection().createStatement();
    		
    		int result = state.executeUpdate(sql);
    		
    		return result;
		}
		catch (Exception e)
		{
			throw e;
		}
		finally 
		{
			state.close();
			connResource.release();
			connResource = null;
		}
	}

	public int excuteUpdate(ConnectionResource connResource, String sql, String args[]) throws Exception {
		connResource = _dbConnMgr.getConnectionResource();
		PreparedStatement pstate = null;
		try
		{
    		pstate = connResource.getConnection().prepareStatement(sql);
    		for (int i = 0; i < args.length; i++) {
    			pstate.setString(i + 1, args[i]);
    		}
    		int result = pstate.executeUpdate();
    
    		return result;
		}
		catch (Exception e)
		{
			throw e;
		}
		finally 
		{
			pstate.close();
			connResource.release();
			connResource = null;
		}
	}

	public static DBManager getInstance() {
		if (instance == null) {
			DBManager.initialize();
		}
		return instance;
	}

	public static void main(String[] args) {
		Log.initialize();
		try {
			Constants.initialize();
		} catch (Exception e) {
			e.printStackTrace();
		}
		DBManager.initialize();
		DBManager dbManager = DBManager.getInstance();

		dbManager.printStatus();
		ArrayList<ArrayList<Object>> list;
		try {
			list = dbManager.executeQuery("select * from pillbox");

			System.out.println("Size : " + list.size());
			for (int i = 0; i < list.size(); i++) {
				ArrayList objList = list.get(i);
				for (int y = 0; y < objList.size(); y++) {
					System.out.println("data[" + i + "][" + y + "] = " + objList.get(y).toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
