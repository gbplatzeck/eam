package br.com.eam.dao.command;

import br.com.eam.model.user.misc.Wand;

public interface WandCommand {

	void insert(String personId, Wand wand);
	Boolean inactivate(String personId);
}
