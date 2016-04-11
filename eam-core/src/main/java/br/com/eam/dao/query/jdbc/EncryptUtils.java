package br.com.eam.dao.query.jdbc;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

public class EncryptUtils {

	/**
	 * 
	 * @param plainText to be encrypted
	 * @param key for encryption with length: 16 bytes
	 * @return encrypted text
	 */
	public static String encrypt(String plainText, String key) {
		try {
			Cipher cipher = getCipher(Cipher.ENCRYPT_MODE, key);
			byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
			return Base64.getEncoder().encodeToString(encryptedBytes);
		} catch (IllegalBlockSizeException | BadPaddingException e) {
			throw new RuntimeException(e);
		}

	}

	/**
	 * 
	 * @param encrypted text
	 * @param  key for encryption with length: 16 bytes
	 * @return decrypted text
	 */
	public static String decrypt(String encrypted, String key) {
		try {
			Cipher cipher = getCipher(Cipher.DECRYPT_MODE, key);
			byte[] plainBytes = cipher.doFinal(Base64.getDecoder().decode(
					encrypted));
			return new String(plainBytes);
		} catch (IllegalBlockSizeException | BadPaddingException e) {
			throw new RuntimeException(e);
		}

	}

	private static Cipher getCipher(int cipherMode, String key) {
		try {
			String encryptionAlgorithm = "AES";
			SecretKeySpec keySpecification = new SecretKeySpec(
					key.getBytes("UTF-8"), encryptionAlgorithm);
			Cipher cipher = Cipher.getInstance(encryptionAlgorithm);
			cipher.init(cipherMode, keySpecification);
			return cipher;
		} catch (InvalidKeyException | NoSuchAlgorithmException | NoSuchPaddingException | UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

	}
}