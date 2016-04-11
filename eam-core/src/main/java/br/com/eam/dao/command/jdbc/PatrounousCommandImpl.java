package br.com.eam.dao.command.jdbc;

import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.command.PatrounousCommand;
import br.com.eam.model.user.misc.Patrounous;

@Repository
public class PatrounousCommandImpl extends JdbcCommand implements
		PatrounousCommand {

	private final static String RELATE_PATROUNOUS = ""
			+ "	INSERT INTO r_person_patrounous "
			+ "		(per_id, pat_id) "
			+ "	VALUES"
			+ "		(:personId::uuid, :patrounousId::uuid) ";
	
	private final static String INACTIVATE_PATROUNOUS = ""
			+ "	UPDATE r_person_patrounous "
			+ "	SET "
			+ "		active = false,"
			+ "		updated_date = now()"
			+ "	WHERE"
			+ "		per_id = :personId::uuid"
			+ "		AND active = true";
	
	@Override
	public void insert(String personId, Patrounous patrounous) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("patrounousId", patrounous.getId());
		template().update(RELATE_PATROUNOUS, paramMap);
	}

	@Override
	public Boolean inactivate(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().update(INACTIVATE_PATROUNOUS, paramMap) >= 1;
	}

}
