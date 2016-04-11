package br.com.eam.dao.command.jdbc;

import java.util.Map;

import br.com.eam.dao.command.SpellCommand;
import br.com.eam.model.user.knowledge.Spell;

public class SpellCommandImpl extends JdbcCommand implements SpellCommand {

	private final static String INSERT_SPELL = ""
			+ "	INSERT INTO r_person_spell ("
			+ "		per_id,"
			+ "		spe_id,"
			+ "		points,"
			+ "		usage)"
			+ "	VALUES ("
			+ "		:personId,"
			+ "		:spellId,"
			+ "		:points,"
			+ "		:usage)";
	
	private final static String UPDATE_SPELL = ""
			+ "	UPDATE r_person_spell "
			+ "	SET per_id = :personId";
	
	private final static String SET_POINTS = ""
			+ "	, points = :points";
	
	private final static String SET_USAGE = ""
			+ "	, usage = :usage";
	
	private final static String WHERE = ""
			+ "	WHERE per_id = :personId"
			+ "		AND spe_id = :spellId";
	
	@Override
	public void insert(String personId, Spell spell) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("spellId", spell.getId());
		paramMap.put("points", spell.getPoints());
		paramMap.put("usage", spell.getUsage());
		template().update(INSERT_SPELL, paramMap);
	}

	@Override
	public Boolean update(String personId, Spell spell) {
		StringBuilder sql = new StringBuilder(UPDATE_SPELL);
		
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("spellId", spell.getId());
		
		if(spell.getPoints() != null){
			sql.append(SET_POINTS);
			paramMap.put("points", spell.getPoints());
		}
		if(spell.getUsage() != null){
			sql.append(SET_USAGE);
			paramMap.put("usage", spell.getUsage());
		}
		sql.append(WHERE);
		return template().update(sql.toString(), paramMap) == 1;
	}

}
