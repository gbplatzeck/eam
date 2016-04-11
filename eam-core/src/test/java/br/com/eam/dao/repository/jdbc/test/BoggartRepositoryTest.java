package br.com.eam.dao.repository.jdbc.test;

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

import br.com.eam.dao.command.BoggartCommand;
import br.com.eam.dao.command.PersonCommand;
import br.com.eam.dao.query.BoggartQuery;
import br.com.eam.dao.query.PersonQuery;
import br.com.eam.main.EAMApplication;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.misc.Boggart;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes=EAMApplication.class)
@WebAppConfiguration
@Transactional
public class BoggartRepositoryTest {
	
	@Autowired
	BoggartCommand boggartCommand;
	
	@Autowired
	BoggartQuery boggartQuery;
	
	@Autowired
	PersonCommand personCommand;
	
	@Autowired
	PersonQuery personQuery;
	
	private Person person;

	@Before
	public void setUp() {
		person = new Person();
		
		person.setId(personQuery.generateId());
		person.setBirthday(new Date());
		person.setBloodStatus("PURE BLOOD");
		person.setForename("Test");
		person.setGender("FEMALE");
		person.setMaritalStatus("SINGLE");
		person.setMiddleNames("Te St Tes");
		person.setSpecies("HUMAN");
		person.setStory("Story test");
		person.setSurname("Test");
		person.setUsername("Test"+new Date());
		person.setDeathDate(new Date());
		
		personCommand.insert(person);
	}
	
	@Test
	public void testPick(){
		Boggart choice = boggartQuery.pick();
		Assert.assertNotNull(choice);
		Assert.assertNotNull(choice.getId());
		Assert.assertNotNull(choice.getName());
		Assert.assertNotNull(choice.getCreationDate());
		Assert.assertTrue(choice.getActive());
	}
	
	@Test
	public void testInsert(){
		Boggart choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		Boggart current = boggartQuery.get(person.getId());
		Assert.assertNotNull(current);
		Assert.assertEquals(current.getId(), choice.getId());
		Assert.assertEquals(current.getName(), choice.getName());
		Assert.assertEquals(current.getDescription(), choice.getDescription());
		Assert.assertTrue(current.getActive());
	}
	
	@Test
	public void testFormerInitial(){
		Boggart choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		List<Boggart> former = boggartQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);
	}
	
	@Test
	public void testEmptyFormer(){
		List<Boggart> former = boggartQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);		
	}
	
	@Test
	public void testInitial(){
		Boggart current = boggartQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivate(){
		Boggart choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		Boolean inactivated = boggartCommand.inactivate(person.getId());
		Assert.assertTrue(inactivated);
	}
	
	@Test
	public void testCurrentAfterInactivation(){
		Boggart choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		boggartCommand.inactivate(person.getId());
		Boggart current = boggartQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivateWithoutCurrent(){
		Boolean inactivated = boggartCommand.inactivate(person.getId());
		Assert.assertFalse(inactivated);
	}
	
	@Test
	public void testFormer(){
		Boggart choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		boggartCommand.inactivate(person.getId());
		List<Boggart> former = boggartQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 1);
		choice = boggartQuery.pick();
		boggartCommand.insert(person.getId(), choice);
		boggartCommand.inactivate(person.getId());
		former = boggartQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 2);
	}
}

