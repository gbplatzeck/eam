package br.com.eam.model.user.knowledge;

import java.io.Serializable;

import br.com.eam.model.user.knowledge.field.Divination;
import br.com.eam.model.user.knowledge.field.Potions;
import br.com.eam.model.user.knowledge.field.Charms;
import br.com.eam.model.user.knowledge.field.Transfiguration;

public class FieldSet implements Serializable {

	private static final long serialVersionUID = -1358059018520219029L;
	
	private Divination divination;
	private Potions potion;
	private Charms charms;
	private Transfiguration transfiguration;

	public Divination getDivination() {
		return divination;
	}
	public void setDivination(Divination divination) {
		this.divination = divination;
	}
	public Potions getPotion() {
		return potion;
	}
	public void setPotion(Potions potion) {
		this.potion = potion;
	}
	public Transfiguration getTransfiguration() {
		return transfiguration;
	}
	public void setTransfiguration(Transfiguration transfiguration) {
		this.transfiguration = transfiguration;
	}
	public Charms getCharms() {
		return charms;
	}
	public void setCharms(Charms charms) {
		this.charms = charms;
	}
}
