package nl.hajari.wha.domain;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import java.math.BigDecimal;

@Entity
@RooJavaBean
@RooEntity
public class Employee {

	@NotNull
	@Size(max = 30)
	private String firstName;

	@NotNull
	@Size(max = 30)
	private String lastName;

	@NotNull
	private String employeeId;

	@OneToOne(targetEntity = User.class, cascade = CascadeType.REMOVE)
	private User user;

	private BigDecimal payRate;

	@ManyToOne
	private TechnicalRole technicalRole;

	@Override
	public String toString() {
		return employeeId + " : " + firstName + " " + lastName;
	}
}
