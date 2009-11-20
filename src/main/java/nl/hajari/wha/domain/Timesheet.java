package nl.hajari.wha.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity
public class Timesheet {

	@NotNull
	@Size(min = 2, max = 2)
	@Column(name = "sheet_year", length = 2)
	private String sheetYear;

	@NotNull
	@Size(max = 4)
	@Column(name = "sheet_month", length = 4)
	private String sheetMonth;

	@NotNull
	private Float monthlyTotal;

	@NotNull
	@ManyToOne(targetEntity = Employee.class)
	@JoinColumn(name = "employee_id")
	private Employee employee;

	@OneToMany(targetEntity = DailyTimesheet.class, mappedBy = "timesheet", fetch = FetchType.LAZY, cascade =CascadeType.ALL)
	private Set<DailyTimesheet> dailyTimesheets;

	public String toString() {
		return sheetYear + " " + sheetMonth + " " + monthlyTotal;
	}
}
