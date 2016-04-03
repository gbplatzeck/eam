package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.WandQuery;
import br.com.eam.dao.query.jdbc.rowmapper.WandRowMapper;
import br.com.eam.model.user.misc.Wand;

@Repository
public class WandQueryImpl extends JdbcQuery implements WandQuery{
	
	private final static String SELECT_WAND_BY_PERSON_ID = ""
			+ "	SELECT w.wan_id wan_id"
			+ "		, w.kernel wan_kernel"
			+ "		, w.size wan_size"
			+ "		, w.wood wan_wood"
			+ "		, r.active wan_active"
			+ "		, r.creation_date wan_creation_date"
			+ "		, r.updated_date wan_updated_date"
			+ "	FROM k_wand w"
			+ "	INNER JOIN r_person_wand r"
			+ "		ON r.wan_id = w.wan_id"
			+ "	WHERE r.per_id = :personId "
			+ "		AND r.active = :active "
			+ "	ORDER BY r.creation_date DESC";
	
	private final static String PICK_WAND = ""
			+ "	SELECT w.wan_id wan_id"
			+ "		, w.wood wan_wood"
			+ "		, w.kernel wan_kernel"
			+ "		, w.size wan_size"
			+ "		, sysdate wan_creation_date"
			+ "		, sysdate wan_updated_date"
			+ "		, true wan_active "
			+ "	FROM k_wand "
			+ "	OFFSET floor(random() * ("
			+ "		SELECT count(*) "
			+ "		FROM k_wand)) "
			+ "	LIMIT 1";
	
	@Override
	public Wand pick() {
		String sql = PICK_WAND;
		return template().queryForObject(sql,params(), new WandRowMapper());
	}

	@Override
	public Wand getByPersonId(String personId) {
		String sql = SELECT_WAND_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", true);
		return template().queryForObject(sql, paramMap, new WandRowMapper());
	}

	@Override
	public List<Wand> getFormerByPersonId(String personId) {
		String sql = SELECT_WAND_BY_PERSON_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", false);
		return template().query(sql, paramMap, new WandRowMapper());
	}

}
