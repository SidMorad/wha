package nl.hajari.wha.domain;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import nl.hajari.wha.web.util.DateUtils;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity(finders = { "findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals" })
public class Timesheet {

	public static final String TIMESHEET_ID = "timesheetId";
	
	@NotNull
	@Size(min = 4, max = 4)
	@Column(name = "sheet_year", length = 4)
	private Integer sheetYear;

	@NotNull
	@Size(min = 1, max = 2)
	@Column(name = "sheet_month", length = 2)
	private Integer sheetMonth;

	@NotNull
	private Float monthlyTotal;

	@NotNull
	@ManyToOne(targetEntity = Employee.class)
	@JoinColumn(name = "employee_id", nullable = false)
	private Employee employee;

	@OneToMany(targetEntity = DailyTimesheet.class, mappedBy = "timesheet", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<DailyTimesheet> dailyTimesheets = new HashSet<DailyTimesheet>();

	@OneToMany(targetEntity = DailyTravel.class, mappedBy = "timesheet", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<DailyTravel> dailyTravels = new HashSet<DailyTravel>();

	@OneToMany(targetEntity = DailyExpense.class, mappedBy = "timesheet", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<DailyExpense> dailyExpenses = new HashSet<DailyExpense>();

	public String toString() {
		return sheetYear + ", " + sheetMonth + ", " + monthlyTotal;
	}

	public String getDescription() {
		return sheetYear + ", "
				+ Calendar.getInstance().getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());
	}

	@Transient
	public String getSheetMonthShortName() {
		return DateUtils.getSheetMonthShortName(sheetMonth);
	}
	
	@Transient
	public List<DailyTimesheet> getDailyTimesheetsSortedList() {
		List<DailyTimesheet> dailyTimesheetList = new ArrayList<DailyTimesheet>(dailyTimesheets);
		Collections.sort(dailyTimesheetList, new Comparator<DailyTimesheet>() {
			public int compare(DailyTimesheet d1, DailyTimesheet d2) {
				return d1.getDayDate().compareTo(d2.getDayDate());
			}
		});
		return dailyTimesheetList;
	}

	@Transient
	public List<DailyTravel> getDailyTravelsSortedList() {
		List<DailyTravel> dailyTravelList = new ArrayList<DailyTravel>(dailyTravels);
		Collections.sort(dailyTravelList, new Comparator<DailyTravel>() {
			public int compare(DailyTravel d1, DailyTravel d2) {
				return d1.getDayDate().compareTo(d2.getDayDate());
			}
		});
		return dailyTravelList;
	}

	@Transient
	public List<DailyExpense> getDailyExpensesSortedList() {
		List<DailyExpense> dailyExpenseList = new ArrayList<DailyExpense>(dailyExpenses);
		Collections.sort(dailyExpenseList, new Comparator<DailyExpense>() {
			public int compare(DailyExpense d1, DailyExpense d2) {
				return d1.getDayDate().compareTo(d2.getDayDate());
			}
		});
		return dailyExpenseList;
	}
}
