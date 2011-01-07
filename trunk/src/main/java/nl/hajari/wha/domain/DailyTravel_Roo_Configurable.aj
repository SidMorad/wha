package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect DailyTravel_Roo_Configurable {
    
    declare @type: DailyTravel: @Configurable;
    
}
