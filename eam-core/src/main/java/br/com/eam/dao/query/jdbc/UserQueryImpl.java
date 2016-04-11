package br.com.eam.dao.query.jdbc;

import java.util.Map;

import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.UserQuery;
import br.com.eam.dao.query.jdbc.rowmapper.UserRowMapper;
import br.com.eam.model.user.User;

@Repository
public class UserQueryImpl extends JdbcQuery implements UserQuery {

	private final static String SELECT_USER = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.active per_active"
			+ "		, p.creation_date per_creation_date"
			+ "		, p.updated_date per_updated_date"
			+ "		, p.username per_username"
			+ "		, p.forename per_forename"
			+ "		, p.middle_names per_middle_names"
			+ "		, p.surname per_surname"
			+ "		, p.blood_status per_blood_status"
			+ "		, p.marital_status per_marital_status"
			+ "		, p.species per_species"
			+ "		, p.gender per_gender"
			+ "		, p.death_date per_death_date"
			+ "		, p.birthday per_birthday"
			+ "		, p.story per_story"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "		, u.use_id use_id"
			+ "		, u.active use_active"
			+ "		, u.creation_date use_creation_date"
			+ "		, u.updated_date use_updated_date"
			+ "		, u.login use_login"
			+ "		, u.password use_password"
			+ "		, u.email use_email"
			+ "		, u.user_birthday use_user_birthday"
			+ "		, u.role use_role"
			+ "	FROM d_user u"
			+ "	LEFT JOIN d_person p"
			+ "		ON u.per_id = p.per_id"
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = p.per_id";
	
	private final static String SELECT_USER_BY_ID = 
			SELECT_USER
			+ "	WHERE u.use_id = :userId::uuid";
	
	private final static String SELECT_USER_BY_AUTHENTICATION =
			SELECT_USER
			+ " WHERE u.active = true "
			+ "		AND u.password = :password "
			+ "		AND u.login = :login ";
	
	private final static String SELECT_USER_BY_LOGIN =
			SELECT_USER
			+ "	WHERE u.active = true"
			+ "		AND u.login = :login";
	
	private final static String CHECK_USERNAME = ""
			+ "	SELECT 1 "
			+ "	FROM d_user u "
			+ "	WHERE u.active = true"
			+ "		AND u.login = :login";
			
	@Override
	public User get(String userId) {
		String sql = SELECT_USER_BY_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("userId", userId);
		return template().queryForObject(sql, paramMap, new UserRowMapper());
	}

	@Override
	public User get(String login, String password) {
		String sql = SELECT_USER_BY_AUTHENTICATION;
		Map<String, Object> paramMap = params();
		paramMap.put("login", login);
		paramMap.put("password", password);
		SqlRowSet rs = template().queryForRowSet(sql, paramMap);
		User user = null;
		if(rs.next()){
			user = new UserRowMapper().mapRow(rs, 0);
		}
		return user;
	}
	
	@Override
	public Boolean loginAlreadyExists(String login){
		Map<String, Object> paramMap = params();
		paramMap.put("login", login);
		SqlRowSet rs = template().queryForRowSet(CHECK_USERNAME, paramMap);
		return rs.next();
	}
	
	@Override
	public User getByLogin(String login){
		String sql = SELECT_USER_BY_LOGIN;
		Map<String, Object> paramMap = params();
		paramMap.put("login", login);
		SqlRowSet rs = template().queryForRowSet(sql, paramMap);
		User user = null;
		if(rs.next()){
			user = new UserRowMapper().mapRow(rs, 0);
		}
		return user;
	}
	
}
