/*
 * Created on Feb 23, 2010 - 4:08:56 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface NotificationService {

	/**
	 * @param emails
	 * @param subject
	 * @param message
	 */
	void sendEmail(List<String> emails, String subject, String message);

	/**
	 * @param mailSender
	 */
	void setMailSender(JavaMailSender mailSender);

}
