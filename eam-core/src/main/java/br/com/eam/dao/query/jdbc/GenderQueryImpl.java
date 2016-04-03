package br.com.eam.dao.query.jdbc;

import java.util.List;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.GenderQuery;

@Repository
public class GenderQueryImpl extends JdbcQuery implements GenderQuery {

	private final static String SELECT_GENDERS = ""
			+ "	SELECT name "
			+ "	FROM k_gender"
			+ "	ORDER BY name";
	
	@Override
	public List<String> getGenders() {
		return template().queryForList(SELECT_GENDERS, params(), String.class);
	}

}
