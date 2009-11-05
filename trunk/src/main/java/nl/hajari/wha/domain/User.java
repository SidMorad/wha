package nl.hajari.wha.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.userdetails.UserDetails;

@Entity
@Table(name = "app_user", uniqueConstraints = @UniqueConstraint(columnNames = { "username" }))
@RooJavaBean
@RooEntity
public class User implements UserDetails {

    @NotNull
    @Size(max = 30)
    private String username;

    @NotNull
    private String password;

    private transient String confirmPassword;

    @NotNull
    @Size(max = 30)
    private String firstName;

    @NotNull
    @Size(max = 30)
    private String lastName;

    @NotNull
    private String email;

    @Size(max = 20)
    private String phone;
    
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
        return false;
    }

    @Transient
    public GrantedAuthority[] getAuthorities() {
        return roles.toArray(new GrantedAuthority[0]);
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

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.username);
        GrantedAuthority[] auths = this.getAuthorities();
        if (auths != null) {
            sb.append(" Granted Authorities: ");
            for (int i = 0; i < auths.length; i++) {
                if (i > 0) {
                    sb.append(", ");
                }
                sb.append(auths[i].toString());
            }
        } else {
            sb.append("No Granted Authorities");
        }
        return sb.toString();
    }
}
