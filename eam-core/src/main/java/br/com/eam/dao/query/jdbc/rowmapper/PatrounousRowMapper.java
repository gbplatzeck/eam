package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.model.user.misc.Patrounous;

public class PatrounousRowMapper implements RowMapper<Patrounous> {

	@Override
	public Patrounous mapRow(ResultSet rs, int row) throws SQLException {
		String id = rs.getString("pat_id");
		String name = rs.getString("pat_name");
		String description = rs.getString("pat_description");
		Date creationDate = rs.getTimestamp("pat_creation_date");
		Date updatedDate = rs.getTimestamp("pat_updated_date");
		Boolean active = rs.getBoolean("active");
		
		Patrounous patrounous = new Patrounous();
		patrounous.setId(id);
		patrounous.setName(name);
		patrounous.setDescription(description);
		patrounous.setCreationDate(creationDate);
		patrounous.setUpdatedDate(updatedDate);
		patrounous.setActive(active);
		return patrounous;
	}

}
