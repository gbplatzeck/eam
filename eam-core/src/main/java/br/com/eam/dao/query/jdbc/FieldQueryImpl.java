package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import br.com.eam.dao.query.FieldQuery;
import br.com.eam.dao.query.jdbc.rowmapper.FieldRowMapper;
import br.com.eam.model.user.knowledge.Field;

public class FieldQueryImpl extends JdbcQuery implements FieldQuery {

	private final static String SELECT_FIELDS = ""
			+ "	SELECT f.fie_id fie_id"
			+ "		, f.description fie_description"
			+ "		, COALESCE(r.points fie_points, 0) fie_points"
			+ "		, COALESCE(r.usage fie_usage, 0) fie_usage"
			+ "	FROM k_field f "
			+ "	LEFT JOIN r_person_field r "
			+ "		ON f.fie_id = r.fie_id "
			+ "	WHERE r.per_id = :personId "
			+ "	ORDER BY f.name";
	
	private final static String SELECT_ALL_FIELDS = ""
			+ "	SELECT f.fie_id fie_id"
			+ "		, f.description fie_description"
			+ "		, 0 fie_points"
			+ "		, 0 fie_usage"
			+ "	FROM k_field f"
			+ "	ORDER BY f.name";
	
	@Override
	public List<Field> get(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().query(SELECT_FIELDS, paramMap, new FieldRowMapper());
	}

	@Override
	public List<Field> list() {
		return template().query(SELECT_ALL_FIELDS, params(), new FieldRowMapper());
	}

}
