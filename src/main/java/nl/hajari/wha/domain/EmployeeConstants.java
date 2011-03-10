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

@Entity
@RooJavaBean
@RooToString
@RooEntity(finders = { "findEmployeeConstantsesByEmployee" })
public class EmployeeConstants {

    @NotNull
    @Column(name = "key_cons")
    private String key;

    @NotNull
    @Column(name = "value_cons")
    private String value;

    @NotNull
    @ManyToOne(targetEntity = Employee.class)
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;
}
