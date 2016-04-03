package br.com.eam.dao.query.jdbc;

import java.util.Date;
import java.util.HashMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

@Component(value="query")
public class JdbcQuery {

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
	
	public String generateId() {
		return template().queryForObject("select uuid_generate_v1()", params(),
				String.class);
	}
	
	public Date now() {
        return template().queryForObject("select now()", params(), Date.class);
    }
}
