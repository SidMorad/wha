package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.Project;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect ProjectEditor_Roo_Editor {
    
    declare parents: ProjectEditor implements PropertyEditorSupport;    
    
    private SimpleTypeConverter ProjectEditor.typeConverter = new SimpleTypeConverter();    
    
    public String ProjectEditor.getAsText() {    
        Object obj = getValue();        
        if (obj == null) {        
            return null;            
        }        
        return (String) typeConverter.convertIfNecessary(((Project) obj).getId(), String.class);        
    }    
    
    public void ProjectEditor.setAsText(String text) {    
        if (text == null || 0 == text.length()) {        
            setValue(null);            
            return;            
        }        
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);        
        if (identifier == null) {        
            setValue(null);            
            return;            
        }        
        
        setValue(Project.findProject(identifier));        
    }    
    
}
