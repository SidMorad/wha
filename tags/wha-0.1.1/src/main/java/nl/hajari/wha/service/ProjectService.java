/*
 * Created on Dec 12, 2009 - 12:45:56 AM
 */
package nl.hajari.wha.service;

import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.Project;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Service
public class ProjectService {

	protected final Log logger = LogFactory.getLog(getClass());

	public List<Project> findProjectsByName(String projectName) {
		Query query = Project.findProjectsByNameLike(projectName);
		List projects = query.getResultList();
		logger.debug("Projects [" + projects.size()
				+ "] found with name similar to [" + projectName + "]");
		return projects;
	}

	public List<Project> findAll() {
		List<Project> all = Project.findAllProjects();
		logger.debug("All projects fetched with size [" + all.size() + "].");
		return all;
	}

	@Transactional(readOnly = false)
	public Project loadOrCreateProject(String name) {
		String projectName = name;
		String customerName = null;
		int atSign = projectName.indexOf('@');
		if (atSign > 0) {
			customerName = projectName.substring(atSign + 1);
			projectName = projectName.substring(0, atSign);
			customerName = customerName.trim();
		}
		projectName = projectName.trim();
		Project project;
		try {
			// If customer does not exist , then project need to be create.
			Customer customer = (Customer) Customer.findCustomersByNameEquals(
					customerName).getSingleResult();
			project = (Project) Project.findProjectsByCustomerAndNameEquals(
					customer, projectName).getSingleResult();
		} catch (Exception e) {
			project = createProject(projectName, customerName);
			return project;
		}
		return project;
	}

	@Transactional(readOnly = false)
	private Project createProject(String projectName, String customerName) {
		Project project = new Project();
		project.setName(projectName);
		Customer customer = null;
		if (customerName != null) {
			try {
				// Check if we have customer with this name already.
				customer = (Customer) Customer.findCustomersByNameEquals(
						customerName).getSingleResult();
			} catch (Exception e) {
				customer = new Customer();
				customer.setName(customerName);
				customer.persist();
				customer.flush();
			}
		}
		project.setCustomer(customer);
		project.persist();
		project.flush();
		logger.debug("Created new project: " + project);
		return project;
	}

}
