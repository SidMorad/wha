/*
 * Created on 13/03/2010 - 2:37:09 PM 
 */
package nl.hajari.wha.service;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
public interface DailyTravelService {

	/**
	 * 
	 * @param timesheetId
	 * @return travelTotalDistance
	 */
	Float calculateTravelTotalDistance(Long timesheetId);
}
