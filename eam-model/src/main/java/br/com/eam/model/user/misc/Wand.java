package br.com.eam.model.user.misc;

import br.com.eam.model.Base;

public class Wand extends Base {

	private static final long serialVersionUID = -3055018881446263855L;

	private String kernel;
	private String wood;
	private Double size;
	
	public String getKernel() {
		return kernel;
	}
	public void setKernel(String kernel) {
		this.kernel = kernel;
	}
	public String getWood() {
		return wood;
	}
	public void setWood(String wood) {
		this.wood = wood;
	}
	public Double getSize() {
		return size;
	}
	public void setSize(Double size) {
		this.size = size;
	}
}
