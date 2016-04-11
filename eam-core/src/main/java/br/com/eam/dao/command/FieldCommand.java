package br.com.eam.dao.command;

import br.com.eam.model.user.knowledge.Field;

public interface FieldCommand {

	void insert(String personId, Field field);
	Boolean update(String personId, Field field);
}
