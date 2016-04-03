package br.com.eam.dao.command.jdbc;

import java.util.Map;

import br.com.eam.dao.command.PatrounousCommand;
import br.com.eam.model.user.misc.Patrounous;

public class PatrounousCommandImpl extends JdbcCommand implements
		PatrounousCommand {

	private final static String RELATE_PATROUNOUS = ""
			+ "	INSERT INTO r_person_patrounous "
			+ "		(per_id, pat_id) "
			+ "	VALUES"
			+ "		(:personId, :patrounousId) ";
	
	private final static String INACTIVATE_PATROUNOUS = ""
			+ "	UPDATE r_person_patrounous "
			+ "	SET "
			+ "		active = false,"
			+ "		updated_date = now()"
			+ "	WHERE"
			+ "		per_id = :personId"
			+ "		AND active = true";
	
	@Override
	public Boolean insert(String personId, Patrounous patrounous) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("patrounousId", patrounous.getId());
		return template().update(RELATE_PATROUNOUS, paramMap) == 1;
	}

	@Override
	public Boolean inactivate(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().update(INACTIVATE_PATROUNOUS, paramMap) >= 1;
	}

}
