/*
 * Created on Jan 30, 2010 - 5:59:36 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.Project;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface ProjectService {

	/**
	 * @param name
	 * @return
	 */
	List<Project> findProjectsByName(String name);

	/**
	 * @return
	 */
	List<Project> findAll();

	/**
	 * @param name
	 * @return
	 */
	Project loadOrCreateProject(String name);

}
