package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.knowledge.Spell;

public interface SpellQuery {

	List<Spell> get(String personId);
	List<Spell> list();
}
