package nl.hajari.wha.domain;

import java.util.Date;
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
@RooEntity(finders = { "findEmployeesByUser" })
public class Employee {

	public static final String EMPLOYEE_ID = "employeeId";

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
	@Column(name = "emp_id", length = 45, unique = true)
	private String empId;

	private Float hourlyWage;

	@OneToOne(targetEntity = User.class, cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "employee_has_techrole", joinColumns = { @JoinColumn(name = "employee_id") }, inverseJoinColumns = @JoinColumn(name = "techrole_id"))
	private Set<TechRole> techRoles = new HashSet<TechRole>();

	@Column(name = "private_address", length = 255)
	private String privateAddress;

	@Column(name = "postcode", length = 10)
	private Integer postcode;

	@Column(name = "place", length = 50)
	private String place;

	@Column(name = "private_phone", length = 12)
	private String privatePhone;

	@Column(name = "work_phone", length = 12)
	private String workPhone;

	@Column(name = "mobile", length = 12)
	private String mobile;

	@Column(name = "birthday")
	private Date birthday;
	
	@Column(name = "startDate")
	private Date startDate;

	@Column(name = "organization", length = 50)
	private String organization;

	@Column(name = "management_name", length = 50)
	private String managementName;

	@Override
	public String toString() {
		return firstName + " " + lastName + " [" + empId + "]";
	}
}
