package br.com.eam.model.user.misc;

import br.com.eam.model.Base;

public class Patrounous extends Base{

	private static final long serialVersionUID = -3264719171439786007L;

	private String name;
	private String description;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
