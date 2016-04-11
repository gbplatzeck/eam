package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import br.com.eam.dao.query.SpellQuery;
import br.com.eam.dao.query.jdbc.rowmapper.SpellRowMapper;
import br.com.eam.model.user.knowledge.Spell;

public class SpellQueryImpl extends JdbcQuery implements SpellQuery {

	private final static String SELECT_SPELLS = ""
			+ "	SELECT s.spe_id spe_id"
			+ "		, s.description spe_description"
			+ "		, s.type spe_type"
			+ "		, r.points spe_points"
			+ "		, r.usage spe_usage"
			+ "	FROM k_spell s"
			+ "	INNER JOIN r_person_spell r"
			+ "		ON r.spe_id = s.spe_id"
			+ "	WHERE r.per_id = :personId"
			+ "	ORDER BY s.name";
	
	private final static String SELECT_ALL_SPELLS = ""
			+ "	SELECT s.spe_id spe_id"
			+ "		, s.description spe_description"
			+ "		, s.type spe_type"
			+ "		, 0 spe_points"
			+ "		, 0 spe_usage"
			+ "	FROM k_spell s"
			+ "	ORDER BY s.name";
	
	@Override
	public List<Spell> get(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().query(SELECT_SPELLS, paramMap, new SpellRowMapper());
	}

	@Override
	public List<Spell> list() {
		return template().query(SELECT_ALL_SPELLS, params(), new SpellRowMapper());
	}

}
