package br.com.eam.model.user.knowledge.spell;

import br.com.eam.model.user.knowledge.Field;
import br.com.eam.model.user.knowledge.Spell;
import br.com.eam.model.user.knowledge.SpellType;

public class WingardiumLeviosa extends Spell {

	private static final long serialVersionUID = 4055783978325083566L;

	@Override
	public SpellType getType() {
		return SpellType.SPELL;
	}

	@Override
	public String getModifier() {
		return Field.FD_CHARMS;
	}

	@Override
	public String getName() {
		return "Wingardium Leviosa";
	}

	@Override
	public String getDescription() {
		// TODO Auto-generated method stub
		return null;
	}

}
