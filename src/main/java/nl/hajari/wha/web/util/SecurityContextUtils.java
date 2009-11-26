package nl.hajari.wha.web.util;

import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContextHolder;

/**
 * 
 * @author Behrooz Nobakht
 * 
 */
public class SecurityContextUtils {

	public static String getCurrentUsername() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return auth == null ? null : auth.getName();
	}

}
