/*
 * Created on 20/04/2010 - 11:57:37 PM 
 */
package nl.hajari.wha.web.controller.formbean;

import java.util.Map;

import nl.hajari.wha.domain.Project;

/**
 * This class represents formBackingBean for handle timesheet weekly view .
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class TimesheetWeeklyFormBean {

	private Map<Integer, Week> weeks;

	private Integer week;
	private String projectName;
	private Project project;

	private Integer day1 = 0;
	private Integer day2 = 0;
	private Integer day3 = 0;
	private Integer day4 = 0;
	private Integer day5 = 0;
	private Integer day6 = 0;
	private Integer day7 = 0;

	public Integer getWeek() {
		return week;
	}

	public void setWeek(Integer week) {
		this.week = week;
	}

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

	public Integer getDay1() {
		return day1;
	}

	public void setDay1(Integer day1) {
		this.day1 = day1;
	}

	public Integer getDay2() {
		return day2;
	}

	public void setDay2(Integer day2) {
		this.day2 = day2;
	}

	public Integer getDay3() {
		return day3;
	}

	public void setDay3(Integer day3) {
		this.day3 = day3;
	}

	public Integer getDay4() {
		return day4;
	}

	public void setDay4(Integer day4) {
		this.day4 = day4;
	}

	public Integer getDay5() {
		return day5;
	}

	public void setDay5(Integer day5) {
		this.day5 = day5;
	}

	public Integer getDay6() {
		return day6;
	}

	public void setDay6(Integer day6) {
		this.day6 = day6;
	}

	public Integer getDay7() {
		return day7;
	}

	public void setDay7(Integer day7) {
		this.day7 = day7;
	}

	public Map<Integer, Week> getWeeks() {
		return weeks;
	}

	public void setWeeks(Map<Integer, Week> weeks) {
		this.weeks = weeks;
	}

	@Override
	public String toString() {
		int total = day1 + day2 + day3 + day4 + day5 + day6 + day7;
		return "[" + total + ", " + projectName + ", " + week + " ]";
	}

}
