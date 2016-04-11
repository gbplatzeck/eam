package br.com.eam.dao.command.jdbc;

import java.util.Map;

import br.com.eam.dao.command.FieldCommand;
import br.com.eam.model.user.knowledge.Field;

public class FieldCommandImpl extends JdbcCommand implements FieldCommand{

	private final static String INSERT_FIELD = ""
			+ "	INSERT INTO r_person_field ("
			+ "		per_id,"
			+ "		fie_id,"
			+ "		points,"
			+ "		usage)"
			+ "	VALUES ("
			+ "		:personId,"
			+ "		:fieldId,"
			+ "		:points,"
			+ "		:usage)";
	
	private final static String UPDATE_FIELD = ""
			+ "	UPDATE r_person_field "
			+ "	SET per_id = :personId";
	
	private final static String SET_POINTS = ""
			+ "	, points = :points";
	
	private final static String SET_USAGE = ""
			+ "	, usage = :usage";
	
	private final static String WHERE = ""
			+ "	WHERE per_id = :personId"
			+ "		AND fie_id = :fieldId";
	
	@Override
	public void insert(String personId, Field field) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("fieldId", field.getId());
		paramMap.put("points", field.getPoints());
		paramMap.put("usage", field.getUsage());
		template().update(INSERT_FIELD, paramMap);
	}

	@Override
	public Boolean update(String personId, Field field) {
		StringBuilder sql = new StringBuilder(UPDATE_FIELD);
		
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("fieldId", field.getId());
		
		if(field.getPoints() != null){
			sql.append(SET_POINTS);
			paramMap.put("points", field.getPoints());
		}
		if(field.getUsage() != null){
			sql.append(SET_USAGE);
			paramMap.put("usage", field.getUsage());
		}
		sql.append(WHERE);
		return template().update(sql.toString(), paramMap) == 1;
	}

}
