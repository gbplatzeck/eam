package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import br.com.eam.model.school.House;
import br.com.eam.model.user.Person;

public class PersonRowMapper implements RowMapper<Person>{

	@Override
	public Person mapRow(ResultSet rs, int row) throws SQLException {
		
		String id = rs.getString("per_id");
		Boolean active = rs.getBoolean("per_active");
		Date creationDate = rs.getTimestamp("per_creation_date");
		Date updatedDate = rs.getTimestamp("per_updated_date");
		String username = rs.getString("per_username");
		String forename = rs.getString("per_forename");
		String middleNames = rs.getString("per_middle_names");
		String surname = rs.getString("per_surname");
		String bloodStatus = rs.getString("per_blood_status");
		String maritalStatus = rs.getString("per_marital_status");
		String species = rs.getString("per_species");
		String gender = rs.getString("per_gender");
		String story = rs.getString("per_story");
		Date birthday = rs.getTimestamp("per_birthday");
		Date deathDate = rs.getTimestamp("per_death_date");
		
		House house = new HouseRowMapper().minimalMapRow(rs, row);
		
		Person person = new Person();
		person.setId(id);
		person.setActive(active);
		person.setCreationDate(creationDate);
		person.setUpdatedDate(updatedDate);
		person.setUsername(username);
		person.setForename(forename);
		person.setMiddleNames(middleNames);
		person.setSurname(surname);
		person.setBloodStatus(bloodStatus);
		person.setMaritalStatus(maritalStatus);
		person.setSpecies(species);
		person.setGender(gender);
		person.setStory(story);
		person.setBirthday(birthday);
		person.setDeathDate(deathDate);
		person.setHouse(house);
		
		return person;
	}

	public Person mapRow(SqlRowSet rs, int row) {
		
		String id = rs.getString("per_id");
		Boolean active = rs.getBoolean("per_active");
		Date creationDate = rs.getTimestamp("per_creation_date");
		Date updatedDate = rs.getTimestamp("per_updated_date");
		String username = rs.getString("per_username");
		String forename = rs.getString("per_forename");
		String middleNames = rs.getString("per_middle_names");
		String surname = rs.getString("per_surname");
		String bloodStatus = rs.getString("per_blood_status");
		String maritalStatus = rs.getString("per_marital_status");
		String species = rs.getString("per_species");
		String gender = rs.getString("per_gender");
		String story = rs.getString("per_story");
		Date birthday = rs.getTimestamp("per_birthday");
		Date deathDate = rs.getTimestamp("per_death_date");
		
		House house = new HouseRowMapper().minimalMapRow(rs, row);
		
		Person person = new Person();
		person.setId(id);
		person.setActive(active);
		person.setCreationDate(creationDate);
		person.setUpdatedDate(updatedDate);
		person.setUsername(username);
		person.setForename(forename);
		person.setMiddleNames(middleNames);
		person.setSurname(surname);
		person.setBloodStatus(bloodStatus);
		person.setMaritalStatus(maritalStatus);
		person.setSpecies(species);
		person.setGender(gender);
		person.setStory(story);
		person.setBirthday(birthday);
		person.setDeathDate(deathDate);
		person.setHouse(house);
		
		return person;
	}

	public Person minimalMapRow(ResultSet rs, int row) throws SQLException{
		String id = rs.getString("per_id");
		String forename = rs.getString("per_forename");
		String middleNames = rs.getString("per_middle_names");
		String surname = rs.getString("per_surname");
		
		Person person = new Person();
		person.setId(id);
		person.setForename(forename);
		person.setMiddleNames(middleNames);
		person.setSurname(surname);
		
		return person;
	}

}
