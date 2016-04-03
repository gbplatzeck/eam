package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.HouseQuery;
import br.com.eam.dao.query.jdbc.rowmapper.HouseRowMapper;
import br.com.eam.dao.query.jdbc.rowmapper.PersonRowMapper;
import br.com.eam.model.school.House;
import br.com.eam.model.user.Person;

@Repository
public class HouseQueryImpl extends JdbcQuery implements HouseQuery {

	private final static String SELECT_HOUSES = ""
			+ "	SELECT h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "		, h.primary_colour hou_primary_colour"
			+ "		, h.secundary_colour hou_secundary_colour"
			+ "		, h.symbol hou_symbol"
			+ "		, h.history hou_history"
			+ "		, p.per_id per_id"
			+ "		, p.forename per_forename"
			+ "		, p.middle_names per_middle_names"
			+ "		, p.surname per_surname"
			+ "	FROM k_house h "
			+ "	LEFT JOIN d_person p "
			+ "		ON p.per_id = h.per_id ";
	
	private final static String SELECT_HOUSE_BY_ID = 
			SELECT_HOUSES
			+ "	WHERE hou_id = :houseId";
	
	private final static String SELECT_HEADMASTER = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.creation_date per_creation_date"
			+ "		, p.updated_date per_updated_date"
			+ "		, p.username per_username"
			+ "		, p.forename per_forename"
			+ "		, p.middle_names per_middle_names"
			+ "		, p.surname per_surname"
			+ "		, p.blood_status per_blood_status"
			+ "		, p.marital_status per_marital_status"
			+ "		, p.species per_species"
			+ "		, p.gender per_gender"
			+ "		, p.death_date per_death_date"
			+ "		, p.birthday per_birthday"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "	FROM d_person p "
			+ "	INNER JOIN r_house_headmaster r "
			+ "		ON p.per_id = r.per_id "
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = r.hou_id "
			+ "	WHERE r.hou_id = :houseId "
			+ "		AND r.active = :active "
			+ "	ORDER BY r.creation_date DESC ";
	
	@Override
	public List<House> getHouses() {
		String sql = SELECT_HOUSES;
		return template().query(sql, new HouseRowMapper());
	}

	@Override
	public House get(String houseId) {
		String sql = SELECT_HOUSE_BY_ID;
		Map<String, Object> paramMap = params();
		paramMap.put("houseId", houseId);
		return template().queryForObject(sql, paramMap, new HouseRowMapper());
	}

	@Override
	public Person getHeadmaster(String houseId) {
		String sql = SELECT_HEADMASTER;
		Map<String, Object> paramMap = params();
		paramMap.put("houseId", houseId);
		paramMap.put("active", true);
		return template().queryForObject(sql, paramMap, new PersonRowMapper());
	}

	@Override
	public List<Person> getFormerHeadmasters(String houseId) {
		String sql = SELECT_HEADMASTER;
		Map<String, Object> paramMap = params();
		paramMap.put("houseId", houseId);
		paramMap.put("active", true);
		return template().query(sql, paramMap, new PersonRowMapper());
	}

}
