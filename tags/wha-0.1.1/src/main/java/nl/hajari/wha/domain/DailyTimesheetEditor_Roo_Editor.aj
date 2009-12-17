package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.DailyTimesheet;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect DailyTimesheetEditor_Roo_Editor {
    
    declare parents: DailyTimesheetEditor implements PropertyEditorSupport;    
    
    private SimpleTypeConverter DailyTimesheetEditor.typeConverter = new SimpleTypeConverter();    
    
    public String DailyTimesheetEditor.getAsText() {    
        Object obj = getValue();        
        if (obj == null) {        
            return null;            
        }        
        return (String) typeConverter.convertIfNecessary(((DailyTimesheet) obj).getId(), String.class);        
    }    
    
    public void DailyTimesheetEditor.setAsText(String text) {    
        if (text == null || 0 == text.length()) {        
            setValue(null);            
            return;            
        }        
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);        
        if (identifier == null) {        
            setValue(null);            
            return;            
        }        
        
        setValue(DailyTimesheet.findDailyTimesheet(identifier));        
    }    
    
}
