package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect DailyTimesheet_Roo_Configurable {
    
    declare @type: DailyTimesheet: @Configurable;    
    
}
