package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.misc.Boggart;

public interface BoggartQuery {

	Boggart pick();
	Boggart getByPersonId(String personId);
	List<Boggart> getFormerByPersonId(String personId);
}
