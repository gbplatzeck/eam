package br.com.eam.dao.command.jdbc;

import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.command.BoggartCommand;
import br.com.eam.model.user.misc.Boggart;

@Repository
public class BoggartCommandImpl extends JdbcCommand implements BoggartCommand{

	private final static String RELATE_BOGGART = ""
			+ "	INSERT INTO r_person_boggart "
			+ "		(per_id, bog_id) "
			+ "	VALUES"
			+ "		(:personId, :boggartId) ";
	
	private final static String INACTIVATE_BOGGART = ""
			+ "	UPDATE r_person_boggart "
			+ "	SET "
			+ "		active = false,"
			+ "		updated_date = now()"
			+ "	WHERE"
			+ "		per_id = :personId"
			+ "		AND active = true";
	
	@Override
	public void insert(String personId, Boggart boggart) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("boggartId", boggart.getId());
		template().update(RELATE_BOGGART, paramMap);
	}

	@Override
	public Boolean inactivate(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().update(INACTIVATE_BOGGART, paramMap) >= 1;
	}

}
