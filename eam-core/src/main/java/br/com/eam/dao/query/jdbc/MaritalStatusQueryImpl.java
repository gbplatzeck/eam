package br.com.eam.dao.query.jdbc;

import java.util.List;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.MaritalStatusQuery;

@Repository
public class MaritalStatusQueryImpl extends JdbcQuery implements
		MaritalStatusQuery {
	
	private final static String SELECT_MARITAL_STATUSES = ""
			+ " SELECT name "
			+ "	FROM k_marital_status";

	@Override
	public List<String> getMaritalStatuses() {
		return template().queryForList(SELECT_MARITAL_STATUSES, params(), String.class);
	}

}
