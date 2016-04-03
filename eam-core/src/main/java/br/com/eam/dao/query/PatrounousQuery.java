package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.misc.Patrounous;

public interface PatrounousQuery {

	Patrounous pick();
	Patrounous getByPersonId(String personId);
	List<Patrounous> getFormerByPersonId(String personId);
}
