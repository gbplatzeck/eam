package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import br.com.eam.model.user.Person;
import br.com.eam.model.user.Role;
import br.com.eam.model.user.User;

public class UserRowMapper implements RowMapper<User> {

	@Override
	public User mapRow(ResultSet rs, int row) throws SQLException {
		String id = rs.getString("use_id");
		String login = rs.getString("use_login");
		String email = rs.getString("use_email");
		Date userBirthday = rs.getTimestamp("use_user_birthday");
		Boolean active = rs.getBoolean("use_active");
		Date creationDate = rs.getTimestamp("use_creation_date");
		Date updatedDate = rs.getTimestamp("use_updated_date");
		String roleS = rs.getString("use_role");
		Role role = Role.valueOf(roleS);
		String password = rs.getString("use_password");
		
		Person person = new PersonRowMapper().mapRow(rs, row);
		
		User user = new User();
		user.setActive(active);
		user.setCreationDate(creationDate);
		user.setEmail(email);
		user.setId(id);
		user.setLogin(login);
		user.setPerson(person);
		user.setRole(role);
		user.setUpdatedDate(updatedDate);
		user.setUserBirthday(userBirthday);
		user.setPassword(password);
		
		return user;
	}
	
	public User mapRow(SqlRowSet rs, int row) {
		String id = rs.getString("use_id");
		String login = rs.getString("use_login");
		String email = rs.getString("use_email");
		Date userBirthday = rs.getTimestamp("use_user_birthday");
		Boolean active = rs.getBoolean("use_active");
		Date creationDate = rs.getTimestamp("use_creation_date");
		Date updatedDate = rs.getTimestamp("use_updated_date");
		String roleS = rs.getString("use_role");
		Role role = Role.valueOf(roleS);
		String password = rs.getString("use_password");
		
		Person person = new PersonRowMapper().mapRow(rs, row);
		
		User user = new User();
		user.setActive(active);
		user.setCreationDate(creationDate);
		user.setEmail(email);
		user.setId(id);
		user.setLogin(login);
		user.setPerson(person);
		user.setRole(role);
		user.setUpdatedDate(updatedDate);
		user.setUserBirthday(userBirthday);
		user.setPassword(password);
		
		return user;
	}

}
