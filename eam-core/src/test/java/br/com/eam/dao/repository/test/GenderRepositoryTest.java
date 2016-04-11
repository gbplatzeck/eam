package br.com.eam.dao.repository.test;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import br.com.eam.dao.query.GenderQuery;
import br.com.eam.main.EAMApplication;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes=EAMApplication.class)
@WebAppConfiguration
@Transactional
public class GenderRepositoryTest {

	@Autowired
	GenderQuery genderQuery;
	
	@Test
	public void testGetGenders() {
		List<String> genders = genderQuery.getGenders();
		Assert.assertNotNull(genders);
	}

}
