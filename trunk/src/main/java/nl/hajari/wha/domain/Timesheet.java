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
import nl.hajari.wha.domain.enums.Month;
import javax.persistence.Enumerated;
import javax.persistence.EnumType;

@Entity
@RooJavaBean
@RooEntity(finders = { "findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals" })
public class Timesheet {

    @NotNull
    @Size(min = 4, max = 4)
    @Column(name = "sheet_year", length = 2)
    private Integer sheetYear;

    @NotNull
    @Enumerated(EnumType.STRING)
    private Month sheetMonth;

    @NotNull
    private Float monthlyTotal;

    @NotNull
    @ManyToOne(targetEntity = Employee.class)
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @OneToMany(targetEntity = DailyTimesheet.class, mappedBy = "timesheet", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<DailyTimesheet> dailyTimesheets;

    public String toString() {
        return sheetYear + ", " + sheetMonth + ", " + monthlyTotal;
    }
}
