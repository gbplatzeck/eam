package br.com.eam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.eam.dao.command.PersonCommand;
import br.com.eam.dao.command.UserCommand;
import br.com.eam.dao.query.PersonQuery;
import br.com.eam.dao.query.UserQuery;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.User;

@Service
public class CharacterService {

	@Autowired
	UserCommand userCommand;
	
	@Autowired
	PersonCommand personCommand;
	
	@Autowired
	PersonQuery personQuery;
	
	@Autowired
	UserQuery userQuery;
	
	@Transactional
	public Person create(Person person, String userId){
		create(person);
		User user = userQuery.get(userId);
		user.setPerson(person);
		userCommand.update(user);
		return person;
	}
	
	public Person create(Person person){
		String id = personQuery.generateId();
		person.setId(id);
		personCommand.insert(person);
		return person;
	}
	
	public Person getByUsername(String username){
		return personQuery.getByUsername(username);
	}
	
	public Person get(String personId){
		return personQuery.get(personId);
	}
	
}
