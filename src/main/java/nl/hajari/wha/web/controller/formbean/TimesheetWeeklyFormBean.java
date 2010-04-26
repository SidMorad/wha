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

	private Float day1 = 0f;
	private Float day2 = 0f;
	private Float day3 = 0f;
	private Float day4 = 0f;
	private Float day5 = 0f;
	private Float day6 = 0f;
	private Float day7 = 0f;

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

	public Float getDay1() {
		return day1;
	}

	public void setDay1(Float day1) {
		this.day1 = day1;
	}

	public Float getDay2() {
		return day2;
	}

	public void setDay2(Float day2) {
		this.day2 = day2;
	}

	public Float getDay3() {
		return day3;
	}

	public void setDay3(Float day3) {
		this.day3 = day3;
	}

	public Float getDay4() {
		return day4;
	}

	public void setDay4(Float day4) {
		this.day4 = day4;
	}

	public Float getDay5() {
		return day5;
	}

	public void setDay5(Float day5) {
		this.day5 = day5;
	}

	public Float getDay6() {
		return day6;
	}

	public void setDay6(Float day6) {
		this.day6 = day6;
	}

	public Float getDay7() {
		return day7;
	}

	public void setDay7(Float day7) {
		this.day7 = day7;
	}

	public Float[] getDays() {
		return new Float[] { day1, day2, day3, day4, day5, day6, day7 };
	}

	public Map<Integer, Week> getWeeks() {
		return weeks;
	}

	public void setWeeks(Map<Integer, Week> weeks) {
		this.weeks = weeks;
	}

	@Override
	public String toString() {
		float total = day1 + day2 + day3 + day4 + day5 + day6 + day7;
		return "[" + total + ", " + projectName + ", " + week + " ]";
	}

}
