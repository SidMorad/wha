package nl.hajari.wha.utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ComboUtil {

	public List<MonthLabelValue> getMonthCombo() {
		List<MonthLabelValue> list = new ArrayList<MonthLabelValue>();
		int year = getCurrentYear();
		MonthLabelValue jan = new MonthLabelValue("January", year + "01");
		MonthLabelValue feb = new MonthLabelValue("February", year + "02");
		MonthLabelValue mar = new MonthLabelValue("March", year + "03");
		MonthLabelValue apr = new MonthLabelValue("April", year + "04");
		MonthLabelValue may = new MonthLabelValue("May", year + "05");
		MonthLabelValue jun = new MonthLabelValue("June", year + "06");
		MonthLabelValue jul = new MonthLabelValue("July", year + "07");
		MonthLabelValue aug = new MonthLabelValue("August", year + "08");
		MonthLabelValue sep = new MonthLabelValue("September", year + "09");
		MonthLabelValue oct = new MonthLabelValue("October", year + "10");
		MonthLabelValue nov = new MonthLabelValue("November", year + "11");
		MonthLabelValue dec = new MonthLabelValue("December", year + "12");
		list.add(jan);
		list.add(feb);
		list.add(mar);
		list.add(apr);
		list.add(may);
		list.add(jun);
		list.add(jul);
		list.add(aug);
		list.add(sep);
		list.add(oct);
		list.add(nov);
		list.add(dec);
		return list;
	}

	class MonthLabelValue {
		String label;
		String value;

		MonthLabelValue() {
		}

		MonthLabelValue(String label, String value) {
			this.label = label;
			this.value = value;
		}

		public String getLabel() {
			return label;
		}

		public void setLabel(String label) {
			this.label = label;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}
	}

	private int getCurrentYear() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		return year;
	}
	
	private int getCurrentMonth() {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH);
		return month;
	}
	
	public String getCurrentNumber() {
		return getCurrentYear()+""+getCurrentMonth();
	}

}
