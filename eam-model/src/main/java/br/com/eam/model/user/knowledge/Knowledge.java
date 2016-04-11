package br.com.eam.model.user.knowledge;

import br.com.eam.model.Base;

public abstract class Knowledge extends Base{

	private static final long serialVersionUID = -6080304916473745219L;
	
	private Integer points = 0;
	private Integer usage = 0;
	private String description;
	
	public abstract String getName();
	public abstract Integer getMaximumPoints();
	
	public Integer getPoints() {
		return points;
	}
	public void setPoints(Integer points) {
		this.points = points;
	}
	public Integer getUsage() {
		return usage;
	}
	public void setUsage(Integer usage) {
		this.usage = usage;
	}
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
	}

}
