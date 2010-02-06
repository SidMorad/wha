/*
 * Created on Jan 30, 2010 - 6:16:19 PM
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.User;

import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface UserService extends UserDetailsService {

	/**
	 * @param username
	 * @return
	 */
	User load(String username);

	/**
	 * @param user
	 */
	void save(User user);

	/**
	 * @param user
	 */
	void update(User user);

	/**
	 * @param username
	 * @param newPassword
	 */
	void setPassword(String username, String newPassword);

}
