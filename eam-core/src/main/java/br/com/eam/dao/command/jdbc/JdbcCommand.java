package br.com.eam.dao.command.jdbc;

import java.util.HashMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class JdbcCommand {

private NamedParameterJdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setJdbcTemplate(DataSource dataSource){
		this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}
	
	public NamedParameterJdbcTemplate template(){
		return jdbcTemplate;
	}
	
	public HashMap<String, Object> params(){
		return new HashMap<String, Object>();
	}
}
