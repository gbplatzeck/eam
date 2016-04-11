package br.com.eam.dao.command;

import br.com.eam.model.user.knowledge.Spell;

public interface SpellCommand {

	void insert(String personId, Spell spell);
	Boolean update(String personId, Spell spell);
}
