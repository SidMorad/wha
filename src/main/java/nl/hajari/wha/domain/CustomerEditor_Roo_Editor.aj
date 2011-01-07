package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.Customer;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect CustomerEditor_Roo_Editor {
    
    declare parents: CustomerEditor implements PropertyEditorSupport;
    
    private SimpleTypeConverter CustomerEditor.typeConverter = new SimpleTypeConverter();
    
    public String CustomerEditor.getAsText() {
        Object obj = getValue();
        if (obj == null) {
            return null;
        }
        return (String) typeConverter.convertIfNecessary(((Customer) obj).getId(), String.class);
    }
    
    public void CustomerEditor.setAsText(String text) {
        if (text == null || 0 == text.length()) {
            setValue(null);
            return;
        }
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);
        if (identifier == null) {
            setValue(null);
            return;
        }
        
        setValue(Customer.findCustomer(identifier));
    }
    
}
