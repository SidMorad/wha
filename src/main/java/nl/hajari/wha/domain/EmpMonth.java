package nl.hajari.wha.domain;

import javax.persistence.Entity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import nl.hajari.wha.domain.Employee;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import nl.hajari.wha.domain.MonthStatus;
import javax.persistence.Enumerated;
import javax.persistence.EnumType;

@Entity
@RooJavaBean
@RooToString
@RooEntity(finders = { "findEmpMonthsByNumberEquals", "findEmpMonthsByEmployeeAndNumberEquals" })
public class EmpMonth {
	
	/**
	 * Number is composition of YEAR + MM
	 * e.g. 2009 March == 200903
	 */
    private String number;

    @ManyToOne(targetEntity = Employee.class)
    @JoinColumn
    private Employee employee;

    @Enumerated(EnumType.STRING)
    private MonthStatus monthStatus;
}
