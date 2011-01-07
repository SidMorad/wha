package nl.hajari.wha.domain;

import java.beans.PropertyEditorSupport;
import java.lang.Long;
import java.lang.String;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.beans.SimpleTypeConverter;

privileged aspect TimesheetEditor_Roo_Editor {
    
    declare parents: TimesheetEditor implements PropertyEditorSupport;
    
    private SimpleTypeConverter TimesheetEditor.typeConverter = new SimpleTypeConverter();
    
    public String TimesheetEditor.getAsText() {
        Object obj = getValue();
        if (obj == null) {
            return null;
        }
        return (String) typeConverter.convertIfNecessary(((Timesheet) obj).getId(), String.class);
    }
    
    public void TimesheetEditor.setAsText(String text) {
        if (text == null || 0 == text.length()) {
            setValue(null);
            return;
        }
        
        Long identifier = (Long) typeConverter.convertIfNecessary(text, Long.class);
        if (identifier == null) {
            setValue(null);
            return;
        }
        
        setValue(Timesheet.findTimesheet(identifier));
    }
    
}
