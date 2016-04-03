package br.com.eam.model.school;

import java.util.List;

import br.com.eam.model.Base;
import br.com.eam.model.user.Person;

public class House extends Base {

	private static final long serialVersionUID = -1840822461761619692L;
	
	private String name;
	private String primaryColour;
	private String secundaryColour;
	private String symbol;
	private String history;
	private Person founder;
	private Person headmaster;
	private List<Person> notoriousPeople;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrimaryColour() {
		return primaryColour;
	}
	public void setPrimaryColour(String primaryColour) {
		this.primaryColour = primaryColour;
	}
	public String getSecundaryColour() {
		return secundaryColour;
	}
	public void setSecundaryColour(String secundaryColour) {
		this.secundaryColour = secundaryColour;
	}
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public String getHistory() {
		return history;
	}
	public void setHistory(String history) {
		this.history = history;
	}
	public Person getFounder() {
		return founder;
	}
	public void setFounder(Person founder) {
		this.founder = founder;
	}
	public Person getHeadmaster() {
		return headmaster;
	}
	public void setHeadmaster(Person headmaster) {
		this.headmaster = headmaster;
	}
	public List<Person> getNotoriousPeople() {
		return notoriousPeople;
	}
	public void setNotoriousPeople(List<Person> notoriousPeople) {
		this.notoriousPeople = notoriousPeople;
	}
}
