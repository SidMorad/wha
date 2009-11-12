package nl.hajari.wha.domain;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.security.GrantedAuthority;

@Entity
@RooJavaBean
@RooEntity(finders = { "findRolesByNameEquals" })
public class Role implements GrantedAuthority {

	private static final long serialVersionUID = 1L;
	
	@NotNull
    @Size(max = 20)
    private String name;

    @Override
    public String getAuthority() {
        return name;
    }
    
    @Override
    public int hashCode() {
    	return (name != null ? name.hashCode() : Integer.MIN_VALUE);
    }

    @Override
    public int compareTo(Object o) {
    	if (o == null) {
    		return 1;
    	}
    	if (!(o instanceof Role)) {
    		return 1;
    	}
    	Role r = (Role) o;
    	return name.compareTo(r.name);
    }

    @Override
    public String toString() {
        return name;
    }
}
