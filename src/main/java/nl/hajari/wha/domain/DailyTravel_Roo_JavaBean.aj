package nl.hajari.wha.domain;

import java.lang.Boolean;
import java.lang.Float;
import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTravel_Roo_JavaBean {
    
    public Date DailyTravel.getDayDate() {
        return this.dayDate;
    }
    
    public void DailyTravel.setDayDate(Date dayDate) {
        this.dayDate = dayDate;
    }
    
    public String DailyTravel.getOrigin() {
        return this.origin;
    }
    
    public void DailyTravel.setOrigin(String origin) {
        this.origin = origin;
    }
    
    public String DailyTravel.getDestination() {
        return this.destination;
    }
    
    public void DailyTravel.setDestination(String destination) {
        this.destination = destination;
    }
    
    public Boolean DailyTravel.getWithReturn() {
        return this.withReturn;
    }
    
    public void DailyTravel.setWithReturn(Boolean withReturn) {
        this.withReturn = withReturn;
    }
    
    public Float DailyTravel.getDistance() {
        return this.distance;
    }
    
    public void DailyTravel.setDistance(Float distance) {
        this.distance = distance;
    }
    
    public String DailyTravel.getComment() {
        return this.comment;
    }
    
    public void DailyTravel.setComment(String comment) {
        this.comment = comment;
    }
    
    public Timesheet DailyTravel.getTimesheet() {
        return this.timesheet;
    }
    
    public void DailyTravel.setTimesheet(Timesheet timesheet) {
        this.timesheet = timesheet;
    }
    
}
