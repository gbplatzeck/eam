package br.com.eam.model.user.knowledge;

public abstract class Spell extends Knowledge{

	private static final long serialVersionUID = -7758916912148554178L;
	
	public static final String SP_WINGARDIUM_LEVIOSA = "Wingardium Leviosa";
	
	private SpellType type;
	
	public abstract String getModifier();

	@Override
	public Integer getMaximumPoints() {
		return 10;
	}

	public SpellType getType(){
		return type;
	}
	
	public void setType(SpellType type){
		this.type = type;
	}
}
