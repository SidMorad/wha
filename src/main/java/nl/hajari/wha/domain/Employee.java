package nl.hajari.wha.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity
public class Employee {

	@NotNull
	@Size(min = 2, max = 45)
	@Column(name = "first_name", length = 45)
	private String firstName;

	@NotNull
	@Size(min = 2, max = 45)
	@Column(name = "last_name", length = 45)
	private String lastName;

	@NotNull
	@Size(max = 45)
	@Column(name = "emp_id", length = 45)
	private String empId;

	private Float hourlyWage;

	@OneToOne(targetEntity = User.class, cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "employee_has_techrole", joinColumns = { @JoinColumn(name = "employee_id") }, inverseJoinColumns = @JoinColumn(name = "techrole_id"))
	private Set<TechRole> techRoles = new HashSet<TechRole>();

	@Override
	public String toString() {
		return empId + " : " + firstName + " " + lastName;
	}
}
