package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Timesheet_Roo_Configurable {
    
    declare @type: Timesheet: @Configurable;    
    
}
