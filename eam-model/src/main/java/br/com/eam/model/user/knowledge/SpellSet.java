package br.com.eam.model.user.knowledge;

import java.io.Serializable;

import br.com.eam.model.user.knowledge.spell.WingardiumLeviosa;

public class SpellSet implements Serializable {

	private static final long serialVersionUID = -5768689083135137982L;
	
	private WingardiumLeviosa wingardiumLeviosa;

	public WingardiumLeviosa getWingardiumLeviosa() {
		return wingardiumLeviosa;
	}

	public void setWingardiumLeviosa(WingardiumLeviosa wingardiumLeviosa) {
		this.wingardiumLeviosa = wingardiumLeviosa;
	}

}
