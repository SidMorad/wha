package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.Role;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect RoleEditor_Roo_Editor {
    
    declare parents: RoleEditor implements PropertyEditorSupport;
    
    private SimpleTypeConverter RoleEditor.typeConverter = new SimpleTypeConverter();
    
    public String RoleEditor.getAsText() {
        Object obj = getValue();
        if (obj == null) {
            return null;
        }
        return (String) typeConverter.convertIfNecessary(((Role) obj).getId(), String.class);
    }
    
    public void RoleEditor.setAsText(String text) {
        if (text == null || 0 == text.length()) {
            setValue(null);
            return;
        }
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);
        if (identifier == null) {
            setValue(null);
            return;
        }
        
        setValue(Role.findRole(identifier));
    }
    
}
