package br.com.eam.model.user;

import java.util.Date;
import java.util.List;

import br.com.eam.model.Base;
import br.com.eam.model.school.House;
import br.com.eam.model.user.knowledge.FieldSet;
import br.com.eam.model.user.knowledge.SkillSet;
import br.com.eam.model.user.knowledge.SpellSet;
import br.com.eam.model.user.misc.Boggart;
import br.com.eam.model.user.misc.Patrounous;
import br.com.eam.model.user.misc.Wand;

public class Person extends Base {

	private static final long serialVersionUID = 8549573220293039372L;

	private String username;
	private String forename;
	private String middleNames;
	private String surname;
	private Date birthday;
	private Date deathDate;
	
	private String bloodStatus;
	private String maritalStatus;
	
	private String species;
	private String gender;
	
	private List<Person> parents;
	private List<Person> children;
	private List<Person> partners;
	private List<Person> formerPartners;
	
	private Boggart boggart;
	private Wand wand;
	private Patrounous patrounous;

	private FieldSet fieldSet;
	private SkillSet skillSet;
	private SpellSet spellSet;
	
	private House house;
	
	private String story;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getForename() {
		return forename;
	}

	public void setForename(String forename) {
		this.forename = forename;
	}

	public String getMiddleNames() {
		return middleNames;
	}

	public void setMiddleNames(String middleNames) {
		this.middleNames = middleNames;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getDeathDate() {
		return deathDate;
	}
	
	public void setDeathDate(Date deathDate) {
		this.deathDate = deathDate;
	}
	
	public String getBloodStatus() {
		return bloodStatus;
	}

	public void setBloodStatus(String bloodStatus) {
		this.bloodStatus = bloodStatus;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public List<Person> getParents() {
		return parents;
	}

	public void setParents(List<Person> parents) {
		this.parents = parents;
	}

	public List<Person> getPartners() {
		return partners;
	}
	
	public void setPartners(List<Person> partners) {
		this.partners = partners;
	}
	
	public List<Person> getFormerPartners() {
		return formerPartners;
	}

	public void setFormerPartners(List<Person> formerPartners) {
		this.formerPartners = formerPartners;
	}

	public List<Person> getChildren() {
		return children;
	}

	public void setChildren(List<Person> children) {
		this.children = children;
	}

	public Boggart getBoggart() {
		return boggart;
	}

	public void setBoggart(Boggart boggart) {
		this.boggart = boggart;
	}

	public Wand getWand() {
		return wand;
	}

	public void setWand(Wand wand) {
		this.wand = wand;
	}

	public Patrounous getPatrounous() {
		return patrounous;
	}

	public void setPatrounous(Patrounous patrounous) {
		this.patrounous = patrounous;
	}

	public FieldSet getFieldSet() {
		return fieldSet;
	}

	public void setFieldSet(FieldSet fieldSet) {
		this.fieldSet = fieldSet;
	}

	public SkillSet getSkillSet() {
		return skillSet;
	}

	public void setSkillSet(SkillSet skillSet) {
		this.skillSet = skillSet;
	}

	public SpellSet getSpellSet() {
		return spellSet;
	}

	public void setSpellSet(SpellSet spellSet) {
		this.spellSet = spellSet;
	}

	public House getHouse() {
		return house;
	}

	public void setHouse(House house) {
		this.house = house;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}
}
