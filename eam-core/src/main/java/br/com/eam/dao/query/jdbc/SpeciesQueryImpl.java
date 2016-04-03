package br.com.eam.dao.query.jdbc;

import java.util.List;

import org.springframework.stereotype.Repository;

import br.com.eam.dao.query.SpeciesQuery;

@Repository
public class SpeciesQueryImpl extends JdbcQuery implements SpeciesQuery {

	private final static String SELECT_SPECIES = ""
			+ "	SELECT name "
			+ "	FROM k_species "
			+ "	ORDER BY name ";
	
	@Override
	public List<String> getSpecies() {
		return template().queryForList(SELECT_SPECIES, params(), String.class);
	}

}
