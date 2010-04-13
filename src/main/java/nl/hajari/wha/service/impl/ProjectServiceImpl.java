/*
 * Created on Dec 12, 2009 - 12:45:56 AM
 */
package nl.hajari.wha.service.impl;

import java.util.Arrays;
import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.service.ProjectService;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Service
public class ProjectServiceImpl extends AbstractService implements ProjectService, InitializingBean {

	private String OFF_TIME_KEYWORDS_KEY = "off.time.keywords";
	private String DEFULAT_OFF_TIME_PROJECT_COMPLETE_NAME_KEY = "default.off.time.project.complete.name";

	private String offTimeKeywords;
	private List<String> offTimeKeywordList;
	private String offTimeProjectCompleteName;

	@Override
	public void afterPropertiesSet() throws Exception {
		if (null == offTimeKeywords) {
			offTimeKeywords = getConfig(OFF_TIME_KEYWORDS_KEY);
			offTimeKeywordList = Arrays.asList(offTimeKeywords.split(","));
		}
		if (null == offTimeProjectCompleteName) {
			offTimeProjectCompleteName = getConfig(DEFULAT_OFF_TIME_PROJECT_COMPLETE_NAME_KEY);
		}
	}

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
		if (looksLikeAnOffTimeProject(projectName)) {
			logger.debug("Project [" + projectName + "] looks to be meant to be [" + offTimeProjectCompleteName + "]");
			projectName = offTimeProjectCompleteName;
		}
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

	public void setOffTimeKeywords(String offTimeKeywords) {
		this.offTimeKeywords = offTimeKeywords;
	}

	public void setOffTimeProjectCompleteName(String offTimeProjectCompleteName) {
		this.offTimeProjectCompleteName = offTimeProjectCompleteName;
	}

	private boolean looksLikeAnOffTimeProject(String projectName) {
		String projectNameLowered = projectName.toLowerCase();
		for (String keyword : offTimeKeywordList) {
			if (projectNameLowered.contains(keyword)) {
				return true;
			}
		}
		return false;
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
