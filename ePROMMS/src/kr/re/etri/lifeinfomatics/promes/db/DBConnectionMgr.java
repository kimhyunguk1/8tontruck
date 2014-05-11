package kr.re.etri.lifeinfomatics.promes.db;

/**
 *
 * <p>Title: 지능형 MMC 시스템</p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2003~2008 MetaBiz, All rights reserved</p>
 *
 * <p>Company: MetaBiz, Inc.</p>
 *
 * @author not attributable
 * @version 1.0
 */
public interface DBConnectionMgr {
    public void initialize(DBConstants dbConstants) throws Exception;

    public ConnectionResource getConnectionResource() throws Exception;

    public ConnectionResource getConnectionResource(boolean autoCommit) throws Exception;

    public void statusDBConnection();

    public void finalize();
}
