package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.model.user.misc.Boggart;

public class BoggartRowMapper implements RowMapper<Boggart> {

	@Override
	public Boggart mapRow(ResultSet rs, int row) throws SQLException {
		String id = rs.getString("bog_id");
		String name = rs.getString("bog_name");
		String description = rs.getString("bog_description");
		Date creationDate = rs.getTimestamp("bog_creation_date");
		Date updatedDate = rs.getTimestamp("bog_updated_date");
		Boolean active = rs.getBoolean("bog_active");
		
		Boggart boggart = new Boggart();
		boggart.setId(id);
		boggart.setName(name);
		boggart.setDescription(description);
		boggart.setCreationDate(creationDate);
		boggart.setUpdatedDate(updatedDate);
		boggart.setActive(active);
		
		return boggart;
	}

}
