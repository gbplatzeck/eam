package br.com.eam.dao.query.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.PersonQuery;
import br.com.eam.dao.query.jdbc.rowmapper.PersonRowMapper;
import br.com.eam.model.user.Person;

@Repository
public class PersonQueryImpl extends JdbcQuery implements PersonQuery{

	private final static String SELECT_PERSON_BY_ID = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.active per_active"			
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
			+ "		, p.story per_story"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "	FROM d_person p "
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = p.hou_id "
			+ "	WHERE p.per_id = :personId::uuid";
	
	private final static String SELECT_PARENTS = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.active per_active"
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
			+ "		, p.story per_story"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "	FROM d_person p "
			+ "	INNER JOIN r_person_parenting r "
			+ "		ON p.per_id = r.per_id_parent "
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = p.hou_id "
			+ "	WHERE r.per_id = :personId::uuid";
	
	private final static String SELECT_CHILDREN = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.active per_active"
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
			+ "		, p.story per_story"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "	FROM d_person p "
			+ "	INNER JOIN r_person_parenting r "
			+ "		ON p.per_id = r.per_id "
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = p.hou_id "
			+ "	WHERE r.per_id_parent = :personId::uuid";
	
	private final static String SELECT_PARTNERS = ""
			+ "	SELECT p.per_id per_id"
			+ "		, p.active per_active"
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
			+ "		, p.story per_story"
			+ "		, h.hou_id hou_id"
			+ "		, h.name hou_name"
			+ "	FROM d_person p "
			+ "	INNER JOIN r_person_partner r "
			+ "		ON (p.per_id = r.per_id AND r.per_id_2 = :personId::uuid)"
			+ "			OR (p.per_id = r.per_id_2 AND r.per_id = :personId::uuid)"
			+ "	LEFT JOIN k_house h "
			+ "		ON h.hou_id = p.hou_id "
			+ "	WHERE r.active = :active ";
	
	private final static String CHECK_PARTNERSHIP = ""
			+ "	SELECT true "
			+ "	FROM r_person_partner "
			+ "	WHERE "
			+ "		((per_id = :personId::uuid"
			+ "			AND per_id_2 = :partnerId::uuid)"
			+ "		OR (per_id_2 = :personId::uuid"
			+ "			AND per_id = :partnerId::uuid))"
			+ "		AND active = true";
	
	@Override
	public Person get(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().queryForObject(SELECT_PERSON_BY_ID, paramMap, new PersonRowMapper());
	}

	@Override
	public List<Person> getParents(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().query(SELECT_PARENTS, paramMap, new PersonRowMapper());
	}

	@Override
	public List<Person> getChildren(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		return template().query(SELECT_CHILDREN, paramMap, new PersonRowMapper());
	}

	@Override
	public List<Person> getPartners(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", true);
		return template().query(SELECT_PARTNERS, paramMap, new PersonRowMapper());
	}

	@Override
	public List<Person> getFormerPartners(String personId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("active", false);
		return template().query(SELECT_PARTNERS, paramMap, new PersonRowMapper());
	}

	@Override
	public Boolean checkPartnership(String personId, String partnerId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("partnerId", partnerId);
		SqlRowSet rs = template().queryForRowSet(CHECK_PARTNERSHIP, paramMap);
		return rs.next();
	}

}
