package br.com.eam.service;

import org.apache.commons.lang3.NotImplementedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.eam.dao.command.UserCommand;
import br.com.eam.dao.query.UserQuery;
import br.com.eam.exception.InvalidParameterException;
import br.com.eam.exception.InvalidTokenException;
import br.com.eam.model.user.User;
import br.com.eam.utils.AccountUtils;
import br.com.eam.validation.AccountValidation;

@Service
public class AccountService {

	@Autowired
	UserQuery userQuery;
	
	@Autowired
	UserCommand userCommand;
	
	public User register(User user){
		String id = userQuery.generateId();
		user.setId(id);
		userCommand.insert(user);
		AccountUtils.removeSensitiveInfo(user);
		return user;
	}
	
	public Boolean changeEmail(User user){
		user.setActive(null);
		user.setLogin(null);
		user.setPassword(null);
		user.setPerson(null);
		user.setRole(null);
		user.setUserBirthday(null);
		return userCommand.update(user);
	}
	
	public Boolean changePassword(User user, String newPassword) throws InvalidParameterException{
		User currentUser = userQuery.get(user.getId());
		if(!currentUser.getPassword().equals(user.getPassword())){
			throw new InvalidParameterException("Check your password.");
		}
		currentUser.setPassword(newPassword);
		return userCommand.update(currentUser);
	}
	
	public User authenticate(String login, String password) throws InvalidParameterException{
		String hashedPassword = AccountUtils.sha256(password);
		User user = userQuery.get(login, hashedPassword);
		if(user == null){
			throw new InvalidParameterException("Wrong username or password.");
		}
		AccountUtils.removeSensitiveInfo(user);
		return user;
	}
	
	public Boolean resetPassword(String login, String newPassword, String recoveryToken) throws InvalidParameterException, InvalidTokenException{
		User user = userQuery.getByLogin(login);
		if(user == null){
			throw new InvalidParameterException("Not possible to reset your password.");
		}
		AccountValidation.validateRecoveryToken(recoveryToken, user.getPassword());
		user.setPassword(newPassword);
		return userCommand.update(user);
	}
	
	public Boolean recoverPassword(String login) throws InvalidParameterException{
		User user = userQuery.getByLogin(login);
		if(user == null){
			throw new InvalidParameterException("Not possible to reset your password.");
		}
		String recoveryToken = AccountUtils.generateRecoveryToken(user.getPassword());
		//return EmailSender.sendRecoveryPasswordEmail(user, recoveryToken);
		throw new RuntimeException(new NotImplementedException("recover password not implemented: "+recoveryToken));
	}
}
