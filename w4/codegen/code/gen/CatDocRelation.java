package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

/**
 * CatDocRelation generated by hbm2java
 */
public class CatDocRelation implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
	private Long categoryCode;
	private Long accountingCode;
	private String descriptorIds;
	private Integer year;

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getCategoryCode() {
		return this.categoryCode;
	}

	public void setCategoryCode(Long categoryCode) {
		this.categoryCode = categoryCode;
	}

	public Long getAccountingCode() {
		return this.accountingCode;
	}

	public void setAccountingCode(Long accountingCode) {
		this.accountingCode = accountingCode;
	}

	public String getDescriptorIds() {
		return this.descriptorIds;
	}

	public void setDescriptorIds(String descriptorIds) {
		this.descriptorIds = descriptorIds;
	}

	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

}