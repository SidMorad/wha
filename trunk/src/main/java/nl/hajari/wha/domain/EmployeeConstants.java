package nl.hajari.wha.domain;

import javax.persistence.Entity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import javax.validation.constraints.NotNull;
import javax.persistence.Column;
import nl.hajari.wha.domain.Employee;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.UniqueConstraint;

@Entity
@RooJavaBean
@RooToString
@UniqueConstraint(columnNames = "employee,key")
@RooEntity(finders = { "findEmployeeConstantsesByEmployee", "findEmployeeConstantsesByEmployeeAndKeyEquals" })
public class EmployeeConstants {

    @NotNull
    @Column(name = "key_cons", nullable = false)
    private String key;

    @NotNull
    @Column(name = "value_cons", nullable = false)
    private String value;

    @NotNull
    @ManyToOne(targetEntity = Employee.class)
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    public EmployeeConstants() {
    }

    public EmployeeConstants(Employee employee, String key, String value) {
        this.employee = employee;
        this.key = key;
        this.value = value;
    }
}
