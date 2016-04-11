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

import br.com.eam.dao.command.PatrounousCommand;
import br.com.eam.dao.command.PersonCommand;
import br.com.eam.dao.query.PatrounousQuery;
import br.com.eam.dao.query.PersonQuery;
import br.com.eam.main.EAMApplication;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.misc.Patrounous;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes=EAMApplication.class)
@WebAppConfiguration
@Transactional
public class PatrounousRepositoryTest {
	
	@Autowired
	PatrounousCommand patrounousCommand;
	
	@Autowired
	PatrounousQuery patrounousQuery;
	
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
		Patrounous choice = patrounousQuery.pick();
		Assert.assertNotNull(choice);
		Assert.assertNotNull(choice.getId());
		Assert.assertNotNull(choice.getName());
		Assert.assertNotNull(choice.getCreationDate());
		Assert.assertTrue(choice.getActive());
	}
	
	@Test
	public void testInsert(){
		Patrounous choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		Patrounous current = patrounousQuery.get(person.getId());
		Assert.assertNotNull(current);
		Assert.assertEquals(current.getId(), choice.getId());
		Assert.assertEquals(current.getName(), choice.getName());
		Assert.assertEquals(current.getDescription(), choice.getDescription());
		Assert.assertTrue(current.getActive());
	}
	
	@Test
	public void testFormerInitial(){
		Patrounous choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		List<Patrounous> former = patrounousQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);
	}
	
	@Test
	public void testEmptyFormer(){
		List<Patrounous> former = patrounousQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);		
	}
	
	@Test
	public void testInitial(){
		Patrounous current = patrounousQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivate(){
		Patrounous choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		Boolean inactivated = patrounousCommand.inactivate(person.getId());
		Assert.assertTrue(inactivated);
	}
	
	@Test
	public void testCurrentAfterInactivation(){
		Patrounous choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		patrounousCommand.inactivate(person.getId());
		Patrounous current = patrounousQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivateWithoutCurrent(){
		Boolean inactivated = patrounousCommand.inactivate(person.getId());
		Assert.assertFalse(inactivated);
	}
	
	@Test
	public void testFormer(){
		Patrounous choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		patrounousCommand.inactivate(person.getId());
		List<Patrounous> former = patrounousQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 1);
		choice = patrounousQuery.pick();
		patrounousCommand.insert(person.getId(), choice);
		patrounousCommand.inactivate(person.getId());
		former = patrounousQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 2);
	}
}
