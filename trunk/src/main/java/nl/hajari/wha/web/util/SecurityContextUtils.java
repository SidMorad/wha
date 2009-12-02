package nl.hajari.wha.web.util;

import java.util.Collection;

import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.User;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * 
 * @author Behrooz Nobakht
 * 
 */
public class SecurityContextUtils {

	private static final GrantedAuthority ROLE_ADMIN = new GrantedAuthorityImpl(Constants.ROLE_ADMIN);

	public static String getCurrentUsername() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return auth == null ? null : auth.getName();
	}

	public static boolean isCurrentUserAdmin() {
		User user = (User) User.findUsersByUsernameEquals(getCurrentUsername()).getSingleResult();
		if (user == null) {
			return false;
		}
		Collection<GrantedAuthority> authorities = user.getAuthorities();
		return authorities.contains(ROLE_ADMIN);
	}

}
