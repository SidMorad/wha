/*
 * Created on Feb 26, 2010 - 2:40:56 PM
 */
package nl.hajari.wha.web.util;

import java.util.Locale;

import org.springframework.context.i18n.LocaleContextHolder;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public abstract class LocaleUtils {

	public static Locale getCurrentLocale() {
		Locale l = getDefaultLocale();
		try {
			l = LocaleContextHolder.getLocale();
		} catch (Exception e) {
		}
		return l;
	}

	protected static Locale getDefaultLocale() {
		return Locale.US;
	}
	
	private LocaleUtils() {
	}

}
