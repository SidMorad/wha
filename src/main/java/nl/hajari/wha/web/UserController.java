package nl.hajari.wha.web;

import java.util.List;

import nl.hajari.wha.domain.User;

import org.springframework.dao.DataAccessException;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "user", automaticallyMaintainView = true, formBackingObject = User.class)
@RequestMapping("/user/**")
@Controller
public class UserController implements UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {
		List<User> users = User.findUsersByUsernameEquals(username).getResultList();
		if (users.size() == 1) {
			return users.get(0);
		}
		throw new UsernameNotFoundException("Username: [ " + username + " ] not found!");
	}
}
