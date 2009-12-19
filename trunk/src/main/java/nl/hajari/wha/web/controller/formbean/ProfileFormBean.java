package nl.hajari.wha.web.controller.formbean;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

/**
 * This class represents formBackingBean for handle profile update action.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/

public class ProfileFormBean {

	private Long id;

	private Integer version;

	@NotNull
	@Size(min = 2, max = 45)
	private String firstName;
	@NotNull
	@Size(min = 2, max = 45)
	private String lastName;

	@NotNull
	@Size(max = 30)
	@Pattern(regexp = ".+@.+\\.[a-z]+")
	private String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

}
