package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.BoggartQuery;
import br.com.eam.dao.query.jdbc.rowmapper.BoggartRowMapper;
import br.com.eam.model.user.misc.Boggart;

@Repository
public class BoggartQueryImpl extends JdbcQuery implements BoggartQuery {
	
	private final static String SELECT_BOGGART_BY_PERSON_ID = ""
			+ "	SELECT b.bog_id bog_id"
			+ "		, b.name bog_name"
			+ "		, b.description bog_description"
			+ "		, r.active bog_active"
			+ "		, r.creation_date bog_creation_date"
			+ "		, r.updated_date bog_updated_date"
			+ "	FROM k_boggart b"
			+ "	INNER JOIN r_person_boggart r"
			+ "		ON r.bog_id = b.bog_id"
			+ "	WHERE r.per_id = :personId "
			+ "		AND r.active = :active "
			+ "	ORDER BY r.creation_date DESC";

	private final static String PICK_BOGGART = ""
			+ "	SELECT b.bog_id bog_id"
			+ "		, b.name bog_name "
			+ "		, b.description bog_description "
			+ "		, true bog_active"
			+ "		, sysdate bog_creation_date "
			+ "		, sysdate bog_updated_date "
			+ "	FROM k_boggart b"
			+ "	OFFSET floor(random() * ("
			+ "		SELECT count(*) "
			+ "		FROM k_boggart))"
			+ "	LIMIT 1";
	
	@Override
	public Boggart pick() {
		return template().queryForObject(PICK_BOGGART, params(), new BoggartRowMapper());
	}

	@Override
	public Boggart getByPersonId(String personId) {
		String sql = SELECT_BOGGART_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", true);
		return template().queryForObject(sql, paramMap, new BoggartRowMapper());
	}

	@Override
	public List<Boggart> getFormerByPersonId(String personId) {
		String sql = SELECT_BOGGART_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", false);
		return template().query(sql, paramMap, new BoggartRowMapper());
	}

}
