package br.com.eam.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.eclipse.jetty.util.security.Credential.MD5;

import br.com.eam.dao.query.jdbc.EncryptUtils;
import br.com.eam.model.user.User;

public class AccountUtils {
	
	private static final String PASSWORD_BASE = "DONTCHANGETHIS";
	private static final String TOKEN_BASE = "TH155H0ULDN0TB3CH4NG3D";
	private static final String TOKEN_KEY = "TH1SK1ND4C0ULDB3CH4NG3DBUTD0NT";
	
	/**
	 * Masks email and empties password
	 * @param user
	 */
	public static void removeSensitiveInfo(User user){
		user.setPassword(StringUtils.EMPTY);
		user.setEmail(maskEmail(user.getEmail()));
	}
	
	/**
	 * @param email
	 * @return obfuscated email (using *) with full domain
	 */
	public static String maskEmail(String email){
		int indexAt = StringUtils.indexOf(email,"@");
		String domain = StringUtils.substring(email, indexAt);
		String user = StringUtils.substring(email, 0, indexAt);
		String fixed = StringUtils.substring(user, 0, 2);
		String mask = StringUtils.substring(user, 2, user.length());
		mask = mask.replaceAll(".", "*");
		return fixed + mask + domain;
	}
	
	public static String sha256(String password) {
	    try{
	    	String base = MD5.digest(PASSWORD_BASE);
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        password = base + password;
	        byte[] hash = digest.digest(password.getBytes("UTF-8"));
	        StringBuffer hexString = new StringBuffer();

	        for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) hexString.append('0');
	            hexString.append(hex);
	        }

	        return hexString.toString();
	    } catch(NoSuchAlgorithmException | UnsupportedEncodingException ex){
	       throw new RuntimeException(ex);
	    }
	}
	
	public static String generateRecoveryToken(String password){
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.HOUR, 12);
		String salted = tokenBase() + cal.getTimeInMillis() + "+" + password;
		return EncryptUtils.encrypt(salted, tokenKey());
	}
	
	public static String getPassword(String recoveryToken){
		String decryptedToken = decryptToken(recoveryToken);
		int indexOfSeparator = StringUtils.indexOf(decryptedToken, "+");
		return StringUtils.substring(decryptedToken, indexOfSeparator + 1);
	}
	
	public static Date getExpirationDate(String recoveryToken){
		String decryptedToken = decryptToken(recoveryToken);
		int indexOfSeparator = StringUtils.indexOf(decryptedToken, "+");
		long timeInMillis = Long.valueOf(StringUtils.substring(decryptedToken, 0, indexOfSeparator));
		return new Date(timeInMillis);
	}
	
	private static String decryptToken(String recoveryToken){
		String salted = EncryptUtils.decrypt(recoveryToken, tokenKey());
		return StringUtils.removeStart(salted, tokenBase());
	}
	
	private static String tokenBase(){
		return StringUtils.substring(MD5.digest(TOKEN_BASE), 16);
	}
	
	private static String tokenKey(){
		return StringUtils.substring(MD5.digest(TOKEN_KEY), 2, 18);
	}
	
}
