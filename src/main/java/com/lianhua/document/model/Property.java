package com.lianhua.document.model;

// Generated 2013-3-27 13:37:50 by Hibernate Tools 3.6.0

/**
 * Property generated by hbm2java
 */
public class Property implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	private Long documentId;
	private Document document;
	private String value;
	private String name;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getDocumentId() {
		return documentId;
	}
	public void setDocumentId(Long documentId) {
		this.documentId = documentId;
	}
	public Document getDocument() {
		return document;
	}
	public void setDocument(Document document) {
		this.document = document;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}