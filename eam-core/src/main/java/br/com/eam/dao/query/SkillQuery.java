package br.com.eam.dao.query;

import br.com.eam.model.user.knowledge.SkillSet;

public interface SkillQuery {

	SkillSet get(String personId);
	SkillSet list();
}
