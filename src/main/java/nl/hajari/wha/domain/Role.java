package nl.hajari.wha.domain;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.security.GrantedAuthority;

@Entity
@RooJavaBean
@RooEntity
/**
 * This class is used to represent available Roles in the database.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class Role implements GrantedAuthority {

    @NotNull
    @Size(max = 20)
    private String name;

	@Override
	public String getAuthority() {
		return name;
	}

	@Override
	public int compareTo(Object o) {
		return (name != null ? name.hashCode() : 0);
	}
	
	@Override
	public String toString() {
		return name;
	}
}
