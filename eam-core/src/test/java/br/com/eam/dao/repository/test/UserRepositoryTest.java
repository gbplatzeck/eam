package br.com.eam.dao.repository.test;

import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import br.com.eam.dao.command.PersonCommand;
import br.com.eam.dao.command.UserCommand;
import br.com.eam.dao.query.UserQuery;
import br.com.eam.main.EAMApplication;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.Role;
import br.com.eam.model.user.User;
import br.com.eam.service.CharacterProfileService;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = EAMApplication.class)
@WebAppConfiguration
@Transactional
public class UserRepositoryTest {

	@Autowired
	UserQuery userQuery;

	@Autowired
	UserCommand userCommand;

	@Autowired
	CharacterProfileService characterProfileService;

	@Autowired
	PersonCommand personCommand;

	private String login;
	private String password;
	private String id;
	private User user;
	private User touch;
	private User update;

	@Before
	public void setUp() {
		login = "test" + new Date();
		password = "password" + new Date();
		id = userQuery.generateId();

		List<String> bloodStatuses = characterProfileService.getBloodStatuses();
		List<String> maritalStatuses = characterProfileService
				.getMaritalStatuses();
		List<String> species = characterProfileService.getSpecies();
		List<String> genders = characterProfileService.getGenders();

		Person person = new Person();

		person.setId("cc8a32ea-f8e7-11e5-9adc-5ce0c56ce5ee");
		person.setBirthday(new Date());
		person.setBloodStatus(bloodStatuses.get(0));
		person.setForename("Test");
		person.setGender(genders.get(0));
		person.setMaritalStatus(maritalStatuses.get(0));
		person.setMiddleNames("Te St Tes");
		person.setSpecies(species.get(0));
		person.setStory("Story test");
		person.setSurname("Test");
		person.setUsername("Test" + new Date());
		person.setDeathDate(new Date());

		personCommand.insert(person);

		user = new User();
		user.setEmail("foo@bla.dum.my");
		user.setId(id);
		user.setLogin(login);
		user.setPassword(password);
		user.setUserBirthday(new Date());
		user.setPerson(person);

		touch = new User();
		touch.setId(id);

		update = new User();
		update.setId(id);
		update.setActive(false);
		update.setEmail("email@update.co");
		update.setLogin("update_login");
		update.setPassword("passwd" + new Date());
		update.setPerson(person);
		update.setUserBirthday(new Date());
	}

	@Test
	public void testUser() {
		userCommand.insert(user);
		User result = userQuery.get(id);
		Assert.assertEquals(result.getLogin(), user.getLogin());
		Assert.assertEquals(result.getEmail(), user.getEmail());
		Assert.assertEquals(result.getUserBirthday().getTime(), user
				.getUserBirthday().getTime());
		Assert.assertEquals(result.getRole(), Role.USER);
		Assert.assertNull(result.getPerson().getId());
		Boolean deleted = userCommand.delete(id);
		Assert.assertTrue(deleted);
		deleted = userCommand.delete(id);
		Assert.assertFalse(deleted);
	}

	@Test
	public void testUserWithPerson() {
		userCommand.insert(user);
		userCommand.update(user);
		User result = userQuery.get(id);
		Assert.assertNotNull(result.getPerson().getId());
		Assert.assertEquals(result.getPerson().getId(), user.getPerson()
				.getId());

		Assert.assertEquals(result.getPerson().getBloodStatus(), user
				.getPerson().getBloodStatus());
		Assert.assertEquals(result.getPerson().getForename(), user.getPerson()
				.getForename());
		Assert.assertEquals(result.getPerson().getGender(), user.getPerson()
				.getGender());
		Assert.assertEquals(result.getPerson().getMaritalStatus(), user
				.getPerson().getMaritalStatus());
		Assert.assertEquals(result.getPerson().getMiddleNames(), user
				.getPerson().getMiddleNames());
		Assert.assertEquals(result.getPerson().getSpecies(), user.getPerson()
				.getSpecies());
		Assert.assertEquals(result.getPerson().getStory(), user.getPerson()
				.getStory());
		Assert.assertEquals(result.getPerson().getSurname(), user.getPerson()
				.getSurname());
		Assert.assertEquals(result.getPerson().getUsername(), user.getPerson()
				.getUsername());
		Assert.assertEquals(result.getPerson().getDeathDate().getTime(), user
				.getPerson().getDeathDate().getTime());
		Assert.assertEquals(result.getPerson().getBirthday().getTime(), user
				.getPerson().getBirthday().getTime());
	}

	@Test
	public void testUpdateWithChanges() {
		userCommand.insert(user);
		Person person = new Person();
		update.setPerson(person);
		Boolean updated = userCommand.update(update);
		Assert.assertTrue(updated);
		User result = userQuery.get(update.getId());

		Assert.assertEquals(result.getEmail(), update.getEmail());
		Assert.assertEquals(result.getLogin(), update.getLogin());
		Assert.assertEquals(result.getActive(), update.getActive());
		Assert.assertEquals(result.getPassword(), update.getPassword());
		Assert.assertEquals(result.getUserBirthday().getTime(), update
				.getUserBirthday().getTime());
	}

	@Test
	public void testUpdateWithoutChanges() {
		userCommand.insert(user);
		Boolean updated = userCommand.update(touch);
		Assert.assertTrue(updated);
		User result = userQuery.get(user.getId());
		Assert.assertEquals(result.getLogin(), user.getLogin());
		Assert.assertEquals(result.getPassword(), user.getPassword());
		Assert.assertEquals(result.getEmail(), user.getEmail());
		Assert.assertEquals(result.getUserBirthday().getTime(), user
				.getUserBirthday().getTime());
		Assert.assertEquals(result.getRole(), Role.USER);
		Assert.assertNull(result.getPerson().getId());
	}

	@Test
	public void testUpdateNonExistingUser() {
		String nonUserId = userQuery.generateId();
		user.setId(nonUserId);
		Boolean updated = userCommand.update(user);
		Assert.assertFalse(updated);
	}

	@Test
	public void testAuthentication() {
		userCommand.insert(user);
		User result = userQuery.get(login, password);
		Assert.assertEquals(result.getLogin(), user.getLogin());
		Assert.assertEquals(result.getEmail(), user.getEmail());
		Assert.assertEquals(result.getUserBirthday().getTime(), user
				.getUserBirthday().getTime());
		Assert.assertEquals(result.getRole(), Role.USER);
		Assert.assertNull(result.getPerson().getId());
	}

	@Test
	public void testAuthenticationFailed() {
		String nonLogin = "non" + new Date().getTime();
		String nonPassword = "non_" + new Date().getTime();
		User user = userQuery.get(nonLogin, nonPassword);
		Assert.assertNull(user);
	}

	@Test
	public void testCheckLogin() {
		String login = user.getLogin();
		userCommand.insert(user);
		Boolean exists = userQuery.loginAlreadyExists(login);
		Assert.assertTrue(exists);
		exists = userQuery.loginAlreadyExists(login + new Date().getTime());
		Assert.assertFalse(exists);
	}
	
	@Test
	public void testGetByLogin() {
		User currentUser = userQuery.getByLogin(user.getLogin());
		Assert.assertNull(currentUser);
		userCommand.insert(user);
		currentUser = userQuery.getByLogin(user.getLogin());
		Assert.assertEquals(currentUser.getId(), user.getId());
	}

}
