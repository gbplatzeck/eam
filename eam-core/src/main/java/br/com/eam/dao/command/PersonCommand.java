package br.com.eam.dao.command;

import br.com.eam.model.user.Person;

public interface PersonCommand {

	void insert(Person person);
	Boolean update(Person person);
	void insertParent(String personId, String parentId);
	void insertPartnership(String personId, String partnerId);
	Boolean cancelPartnership(String personId, String partnerId);
}
