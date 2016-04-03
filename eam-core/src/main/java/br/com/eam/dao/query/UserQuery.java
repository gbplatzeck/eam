package br.com.eam.dao.query;

import br.com.eam.model.user.User;

public interface UserQuery {

	User get(String userId);
	User get(String username, String password);
	String generateId();
}
