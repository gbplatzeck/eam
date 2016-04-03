package br.com.eam.dao.command.jdbc;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import br.com.eam.dao.command.UserCommand;
import br.com.eam.model.user.Person;
import br.com.eam.model.user.User;

@Repository
public class UserCommandImpl extends JdbcCommand implements UserCommand{

	private final static String INSERT_USER = ""
			+ "	INSERT INTO d_user "
			+ "		(use_id, email, login, password, user_birthday)"
			+ "	VALUES ("
			+ "		:userId::uuid,"
			+ "		:email,"
			+ "		:login,"
			+ "		:password,"
			+ "		:userBirthday"
			+ "	)";
	
	private final static String UPDATE_USER = ""
			+ "	UPDATE d_user"
			+ "	SET updated_date = now() ";
	
	private final static String SET_EMAIL = ", email = :email";
	private final static String SET_LOGIN = ", login = :login";
	private final static String SET_PASSWORD = ", password = :password";
	private final static String SET_USER_BIRTHDAY = ", user_birthday = :userBirthday";
	private final static String SET_PERSON = ", per_id = :personId::uuid";
	private final static String SET_ACTIVE = ", active = :active";
	
	private final static String UPDATE_WHERE = ""
			+ "	WHERE use_id = :userId::uuid";
	
	private final static String DELETE_USER = ""
			+ "	DELETE FROM d_user WHERE use_id = :userId::uuid";
	
	@Override
	public void insert(User user) {
		Map<String, Object> paramMap = params();
		paramMap.put("userId", user.getId());
		paramMap.put("email", user.getEmail());
		paramMap.put("login", user.getLogin());
		paramMap.put("password", user.getPassword());
		paramMap.put("userBirthday", user.getUserBirthday());
		template().update(INSERT_USER, paramMap);
	}

	@Override
	public Boolean update(User user) {
		StringBuilder sql = new StringBuilder(UPDATE_USER);
		Map<String, Object> paramMap = params();
		paramMap.put("userId", user.getId());
		
		String email = user.getEmail();
		if(StringUtils.isNotBlank(email)){
			sql.append(SET_EMAIL);
			paramMap.put("email", email);
		}
		String login = user.getLogin();
		if(StringUtils.isNotBlank(login)){
			sql.append(SET_LOGIN);
			paramMap.put("login", login);
		}
		String password = user.getPassword();
		if(StringUtils.isNoneBlank(password)){
			sql.append(SET_PASSWORD);
			paramMap.put("password", password);
		}
		Date userBirthday = user.getUserBirthday();
		if(userBirthday != null){
			sql.append(SET_USER_BIRTHDAY);
			paramMap.put("userBirthday", userBirthday);
		}
		Person person = user.getPerson();
		if(person != null && StringUtils.isNotBlank(person.getId())){
			sql.append(SET_PERSON);
			paramMap.put("personId", person.getId());
		}
		Boolean active = user.getActive();
		if(active != null){
			sql.append(SET_ACTIVE);
			paramMap.put("active", active);
		}
		sql.append(UPDATE_WHERE);
		return template().update(sql.toString(), paramMap) == 1;
	}

	@Override
	public Boolean delete(String userId) {
		Map<String, Object> paramMap = params();
		paramMap.put("userId", userId);
		return template().update(DELETE_USER, paramMap) == 1;
	}

}
