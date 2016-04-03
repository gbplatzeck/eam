package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.Person;

public interface PersonQuery {

	Person get(String personId);
	List<Person> getParents(String personId);
	List<Person> getChildren(String personId);
	List<Person> getPartners(String personId);
	List<Person> getFormerPartners(String personId);
	Boolean checkPartnership(String personId, String partnerId);
	String generateId();
	
}
