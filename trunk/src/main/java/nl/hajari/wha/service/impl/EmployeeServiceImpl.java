/*
 * Created on Feb 23, 2010 - 4:03:42 PM
 */
package nl.hajari.wha.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.service.EmployeeService;
import nl.hajari.wha.service.NotificationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class EmployeeServiceImpl extends AbstractService implements EmployeeService {

	private String monthlyTimesheetUpdateMessage = "Hey fellas, time is up!";
	private String monthlyTimesheetUpdateSubject = "HM Solutions - WHA - Timesheet WARNING";

	@Autowired
	private NotificationService notificationService;

	@Override
	public List<Employee> findEmployeeByRole(String role) {
		Query q = Employee.findEmployeesByRole(role);
		try {
			List<Employee> all = q.getResultList();
			if (null == all) {
				return new ArrayList<Employee>();
			}
			return all;
		} catch (Exception e) {
			logger.error("Failed to load all employees with role[" + role + "]: " + e.getMessage());
		}
		return new ArrayList<Employee>();
	}

	@Override
	public void sendMonthlyTimesheetUpdateNotification() {
		// TODO
		// OR SUPRISINGLY: employees = Employee.findAll() ?!!!! I am confused!
		List<Employee> employees = findEmployeeByRole(Constants.ROLE_EMPLOYEE);
		List<String> emails = extractEmails(employees);
		notificationService.sendEmail(emails, monthlyTimesheetUpdateSubject, monthlyTimesheetUpdateMessage);
		logger.info("A request of monthly timesheet update notification initiated.");
	}

	protected List<String> extractEmails(List<Employee> employees) {
//		List<String> emails = new ArrayList<String>();
//		for (Employee employee : employees) {
//			emails.add(employee.getUser().getEmail());
//		}
//		return emails;
		List<String> mails = new ArrayList<String>();
		mails.add("behrooz.nobakht@gmail.com");
		return mails;
	}

	public void setMonthlyTimesheetUpdateMessage(String monthlyTimesheetUpdateMessage) {
		this.monthlyTimesheetUpdateMessage = monthlyTimesheetUpdateMessage;
	}

	public void setMonthlyTimesheetUpdateSubject(String monthlyTimesheetUpdateSubject) {
		this.monthlyTimesheetUpdateSubject = monthlyTimesheetUpdateSubject;
	}

	public void setNotificationService(NotificationService notificationService) {
		this.notificationService = notificationService;
	}
}
