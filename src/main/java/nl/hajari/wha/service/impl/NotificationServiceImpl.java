/*
 * Created on Feb 23, 2010 - 4:14:26 PM
 */
package nl.hajari.wha.service.impl;

import java.util.List;

import nl.hajari.wha.service.NotificationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class NotificationServiceImpl extends AbstractService implements NotificationService {

	private String from = "wha@hmsolutions.nl";

	@Autowired
	private JavaMailSender mailSender;

	@Override
	public void sendEmail(List<String> emails, String subject, String message) {
		SimpleMailMessage mail = createMail(emails, subject, message);
		sendEmail(mail);
	}

	protected void sendEmail(final SimpleMailMessage mail) {
		try {
			mailSender.send(mail);
			String logMsg = "A notification was sent to [" + mail.getTo().length + "] receivers.";
			logger.info(logMsg);
			logService.log("admin", null, null, null, logMsg);
		} catch (MailException e) {
			String logMsg = "Failed to send a notification to [" + mail.getTo().length + "] receivers: "
					+ e.getMessage();
			logger.error(logMsg, e);
			logService.log("admin", null, null, null, logMsg);
		}
	}

	protected SimpleMailMessage createMail(List<String> emails, String subject, String message) {
		SimpleMailMessage mail = new SimpleMailMessage();
		mail.setFrom(from);
		mail.setTo(emails.toArray(new String[] {}));
		mail.setSubject(subject);
		mail.setText(message);
		mail.setReplyTo(from);
		return mail;
	}

	@Override
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
}
