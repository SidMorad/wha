package nl.hajari.wha.web.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.web.util.SecurityContextUtils;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

public class UserEmployeeSecurityFilter extends OncePerRequestFilter {

	@Override
	@Transactional
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute(Employee.EMPLOYEE_ID) != null) {
			filterChain.doFilter(request, response);
			return;
		}
		String username = SecurityContextUtils.getCurrentUsername();
		if (!StringUtils.hasText(username)) {
			username = (String) session.getAttribute(User.USER_ID);
		}
		if (!StringUtils.hasText(username)) {
			filterChain.doFilter(request, response);
			return;
		}
		User currentUser = (User) User.findUsersByUsernameEquals(username).getSingleResult();
		if (currentUser == null) {
			filterChain.doFilter(request, response);
			return;
		}
		session.setAttribute(User.USER_ID, currentUser.getId());
		try {
			Employee currentEmployee = (Employee) Employee.findEmployeesByUser(currentUser).getSingleResult();
			if (currentEmployee != null) {
				session.setAttribute(Employee.EMPLOYEE_ID, currentEmployee.getId());
			}
			logger.debug("Registered current user[" + currentUser + "] and employe[" + currentEmployee
					+ "] on HTTP session.");
		} catch (Exception e) {
		}
		filterChain.doFilter(request, response);
	}
}
