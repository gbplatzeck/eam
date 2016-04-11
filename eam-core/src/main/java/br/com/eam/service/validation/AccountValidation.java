package br.com.eam.service.validation;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.eam.dao.query.UserQuery;
import br.com.eam.exception.InvalidParameterException;
import br.com.eam.exception.InvalidTokenException;
import br.com.eam.utils.AccountUtils;

@Component
public class AccountValidation {

	@Autowired
	UserQuery userQuery;
	
	public void validateLogin(String login) throws InvalidParameterException{
		if(StringUtils.isBlank(login)){
			throw new InvalidParameterException("Login must not be blank!");
		}
		if(login.length() < 6){
			throw new InvalidParameterException("Login must be at least 6-characters long.");
		}
		if(userQuery.loginAlreadyExists(login)){
			throw new InvalidParameterException("Login already exists!");
		}
	}
	
	public static void validateRecoveryToken(String recoveryToken, String oldPassword) throws InvalidTokenException{
		Date date = AccountUtils.getExpirationDate(recoveryToken);
		if(date.before(new Date())){
			throw new InvalidTokenException("Recovery Token has already expired.");
		}
		String passwordFromToken = AccountUtils.getPassword(recoveryToken);
		if(!passwordFromToken.equals(oldPassword)){
			throw new InvalidTokenException("This is not a valid token.");
		}
	}
}
