package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

/**
 * XproxyIdServer generated by hbm2java
 */
public class XproxyIdServer implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String idxname;
	private Long curid;

	public String getIdxname() {
		return this.idxname;
	}

	public void setIdxname(String idxname) {
		this.idxname = idxname;
	}

	public Long getCurid() {
		return this.curid;
	}

	public void setCurid(Long curid) {
		this.curid = curid;
	}

}
