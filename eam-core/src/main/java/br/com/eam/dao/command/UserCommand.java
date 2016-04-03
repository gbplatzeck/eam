package br.com.eam.dao.command;

import br.com.eam.model.user.User;

public interface UserCommand {

	void insert(User user);
	Boolean update(User user);
	Boolean delete(String userId);
}
