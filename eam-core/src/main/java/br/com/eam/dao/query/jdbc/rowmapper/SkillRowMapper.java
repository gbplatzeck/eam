package br.com.eam.dao.query.jdbc.rowmapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.eam.exception.KnowledgeNotImplementedException;
import br.com.eam.model.user.knowledge.Skill;
import br.com.eam.model.user.knowledge.SkillSet;
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
	
	private SkillSet skillSet;
	
	public SkillRowMapper(SkillSet skillSet){
		this.skillSet = skillSet;
	}

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

	private Skill getInstance(String name) {
		Skill skill = null;
		
		switch(name){
		case Skill.SK_ACTING:
			skillSet.setActing(new Acting());
			skill = skillSet.getActing();
			break;
		case Skill.SK_BLUFFING:
			skillSet.setBluffing(new Bluffing());
			skill = skillSet.getBluffing();
			break;
		case Skill.SK_CLIMBING:
			skillSet.setClimbing(new Climbing());
			skill = skillSet.getClimbing();
			break;
		case Skill.SK_FLYING:
			skillSet.setFlying(new Flying());
			skill = skillSet.getFlying();
			break;
		case Skill.SK_HIDING:
			skillSet.setHiding(new Hiding());
			skill = skillSet.getHiding();
			break;
		case Skill.SK_JUMPING:
			skillSet.setJumping(new Jumping());
			skill = skillSet.getJumping();
			break;
		case Skill.SK_LISTENING:
			skillSet.setListening(new Listening());
			skill = skillSet.getListening();
			break;
		case Skill.SK_RIDING:
			skillSet.setRiding(new Riding());
			skill = skillSet.getRiding();
			break;
		case Skill.SK_RUNNING:
			skillSet.setRunning(new Running());
			skill = skillSet.getRunning();
			break;
		case Skill.SK_SEARCHING:
			skillSet.setSearching(new Searching());
			skill = skillSet.getSearching();
			break;
		case Skill.SK_SPOTTING:
			skillSet.setSpotting(new Spotting());
			skill = skillSet.getSpotting();
			break;
		case Skill.SK_SWIMMING:
			skillSet.setSwimming(new Swimming());
			skill = skillSet.getSwimming();
			break;
		case Skill.SK_TUMBLING:
			skillSet.setTumbling(new Tumbling());
			skill = skillSet.getTumbling();
			break;
		default:
			throw new KnowledgeNotImplementedException(name);
		}
		
		return skill;
	}

}
