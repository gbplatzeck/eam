package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.model.user.misc.Wand;

public class WandRowMapper implements RowMapper<Wand> {

	@Override
	public Wand mapRow(ResultSet rs, int row) throws SQLException {
		String id = rs.getString("wan_id");
		String wood = rs.getString("wan_wood");
		String kernel = rs.getString("wan_kernel");
		Double size = rs.getDouble("wan_size");
		Date creationDate = rs.getTimestamp("wan_creation_date");
		Date updatedDate = rs.getTimestamp("wan_updated_date");
		Boolean active = rs.getBoolean("wan_active");
		
		Wand wand = new Wand();
		wand.setId(id);
		wand.setWood(wood);
		wand.setKernel(kernel);
		wand.setSize(size);
		wand.setCreationDate(creationDate);
		wand.setUpdatedDate(updatedDate);
		wand.setActive(active);
		return wand;
	}

}
