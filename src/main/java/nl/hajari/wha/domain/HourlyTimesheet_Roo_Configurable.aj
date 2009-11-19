package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect HourlyTimesheet_Roo_Configurable {
    
    declare @type: HourlyTimesheet: @Configurable;    
    
}
