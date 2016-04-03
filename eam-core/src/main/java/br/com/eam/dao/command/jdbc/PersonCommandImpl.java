package br.com.eam.dao.command.jdbc;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import br.com.eam.dao.command.PersonCommand;
import br.com.eam.model.user.Person;

@Repository
public class PersonCommandImpl extends JdbcCommand implements PersonCommand {

	private final static String INSERT_PERSON = ""
			+ "	INSERT INTO d_person ("
			+ "		per_id,"
			+ "		username,"
			+ "		forename,"
			+ "		middle_names,"
			+ "		surname,"
			+ "		blood_status,"
			+ "		marital_status,"
			+ "		species,"
			+ "		gender,"
			+ "		birthday,"
			+ "		death_date,"
			+ "		story)"
			+ "	VALUES ("
			+ "		:personId::uuid,"
			+ "		:username,"
			+ "		:forename,"
			+ "		:middleNames,"
			+ "		:surname,"
			+ "		:bloodStatus,"
			+ "		:maritalStatus,"
			+ "		:species,"
			+ "		:gender,"
			+ "		:birthday,"
			+ "		:deathDate,"
			+ "		:story)";
	
	private final static String UPDATE_PERSON = ""
			+ "	UPDATE d_person "
			+ "	SET updated_date = now() ";
	
	private final static String SET_USERNAME = ", username = :username";
	private final static String SET_FORENAME = ", forename = :forename";
	private final static String SET_MIDDLE_NAMES = ", middle_names = :middleNames";
	private final static String SET_SURNAME = ", surname = :surname";
	private final static String SET_MARITAL_STATUS = ", marital_status = :maritalStatus";
	private final static String SET_DEATH_DATE = ", death_date = :deathDate";
	private final static String SET_GENDER = ", gender = :gender";
	private final static String SET_BLOOD_STATUS = ", blood_status = :bloodStatus";
	private final static String SET_SPECIES = ", species = :species";
	private final static String SET_STORY = " , story = :story";
//	private final static String SET_BIRTHDAY = ", birthday";
	
	private final static String UPDATE_WHERE = " WHERE per_id = :personId::uuid";
	
	private final static String INSERT_PARENT = ""
			+ "	INSERT INTO r_person_parenting ("
			+ "		per_id,"
			+ "		per_id_parent)"
			+ "	VALUES ("
			+ "		:personId::uuid,"
			+ "		:parentId::uuid)";
	
	private final static String INSERT_PARTNER = ""
			+ "	INSERT INTO r_person_partner ("
			+ "		per_id,"
			+ "		per_id_2)"
			+ "	VALUES ("
			+ "		:personId::uuid,"
			+ "		:partnerId::uuid)";
	
	private final static String INACTIVATE_PARTNER = ""
			+ "	UPDATE r_person_partner "
			+ "	SET active = false,	"
			+ "		updated_date = now() "
			+ "	WHERE "
			+ "		(per_id = :personId::uuid"
			+ "			AND per_id_2 = :partnerId::uuid)"
			+ "		OR"
			+ "		(per_id = :partnerId::uuid"
			+ "			AND per_id_2 = :personId::uuid)"
			+ "		AND active = true";
	
	@Override
	public void insert(Person person) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", person.getId());
		paramMap.put("username", person.getUsername());
		paramMap.put("forename", person.getForename());
		paramMap.put("middleNames", person.getMiddleNames());
		paramMap.put("surname", person.getSurname());
		paramMap.put("bloodStatus", person.getBloodStatus());
		paramMap.put("maritalStatus", person.getMaritalStatus());
		paramMap.put("species", person.getSpecies());
		paramMap.put("gender", person.getGender());
		paramMap.put("birthday", person.getBirthday());
		paramMap.put("deathDate", person.getDeathDate());
		paramMap.put("story", person.getStory());
		
		template().update(INSERT_PERSON, paramMap);
	}

	@Override
	public Boolean update(Person person) {
		StringBuilder sql = new StringBuilder(UPDATE_PERSON);
		
		Map<String, Object> paramMap = params();
		paramMap.put("personId", person.getId());
		if(StringUtils.isNotBlank(person.getUsername())){
			sql.append(SET_USERNAME);
			paramMap.put("username", person.getUsername());
		}
		if(StringUtils.isNotBlank(person.getForename())){
			sql.append(SET_FORENAME);
			paramMap.put("forename", person.getForename());
		}
		if(StringUtils.isNotBlank(person.getMiddleNames())){
			sql.append(SET_MIDDLE_NAMES);
			paramMap.put("middleNames", person.getMiddleNames());
		}
		if(StringUtils.isNotBlank(person.getSurname())){
			sql.append(SET_SURNAME);
			paramMap.put("surname", person.getSurname());
		}
		if(StringUtils.isNotBlank(person.getBloodStatus())){
			sql.append(SET_BLOOD_STATUS);
			paramMap.put("bloodStatus", person.getBloodStatus());
		}
		if(StringUtils.isNotBlank(person.getMaritalStatus())){
			sql.append(SET_MARITAL_STATUS);
			paramMap.put("maritalStatus", person.getMaritalStatus());
		}
		if(StringUtils.isNotBlank(person.getSpecies())){
			sql.append(SET_SPECIES);
			paramMap.put("species", person.getSpecies());
		}
		if(StringUtils.isNotBlank(person.getGender())){
			sql.append(SET_GENDER);
			paramMap.put("gender", person.getGender());
		}
		if(person.getDeathDate() != null){
			sql.append(SET_DEATH_DATE);
			paramMap.put("deathDate", person.getDeathDate());
		}
		if(StringUtils.isNotBlank(person.getStory())){
			sql.append(SET_STORY);
			paramMap.put("story", person.getStory());
		}
		sql.append(UPDATE_WHERE);
		
		return template().update(sql.toString(), paramMap) == 1;
	}

	@Override
	public void insertParent(String personId, String parentId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("parentId", parentId);
		template().update(INSERT_PARENT, paramMap);
	}

	@Override
	public void insertPartnership(String personId, String partnerId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("partnerId", partnerId);
		template().update(INSERT_PARTNER, paramMap);
	}

	@Override
	public Boolean cancelPartnership(String personId, String partnerId) {
		Map<String, Object> paramMap = params();
		paramMap.put("personId", personId);
		paramMap.put("partnerId", partnerId);
		return template().update(INACTIVATE_PARTNER, paramMap) == 1;
	}

}
