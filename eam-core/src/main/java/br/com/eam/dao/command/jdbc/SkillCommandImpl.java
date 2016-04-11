package br.com.eam.dao.command.jdbc;

import java.util.Map;

import br.com.eam.dao.command.SkillCommand;
import br.com.eam.model.user.knowledge.Skill;

public class SkillCommandImpl extends JdbcCommand implements SkillCommand {

	private final static String INSERT_SKILL = ""
			+ "	INSERT INTO r_person_skill ("
			+ "		per_id,"
			+ "		ski_id,"
			+ "		points,"
			+ "		usage)"
			+ "	VALUES ("
			+ "		:personId,"
			+ "		:skillId,"
			+ "		:points,"
			+ "		:usage)";
	
	private final static String UPDATE_SKILL = ""
			+ "	UPDATE r_person_skill "
			+ "	SET per_id = :personId";
	
	private final static String SET_POINTS = ""
			+ "	, points = :points";
	
	private final static String SET_USAGE = ""
			+ "	, usage = :usage";
	
	private final static String WHERE = ""
			+ "	WHERE per_id = :personId"
			+ "		AND ski_id = :skillId";
	
	@Override
	public void insert(String personId, Skill skill) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("skillId", skill.getId());
		paramMap.put("points", skill.getPoints());
		paramMap.put("usage", skill.getUsage());
		template().update(INSERT_SKILL, paramMap);
	}

	@Override
	public Boolean update(String personId, Skill skill) {
		StringBuilder sql = new StringBuilder(UPDATE_SKILL);
		
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("skillId", skill.getId());
		
		if(skill.getPoints() != null){
			sql.append(SET_POINTS);
			paramMap.put("points", skill.getPoints());
		}
		if(skill.getUsage() != null){
			sql.append(SET_USAGE);
			paramMap.put("usage", skill.getUsage());
		}
		sql.append(WHERE);
		return template().update(sql.toString(), paramMap) == 1;
	}

}
