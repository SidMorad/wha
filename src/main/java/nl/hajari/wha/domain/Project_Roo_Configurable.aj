package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Project_Roo_Configurable {
    
    declare @type: Project: @Configurable;    
    
}
