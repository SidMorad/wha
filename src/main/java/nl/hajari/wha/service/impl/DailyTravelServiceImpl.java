/*
 * Created on 13/03/2010 - 2:38:58 PM 
 */
package nl.hajari.wha.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.DailyTravelService;
import nl.hajari.wha.service.TimesheetService;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Service
public class DailyTravelServiceImpl extends AbstractService implements DailyTravelService {

	@Autowired
	protected TimesheetService timesheetService;
	
	@Override
	public Float calculateTravelTotalDistance(Long timesheetId) {
		Timesheet timesheet = timesheetService.load(timesheetId);
		
		Float totalDistance = 0f;
		for (DailyTravel dailyTravel : timesheet.getDailyTravels()) {
			if (dailyTravel.getWithReturn() != null && dailyTravel.getWithReturn() == Boolean.TRUE) {
				totalDistance+= dailyTravel.getDistance() * 2;
			} else {
				totalDistance+= dailyTravel.getDistance();
			}
		}
		
		return totalDistance;
	}

}
