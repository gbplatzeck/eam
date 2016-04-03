package br.com.eam.model.user.knowledge;

public abstract class Spell extends Knowledge{

	private static final long serialVersionUID = -7758916912148554178L;
	
	public abstract SpellType getType();
	public abstract String getModifier();

	@Override
	public Integer getMaximumPoints() {
		return 10;
	}

}
