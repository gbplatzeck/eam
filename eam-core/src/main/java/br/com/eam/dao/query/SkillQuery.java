package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.knowledge.Skill;

public interface SkillQuery {

	List<Skill> get(String personId);
	List<Skill> list();
}
