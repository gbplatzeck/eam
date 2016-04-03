package br.com.eam.model;

import java.io.Serializable;
import java.util.Date;

public class Base implements Serializable{

	private static final long serialVersionUID = -7190114841872701621L;

	private String id;
	private Boolean active;
	private Date creationDate;
	private Date updatedDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
}
