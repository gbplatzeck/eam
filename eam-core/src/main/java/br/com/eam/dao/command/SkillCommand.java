package br.com.eam.dao.command;

import br.com.eam.model.user.knowledge.Skill;

public interface SkillCommand {

	void insert(String personId, Skill skill);
	Boolean update(String personId, Skill skill);
}
