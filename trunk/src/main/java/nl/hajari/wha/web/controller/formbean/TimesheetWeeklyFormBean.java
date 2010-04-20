/*
 * Created on 20/04/2010 - 11:57:37 PM 
 */
package nl.hajari.wha.web.controller.formbean;

import nl.hajari.wha.domain.Project;

/**
 * This class represents formBackingBean for handle timesheet weekly view .
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class TimesheetWeeklyFormBean {
	
	private String projectName;

	private Project project;

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	
	
	
}
