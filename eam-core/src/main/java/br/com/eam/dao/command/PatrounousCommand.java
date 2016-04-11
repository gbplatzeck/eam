package br.com.eam.dao.command;

import br.com.eam.model.user.misc.Patrounous;

public interface PatrounousCommand {

	void insert(String personId, Patrounous patrounous);
	Boolean inactivate(String personId);
}
