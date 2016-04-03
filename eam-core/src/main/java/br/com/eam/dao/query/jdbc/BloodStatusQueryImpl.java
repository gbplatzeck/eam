package br.com.eam.dao.query.jdbc;

import java.util.List;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.BloodStatusQuery;

@Repository
public class BloodStatusQueryImpl extends JdbcQuery implements BloodStatusQuery {

	private final static String SELECT_BLOOD_STATUSES = ""
			+ "	SELECT name "
			+ "	FROM k_blood_status"
			+ "	ORDER BY name";
	
	@Override
	public List<String> getBloodStatuses() {
		return template().queryForList(SELECT_BLOOD_STATUSES, params(), String.class);
	}

}
