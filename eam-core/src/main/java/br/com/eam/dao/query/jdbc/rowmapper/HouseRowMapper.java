package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import br.com.eam.model.school.House;
import br.com.eam.model.user.Person;

public class HouseRowMapper implements RowMapper<House> {

	@Override
	public House mapRow(ResultSet rs, int row) throws SQLException {
		
		String id = rs.getString("hou_id");
		String name = rs.getString("hou_name");
		String primaryColour = rs.getString("hou_primary_coulour");
		String secundaryColour = rs.getString("hou_secundary_colour");
		String symbol = rs.getString("hou_symbol");
		String history = rs.getString("hou_history");
		
		Person founder = new PersonRowMapper().minimalMapRow(rs, row);
		
		House house = new House();
		house.setId(id);
		house.setName(name);
		house.setPrimaryColour(primaryColour);
		house.setSecundaryColour(secundaryColour);
		house.setSymbol(symbol);
		house.setHistory(history);
		house.setFounder(founder);
		
		return house;
	}
	
	public House minimalMapRow(ResultSet rs, int row) throws SQLException {
		String id = rs.getString("hou_id");
		String name = rs.getString("hou_name");
		
		House house = new House();
		
		house.setId(id);
		house.setName(name);
		
		return house;
	}
	
	public House minimalMapRow(SqlRowSet rs, int row) {
		String id = rs.getString("hou_id");
		String name = rs.getString("hou_name");
		
		House house = new House();
		
		house.setId(id);
		house.setName(name);
		
		return house;
	}

}
