/*
 * Created on Feb 6, 2010 - 5:28:57 PM
 */
package nl.hajari.wha.service.impl;

import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class UserServiceImpl extends AbstractService implements UserService {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public User load(String username) {
		User user = (User) User.findUsersByUsernameEquals(username).getSingleResult();
		return user;
	}

	@Override
	public void save(User user) {
		user.setPassword(passwordEncoder.encodePassword(user.getPassword(), null));
		user.persist();
	}

	@Override
	public void setPassword(String username, String newPassword) {
		User user = load(username);
		user.setPassword(passwordEncoder.encodePassword(user.getPassword(), null));
		user.merge();
	}

	@Override
	public void update(User user) {
		user.merge();
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
		User user = load(username);
		if (null == user) {
			throw new UsernameNotFoundException("Username: [ " + username + " ] not found.");
		}
		return user;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
