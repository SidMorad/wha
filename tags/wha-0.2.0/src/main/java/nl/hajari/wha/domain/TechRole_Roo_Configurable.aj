package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect TechRole_Roo_Configurable {
    
    declare @type: TechRole: @Configurable;    
    
}
