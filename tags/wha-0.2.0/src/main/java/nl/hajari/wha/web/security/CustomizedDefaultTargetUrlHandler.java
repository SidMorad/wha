/*
 * Created on Dec 2, 2009 - 9:09:33 PM
 */
package nl.hajari.wha.web.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.hajari.wha.web.util.SecurityContextUtils;

import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
public class CustomizedDefaultTargetUrlHandler extends SimpleUrlAuthenticationSuccessHandler {

	@Override
	protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {
		if (SecurityContextUtils.isCurrentUserAdmin()) {
			setDefaultTargetUrl("/");
		}
		return super.determineTargetUrl(request, response);
	}

}
