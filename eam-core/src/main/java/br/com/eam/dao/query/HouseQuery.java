package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.school.House;
import br.com.eam.model.user.Person;

public interface HouseQuery {

	List<House> getHouses();
	House get(String houseId);
	Person getHeadmaster(String houseId);
	List<Person> getFormerHeadmasters(String houseId);
}
