package br.com.eam.model.user.knowledge;

public abstract class Skill extends Knowledge {

	private static final long serialVersionUID = -2843569563098372221L;

	public static final String SK_ACTING = "ACTING";
	public static final String SK_BLUFFING = "BLUFFING";
	public static final String SK_CLIMBING = "CLIMBING";
	public static final String SK_FLYING = "FLYING";
	public static final String SK_HIDING = "HIDING";
	public static final String SK_JUMPING = "JUMPING";
	public static final String SK_LISTENING = "LISTENING";
	public static final String SK_RIDING = "RIDING";
	public static final String SK_RUNNING = "RUNNING";
	public static final String SK_SEARCHING = "SEARCHING";
	public static final String SK_SPOTTING = "SPOTTING";
	public static final String SK_SWIMMING = "SWIMMING";
	public static final String SK_TUMBLING = "TUMBLING";
	
	@Override
	public Integer getMaximumPoints() {
		return 10;
	}

}
