package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.exception.KnowledgeNotImplementedException;
import br.com.eam.model.user.knowledge.Field;
import br.com.eam.model.user.knowledge.field.Arithmancy;
import br.com.eam.model.user.knowledge.field.Astronomy;
import br.com.eam.model.user.knowledge.field.CareOfMagicalCreatures;
import br.com.eam.model.user.knowledge.field.Charms;
import br.com.eam.model.user.knowledge.field.DefenceAgainstDarkArts;
import br.com.eam.model.user.knowledge.field.Divination;
import br.com.eam.model.user.knowledge.field.Herbology;
import br.com.eam.model.user.knowledge.field.HistoryOfMagic;
import br.com.eam.model.user.knowledge.field.MuggleStudies;
import br.com.eam.model.user.knowledge.field.Potions;
import br.com.eam.model.user.knowledge.field.StudiesOfAncientRunes;
import br.com.eam.model.user.knowledge.field.Transfiguration;

public class FieldRowMapper implements RowMapper<Field>{

	@Override
	public Field mapRow(ResultSet rs, int rowNum) throws SQLException {
		String id = rs.getString("fie_id");
		String name = rs.getString("fie_name");	
		String description = rs.getString("fie_description");
		Integer points = rs.getInt("fie_points");
		Integer usage = rs.getInt("fie_usage");
		
		Field field = getInstance(name);
		field.setId(id);
		field.setDescription(description);
		field.setPoints(points);
		field.setUsage(usage);
		field.setActive(true);
		field.setCreationDate(new Date());
		field.setUpdatedDate(new Date());
		return field;
	}

	private static Field getInstance(String name) {
		Field field = null;
		switch(name){
		case Field.FD_ARITHMANCY:
			field = new Arithmancy();
			break;
		case Field.FD_ASTRONOMY:
			field = new Astronomy();
			break;
		case Field.FD_CHARMS:
			field = new Charms();
			break;
		case Field.FD_CMC:
			field = new CareOfMagicalCreatures();
			break;
		case Field.FD_DADA:
			field = new DefenceAgainstDarkArts();
			break;
		case Field.FD_DIVINATION:
			field = new Divination();
			break;
		case Field.FD_HERBOLOGY:
			field = new Herbology();
			break;
		case Field.FD_HM:
			field = new HistoryOfMagic();
			break;
		case Field.FD_MS:
			field = new MuggleStudies();
			break;
		case Field.FD_POTIONS:
			field = new Potions();
			break;
		case Field.FD_SAR:
			field = new StudiesOfAncientRunes();
			break;
		case Field.FD_TRANSFIGURATION:
			field = new Transfiguration();
			break;
		default:
			throw new KnowledgeNotImplementedException(name);
		}
		return field;
	}

}
