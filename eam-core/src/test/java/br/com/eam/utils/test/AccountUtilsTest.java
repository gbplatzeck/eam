package br.com.eam.utils.test;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import br.com.eam.model.user.User;
import br.com.eam.utils.AccountUtils;

public class AccountUtilsTest {
	
	User user;
	String expectedHash = "5deaa497f59af6e48ec9cce421bd81bd81912ac248ca9cbf785f1030fa55eb5d";
	String expectedMasked = "em***@domain.com";
	String password = "testPasswd";

	@Before
	public void setUp() throws Exception {
		user = new User();
		user.setLogin("login");
		user.setPassword(password);
		user.setEmail("email@domain.com");
	}

	@Test
	public void testRemoveSensitiveInfo() {
		AccountUtils.removeSensitiveInfo(user);
		Assert.assertEquals(user.getEmail(), expectedMasked);
		Assert.assertTrue("".equals(user.getPassword()));
	}

	@Test
	public void testMaskEmail() {
		String masked = AccountUtils.maskEmail(user.getEmail());
		Assert.assertNotEquals(masked, user.getEmail());
		Assert.assertEquals(StringUtils.countMatches(masked, "*"), 3);
	}

	@Test
	public void testSha256() {
		String hash = AccountUtils.sha256(password);
		Assert.assertEquals(hash, expectedHash);
	}

	@Test
	public void testGenerateRecoveryToken() throws InterruptedException {
		String token = AccountUtils.generateRecoveryToken(expectedHash);
		Thread.sleep(1500l);
		String anotherToken = AccountUtils.generateRecoveryToken(expectedHash);
		Assert.assertNotEquals(token, anotherToken);
		Assert.assertEquals(token.length(), 152);
	}

	@Test
	public void testGetPassword() {
		String token = AccountUtils.generateRecoveryToken(expectedHash);
		String decryptedPassword = AccountUtils.getPassword(token);
		Assert.assertEquals(decryptedPassword, expectedHash);
	}

	@Test
	public void testGetExpirationDate() {
		Date begin = new Date();
		String token1 = AccountUtils.generateRecoveryToken(expectedHash);
		String token2 = AccountUtils.generateRecoveryToken(expectedHash+new Date().getTime());
		Date expiration1 = AccountUtils.getExpirationDate(token1);
		Date expiration2 = AccountUtils.getExpirationDate(token2);
		Assert.assertTrue(expiration1.getTime() - begin.getTime() >= 12*60*60*1000);
		Assert.assertTrue(expiration1.getTime() - expiration2.getTime() < 5*1000);
	}

}
