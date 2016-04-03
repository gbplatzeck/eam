package br.com.eam.model.user;

public enum Role {

	ADMIN("ADMIN"), 
	USER("USER"), 
	MANAGER("MANAGER");
	
	Role(final String value){
		this.value = value;
	}
	
	private final String value;
	
	public final String value(){
		return this.value;
	}
	
	
}
