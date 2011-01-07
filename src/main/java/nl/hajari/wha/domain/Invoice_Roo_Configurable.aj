package nl.hajari.wha.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Invoice_Roo_Configurable {
    
    declare @type: Invoice: @Configurable;
    
}
