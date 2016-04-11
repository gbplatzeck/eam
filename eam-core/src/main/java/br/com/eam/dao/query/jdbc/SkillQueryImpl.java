package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import br.com.eam.dao.query.SkillQuery;
import br.com.eam.dao.query.jdbc.rowmapper.SkillRowMapper;
import br.com.eam.model.user.knowledge.Skill;

public class SkillQueryImpl extends JdbcQuery implements SkillQuery {

	private static final String SELECT_SKILLS = ""
			+ "	SELECT s.ski_id ski_id"
			+ "		, s.description ski_description"
			+ "		, r.points ski_points"
			+ "		, r.usage ski_usage"
			+ "	FROM k_skill s "
			+ "	INNER JOIN r_person_skill r "
			+ "		ON r.ski_id = s.ski_id "
			+ "	WHERE r.per_id = :personId "
			+ "	ORDER BY s.name";
	
	private static final String SELECT_ALL_SKILLS = ""
			+ "	SELECT s.ski_id ski_id"
			+ "		, s.description ski_drescription"
			+ "		, 0 ski_points"
			+ "		, 0 ski_usage"
			+ "	FROM k_skill s"
			+ "	ORDER BY s.name";
	
	
	@Override
	public List<Skill> get(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().query(SELECT_SKILLS, paramMap, new SkillRowMapper());
	}


	@Override
	public List<Skill> list() {
		return template().query(SELECT_ALL_SKILLS, params(), new SkillRowMapper());
	}

}
