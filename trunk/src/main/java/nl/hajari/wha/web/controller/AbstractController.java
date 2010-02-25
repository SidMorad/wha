/*
 * Created on Feb 21, 2010 - 9:33:54 PM
 */
package nl.hajari.wha.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import nl.hajari.wha.Constants;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public class AbstractController implements MessageSourceAware {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	@Qualifier("messageSource")
	protected MessageSource messages;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, getCustomDateEditor());
	}

	protected CustomDateEditor getCustomDateEditor() {
		String datePattern = messages.getMessage(Constants.DATE_PATTERN_KEY, new Object[] {}, getLocale());
		logger.debug("Customer editor for date pattern: " + datePattern);
		return new CustomDateEditor(new SimpleDateFormat(datePattern), true);
	}

	protected Locale getLocale() {
		Locale locale = getDefaultLocale();
		try {
			locale = LocaleContextHolder.getLocale();
		} catch (Exception e) {
		}
		logger.debug("Current Locale: " + locale);
		return locale;
	}

	protected Locale getDefaultLocale() {
		return Locale.US;
	}

	protected String getMessage(String key, Object... params) {
		try {
			String value = messages.getMessage(key, params, getLocale());
			return value;
		} catch (NoSuchMessageException e) {
			return null;
		}
	}

	@Override
	public void setMessageSource(MessageSource messageSource) {
		this.messages = messageSource;
	}

}
