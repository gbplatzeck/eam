package br.com.eam.dao.command;

import br.com.eam.model.user.misc.Boggart;

public interface BoggartCommand {

	void insert(String personId, Boggart boggart);
	Boolean inactivate(String personId);
}
