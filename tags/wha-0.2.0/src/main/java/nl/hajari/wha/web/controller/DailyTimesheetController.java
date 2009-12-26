package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.DailyTimesheet;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "dailytimesheet", automaticallyMaintainView = true, formBackingObject = DailyTimesheet.class, exposeFinders = false)
@RequestMapping("/dailytimesheet/**")
@Controller
public class DailyTimesheetController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(java.util.Date.class,
				new org.springframework.beans.propertyeditors.CustomDateEditor(
				new java.text.SimpleDateFormat("d/MM/yy"), true));
	}
}
