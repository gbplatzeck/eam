package br.com.eam.model.user.knowledge;

public class Main {

	public static void main(String[] args) throws InstantiationException, IllegalAccessException {
		for(Class<? extends Skill> c: SkillSet.getAll()){
			System.out.println(((Skill)c.newInstance()).getName());
		}
	}

}
