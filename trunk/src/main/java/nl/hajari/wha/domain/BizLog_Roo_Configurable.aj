package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect BizLog_Roo_Configurable {
    
    declare @type: BizLog: @Configurable;    
    
}
