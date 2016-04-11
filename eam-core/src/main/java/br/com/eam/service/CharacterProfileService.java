package br.com.eam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.eam.dao.query.BloodStatusQuery;
import br.com.eam.dao.query.GenderQuery;
import br.com.eam.dao.query.MaritalStatusQuery;
import br.com.eam.dao.query.SpeciesQuery;

@Service
public class CharacterProfileService {
	
	@Autowired
	BloodStatusQuery bloodStatusQuery;
	
	@Autowired
	MaritalStatusQuery maritalStatusQuery;
	
	@Autowired
	GenderQuery genderQuery;
	
	@Autowired
	SpeciesQuery speciesQuery;
	
	public List<String> getBloodStatuses(){
		return bloodStatusQuery.getBloodStatuses();
	}
	
	public List<String> getMaritalStatuses(){
		return maritalStatusQuery.getMaritalStatuses();
	}
	
	public List<String> getGenders(){
		return genderQuery.getGenders();
	}
	
	public List<String> getSpecies(){
		return speciesQuery.getSpecies();
	}
}
