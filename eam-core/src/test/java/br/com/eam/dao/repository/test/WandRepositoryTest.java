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
import br.com.eam.dao.command.WandCommand;
import br.com.eam.dao.query.PersonQuery;
import br.com.eam.dao.query.WandQuery;
import br.com.eam.main.EAMApplication;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.misc.Wand;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes=EAMApplication.class)
@WebAppConfiguration
@Transactional
public class WandRepositoryTest {
	
	@Autowired
	WandCommand wandCommand;
	
	@Autowired
	WandQuery wandQuery;
	
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
		Wand choice = wandQuery.pick();
		Assert.assertNotNull(choice);
		Assert.assertNotNull(choice.getId());
		Assert.assertNotNull(choice.getKernel());
		Assert.assertNotNull(choice.getSize());
		Assert.assertNotNull(choice.getWood());
		Assert.assertNotNull(choice.getCreationDate());
		Assert.assertTrue(choice.getActive());
	}
	
	@Test
	public void testInsert(){
		Wand choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		Wand current = wandQuery.get(person.getId());
		Assert.assertNotNull(current);
		Assert.assertEquals(current.getId(), choice.getId());
		Assert.assertEquals(current.getKernel(), choice.getKernel());
		Assert.assertEquals(current.getWood(), choice.getWood());
		Assert.assertEquals(current.getSize(), choice.getSize());
		Assert.assertTrue(current.getActive());
	}
	
	@Test
	public void testFormerInitial(){
		Wand choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		List<Wand> former = wandQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);
	}
	
	@Test
	public void testEmptyFormer(){
		List<Wand> former = wandQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 0);		
	}
	
	@Test
	public void testInitial(){
		Wand current = wandQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivate(){
		Wand choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		Boolean inactivated = wandCommand.inactivate(person.getId());
		Assert.assertTrue(inactivated);
	}
	
	@Test
	public void testCurrentAfterInactivation(){
		Wand choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		wandCommand.inactivate(person.getId());
		Wand current = wandQuery.get(person.getId());
		Assert.assertNull(current);
	}
	
	@Test
	public void testInactivateWithoutCurrent(){
		Boolean inactivated = wandCommand.inactivate(person.getId());
		Assert.assertFalse(inactivated);
	}
	
	@Test
	public void testFormer(){
		Wand choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		wandCommand.inactivate(person.getId());
		List<Wand> former = wandQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 1);
		choice = wandQuery.pick();
		wandCommand.insert(person.getId(), choice);
		wandCommand.inactivate(person.getId());
		former = wandQuery.getFormer(person.getId());
		Assert.assertEquals(former.size(), 2);
	}
}

