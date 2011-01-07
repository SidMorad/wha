package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Customer_Roo_Configurable {
    
    declare @type: Customer: @Configurable;
    
}
