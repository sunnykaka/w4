package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

/**
 * Property generated by hbm2java
 */
public class Property implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
	private Document document;
	private String value;
	private String name;

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Document getDocument() {
		return this.document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}

	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}