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
	@Size(max = 30)
	@Pattern(regexp = ".+@.+\\.[a-z]+")
	private String email;

	@NotNull
	@Size(min = 4 , max = 30)
	private String password;

	@NotNull
	@Size(min = 4 , max = 30)
	private String confirmPassword;
	
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
}
