package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.PatrounousQuery;
import br.com.eam.dao.query.jdbc.rowmapper.PatrounousRowMapper;
import br.com.eam.model.user.misc.Patrounous;

@Repository
public class PatrounousQueryImpl extends JdbcQuery implements PatrounousQuery {

	private final static String SELECT_PATROUNOUS_BY_PERSON_ID = ""
			+ "	SELECT p.pat_id pat_id"
			+ "		, p.name pat_name"
			+ "		, p.description pat_description"
			+ "		, r.active pat_active"
			+ "		, r.creation_date pat_creation_date"
			+ "		, r.updated_date pat_updated_date"
			+ "	FROM k_patrounous p"
			+ "	INNER JOIN r_person_patrounous r"
			+ "		ON r.pat_id = p.pat_id"
			+ "	WHERE r.per_id = :personId "
			+ "		AND r.active = :active "
			+ "	ORDER BY r.creation_date DESC";
	
	private final static String PICK_PATROUNOUS = ""
			+ "	SELECT p.pat_id pat_id"
			+ "		, p.name pat_name"
			+ "		, p.description pat_description"
			+ "		, true pat_active"
			+ "		, sysdate pat_creation_date"
			+ "		, sysdate pat_updated_date"
			+ "	FROM k_patrounous "
			+ "	OFFSET floor(random() * ( "
			+ "		SELECT count(*)"
			+ "		FROM k_boggart))"
			+ "	LIMIT 1";
	
	@Override
	public Patrounous pick() {
		return template().queryForObject(PICK_PATROUNOUS, params(), new PatrounousRowMapper());
	}

	@Override
	public Patrounous getByPersonId(String personId) {
		String sql = SELECT_PATROUNOUS_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", true);
		return template().queryForObject(sql, paramMap, new PatrounousRowMapper());
	}

	@Override
	public List<Patrounous> getFormerByPersonId(String personId) {
		String sql = SELECT_PATROUNOUS_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", false);
		return template().query(sql, paramMap, new PatrounousRowMapper());
	}

}
