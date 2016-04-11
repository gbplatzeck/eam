package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.exception.KnowledgeNotImplementedException;
import br.com.eam.model.user.knowledge.Skill;
import br.com.eam.model.user.knowledge.skill.Acting;
import br.com.eam.model.user.knowledge.skill.Bluffing;
import br.com.eam.model.user.knowledge.skill.Climbing;
import br.com.eam.model.user.knowledge.skill.Flying;
import br.com.eam.model.user.knowledge.skill.Hiding;
import br.com.eam.model.user.knowledge.skill.Jumping;
import br.com.eam.model.user.knowledge.skill.Listening;
import br.com.eam.model.user.knowledge.skill.Riding;
import br.com.eam.model.user.knowledge.skill.Running;
import br.com.eam.model.user.knowledge.skill.Searching;
import br.com.eam.model.user.knowledge.skill.Spotting;
import br.com.eam.model.user.knowledge.skill.Swimming;
import br.com.eam.model.user.knowledge.skill.Tumbling;

public class SkillRowMapper implements RowMapper<Skill> {

	@Override
	public Skill mapRow(ResultSet rs, int rowNum) throws SQLException {
		String id = rs.getString("ski_id");
		String name = rs.getString("ski_name");	
		String description = rs.getString("ski_description");
		Integer points = rs.getInt("ski_points");
		Integer usage = rs.getInt("ski_usage");
		
		Skill skill = getInstance(name);
		skill.setId(id);
		skill.setDescription(description);
		skill.setPoints(points);
		skill.setUsage(usage);
		skill.setActive(true);
		skill.setCreationDate(new Date());
		skill.setUpdatedDate(new Date());
		return skill;
	}

	private static Skill getInstance(String name) {
		Skill skill = null;
		
		switch(name){
		case Skill.SK_ACTING:
			skill = new Acting();
			break;
		case Skill.SK_BLUFFING:
			skill = new Bluffing();
			break;
		case Skill.SK_CLIMBING:
			skill = new Climbing();
			break;
		case Skill.SK_FLYING:
			skill = new Flying();
			break;
		case Skill.SK_HIDING:
			skill = new Hiding();
			break;
		case Skill.SK_JUMPING:
			skill = new Jumping();
			break;
		case Skill.SK_LISTENING:
			skill = new Listening();
			break;
		case Skill.SK_RIDING:
			skill = new Riding();
			break;
		case Skill.SK_RUNNING:
			skill = new Running();
			break;
		case Skill.SK_SEARCHING:
			skill = new Searching();
			break;
		case Skill.SK_SPOTTING:
			skill = new Spotting();
			break;
		case Skill.SK_SWIMMING:
			skill = new Swimming();
			break;
		case Skill.SK_TUMBLING:
			skill = new Tumbling();
			break;
		default:
			throw new KnowledgeNotImplementedException(name);
		}
		
		return skill;
	}

}
