package br.com.eam.dao.query;

import java.util.List;

import br.com.eam.model.user.misc.Wand;

public interface WandQuery {
	Wand pick();
	Wand get(String personId);
	List<Wand> getFormer(String personId);
}
