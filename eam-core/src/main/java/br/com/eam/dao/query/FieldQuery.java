package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.knowledge.Field;

public interface FieldQuery {

	List<Field> get(String personId);
	List<Field> list();
}
