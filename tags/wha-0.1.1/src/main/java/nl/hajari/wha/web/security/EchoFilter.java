/*
 * Created on Dec 5, 2009 - 5:13:00 PM
 */
package nl.hajari.wha.web.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
public class EchoFilter implements Filter {

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
			ServletException {
		try {
			chain.doFilter(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
