package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect TechnicalRole_Roo_Configurable {
    
    declare @type: TechnicalRole: @Configurable;    
    
}
