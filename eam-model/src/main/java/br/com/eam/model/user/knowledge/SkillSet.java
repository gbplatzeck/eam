package br.com.eam.model.user.knowledge;

import java.io.Serializable;
import java.util.Set;

import org.reflections.Reflections;

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

public class SkillSet implements Serializable{

	private static final long serialVersionUID = -1538215737952457961L;

	private Acting acting;
	private Bluffing bluffing;
	private Climbing climbing;
	private Flying flying;
	private Hiding hiding;
	private Jumping jumping;
	private Listening listening;
	private Riding riding;
	private Running running;
	private Searching searching;
	private Spotting spotting;
	private Swimming swimming;
	private Tumbling tumbling;
	
	public Acting getActing() {
		return acting;
	}
	public void setActing(Acting acting) {
		this.acting = acting;
	}
	public Flying getFlying() {
		return flying;
	}
	public void setFlying(Flying flying) {
		this.flying = flying;
	}
	public Jumping getJumping() {
		return jumping;
	}
	public void setJumping(Jumping jumping) {
		this.jumping = jumping;
	}
	public Listening getListening() {
		return listening;
	}
	public void setListening(Listening listening) {
		this.listening = listening;
	}
	public Running getRunning() {
		return running;
	}
	public void setRunning(Running running) {
		this.running = running;
	}
	public Searching getSearching() {
		return searching;
	}
	public void setSearching(Searching searching) {
		this.searching = searching;
	}
	public Swimming getSwimming() {
		return swimming;
	}
	public void setSwimming(Swimming swimming) {
		this.swimming = swimming;
	}
	public Bluffing getBluffing() {
		return bluffing;
	}
	public void setBluffing(Bluffing bluffing) {
		this.bluffing = bluffing;
	}
	public Climbing getClimbing() {
		return climbing;
	}
	public void setClimbing(Climbing climbing) {
		this.climbing = climbing;
	}
	public Hiding getHiding() {
		return hiding;
	}
	public void setHiding(Hiding hiding) {
		this.hiding = hiding;
	}
	public Riding getRiding() {
		return riding;
	}
	public void setRiding(Riding riding) {
		this.riding = riding;
	}
	public Spotting getSpotting() {
		return spotting;
	}
	public void setSpotting(Spotting spotting) {
		this.spotting = spotting;
	}
	public Tumbling getTumbling() {
		return tumbling;
	}
	public void setTumbling(Tumbling tumbling) {
		this.tumbling = tumbling;
	}
	
	public static Set<Class<? extends Skill>> getAll(){
		return new Reflections().getSubTypesOf(Skill.class);
	}
}
