package br.com.eam.dao.repository.jdbc.test;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.After;
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
import br.com.eam.dao.query.PersonQuery;
import br.com.eam.main.EAMApplication;
import br.com.eam.model.user.Person;
import br.com.eam.service.PersonProfileService;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes=EAMApplication.class)
@WebAppConfiguration
@Transactional
public class PersonRepositoryTest {
	
	@Autowired
	PersonCommand personCommand;
	
	@Autowired
	PersonQuery personQuery;
	
	@Autowired
	PersonProfileService personProfileService;
	
	Person person;
	Person update;
	Person touch;

	@Before
	public void setUp() throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.YEAR, -21);
		
		List<String> bloodStatuses = personProfileService.getBloodStatuses();
		List<String> maritalStatuses = personProfileService.getMaritalStatuses();
		List<String> species = personProfileService.getSpecies();
		List<String> genders = personProfileService.getGenders();
		
		person = new Person();
		
		person.setId(personQuery.generateId());
		person.setBirthday(calendar.getTime());
		person.setBloodStatus(bloodStatuses.get(0));
		person.setForename("Test");
		person.setGender(genders.get(0));
		person.setMaritalStatus(maritalStatuses.get(0));
		person.setMiddleNames("Te St Tes");
		person.setSpecies(species.get(0));
		person.setStory("Story test");
		person.setSurname("Test");
		person.setUsername("Test"+calendar.getTimeInMillis());
		person.setDeathDate(new Date());
		
		update = new Person();
		update.setId(person.getId());
		update.setBloodStatus(bloodStatuses.get(1));
		update.setDeathDate(new Date());
		update.setForename("Tess");
		update.setGender(genders.get(1));
		update.setMaritalStatus(maritalStatuses.get(1));
		update.setMiddleNames("123 Bas");
		update.setSpecies(species.get(1));
		update.setStory("Story 2");
		update.setSurname("Surname 2");
		update.setUsername("Update"+calendar.getTimeInMillis());
		update.setBirthday(new Date());
		
		touch = new Person();
		touch.setId(person.getId());
		
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testInsert() {
		personCommand.insert(person);
		Person insertedPerson = personQuery.get(person.getId());
		Assert.assertTrue(insertedPerson.getActive());
		Assert.assertTrue(insertedPerson.getCreationDate().before(new Date()));
		Assert.assertTrue(insertedPerson.getUpdatedDate().equals(insertedPerson.getCreationDate()));
	}

	@Test
	public void testUpdateWithChanges() {
		personCommand.insert(person);
		Boolean updated = personCommand.update(update);
		Assert.assertTrue(updated);
		Person result = personQuery.get(person.getId());
		Assert.assertTrue(result.getActive());

		Assert.assertEquals(result.getBloodStatus(), update.getBloodStatus());
		Assert.assertEquals(result.getForename(), update.getForename());
		Assert.assertEquals(result.getGender(), update.getGender());
		Assert.assertEquals(result.getMaritalStatus(), update.getMaritalStatus());
		Assert.assertEquals(result.getMiddleNames(), update.getMiddleNames());
		Assert.assertEquals(result.getSpecies(), update.getSpecies());
		Assert.assertEquals(result.getStory(), update.getStory());
		Assert.assertEquals(result.getSurname(), update.getSurname());
		Assert.assertEquals(result.getUsername(), update.getUsername());
		Assert.assertEquals(result.getDeathDate().getTime(), update.getDeathDate().getTime());
		
		Assert.assertNotEquals(result.getBirthday().getTime(), update.getBirthday().getTime());
		Assert.assertEquals(result.getBirthday().getTime(), person.getBirthday().getTime());
	}
	
	@Test
	public void testUpdateWithoutChanges(){
		personCommand.insert(person);
		Boolean updated = personCommand.update(touch);
		Assert.assertTrue(updated);
		Person result = personQuery.get(touch.getId());
		Assert.assertTrue(result.getActive());
		
		Assert.assertEquals(result.getBloodStatus(), person.getBloodStatus());
		Assert.assertEquals(result.getForename(), person.getForename());
		Assert.assertEquals(result.getGender(), person.getGender());
		Assert.assertEquals(result.getMaritalStatus(), person.getMaritalStatus());
		Assert.assertEquals(result.getMiddleNames(), person.getMiddleNames());
		Assert.assertEquals(result.getSpecies(), person.getSpecies());
		Assert.assertEquals(result.getStory(), person.getStory());
		Assert.assertEquals(result.getSurname(), person.getSurname());
		Assert.assertEquals(result.getUsername(), person.getUsername());
		Assert.assertEquals(result.getDeathDate().getTime(), person.getDeathDate().getTime());
		Assert.assertEquals(result.getBirthday().getTime(), person.getBirthday().getTime());
	}
	
	@Test
	public void testUpdateNonExistingPerson(){
		String nonExistingId = personQuery.generateId();
		update.setId(nonExistingId);
		Boolean updated = personCommand.update(update);
		Assert.assertFalse(updated);
	}
	
	@Test
	public void testPartnership(){
		String personId = person.getId();
		personCommand.insert(person);
		String partnerId = personQuery.generateId();
		person.setId(partnerId);
		person.setUsername("partner"+new Date());
		personCommand.insert(person);
		Boolean check = personQuery.checkPartnership(personId, partnerId);
		Assert.assertFalse(check);
		personCommand.insertPartnership(personId, partnerId);
		check = personQuery.checkPartnership(personId, partnerId);
		Assert.assertTrue(check);
		List<Person> partners = personQuery.getPartners(personId);
		Assert.assertEquals(partnerId, partners.get(0).getId());
		Boolean divorce = personCommand.cancelPartnership(personId, partnerId);
		Assert.assertTrue(divorce);
		check = personQuery.checkPartnership(personId, partnerId);
		Assert.assertFalse(check);
		partners = personQuery.getPartners(personId);
		Assert.assertEquals(partners.size(), 0);
		List<Person> formerPartners = personQuery.getFormerPartners(personId);
		Assert.assertEquals(formerPartners.size(), 1);
		Assert.assertEquals(formerPartners.get(0).getId(), partnerId);
	}
	
	@Test
	public void testParenting(){
		String personId = person.getId();
		personCommand.insert(person);
		String parentId = personQuery.generateId();
		person.setId(parentId);
		person.setUsername("partner"+new Date());
		personCommand.insert(person);
		List<Person> parents = personQuery.getParents(personId);
		List<Person> children = personQuery.getChildren(parentId);
		Assert.assertEquals(parents.size(), 0);
		Assert.assertEquals(children.size(), 0);
		personCommand.insertParent(personId, parentId);
		parents = personQuery.getParents(personId);
		children = personQuery.getChildren(parentId);
		Assert.assertEquals(parents.size(), 1);
		Assert.assertEquals(children.size(), 1);
		Assert.assertEquals(parents.get(0).getId(), parentId);
		Assert.assertEquals(children.get(0).getId(), personId);
	}
	
	@Test
	public void testCancelNonExistingPartnership(){
		String personId = person.getId();
		String nonPartnerId = personQuery.generateId();
		Boolean divorce = personCommand.cancelPartnership(personId, nonPartnerId);
		Assert.assertFalse(divorce);
	}

}
