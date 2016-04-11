package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.exception.KnowledgeNotImplementedException;
import br.com.eam.model.user.knowledge.Spell;
import br.com.eam.model.user.knowledge.SpellType;
import br.com.eam.model.user.knowledge.spell.WingardiumLeviosa;

public class SpellRowMapper implements RowMapper<Spell> {

	@Override
	public Spell mapRow(ResultSet rs, int rowNum) throws SQLException {
		String id = rs.getString("spe_id");
		String name = rs.getString("spe_name");	
		String description = rs.getString("spe_description");
		Integer points = rs.getInt("spe_points");
		Integer usage = rs.getInt("spe_usage");
		String typeS = rs.getString("spe_type");
		SpellType type = SpellType.valueOf(typeS);

		Spell spell = getInstance(name);
		spell.setId(id);
		spell.setDescription(description);
		spell.setPoints(points);
		spell.setUsage(usage);
		spell.setType(type);
		spell.setActive(true);
		spell.setCreationDate(new Date());
		spell.setUpdatedDate(new Date());
		return spell;
	}

	private Spell getInstance(String name) {
		Spell spell = null;
		switch(name){
		case(Spell.SP_WINGARDIUM_LEVIOSA):
			spell = new WingardiumLeviosa();
			break;
		default:
			throw new KnowledgeNotImplementedException(name);
		}
		return spell;
	}

}
