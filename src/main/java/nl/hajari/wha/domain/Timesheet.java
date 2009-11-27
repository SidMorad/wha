package nl.hajari.wha.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
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
@RooEntity(finders = { "findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals"})
public class Timesheet {
	
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
    private Set<DailyTimesheet> dailyTimesheets;

    public String toString() {
        return sheetYear + ", " + sheetMonth + ", " + monthlyTotal;
    }

    @Transient
    static final Comparator<DailyTimesheet> DAYDATE_ORDER = new Comparator<DailyTimesheet>() {
		@Override
		public int compare(DailyTimesheet d1, DailyTimesheet d2) {
			return d1.getDayDate().compareTo(d2.getDayDate());
		}
	};
    
    @Transient
    public List<DailyTimesheet> getDailyTimesheetsSortedList() {
    	List<DailyTimesheet> dailyTimesheetList = new ArrayList<DailyTimesheet>(getDailyTimesheets());
    	Collections.sort(dailyTimesheetList, DAYDATE_ORDER);
        return dailyTimesheetList;        
    }

    @Transient
    public String getSheetMonthShortName() {
    	return DateUtils.getSheetMonthShortName(sheetMonth);
    }
}
