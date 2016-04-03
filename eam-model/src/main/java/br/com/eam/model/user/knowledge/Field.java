package br.com.eam.model.user.knowledge;

public abstract class Field extends Knowledge{

	private static final long serialVersionUID = 4263872212881134095L;
	public static final String FD_ARITHMANCY = "ARITHMANCY";
	public static final String FD_ASTRONOMY = "ASTRONOMY";
	public static final String FD_CMC = "CARE OF MAGICAL CREATURES";
	public static final String FD_CHARMS = "CHARMS";
	public static final String FD_DADA = "DEFENCE AGAINST DARK ARTS";
	public static final String FD_DIVINATION = "DIVINATION";
	public static final String FD_HERBOLOGY = "HERBOLOGY";
	public static final String FD_HM = "HISTORY OF MAGIC";
	public static final String FD_MS = "MUGGLE STUDIES";
	public static final String FD_POTIONS = "POTIONS";
	public static final String FD_SAR = "STUDIES OF ANCIENT RUNES";
	public static final String FD_TRANSFIGURATION = "TRANSFIGURATION";

	@Override
	public Integer getMaximumPoints() {
		return 7;
	}

}
