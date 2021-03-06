package br.com.eam.dao.command.jdbc;

import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.command.WandCommand;
import br.com.eam.model.user.misc.Wand;

@Repository
public class WandCommandImpl extends JdbcCommand implements WandCommand {
	
	private final static String RELATE_WAND = ""
			+ "	INSERT INTO r_person_wand "
			+ "		(per_id, wan_id) "
			+ "	VALUES"
			+ "		(:personId::uuid, :wandId::uuid) ";
	
	private final static String INACTIVATE_WAND = ""
			+ "	UPDATE r_person_wand "
			+ "	SET "
			+ "		active = false,"
			+ "		updated_date = now()"
			+ "	WHERE"
			+ "		per_id = :personId::uuid"
			+ "		AND active = true";
	
	@Override
	public void insert(String personId, Wand wand) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("wandId", wand.getId());
		template().update(RELATE_WAND, paramMap);
	}

	@Override
	public Boolean inactivate(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().update(INACTIVATE_WAND, paramMap) >= 1;
	}

}
