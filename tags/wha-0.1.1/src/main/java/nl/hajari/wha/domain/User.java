package nl.hajari.wha.domain;

import java.util.Collection;
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
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.StringUtils;

@Entity
@Table(name = "app_user")
@RooJavaBean
@RooEntity(finders = { "findUsersByUsernameEquals" })
public class User implements UserDetails {

	private static final long serialVersionUID = 1L;

	public static final String USER_ID = "userId";
	public static final String USERNAME = "username";

	@NotNull
	@Size(max = 30)
	@Column(unique = true)
	private String username;

	@NotNull
	private String password;

	private transient String confirmPassword;

//	@Pattern(regexp = "email@example.com")
	@Size(max = 30)
	@Column(unique = true)
	private String email;

	@OneToOne(targetEntity = Employee.class, cascade = CascadeType.ALL)
	@JoinColumn(name = "employee_id")
	private Employee employee;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "user_role", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = @JoinColumn(name = "role_id"))
	private Set<Role> roles = new HashSet<Role>();

	private boolean enabled;

	private boolean accountExpired;

	private boolean accountLocked;

	private boolean credentialsExpired;

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	@Transient
	public Collection<GrantedAuthority> getAuthorities() {
		return AuthorityUtils
				.commaSeparatedStringToAuthorityList(getRolesCommaSeparatedString());
	}

	@Transient
	public boolean isAccountNonExpired() {
		return !accountExpired;
	}

	@Transient
	public boolean isAccountNonLocked() {
		return !accountLocked;
	}

	@Transient
	public boolean isCredentialsNonExpired() {
		return !credentialsExpired;
	}

	@Transient
	public String getConfirmPassword() {
		return confirmPassword;
	}

	@Transient
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	@Transient
	public void addRole(Role role) {
		roles.add(role);
	}

	@Transient
	public String getRolesCommaSeparatedString() {
		return StringUtils.collectionToDelimitedString(getRoles(), ",");
	}

	@Override
	public String toString() {
		return this.username;
	}
}
