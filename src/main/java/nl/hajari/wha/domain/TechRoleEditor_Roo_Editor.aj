package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.TechRole;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect TechRoleEditor_Roo_Editor {
    
    declare parents: TechRoleEditor implements PropertyEditorSupport;
    
    private SimpleTypeConverter TechRoleEditor.typeConverter = new SimpleTypeConverter();
    
    public String TechRoleEditor.getAsText() {
        Object obj = getValue();
        if (obj == null) {
            return null;
        }
        return (String) typeConverter.convertIfNecessary(((TechRole) obj).getId(), String.class);
    }
    
    public void TechRoleEditor.setAsText(String text) {
        if (text == null || 0 == text.length()) {
            setValue(null);
            return;
        }
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);
        if (identifier == null) {
            setValue(null);
            return;
        }
        
        setValue(TechRole.findTechRole(identifier));
    }
    
}
