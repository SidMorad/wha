package nl.hajari.wha.domain.enums;

public enum WeekDay {
	Mon(1), Tus(2), Wed(3), Thu(4), Fri(5), Sat(6), Sun(7);
	
	private Integer value;
	
	WeekDay(Integer value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return super.toString();
	}
}
